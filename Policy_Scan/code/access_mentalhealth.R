########### INFO ###########

# Author : Susan Paykin
# Date : January 9, 2021
# About: This code prepares the metrics as a proxy for access to mental health providers for all U.S. zip codes and census tracts. 

# Part 1) Wrangle national mental health provider data: 
# loads the complete raw dataset, selects relevant variables, geocodes addresses, 
# and saves the cleaned geocoded dataset in the data_raw folder. 
# Part 2) Conduct nearest resource analysis, using minimum distance as proxy for access,
# determining the distance from census tracts and zip code tracts to mental health providers. 
# Part 3) Save final Access Metrics datasets: 
# Create new csv files with access metrics by census tracts and zip codes, saved in the data_final folder. 

#### Part 1) Wrangle national pharmacy data ####

# Set up 
library(tidyverse)
library(sf)
library(tmap)
library(units)
#install.packages("tidygeocoder")
library(tidygeocoder)

setwd("~/git/opioid-policy-scan/Policy_Scan")

# Load data
mh_providers <- read.csv("data_raw/mentalhealth_raw.csv")
head(mh_providers)
str(mh_providers)

# remove first variable and extra treatment variables
mh_providers <- mh_providers %>% select(-"X")
mh_providers <- mh_providers[,1:17]

# Convert to spatial data
mh.sf <- st_as_sf(mh_providers,
                  coords = c("longitude", "latitude"),
                  crs = 4326)

# Test visualize
plot(st_geometry(mh.sf))

tmap_mode("view")
tm_shape(mh.sf) +
  tm_dots()
# Arkansas and Wyoming are missing!

# Load AR and WY state data
ark <- read.csv("data_raw/mentalhealth_ark.csv")
wy <- read.csv("data_raw/mentalhealth_wy.csv")

names(ar)
names(wy)
names(mh_providers)

mh_providers <- rbind(mh_providers, ark, wy)
str(mh_providers)

# Save provider dataset
#write.csv(mh_providers, "data_raw/mentalhealth_clean.csv")

# Read in dataset
#mh_providers <- read.csv("data_raw/mentalhealth_clean.csv")
                  

# Convert to spatial data
mh.sf <- st_as_sf(mh_providers,
                  coords = c("longitude", "latitude"),
                  crs = 4326)

# Test visualize
plot(st_geometry(mh.sf))

tm_shape(mh.sf) +
  tm_dots()

sort(unique(mh.sf$state))
length(unique(mh.sf$state))


##### Part 2) Nearest Resource Analysis #####

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Check & transform CRS to projected EPSG:3857, with unit measurement of meters
st_crs(zips)
zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)

st_crs(mh.sf)
mh.sf <- st_transform(mh.sf, 3857)

### Calculate Centroids - Zip Codes ###
# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify pharmacy that is closest to zip centroid. 
# This will return index, so then subset MH providers by the index to get the nearest to each centroid. 
nearestMH_index <- st_nearest_feature(zipCentroids, mh.sf)
nearestMH <- mh.sf[nearestMH_index,]
nearestMH

# Calculate distance
minDistZips <- st_distance(zipCentroids, nearestMH, by_element = TRUE)
head(minDistZips) #meters

# Change from meters to miles
minDistZ_mi <- set_units(minDistZips, "mi")
head(minDistZ_mi)

# Merge data - rejoin minDist_mi to zips
minDistZips_sf <- cbind(zips, minDistZ_mi)
head(minDistZips_sf)

# Clean up data
minDistZips_sf <- minDistZips_sf %>% select(GEOID10, ZCTA5CE10, AFFGEOID10, minDistZ_mi)
head(minDistZips_sf)

### Calculate Centroids - Census Tracts ###
# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify MH provider that is closest to tract centroid.  
# This will return an index, so then subset the providers by the index to get the nearest. 
nearestMH_index_tract <- st_nearest_feature(tractCentroids, mh.sf)
nearestMH_tract <- mh.sf[nearestMH_index_tract, ]
nearestMH_tract

# Calculate distance
minDistTracts <- st_distance(tractCentroids, nearestMH_tract, by_element = TRUE)
head(minDistTracts) #meters

# Change from meters to miles
minDistTracts_mi <- set_units(minDistTracts, "mi")
head(minDistTracts_mi)

# Merge data - rejoin minDist_mi to zips
minDistTracts_sf <- cbind(tracts, minDistTracts_mi)
head(minDistTracts_sf)

# Clean up data
minDistTracts_sf <- minDistTracts_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, minDistT_mi = minDistTracts_mi)
head(minDistTracts_sf)


##### Part 3) Save final Access Metrics datasets #####

# Save zips
write_sf(minDistZips_sf, "data_final/Access05_Z.csv")

# Save tracts
write_sf(minDistTracts_sf, "data_final/Access05_T.csv")







