########### INFO ###########

# Author : Susan Paykin
# Date : January 7, 2021
# About: This code prepares the metrics on Access to Hospitals via nearest resource analysis for all U.S. zip codes and census tracts. 

# Part 1) Wrangle national hospital: 
# loads the data source saves the cleaned pharmacy dataset in the data_raw folder. 
# Part 2) Conduct nearest resource analysis, using minimum distance as proxy for access,
# determining the distance from census tracts and zip code tracts to hospitals. 
# Part 3) Save final Access Metrics datasets: 
# Create new csv files with access metrics by census tracts and zip codes, saved in the data_final folder. 

#### Set Up ####

library(tidyverse)
library(tmap)
library(sf)
library(units)

#### Part 1) Wrangle national hospital data ####

# Data sourced from CovidCareMap - https://github.com/covidcaremap/covid19-healthsystemcapacity/tree/master/data
# Read in data
data <- "https://raw.githubusercontent.com/covidcaremap/covid19-healthsystemcapacity/v0.2/data/published/us_healthcare_capacity-facility-CovidCareMap.csv"
hospitals <- read.csv(data)

# Save raw hospital dataset
# write.csv(hospitals, "data_raw/hospitals_raw.csv")

#### Part 2) Nearest Resource Analysis ####

str(hospitals)

# Convert to spatial data
hospitals.sf <- st_as_sf(hospitals,
                         coords = c("Longitude", "Latitude"),
                         crs = 4326)
str(hospitals.sf)

# Clean up & select relevant variables
hospitals.sf <- hospitals.sf[,1:8]
str(hospitals.sf)

plot(st_geometry(hospitals.sf))

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Check & transform CRS to projected EPSG:3857, with unit measurement of meters
st_crs(zips)
zips <- st_transform(zips, 3857)

tracts <- st_transform(tracts, 3857)

st_crs(hospitals.sf)
hospitals.sf <- st_transform(hospitals.sf, 3857)

##### Calculate Centroids - Zip Codes #####

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify hospital that is closest to zip centroid. 
# Will return index, so then subset pharmacies by the index to get the nearest hc. 
nearestHospital_index <- st_nearest_feature(zipCentroids, hospitals.sf)
nearestHospital <-  hospitals.sf[nearestHospital_index,]
head(nearestHospital)

# Calculate distance
minDistZips <- st_distance(zipCentroids, nearestHospital, by_element = TRUE)
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

##### Calculate Centroids - Tracts #####

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify health center that is closest to tract centroid.  
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHospital_index_tract <- st_nearest_feature(tractCentroids, hospitals.sf)
nearestHospital_tract <- hospitals.sf[nearestHospital_index_tract, ]
head(nearestHospital_tract)

# Calculate distance
minDistTracts <- st_distance(tractCentroids, nearestHospital_tract, by_element = TRUE)
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

#### Part 3) Save final Access datasets ####

# Save zips
write_sf(minDistZips_sf, "data_final/Access03_Z.csv")

# Save tracts
write_sf(minDistTracts_sf, "data_final/Access03_T.csv")



