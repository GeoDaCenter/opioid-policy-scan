# Author : Qinyun Lin
# Date : March 2nd, 2021
# This code select SDOH variables from raw data. 

library(readxl)
library(tidyverse)
library(sf)

library(readr)
sdoh_2014 <- read_csv("data_raw/us-sdoh-2014-v.csv")

data <- sdoh_2014 %>% 
  select(tract_fips, SDOH_CL)

# check GEOID
tract2018 <- st_read("data_final/geometryFiles/tl_2018_tract/tracts2018.shp")
tract2018$GEOID[!(tract2018$GEOID %in% data$tract_fips)]
data$tract_fips[!(data$tract_fips %in% tract2018$GEOID)]

# There are three tracts where the county code chnaged to 102 from 113 in the year 2015
data$tract_fips <- ifelse(data$tract_fips == "46113940800", "46102940800", data$tract_fips)
data$tract_fips <- ifelse(data$tract_fips == "46113940500", "46102940500", data$tract_fips)
data$tract_fips <- ifelse(data$tract_fips == "46113940900", "46102940900", data$tract_fips)
data$tract_fips[!(data$tract_fips %in% tract2018$GEOID)]

# now all the tracts can be matched in our tracts2018.shp
names(data) <- c("GEOID", "SDOH")

write.csv(data, "data_final/DS02_T.csv", row.names = F)
