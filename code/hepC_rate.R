library(tmap)
library(sf)
library(tidyverse)

# Read data
hepC_raw <- read.csv("Policy_Scan/data_raw/hepC_2014-2018.csv")

hepC_raw <- rename(hepC_raw, NAME = State)

# Merge with spatial for FIPS
states <- st_read("Policy_Scan/data_final/geometryFiles/tl_2018_state/states2018.shp")

str(states)

hepC_clean <- left_join(hepC_raw, states, by = "NAME")
str(hepC_clean)

hepC_clean <- hepC_clean %>% select(GEOID, state = STUSPS, state.name = NAME, AveNo, AveRt, No_2014, Rt_2014, No_2015, Rt_2015, No_2016, Rt_2016, 
                                    No_2017, Rt_2017, No_2018, Rt_2018)

write.csv(hepC_clean, "Policy_Scan/data_final/Health02_S.csv")
