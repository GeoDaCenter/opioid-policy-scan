# Author : Qinyun LIn
# Date : Jan 7th, 2020
# This code select Naloxone policy variables from the raw data. 

library(readxl)
library(tidyverse)
library(sf)

# read in raw data
Nal <- read_excel("data_raw/WEB_NAL.xlsx", sheet = "WEB_NAL")

# select PDMP variables
Nal_2017 <- Nal  %>% 
  filter(year=="2017")

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$NAME[!(state_2018$NAME %in% Nal_2017$state)]

# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, NAME)

Nal_2017 <- merge(state_2018_GEOID, Nal_2017, by.x = "NAME", by.y = "state") 
Nal_2017  <- as.data.frame(Nal_2017)
Nal_2017$geometry <- NULL
Nal_2017$NAME <- NULL

# rename variables 
colnames(Nal_2017) <- c("STATEFP", "Year", 
                        "AnyNaldt", "NalPrStdt", "NalPresdt",
                        "AnyNalfr", "NalPrStfr", "NalPresfr")

write.csv(Nal_2017,"data_final/PS05_2017_S.csv", row.names = FALSE)






