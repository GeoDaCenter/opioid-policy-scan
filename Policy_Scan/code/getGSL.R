# Author : Qinyun LIn
# Date : Jan 7th, 2020
# This code select GSL (Good samaritan law) variables from the raw data. 

library(readxl)
library(tidyverse)
library(sf)


# read in raw data
GSL <- read_excel("data_raw/WEB_GSL.xlsx", sheet = "WEB_GSL")

# select PDMP variables
GSL_2018 <- GSL  %>% 
  filter(year=="2018")

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$NAME[!(state_2018$NAME %in% GSL_2018$state)]

# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, NAME)

GSL_2018 <- merge(state_2018_GEOID, GSL_2018, by.x = "NAME", by.y = "state") 
GSL_2018  <- as.data.frame(GSL_2018)
GSL_2018$geometry <- NULL
GSL_2018$NAME <- NULL

# rename variables 
colnames(GSL_2018) <- c("STATEFP", "Year", 
                        "AnyGSLdt", "GSLArrdt",
                        "AnyGSLfr", "GSLArrfr")

# Save final dataset
write.csv(GSL_2018,"data_final/PS04_2018_S.csv", row.names = FALSE)






