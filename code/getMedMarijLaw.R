# Author : Qinyun LIn
# Date : March 2nd, 2021
# This code select medical marijuana policy variables from the raw data. 

# Load libraries
library(readxl)
library(tidyverse)
library(sf)

# read in raw data
raw <- read_excel("data_raw/20170919.MM.Caregiver.Stat.Data.xlsx")

# select PDMP variables
raw <- raw  %>% 
  filter(as.character(`Valid Through Date`) == '2017-02-01') %>% 
  select(Jurisdictions, `mmc-lgl`)

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$NAME[!(state_2018$NAME %in% raw$Jurisdictions)]

# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, NAME)

raw <- merge(state_2018_GEOID, raw, by.x = "NAME", by.y = "Jurisdictions") 
raw  <- as.data.frame(raw)
raw$geometry <- NULL
raw$NAME <- NULL

# rename variables 
colnames(raw) <- c("STATEFP", "MedMarijLaw")

# Save final dataset
write.csv(raw,"data_final/PS09_2017_S.csv", row.names = FALSE)






