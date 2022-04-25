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

#### Nearest FQHC - ZCTA #####

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

#### Nearest FQHC - Tract #####

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


##### Merge travel access metrics - Tract #####

setwd("~/git/opioid-policy-scan")

# Read in minimum distance access
fqhc_minDis_T <- read.csv("data_final/Access02_T.csv")

# Read in driving metrics, rename variables
fqhc_drive <- read.csv("code/Access Metrics - Health Resources/Tract/Driving/FQHC_drive_tract.csv") %>%
  rename(GEOID = origin,
         countDrive = count.within.30,
         timeDrive = minutes)

# Merge
fqhc_accessT <- left_join(fqhc_drive, fqhc_minDis, by = "GEOID")

fqhc_accessT <- fqhc_access %>% select(GEOID, minDisFQHC, timeDrive, countDrive)

# Save file
write.csv(fqhc_accessT, "data_final/Access02_T.csv", row.names = FALSE)

##### Merge travel access metrics - Zip Code #####

# Read in minimum distance access
fqhc_minDis_Zip <- read.csv("data_final/Access02_Z.csv")
head(fqhc_minDis_Zip)

# Read in driving metrics, rename variables
fqhc_drive <- read.csv("code/Access Metrics - Health Resources/Zip Code/Driving/FQHC_drive_zip.csv") %>%
  rename(ZCTA = origin,
         countDrive = count.within.30,
         timeDrive = minutes)
head(fqhc_drive)

# Merge
fqhc_accessZIP <- left_join(fqhc_drive, fqhc_minDis_Zip, by = "ZCTA")
head(fqhc_accessZIP)

fqhc_accessZIP <- fqhc_accessZIP %>% select(ZCTA, minDisFQHC, timeDrive, countDrive)

head(fqhc_accessZIP)

# Save zip file
write.csv(fqhc_accessZIP, "data_final/Access02_Z.csv", row.names = FALSE)

##### County Access #####

# Read in tract access
tract_fqhc <- read.csv("data_final/Access02_T.csv")

# Add the leading 0 to GEOID
tract_fqhc$GEOID <- sprintf("%011s", tract_fqhc$GEOID)

# Pull out full county FIPS codes 
tract_fqhc$COUNTYFP <- substr(tract_fqhc$GEOID, 1, 5)

# Count the number of tracts that are driving time < 30, and average driving time for each county
county_fqhc <- tract_fqhc %>%
  group_by(COUNTYFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30),
            avTimeDrive = mean(timeDrive)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))


##### State Access #####

# Group by state-level

# Full out State FIPS code
tract_fqhc$STATEFP <- substr(tract_fqhc$GEOID, 1, 2)

state_fqhc <- tract_fqhc %>%
  group_by(STATEFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30, na.rm = TRUE),
            avTimeDrive = round(mean(timeDrive, na.rm = TRUE), 2)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))

##### Save state and county files #####

# County
write.csv(county_fqhc, "data_final/Access02_C.csv", row.names = FALSE)

# State
write.csv(state_fqhc, "data_final/Access02_S.csv", row.names = FALSE)




