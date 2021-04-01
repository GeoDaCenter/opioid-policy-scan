#### About ----

# Author : Susan Paykin
# Date : January 7, 2021
# About: This code prepares the metrics on Access to Hospitals via nearest resource analysis for all U.S. zip codes and census tracts. 

# Part 1) Prepare data: Clean and wrangle national hospital data.
# Loads the data source saves the cleaned pharmacy dataset in the data_raw folder. 

# Part 2) Conduct nearest resource analysis: Minimum distance as proxy for access.
# Caculate the distance from census tracts and zip code tracts to hospitals. 

# Part 3) Save final datasets. 
# Creates new csv files with access metrics by tracts and ZCTAs, saved in the data_final folder. 

#### Part 1) Prepare hospital data ----

# Load libraries
library(tidyverse)
library(tmap)
library(sf)
library(units)

# Read in data
data <- "https://raw.githubusercontent.com/covidcaremap/covid19-healthsystemcapacity/v0.2/data/published/us_healthcare_capacity-facility-CovidCareMap.csv"
hospitals <- read.csv(data)

# Save raw hospital dataset
# write.csv(hospitals, "data_raw/hospitals_raw.csv")

# Read in hospitals data, remove overseas territories
hospitals <- read.csv("Policy_Scan/data_raw/hospitals_raw.csv") %>%
  filter(!State %in% c("GU", "MP", "PW", "AS", "VI"))
unique(hospitals$State)

#### Part 2) Nearest Resource Analysis ----

# Convert to spatial data
hospitals.sf <- st_as_sf(hospitals,
                         coords = c("Longitude", "Latitude"),
                         crs = 4326)
str(hospitals.sf)

# Clean up & select relevant variables
hospitals.sf <- hospitals.sf[,1:8]
str(hospitals.sf)

# Simple plot
plot(st_geometry(hospitals.sf))

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Transform CRS to projected EPSG:3857, with unit measurement of meters
zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)
hospitals.sf <- st_transform(hospitals.sf, 3857)

##### Nearest Hospital - ZCTA ----

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify hospital that is closest to zip centroid. 
# Will return index, so then subset pharmacies by the index to get the nearest hc. 
nearestHospital_index <- st_nearest_feature(zipCentroids, hospitals.sf)
nearestHospital <-  hospitals.sf[nearestHospital_index,]
head(nearestHospital)

# Calculate distance
minDistZipsHosp <- st_distance(zipCentroids, nearestHospital, by_element = TRUE)
head(minDistZipsHosp) #meters

# Change from meters to miles
minDistZipsHosp_mi <- set_units(minDistZipsHosp, "mi")
head(minDistZipsHosp_mi)

# Merge data - rejoin minDist_mi to zips
minDistZipsHosp_sf <- cbind(zips, minDistZipsHosp_mi)
head(minDistZipsHosp_sf)

# Clean up data
minDistZipsHosp_sf <- minDistZipsHosp_sf %>% select(ZCTA = ZCTA5CE10, minDisHosp = minDistZipsHosp_mi)
head(minDistZipsHosp_sf)

##### Nearest Hospital - Tracts ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify health center that is closest to tract centroid.  
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHospital_index_tract <- st_nearest_feature(tractCentroids, hospitals.sf)
nearestHospital_tract <- hospitals.sf[nearestHospital_index_tract, ]
head(nearestHospital_tract)

# Calculate distance
minDistTractsHosp <- st_distance(tractCentroids, nearestHospital_tract, by_element = TRUE)
head(minDistTractsHosp) #meters

# Change from meters to miles
minDistTractsHosp_mi <- set_units(minDistTractsHosp, "mi")
head(minDistTractsHosp_mi)

# Merge data - rejoin minDist_mi to zips
minDistTractsHosp_sf <- cbind(tracts, minDistTractsHosp_mi)
head(minDistTractsHosp_sf)

# Clean up data
minDistTractsHosp_sf <- minDistTractsHosp_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, 
                                                        minDisHosp = minDistTractsHosp_mi)
head(minDistTractsHosp_sf)

#### Part 3) Save final datasets ----

# Save ZCTA file
write_sf(minDistZipsHosp_sf, "Policy_Scan/data_final/Access03_Z.csv")

# Save tract file
write_sf(minDistTractsHosp_sf, "Policy_Scan/data_final/Access03_T.csv")



