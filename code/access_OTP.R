# Author: Ashlynn Wimer
# Date: July 17th, 2023
# About: This script prepares the nearest distance metrics to Opioid Treatment 
# Programs at the tract and zip level, merges those metrics into the drive time
# metrics calculated in a separate script, cleans the files, and then saves them.

# It is essentially just a modification of access_mentalhealth.R, a script 
# written by Susan Paykin in January 2021. 

# Libraries #
library(dplyr)
library(stringr)
library(sf)
library(units)

# Read in point dataset
opioid_treatment_progs <- read.csv("Access Metrics - Health Resources/Tract/Driving/OpioidTreatmentProgram_Geocoded.csv")

# Convert to spatial data
otp.sf <- st_as_sf(opioid_treatment_progs,
                   coords = c('Longitude', 'Latitude'),
                   crs = 4326)

### Nearest Resource Analysis

# Read in location Data
zips <- read_sf("../data_final/geometryFiles/tl_2018_zcta/zctas2018.shp")
tracts <- read_sf("../data_final/geometryFiles/tl_2018_tract/tracts2018.shp")

zips <- zips |> st_transform(3857)
tracts <- tracts |> st_transform(3857)
otp.sf <- otp.sf |> st_transform(3857)

### Nearest OTP - ZCTAs ----

# Create centroids for ZCTAs
zipCentroids <- st_centroid(zips)

# Identify the OTP that is nearest to the zip centroid
nearestOTP_index <- st_nearest_feature(zipCentroids, otp.sf)
nearestOTP <- otp.sf[nearestOTP_index,]

# Calculate distance
minDistZipsOTP <- st_distance(zipCentroids, nearestOTP, by_element = TRUE)
head(minDistZipsOTP)

# Convert to miles
minDistZipsOTP_mi <- set_units(minDistZipsOTP, "mi")

# Merge data - everything is ordered so cbind works.
minDistZipsOTP_sf <- cbind(zips, minDistZipsOTP_mi)
head(minDistZipsOTP_sf)

# Clean up
minDistZipsOTP_sf <- minDistZipsOTP_sf |> 
  select(ZCTA = ZCTA5CE10, 
         minDisOTP = minDistZipsOTP_mi) |>
  mutate(ZCTA = str_pad(ZCTA, width=5, side='left', pad='0')) |>
  st_drop_geometry()

### Nearest OTP - Tracts ----

# Create centroids for tracts
tractCentroids <- st_centroid(tracts)

# Identify the OTP that is nearest to the tract centroid
nearestOTP_index <- st_nearest_feature(tractCentroids, otp.sf)
nearestOTP <- otp.sf[nearestOTP_index,]

# Calculate distance
minDistTractsOTP <- st_distance(tractCentroids, nearestOTP, by_element = TRUE)
head(minDistTractsOTP)

# Convert units to miles.
minDistTractsOTP_mi <- set_units(minDistTractsOTP, "mi")

# Merge data - everything is ordered so cbind works.
minDistTractsOTP_sf <- cbind(tracts, minDistTractsOTP_mi)
head(minDistTractsOTP_sf)

# Clean up data
minDistTractsOTP_sf <- minDistTractsOTP_sf |>
  select(GEOID, STATEFP, COUNTYFP, 
         TRACTCE, minDisOTP = minDistTractsOTP_mi) |>
  mutate(GEOID = str_pad(GEOID, width=11, side='left', pad='0')) |>
  st_drop_geometry()

### Merge travel access metrics -- Tracts #####

# Read in driving times, rename variables and clean GEOID
tract_drive <- read.csv('Access Metrics - Health Resources/Tract/Driving/opioidtreatmentprogram_drive_tract.csv') |>
  rename(
    GEOID = origin,
    countDrive = count.within.30,
    timeDrive = minutes
    ) |> 
  mutate(GEOID = str_pad(GEOID, width=11, side='left', pad='0'))
head(tract_drive)

# Merge
otp_accessT <- left_join(tract_drive, minDistTractsOTP_sf, by='GEOID')
head(otp_accessT)

otp_accessT <- otp_accessT |> 
  select(GEOID, minDisOTP, timeDrive, countDrive)
head(otp_accessT)

# Save file
write.csv(otp_accessT, "../data_final/Access07_T.csv", row.names=FALSE)

##### Merge travel access metrics - Zip Code #####

# Read in driving metrics, rename variables, fix ZCTAs
otp_drive <- read.csv('Access Metrics - Health Resources/ZIP Code/Driving/opioidtreatmentprogram_drive_zip.csv') |>
  rename(ZCTA = origin,
         countDrive = count.within.30,
         timeDrive = minutes) |>
  mutate(ZCTA = str_pad(ZCTA, width=5, side='left', pad='0'))

# Merge
otp_accessZ <- left_join(otp_drive, minDistZipsOTP_sf, by='ZCTA')
head(otp_accessZ)

otp_accessZ <- otp_accessZ |>
  select(ZCTA, minDisOTP, countDrive, timeDrive)

head(otp_accessZ)

# Save file

write.csv(otp_accessZ, "../data_final/Access07_Z.csv", row.names=FALSE)

##### County Access #####

tract_OTP <- read.csv("../data_final/Access07_T.csv")

tract_OTP$GEOID <- str_pad(tract_OTP$GEOID, width=11, side='left', pad = '0')

tract_OTP$COUNTYFP <- substr(tract_OTP$GEOID, 1, 5)

county_OTP <- tract_OTP |>
  group_by(COUNTYFP) |>
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30),
            avTimeDrive = round(mean(timeDrive), 2)
            ) |>
  mutate(pctTimeDrive = round(cntTimeDrive / cntT, 2))

head(county_OTP)

##### State Access #####

tract_OTP$STATEFP <- substr(tract_OTP$GEOID, 1, 2)

state_OTP <- tract_OTP |>
  group_by(STATEFP) |>
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30, na.rm = TRUE),
            avTimeDrive = round(mean(timeDrive, na.rm=TRUE), 2)
            ) |>
  mutate(pctTimeDrive = round(cntTimeDrive / cntT, 2))

head(state_OTP)

### Save state and county files

# County
write.csv(county_OTP, "../data_final/Access07_C.csv", row.names=FALSE)

# State
write.csv(state_OTP, '../data_final/Access07_S.csv', row.names=FALSE)