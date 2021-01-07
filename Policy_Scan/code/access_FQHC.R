########### INTRO ###########

# Author : Susan Paykin
# Date : January 5, 2021
# About: This code will:
  # - clean Federal Qualified Health Center (FQHC) data
  # - evaluate minimum distance from Census Tracts and Zip Codes Areas to FQHCs
  # - create new shapefiles and final csv with minimum distances at tract and zip spatial scales.  

##### Set Up #####

# Load libraries
library(sf)
library(tmap)
library(tidyverse)
library(units)

# Set working directory
setwd("~/git/opioid-policy-scan/Policy_Scan")

# Read in CSV data (stored in data_raw)
fqhc_raw <- read.csv("data_raw/FQHC.csv")
head(fqhc_raw)
str(fqhc_raw)

# Remove centers in Mariana Islands (MP), Guam (GU)
# Question: Should also filter out American Samoa, PR? 
fqhc <- fqhc_raw %>%
  filter(!st_abbr %in% c("GU", "MP"))

##### Convert to spatial data #####

fqhc_sf <- st_as_sf(fqhc,
                    coords = c("lon", "lat"),
                    crs = 4326)
# Check geometry
head(data.frame(fqhc_sf))

# Visualize Points
plot(fqhc_sf$geometry) #simple plot

tmap_mode("view")
tm_shape(fqhc_sf) + tm_dots()

# Save data
# write_sf(fqhc_sf, "data_raw/fqhc.shp")

##### Nearest Resource Analysis #####

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

head(zips)
head(tracts)

# Check subsets
zips_subset <- zips[1:1000,]
plot(zips_subset$geometry)
tracts_subset <- tracts[1:1000,]
plot(tracts_subset$geometry)

# Check CRS
st_crs(fqhc_sf)
st_crs(zips) # need to project ? EPSG 3857, meters

zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)
fqhc_sf <- st_transform(fqhc_sf, 3857)

st_crs(zips)
st_crs(fqhc_sf)

##### Calculate Centroids - Zip Codes #####

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify health center that is closest to zip centroid. 
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHC_index <- st_nearest_feature(zipCentroids, fqhc_sf)
nearestHC <- fqhc_sf[nearestHC_index,]
nearestHC

# Calculate distance
minDistZips <- st_distance(zipCentroids, nearestHC, by_element = TRUE)
head(minDistZips) #meters

# Change from meters to miles
minDistZips_mi <- set_units(minDistZips, "mi")
head(minDistZips_mi)

# Merge data - rejoin minDist_mi to zips
minDistZips_sf <- cbind(zips, minDistZips_mi)
head(minDistZips_sf)

# Clean up data
minDistZips_sf <- minDistZips_sf %>% select(GEOID10, ZCTA5CE10, AFFGEOID10, minDistZips_mi)

##### Calculate Centroids - Census Tracts #####

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify health center that is closest to tract centroid.  
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHC_index_tract <- st_nearest_feature(tractCentroids, fqhc_sf)
nearestHC_tract <- fqhc_sf[nearestHC_index_tract,]
nearestHC_tract

# Calculate distance
minDistTracts <- st_distance(tractCentroids, nearestHC_tract, by_element = TRUE)
head(minDistTracts) #meters

# Change from meters to miles
minDistTracts_mi <- set_units(minDistTracts, "mi")
head(minDistZips_mi)

# Merge data - rejoin minDist_mi to zips
minDistTracts_sf <- cbind(tracts, minDistTracts_mi)
head(minDistTracts_sf)

# Clean up data
minDistTracts_sf <- minDistTracts_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, minDistTracts_mi)

##### Save Data #####

# Save zips
write_sf(minDistZips_sf, "data_final/Access02_Z.csv")

# Save tracts
write_sf(minDistTracts_sf, "data_final/Access02_T.csv")
