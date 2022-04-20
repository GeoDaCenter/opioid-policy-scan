#### ABOUT
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

##### Save final files

# Tract
write.csv(tract_all, "data_final/Access01_T.csv", row.names = FALSE)

# Zip
write.csv(zip_all, "data_final/Access01_Z.csv", row.names = FALSE)


# # Load full refined access metrics dataset
# all_access <- read.csv("opioid-projects/moud_zip_svi/data_final/allaccess_SVI_rurality_pop.csv")
# 
# str(all_access)
# 
# all_access_zip <- all_access %>%
#   select(ZCTA = originGEOID,
#          metMinDis = minDisMet, #methadone
#          metTime = time_to_nearest_methadone, 
#          metCount = count_in_range_methadone, 
#          metScore = methadone_score, 
#          bupTime = time_to_nearest_buprenorphine, 
#          bupCount = count_in_range_buprenorphine, 
#          bupScore = buprenorphine_score, 
#          nalMinDis = minDisNalV, #naltrexone
#          nalTime = time_to_nearest_naltrexone.vivitrol, 
#          nalCount = count_in_range_naltrexone.vivitrol, 
#          nalScore = naltrexone.vivitrol_score)
# 
# all_access_zip$ZCTA <- sprintf("%05d", all_access_zip$ZCTA)
# all_access_zip$ZCTA <- as.character(all_access_zip$ZCTA)
# 
# 
# #access01_z <- read.csv("opioid-policy-scan/data_final/Access01_Z.csv")
# 
# #access01_z_new <- left_join(access01_z, all_access_zip)
# #access01_z_new <- access01_z_new %>% 
# #  select(2:11)
# 
# # access01_z_new <- 
# #   access01_z_new %>% rename(
# #        moudMinDis = minDisMOUD,
# #        metMinDis = minDisMeth, 
# #        bupMinDis = minDisBup,
# #        nalMinDis = minDisNalV)
#        
# # Save final data
# write.csv(all_access_zip, "opioid-policy-scan/data_final/Access01_Z.csv")
