#### About ----

# Author : Susan Paykin
# Date : January 6, 2021
# About: This code prepares the metrics on Access to Pharmacies for zip codes and census tracts. 

# Part 1) Wrangle national pharmacy data: 
  # loads the complete 2019 business dataset, filters by NAICS Codes for pharmacies, 
  # selects relevant variables, and saves the cleaned pharmacy dataset in the data_raw folder. 
# Part 2) Conduct nearest resource analysis, using minimum distance as proxy for access,
  # determining the distance from census tracts and zip code tracts to pharmacies. 
# Part 3) Save final Access Metrics datasets: 
  # Create new csv files with access metrics by census tracts and zip codes, saved in the data_final folder. 

#### Part 1) Wrangle national pharmacy data ----

# Set up 
library(tidyverse)
library(sf)
library(tmap)
library(units)

# Load full raw business dataset
pharmacies <- read.table("2019_Business_Academic_QCQ.txt", sep = ",", header = TRUE)

# Explore structure and variable names
names(pharmacies)
head(pharmacies)
str(pharmacies)

# Select only pharmacies, filter by NAICS code
pharmacies2 <- 
  pharmacies %>% 
  filter(str_detect(Primary.NAICS.Code, "^4461100"))

pharmacies_clean <- 
  pharmacies2 %>%
  select(Company, Address = Address.Line.1, City, State, ZipCode, 
         Primary.NAICS.Code, NAICS8.Descriptions, Census.Tract, FIPS.Code, Latitude, Longitude)

# Explore pharmacy data
unique(pharmacies_clean$Primary.NAICS.Code)
unique(pharmacies_clean$NAICS8.Descriptions)
unique(pharmacies_clean$State)

# Save pharmacy dataset 
#write.csv(pharmacies_clean, "pharmacies_2019.csv")

# Read in clean pharmacy dataset
pharmacies <- read.csv("Policy_Scan/data_raw/pharmacies_2019.csv")

# Remove NAs / missing data from longitude
which(is.na(pharmacies$Longitude)) # row 10667 Longitude is NA
pharmacies <- pharmacies[-10667, ]

# Convert longitude variable to numeric
pharmacies$Longitude <- as.numeric(pharmacies$Longitude)
str(pharmacies)

# Convert to spatial data
pharmacies.sf <- st_as_sf(pharmacies,
                          coords = c("Longitude", "Latitude"),
                          crs = 4326)

# Quick plot
plot(st_geometry(pharmacies.sf))

#### Part 2) Nearest Resource Analysis ----

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Check & transform CRS to projected EPSG:3857, with unit measurement of meters
st_crs(zips)
zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)

st_crs(pharmacies.sf)
pharmacies.sf <- st_transform(pharmacies.sf, 3857)

#### Nearest Pharmacies - ZCTAs ----

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify pharmacy that is closest to zip centroid. 
# This will return index, so then subset pharmacies by the index to get the nearest location 
nearestPharma_index <- st_nearest_feature(zipCentroids, pharmacies.sf)
nearestPharma <- pharmacies.sf[nearestPharma_index,]

# Calculate distance
minDistZPharma <- st_distance(zipCentroids, nearestPharma, by_element = TRUE)
head(minDistZPharma) #meters

# Change from meters to miles
minDistZPharma_mi <- set_units(minDistZPharma, "mi")
head(minDistZPharma_mi)

# Merge data - rejoin minDist_mi to zips
minDistZPharma_sf <- cbind(zips, minDistZPharma_mi)
head(minDistZPharma_sf)

# Clean up data
minDistZPharma_sf <- minDistZPharma_sf %>% select(ZCTA = ZCTA5CE10, minDisRx = minDistZPharma_mi)
head(minDistZPharma_sf)

#### Nearest Pharmacies - Tracts ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify pharmacy that is closest to tract centroid.  
# Will return index, so then subset by the index to get the nearest location. 
nearestPharma_index_tract <- st_nearest_feature(tractCentroids, pharmacies.sf)
nearestPharma_tract <- pharmacies.sf[nearestPharma_index_tract, ]
nearestPharma_tract

# Calculate distance
minDistPharmaT <- st_distance(tractCentroids, nearestPharma_tract, by_element = TRUE)
head(minDistPharmaT) #meters

# Change from meters to miles
minDistPharmaT_mi <- set_units(minDistPharmaT, "mi")
head(minDistPharmaT_mi)

# Merge data - rejoin minDist_mi to zips
minDistPharmaT_sf <- cbind(tracts, minDistPharmaT_mi)
head(minDistPharmaT_sf)

# Clean up data
minDistPharmaT_sf <- minDistPharmaT_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, minDisRx = minDistPharmaT_mi)
head(minDistPharmaT_sf)

#### Part 3) Save final datasets ----

# Save zips
write_sf(minDistZPharma_sf, "Policy_Scan/data_final/Access04_Z.csv")

# Save tracts
write_sf(minDistPharmaT_sf, "Policy_Scan/data_final/Access04_T.csv")
