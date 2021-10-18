#### About ----

# Author : Susan Paykin
# Date : March 15, 2021
# About: This code prepares the minimum distance metrics on access to Medications for Opioid Use Disorder (MOUDs)
# for all U.S. ZIP Code Tract Areas (ZCTAs), Census tracts, and counties.

#     Part 1) Prepare national MOUD location data

#     Part 2) Conduct nearest resource analysis: Minimum distance as proxy for access 
#     Calculate distance from ZCTA and tract centroids to nearest MOUD by type

#     Part 3) Save final datasets

#### Prepare MOUD data ----

# Set up 
library(tidyverse)
library(sf)
library(tmap)
library(units)

setwd("~/git/opioid-policy-scan")

# Load full MOUD dataset
mouds <- st_read("data_raw/us-wide-moudsCleaned.gpkg") %>%
  st_transform(3857)

# Subset MOUD by category
bup <- mouds %>% filter(category == "buprenorphine")
meth <- mouds %>% filter(category == "methadone")
nalViv <- mouds %>% filter(category == "naltrexone/vivitrol")

# Read in location data
zips <- read_sf("data_final/geometryFiles/tl_2018_zcta/zctas2018.shp") %>%
  st_transform(3857)
tracts <- read_sf("data_final/geometryFiles/tl_2018_tract/tracts2018.shp") %>%
  st_transform(3857)
counties <- read_sf("data_final/geometryFiles/tl_2018_county/counties2018.shp") %>%
  st_transform(3857)

#### Part 2) Nearest Resource Analysis ----

#### Nearest MOUD, Counties ----

# Create centroids for counties
countyCentroids <- st_centroid(counties)

#### All MOUD - County
# Identify MOUD that is closest to county centroid, then subset by index to get nearest location
nearestMOUD_index <- st_nearest_feature(countyCentroids, mouds)
nearestMOUD <- mouds[nearestMOUD_index, ]

# Calculate distance
minDistCounty <- st_distance(countyCentroids, nearestMOUD, by_element = TRUE)
head(minDistCounty) # meters

# Change from meters to miles
minDistCounty_mi <- set_units(minDistCounty, "mi")
head(minDistCounty_mi)

#### Buprenorphine - County
nearestbup_index <- st_nearest_feature(countyCentroids, bup)
nearestbup <- bup[nearestbup_index, ]
minDistBup <- st_distance(countyCentroids, nearestbup, by_element = TRUE)
minDistBup <- set_units(minDistBup, "mi")
head(minDistBup)

#### Methadone - County
nearestMeth_index <- st_nearest_feature(countyCentroids, meth)
nearestMeth <- meth[nearestMeth_index, ]
minDistMeth <- st_distance(countyCentroids, nearestMeth, by_element = TRUE)
minDistMeth <- set_units(minDistMeth, "mi")
head(minDistMeth)

#### NalViv - County
nearestnalViv_index <- st_nearest_feature(countyCentroids, nalViv)
nearestnalViv <- nalViv[nearestnalViv_index, ]
minDistnalViv <- st_distance(countyCentroids, nearestnalViv, by_element = TRUE)
minDistnalViv <- set_units(minDistnalViv, "mi")
head(minDistnalViv)

# Merge data
minDistCounty_clean <- cbind(counties, minDistCounty_mi, minDistBup, minDistMeth, minDistnalViv)
head(minDistCounty_clean)

# Clean up data
minDistCounty_clean <- minDistCounty_clean %>% select(STATEFP, 
                                                      COUNTYFP = GEOID,
                                                      minDisMOUD = minDistCounty_mi, 
                                                      minDisBup = minDistBup, 
                                                      minDisMeth = minDistMeth, 
                                                      minDisNalV = minDistnalViv) %>%
  filter(!STATEFP %in% c("15", "02", "66", "60", "72", "78")) %>%  # remove HI, AK, GU, AS MP, PR, VI
  st_drop_geometry()

head(minDistCounty_clean)

-----------


#### Nearest MOUD, ZCTA ----

# Create centroids for zip codes
zipCentroids <- st_centroid(zips)

#### All MOUD - ZCTA
# Identify MOUD that is closest to zip centroid, then subset by index to get nearest location
nearestMOUD_index <- st_nearest_feature(zipCentroids, mouds)
nearestMOUD <- mouds[nearestMOUD_index, ]

# Calculate distance
minDistZips <- st_distance(zipCentroids, nearestMOUD, by_element = TRUE)
head(minDistZips) # meters

# Change from meters to miles
minDistZips_mi <- set_units(minDistZips, "mi")
head(minDistZips_mi)

