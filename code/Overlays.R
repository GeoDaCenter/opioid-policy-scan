# Author : Qinyun LIn
# Date : Feb 23th, 2021
# This code select Naloxone policy variables from the raw data. 

library(tidyverse)
library(sf)
library(readr)

USCountyOverlays_DummyValues <- read_csv("Policy_Scan/data_raw/USCountyOverlays_DummyValues.csv")

# check GEOID
county_2018 <- st_read("Policy_Scan/data_final/geometryFiles/tl_2018_county/counties2018.shp")
county_2018$GEOID[!(county_2018$GEOID %in% USCountyOverlays_DummyValues$GEOID)]

data <- USCountyOverlays_DummyValues %>% 
  select(GEOID, Dummy_Segregated, Dummy_Blackbelt, Percent_Native_Reservations)

names(data) <-c("GEOID", "DmySgrg", "DmyBlckBlt", "PrcNtvRsrv")

write.csv(data,"Policy_Scan/data_final/HS04_C.csv", row.names = FALSE)
