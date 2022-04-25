library(tidyverse)

##### Merge travel access metrics - Tract #####

setwd("~/git/opioid-policy-scan")

# Read in minimum distance access
SUT_minDis_T <- read.csv("data_final/Access06_T.csv")
head(SUT_minDis_T)

# Read in driving metrics, rename variables
SUT_drive <- read.csv("code/Access Metrics - Health Resources/Tract/Driving/SUT_drive_tract.csv") %>%
  rename(GEOID = origin,
         countDrive = count.within.30,
         timeDrive = minutes)
head(SUT_drive)

# Merge
SUT_accessT <- left_join(SUT_drive, SUT_minDis_T, by = "GEOID")
head(SUT_accessT)

SUT_accessT <- SUT_accessT %>% select(GEOID,
                                      minDisSUT = sutMinDis,
                                      timeDrive, 
                                      countDrive)
head(SUT_accessT)

# Save file
write.csv(SUT_accessT, "data_final/Access06_T.csv", row.names = FALSE)

##### Merge travel access metrics - Zip Code #####

# Read in minimum distance access
SUT_minDis_Z <- read.csv("data_final/Access06_Z.csv")
head(SUT_minDis_Z)

# Read in driving metrics, rename variables
SUT_drive <- read.csv("code/Access Metrics - Health Resources/Zip Code/Driving/SUT_drive_zip.csv") %>%
  rename(ZCTA = origin,
         countDrive = count.within.30,
         timeDrive = minutes)
head(SUT_drive)

# Merge
SUT_accessZ <- left_join(SUT_drive, SUT_minDis_Z, by = "ZCTA")
head(SUT_accessZ)

SUT_accessZ <- SUT_accessZ %>% select(ZCTA, 
                                      minDisSUT = minDist_SUT,
                                      timeDrive,
                                      countDrive)

head(SUT_accessZ)

# Save file
write.csv(SUT_accessZ, "data_final/Access06_Z.csv", row.names = FALSE)