#### Buprenorphine - ZCTA
nearestbup_index <- st_nearest_feature(zipCentroids, bup)
nearestbup <- bup[nearestbup_index, ]
minDistBup <- st_distance(zipCentroids, nearestbup, by_element = TRUE)
minDistBup <- set_units(minDistBup, "mi")
head(minDistBup)

#### Methadone - ZCTA
nearestMeth_index <- st_nearest_feature(zipCentroids, meth)
nearestMeth <- meth[nearestMeth_index, ]
minDistMeth <- st_distance(zipCentroids, nearestMeth, by_element = TRUE)
minDistMeth <- set_units(minDistMeth, "mi")
head(minDistMeth)

#### NalViv - ZCTA
nearestnalViv_index <- st_nearest_feature(zipCentroids, nalViv)
nearestnalViv <- nalViv[nearestnalViv_index, ]
minDistnalViv <- st_distance(zipCentroids, nearestnalViv, by_element = TRUE)
minDistnalViv <- set_units(minDistnalViv, "mi")
head(minDistnalViv)

# Merge data
minDistZips_clean <- cbind(zips, minDistZips_mi, minDistBup, minDistMeth, minDistnalViv)
head(minDistZips_clean)

# Clean up data
minDistZips_clean <- minDistZips_clean %>% select(ZCTA = GEOID10, 
                                                  minDisMOUD = minDistZips_mi, 
                                                  minDisBup = minDistBup, 
                                                  minDisMeth = minDistMeth, 
                                                  minDisNalV = minDistnalViv) %>%
  filter(!str_detect(ZCTA, "^995|^996|^997|^998|^967|^968")) %>% # remove AK, HI
  st_drop_geometry()

head(minDistZips_clean)

#### Nearest MOUD, Tracts ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)

#### All MOUDs - Tracts
nearestMOUD_tract_index <- st_nearest_feature(tractCentroids, mouds)
nearestMOUD_tract <- mouds[nearestMOUD_tract_index, ]
minDistTracts <- st_distance(tractCentroids, nearestMOUD_tract, by_element = TRUE)
head(minDistTracts) # meters
minDistTracts_mi <- set_units(minDistTracts, "mi") # Change from meters to miles
head(minDistTracts_mi)

#### Buprenorphine - Tracts
nearestbup_index <- st_nearest_feature(tractCentroids, bup)
nearestbup <- bup[nearestbup_index, ]
minDistBup <- st_distance(tractCentroids, nearestbup, by_element = TRUE)
minDistBup <- set_units(minDistBup, "mi")
head(minDistBup)

#### Methadone - Tracts
nearestMeth_index <- st_nearest_feature(tractCentroids, meth)
nearestMeth <- meth[nearestMeth_index, ]
minDistMeth <- st_distance(tractCentroids, nearestMeth, by_element = TRUE)
minDistMeth <- set_units(minDistMeth, "mi")
head(minDistMeth)

#### NalViv - Tracts
nearestnalViv_index <- st_nearest_feature(tractCentroids, nalViv)
nearestnalViv <- nalViv[nearestnalViv_index, ]
minDistnalViv <- st_distance(tractCentroids, nearestnalViv, by_element = TRUE)
minDistnalViv <- set_units(minDistnalViv, "mi")
head(minDistnalViv)

# Merge data
minDistTracts_clean <- cbind(tracts, minDistTracts_mi, minDistBup, minDistMeth, minDistnalViv)
head(minDistTracts_clean)

# Clean up data
minDistTracts_clean <- minDistTracts_clean %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, 
                                                      minDisMOUD = minDistTracts_mi, 
                                                      minDisBup = minDistBup, 
                                                      minDisMeth = minDistMeth, 
                                                      minDisNalV = minDistnalViv) %>%
  filter(!STATEFP %in% c("15", "02", "66", "60", "72", "78")) %>%  # remove HI, AK, GU, AS MP, PR, VI
  st_drop_geometry()

head(minDistTracts_clean)

#### Part 3) Save final datasets ----

# Save county file
write.csv(minDistCounty_clean, "data_final/Access01_C.csv", row.names = FALSE)

# Save zip code file
#write.csv(minDistZips_clean, "data_final/Access01_Z.csv")

# Save tract file
write.csv(minDistTracts_clean, "data_final/Access01_T.csv", row.names = FALSE)

# County
county <- read.csv("opioid-policy-scan/data_final/Access01_C.csv")
county$COUNTYFP <- sprintf("%05d", county$COUNTYFP)
county$COUNTYFP <- as.character(county$COUNTYFP)
write.csv(county, "opioid-policy-scan/data_final/Access01_C.csv")


