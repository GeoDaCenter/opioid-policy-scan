#### About ----

# Author : Susan Paykin
# Date : January 5, 2021
# About: This code will:
  # Part 1) Prepare Data - wrangle and clean Federal Qualified Health Center (FQHC) data
  # Part 2) Conduct Nearest Resource Analysis - evaluate minimum distance from Tract and ZCTA centroids to FQHCs
  # Part 3) Save final datasets  

#### Part 1) Prepare Data - wrangle and clean data ----

# Load libraries
library(sf)
library(tmap)
library(tidyverse)
library(units)

# Read in data
fqhc_raw <- read.csv("Policy_Scan/data_raw/FQHC.csv")
str(fqhc_raw)

# Remove territories
fqhc <- fqhc_raw %>%
  filter(!st_abbr %in% c("GU", "MP", "AS"))

# Convert to spatial data
fqhc_sf <- st_as_sf(fqhc,
                    coords = c("lon", "lat"),
                    crs = 4326)

# Simple plot
plot(fqhc_sf$geometry) #simple plot

#### Part 2) Nearest Resource Analysis ----

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Check CRS
st_crs(fqhc_sf)
st_crs(zips)

# Transform CRS
zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)
fqhc_sf <- st_transform(fqhc_sf, 3857)

#### Nearest FQHC - ZCTA ----

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)

# Identify health center that is closest to zip centroid. 
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHC_index <- st_nearest_feature(zipCentroids, fqhc_sf)
nearestHC <- fqhc_sf[nearestHC_index,]
nearestHC

# Calculate distance
HCminDistZips <- st_distance(zipCentroids, nearestHC, by_element = TRUE)
head(HCminDistZips) #meters

# Change from meters to miles
HCminDistZips_mi <- set_units(HCminDistZips, "mi")
head(HCminDistZips_mi)

# Merge data - rejoin minDist_mi to zips
HCminDistZips_sf <- cbind(zips, HCminDistZips_mi)
head(HCminDistZips_sf)

# Clean up data
HCminDistZips_sf <- HCminDistZips_sf %>% select(ZCTA = ZCTA5CE10, minDisFQHC = HCminDistZips_mi)
head(HCminDistZips_sf)

#### Nearest FQHC - Tract ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify health center that is closest to tract centroid.  
# Will return index, so then subset the fqhcs by the index to get the nearest hc. 
nearestHC_index_tract <- st_nearest_feature(tractCentroids, fqhc_sf)
nearestHC_tract <- fqhc_sf[nearestHC_index_tract,]
nearestHC_tract

# Calculate distance
HCminDistTracts <- st_distance(tractCentroids, nearestHC_tract, by_element = TRUE)
head(HCminDistTracts) #meters

# Change from meters to miles
HCminDistTracts_mi <- set_units(HCminDistTracts, "mi")
head(HCminDistZips_mi)

# Merge data - rejoin minDist_mi to zips
HCminDistTracts_sf <- cbind(tracts, HCminDistTracts_mi)
head(HCminDistTracts_sf)

# Clean up data
HCminDistTracts_sf <- HCminDistTracts_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, 
                                                    minDisFQHC = HCminDistTracts_mi)
head(HCminDistTracts_sf)

##### Part 3) Save final datasets

# Save zips
write_sf(HCminDistZips_sf, "Policy_Scan/data_final/Access02_Z.csv")

# Save tracts
write_sf(HCminDistTracts_sf, "Policy_Scan/data_final/Access02_T.csv")
