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

# Save zip file
write.csv(SUT_accessZ, "data_final/Access06_Z.csv", row.names = FALSE)


##### County Access #####

# Read in tract access
tract_SUT <- read.csv("data_final/Access06_T.csv")

# Add the leading 0 to GEOID
tract_SUT$GEOID <- sprintf("%011s", tract_SUT$GEOID)

# Pull out full county FIPS codes 
tract_SUT$COUNTYFP <- substr(tract_SUT$GEOID, 1, 5)
head(tract_SUT)

# Count the number of tracts that are driving time < 30, and average driving time for each county
county_SUT <- tract_SUT %>%
  group_by(COUNTYFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30),
            avTimeDrive = mean(timeDrive)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))

head(county_SUT)


##### State Access #####

# Group by state-level

# Full out State FIPS code
tract_SUT$STATEFP <- substr(tract_SUT$GEOID, 1, 2)

state_SUT <- tract_SUT %>%
  group_by(STATEFP) %>%
  summarise(cntT = n(),
            cntTimeDrive = sum(timeDrive <= 30, na.rm = TRUE),
            avTimeDrive = round(mean(timeDrive, na.rm = TRUE), 2)) %>%
  mutate(pctTimeDrive = round(cntTimeDrive/cntT, 2))

head(state_SUT)

##### Save state and county files #####

# County
write.csv(county_SUT, "data_final/Access06_C.csv", row.names = FALSE)

# State
write.csv(state_SUT, "data_final/Access06_S.csv", row.names = FALSE)




