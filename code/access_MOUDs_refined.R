##### ABOUT #####
# This script adds travel spatial access metrics at the tract and ZIP code levels level to the existing minimum distance access metrics.

# Set directory
setwd("~/git/opioid-policy-scan")

# Load libraries
library(tidyverse)
library(sf)

##### Tract Access #####

# Load tract-level MOUD travel access metrics
tract_travel <- read.csv("data_raw/Access01_T2.csv")

# Check old data
tract_old <- read.csv("data_final/Access01_T.csv")

# Load tract-level min distance
minDistTracts_clean <- read.csv("data_raw/MOUDMinDis_T.csv") 

# Merge tract travel with min. distance 
tract_drive <- left_join(tract_travel, minDistTracts_clean, by="GEOID")

# Select variables
tract_drive <- tract_drive %>% select(GEOID, STATEFP, COUNTYFP, TRACTCE, 
                                        moudMinDis,
                                        bupMinDis, bupTimeDrive = bupTime, bupCountDrive30 = bupCount,
                                        metMinDis, metTimeDrive = metTime, metCountDrive30 = metCount,
                                        nalMinDis, nalTimeDrive = nalTime, nalCountDrive30 = nalCount)

# Load in walking and biking metrics
tract_walk <- read.csv("code/Access Metrics/Tract/Walking/moud_tract_walkAccess.csv")
tract_bike <- read.csv("code/Access Metrics/Tract/Biking/moud_tract_bikeAccess.csv")

# Merge driving and distance metrics, with walking and biking
tract_all <- left_join(tract_drive, tract_walk, by = "GEOID") %>%
  left_join(., tract_bike, by="GEOID")

str(tract_all)

##### ZIP Code Access #####

# Load zip-level MOUD travel access metrics
zip_old <- read.csv("data_final/Access01_Z.csv")

# Load zip-level min distance
minDistZips_clean <- read.csv("data_raw/MOUDMinDis_Z.csv")

# Merge zip with new min dis
zip_drive <- left_join(zip_old, minDistZips_clean, by="ZCTA")
str(zip_drive)

zip_drive <- zip_drive %>% select(ZCTA, 
                                    moudMinDis = moudMinDis.y,
                                    bupMinDis = bupMinDis.y, bupTimeDrive = bupTime, bupCountDrive30 = bupCount,
                                    metMinDis = metMinDis.y, metTimeDrive = metTime, metCountDrive30 = metCount,
                                    nalMinDis = nalMinDis.y, nalTimeDrive = nalTime, nalCountDrive30 = nalCount)

# Load in walking and biking metrics
zip_walk <- read.csv("code/Access Metrics/Zip Code/Walking/moud_zip_walkAccess.csv")
zip_bike <- read.csv("code/Access Metrics/Zip Code/Biking/moud_zip_bikeAccess.csv")

# Merge driving and distance metrics, with walking and biking
zip_all <- left_join(zip_drive, zip_walk, by = "ZCTA") %>%
  left_join(., zip_bike, by="ZCTA")

str(zip_all)

##### Save tract and zip final files #####

# Tract
write.csv(tract_all, "data_final/Access01_T.csv", row.names = FALSE)

# Zip
write.csv(zip_all, "data_final/Access01_Z.csv", row.names = FALSE)

##### County Access #####

# Read in tract access
tract_moud <- read.csv("../data_final/Access01_T.csv")

# Add the leading 0 to GEOID
tract_moud$GEOID <- str_pad(tract_moud$GEOID, 11, 'left', '0')

# Pull out full county FIPS codes 
tract_moud$COUNTYFP <- substr(tract_moud$GEOID, 1, 5)

# Count the number of tracts that are travel time < 30 by all three modalities, and average trave time for each county
county_moud <- tract_moud %>%
  group_by(COUNTYFP) %>%
  summarise(cntT = n(),
            BupCtTmDr = sum(bupTimeDrive <= 30),
            MetCtTmDr = sum(metTimeDrive <= 30),
            NalCtTmDr = sum(nalTimeDrive <= 30),
            BupCtTmBk = sum(bupTimeBike  <= 30),
            MetCtTmBk = sum(metTimeBike  <= 30),
            NalCtTmBk = sum(nalTimeBike  <= 30),
            BupCtTmWk = sum(bupTimeWalk  <= 30),
            MetCtTmWk = sum(metTimeWalk  <= 30),
            NalCtTmWk = sum(nalTimeWalk  <= 30),
            BupAvTmDr = mean(bupTimeDrive),
            MetAvTmDr = mean(metTimeDrive),
            NalAvTmDr = mean(nalTimeDrive),
            BupAvTmBk = mean(bupTimeBike),
            MetAvTmBk = mean(metTimeBike),
            NalAvTmBk = mean(nalTimeBike),
            BupAvTmWk = mean(bupTimeWalk),
            MetAvTmWk = mean(metTimeWalk),
            NalAvTmWk = mean(nalTimeWalk)
  ) %>%
  mutate(BupTmDrP = round(BupCtTmDr / cntT, 2),
         MetTmDrP = round(MetCtTmDr / cntT, 2),
         NalTmDrP = round(NalCtTmDr / cntT, 2),
         BupTmBkP = round(BupCtTmBk / cntT, 2),
         MetTmBkP = round(MetCtTmBk / cntT, 2),
         NalTmBkP = round(NalCtTmBk / cntT, 2),
         BupTmWkP = round(BupCtTmWk / cntT, 2),
         MetTmWkP = round(MetCtTmWk / cntT, 2),
         NalTmWkP = round(NalCtTmWk / cntT, 2)
  )

##### State Access #####

# Group by state-level

# Full out State FIPS code
tract_moud$STATEFP <- substr(tract_moud$GEOID, 1, 2)
  
state_moud <- tract_moud %>%
  group_by(STATEFP) %>%
  summarise(cntT = n(),
            cntBupT = sum(bupTimeDrive <= 30, na.rm = TRUE),
            cntMetT = sum(metTimeDrive <= 30, na.rm = TRUE),
            cntNalT = sum(nalTimeDrive <= 30, na.rm = TRUE),
            avBupTime = round(mean(bupTimeDrive, na.rm = TRUE),2),
            avMetTime = round(mean(metTimeDrive, na.rm = TRUE),2),
            avNalTime = round(mean(nalTimeDrive, na.rm = TRUE),2)) %>%
  mutate(pctBupT = round(cntBupT/cntT, 2),
         pctMetT = round(cntMetT/cntT, 2),
         pctNalT = round(cntNalT/cntT, 2))

##### Save state and county files #####

# County
write.csv(county_moud, "data_final/Access01_C.csv", row.names = FALSE)

# State
write.csv(state_moud, "data_final/Access01_S.csv", row.names = FALSE)
