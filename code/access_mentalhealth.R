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

# Identify mhacy that is closest to zip centroid. 
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

##### Merge travel access metrics - Tract #####

setwd("~/git/opioid-policy-scan")

# Read in minimum distance access
mentalhealth_minDis_T <- read.csv("data_final/Access05_T.csv")
head(mentalhealth_minDis_T)

# Read in driving metrics, rename variables
mentalhealth_drive <- read.csv("code/Access Metrics - Health Resources/Tract/Driving/mentalhealth_drive_tract.csv") %>%
  rename(GEOID = origin,
         countDrive = count.within.30,
         timeDrive = minutes)
head(mentalhealth_drive)

# Merge
mentalhealth_accessT <- left_join(mentalhealth_drive, mentalhealth_minDis_T, by = "GEOID")
head(mentalhealth_accessT)

mentalhealth_accessT <- mentalhealth_accessT %>% select(GEOID, minDisMH, timeDrive, countDrive)
head(mentalhealth_accessT)

# Save file
write.csv(mentalhealth_accessT, "data_final/Access05_T.csv", row.names = FALSE)

##### Merge travel access metrics - Zip Code #####

# Read in minimum distance access
mentalhealth_minDis_Z <- read.csv("data_final/Access05_Z.csv")
head(mentalhealth_minDis_Z)

# Read in driving metrics, rename variables
mentalhealth_drive <- read.csv("code/Access Metrics - Health Resources/Zip Code/Driving/mentalhealth_drive_zip.csv") %>%
  rename(ZCTA = origin,
         countDrive = count.within.30,
         timeDrive = minutes)
head(mentalhealth_drive)

# Merge
mentalhealth_accessZ <- left_join(mentalhealth_drive, mentalhealth_minDis_Z, by = "ZCTA")
head(mentalhealth_accessZ)

mentalhealth_accessZ <- mentalhealth_accessZ %>% select(ZCTA, minDisMH, timeDrive, countDrive)

head(mentalhealth_accessZ)

# Save file
write.csv(mentalhealth_accessZ, "data_final/Access05_Z.csv", row.names = FALSE)

##### County Access #####

# Read in tract access
tract_mh <- read.csv("data_final/Access05_T.csv")

# Add the leading 0 to GEOID
tract_mh$GEOID <- sprintf("%011s", tract_mh$GEOID)

# Pull out full county FIPS codes 
tract_mh$COUNTYFP <- substr(tract_mh$GEOID, 1, 5)
head(tract_mh)

# Count the number of tracts that are driving time < 30, and average driving time for each county
county_mh <- tract_mh %>%
  group_by(COUNTYFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30),
            avTimeDrive = mean(timeDrive)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))

head(county_mh)


##### State Access #####

# Group by state-level

# Full out State FIPS code
tract_mh$STATEFP <- substr(tract_mh$GEOID, 1, 2)

state_mh <- tract_mh %>%
  group_by(STATEFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30, na.rm = TRUE),
            avTimeDrive = round(mean(timeDrive, na.rm = TRUE), 2)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))

head(state_mh)

##### Save state and county files #####

# County
write.csv(county_mh, "data_final/Access05_C.csv", row.names = FALSE)

# State
write.csv(state_mh, "data_final/Access05_S.csv", row.names = FALSE)


