# Author : Qinyun LIn
# Date : Jan 7th, 2020
# This code select PDMP variables from the raw data. 

library(readxl)
library(tidyverse)
library(sf)


# read in raw data
#PDMP <- read_excel("data_raw/policy/PDMP 12-2020/WEB_OPTIC_PDMP.xlsx", sheet = "WEB_PDMP")
PDMP <- read_excel("data_raw/WEB_OPTIC_PDMP.xlsx", sheet = "WEB_PDMP")

# select PDMP variables
PDMP_2017 <- PDMP  %>% 
  filter(year=="2017")

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$STUSPS[!(state_2018$STUSPS %in% PDMP_2017$state)]

# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, STUSPS)

PDMP_2017 <- merge(state_2018_GEOID, PDMP_2017, by.x = "STUSPS", by.y = "state") 
PDMP_2017 <- as.data.frame(PDMP_2017)
PDMP_2017$geometry <- NULL
PDMP_2017$STUSPS <- NULL

# rename variables 
colnames(PDMP_2017) <- c("STATEFP", "Year", 
                         "AnyPDMPfr", "AnyPDMPHfr", "OpPDMPfr", "MsAcPDMPfr", "ElcPDMPfr",
                         "AnyPDMPdt", "AnyPDMPHdt", "OpPDMPdt", "MsAcPDMPdt", "ElcPDMPdt")

# Save final dataset
write.csv(PDMP_2017,"data_final/PS03_2017_S.csv", row.names = FALSE)






