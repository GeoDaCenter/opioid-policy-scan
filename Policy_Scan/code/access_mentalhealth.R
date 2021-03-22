#### About ----

# Author : Susan Paykin
# Date : January 9, 2021
# About: This code prepares the nearest distance metrics as a proxy for access to mental health providers for all U.S. ZCTAs and census tracts. 

# Part 1) Prepare data: wrangle and clean national mental health provider data
# Loads the complete raw dataset, selects relevant variables, geocodes addresses, and saves the cleaned dataset in the data_raw folder. 

# Part 2) Conduct nearest resource analysis: minimum distance as proxy for access
# Calculates distance to nearest mental health provider from ZCTA and tract centroids. 

# Part 3) Save final datasets
# Creates new csv files, saved in the data_final folder. 

#### Part 1) Prepare mental health provider data ----

# Set up 
library(tidyverse)
library(sf)
library(tmap)
library(units)
library(tidygeocoder)

# # Load raw data
# mh_providers <- read.csv("Policy_Scan/data_raw/mentalhealth_raw.csv")
# str(mh_providers)
# 
# # Remove first variable and extra variables
# mh_providers <- mh_providers %>% select(-"X")
# mh_providers <- mh_providers[,1:17]
# 
# # Explore: convert to spatial data
# mh.sf <- st_as_sf(mh_providers,
#                   coords = c("longitude", "latitude"),
#                   crs = 4326)
# # Test plot
# tmap_mode("view")
# tm_shape(mh.sf) +
#   tm_dots()
# # Arkansas and Wyoming are missing!
# 
# # Load AR and WY state data
# ark <- read.csv("data_raw/mentalhealth_ark.csv")
# wy <- read.csv("data_raw/mentalhealth_wy.csv")
# 
# names(ar)
# names(wy)
# names(mh_providers)
# 
# mh_providers <- rbind(mh_providers, ark, wy)
# str(mh_providers)
# 
# # Save provider dataset
# # write.csv(mh_providers, "data_raw/mentalhealth_clean.csv")

# Read in dataset
mh_providers <- read.csv("Policy_Scan/data_raw/mentalhealth_clean.csv")

# Convert to spatial data
mh.sf <- st_as_sf(mh_providers,
                  coords = c("longitude", "latitude"),
                  crs = 4326)

# Test plot
plot(st_geometry(mh.sf))

##### Part 2) Nearest Resource Analysis ----

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

# Check & transform CRS to projected EPSG:3857, with unit measurement of meters
zips <- st_transform(zips, 3857)
tracts <- st_transform(tracts, 3857)
st_crs(mh.sf)
mh.sf <- st_transform(mh.sf, 3857)

### Nearest providers - ZCTA ----

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)
zipCentroids

# Identify pharmacy that is closest to zip centroid. 
# This will return index, so then subset MH providers by the index to get the nearest to each centroid. 
nearestMH_index <- st_nearest_feature(zipCentroids, mh.sf)
nearestMH <- mh.sf[nearestMH_index,]

# Calculate distance
minDistZipsMH <- st_distance(zipCentroids, nearestMH, by_element = TRUE)
head(minDistZipsMH) #meters

# Change from meters to miles
minDistZipsMH_mi <- set_units(minDistZipsMH, "mi")
head(minDistZipsMH_mi)

# Merge data - rejoin minDist_mi to zips
minDistZipsMH_sf <- cbind(zips, minDistZipsMH_mi)
head(minDistZipsMH_sf)

# Clean up data
minDistZipsMH_sf <- minDistZipsMH_sf %>% select(ZCTA = ZCTA5CE10, minDisMH = minDistZipsMH_mi)
head(minDistZipsMH_sf)

#### Nearest providers - Tracts ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)
head(tractCentroids)

# Identify MH provider that is closest to tract centroid.  
# This will return an index, so then subset the providers by the index to get the nearest. 
nearestMH_index_tract <- st_nearest_feature(tractCentroids, mh.sf)
nearestMH_tract <- mh.sf[nearestMH_index_tract, ]
nearestMH_tract

# Calculate distance
minDistTractsMH <- st_distance(tractCentroids, nearestMH_tract, by_element = TRUE)
head(minDistTractsMH) #meters

# Change from meters to miles
minDistTractsMH_mi <- set_units(minDistTractsMH, "mi")
head(minDistTractsMH_mi)

# Merge data - rejoin minDist_mi to zips
minDistTractsMH_sf <- cbind(tracts, minDistTractsMH_mi)
head(minDistTractsMH_sf)

# Clean up data
minDistTractsMH_sf <- minDistTractsMH_sf %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, minDisMH = minDistTractsMH_mi)
head(minDistTractsMH_sf)

##### Part 3) Save final datasets ----

# Save ZCTA file
write_sf(minDistZipsMH_sf, "Policy_Scan/data_final/Access05_Z.csv")

# Save tract file
write_sf(minDistTractsMH_sf, "Policy_Scan/data_final/Access05_T.csv")


