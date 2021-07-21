#### About ---- 

# This code cleans and prepares hepatitis data at the state and county levels. Data is sourced from HepVu (https://hepvu.org/).
# State level data includes HCV prevalence and mortality, and county-level data is available for mortality only. 

# Set up environment
library(tmap)
library(sf)
library(tidyverse)
library(readxl)

setwd("~/git/opioid-policy-scan")

#### County-level mortality (HepVu, 2014-2017) ----

# Read in raw county-level data, add year to var names
hep2014 <- read_excel("data_raw/hepC/HepVu_County_Mortality_2014.xlsx", skip = 3) %>% 
  rename_at(vars(5:10), paste0, "_2014")
hep2015 <- read_excel("data_raw/hepC/HepVu_County_Mortality_2015.xlsx", skip = 3) %>%
  rename_at(vars(5:10), paste0, "_2015")
hep2016 <- read_excel("data_raw/hepC/HepVu_County_Mortality_2016.xlsx", skip = 3) %>%
  rename_at(vars(5:10), paste0, "_2016")
hep2017 <- read_excel("data_raw/hepC/HepVu_County_Mortality_2017.xlsx", skip = 3) %>%
  rename_at(vars(5:10), paste0, "_2017")

# Join all years
hepCounty <- left_join(hep2014, hep2015, by = "GEO ID") %>%
  left_join(., hep2016, by = "GEO ID") %>%
  left_join(., hep2017, by = "GEO ID")

# Select and rename variables
hepCounty_clean <- hepCounty %>% 
  select(COUNTYFP = `GEO ID`, county = County.x, state.abb = `State Abbreviation.x`,
         `County HCV Death Rate_2014`,`Age Less than 40 HCV Death Rate_2014`, `Age 40+ HCV Death Rate_2014`, 
         `County HCV Death Rate_2015`, `Age Less than 40 HCV Death Rate_2015`, `Age 40+ HCV Death Rate_2015`, 
         `County HCV Death Rate_2016`, `Age Less than 40 HCV Death Rate_2016`, `Age 40+ HCV Death Rate_2016`, 
         `County HCV Death Rate_2017`, `Age Less than 40 HCV Death Rate_2017`,`Age 40+ HCV Death Rate_2017`)

# Save final dataset
write.csv(hepCounty_clean, "data_final/Health02_C.csv")

#### State-level mortality (HepVu, 2014-2017) ----

# Read in raw state-level data, add year to var names
hep2014_state <- read_excel("data_raw/hepC/HepVu_State_Mortality_2014.xlsx", skip = 3) %>% 
  rename_at(vars(5:37), paste0, "_2014")
hep2015_state <- read_excel("data_raw/hepC/HepVu_State_Mortality_2015.xlsx", skip = 3) %>% 
  rename_at(vars(5:37), paste0, "_2015")
hep2016_state <- read_excel("data_raw/hepC/HepVu_State_Mortality_2016.xlsx", skip = 3) %>% 
  rename_at(vars(5:37), paste0, "_2016")
hep2017_state <- read_excel("data_raw/hepC/HepVu_State_Mortality_2017.xlsx", skip = 3) %>% 
  rename_at(vars(5:37), paste0, "_2017")

# Join all years
hepState <- left_join(hep2014_state, hep2015_state, by = "GEO ID") %>%
  left_join(., hep2016_state, by = "GEO ID") %>%
  left_join(., hep2017_state, by = "GEO ID")

# Select and rename variables
colnames(hepState)[2:4] <- c("STATEFP", "state.abb", "state.name") 

hepState_clean <- hepState %>% select(2:145) %>%
  select(!contains("Stability")) %>%
  select(!ends_with(c(".x", ".y")))

# Save final dataset
write.csv(hepState_clean, "data_final/Health02_S.csv")

#### State-level prevalence (HepVu, 2013-2016 ave.) ----

# Read in raw data
hepC_prev_st <- read_excel("data_raw/hepC/HepVu_State_Prev_Stratified_2016.xlsx", skip = 3)

hepC_prev_st_clean <- hepC_prev_st
colnames(hepC_prev_st_clean[1:3]) <- c("STATEFP", "state.abb", "state.name")

# Save final dataset
write.csv(hepC_prev_st_clean, "data_final/Health02_S_Prevalence.csv")





# #### OLD: State-level prevalence (CDC WONDER, 2014-2018) ----
# 
# # Read  in raw state-level prevalence data
# hepC_raw <- read.csv("data_raw/hepC/hepC_prev_2014-2018.csv")
# 
# # Merge with spatial for FIPS codes
# states <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
# hepC_clean <- merge(hepC_raw, states, by.x = "State", by.y = "NAME")
# str(hepC_clean)
# 
# # Clean data, rename variables
# hepC_clean <- hepC_clean %>% select(STATEFP, state.abb = STUSPS, state.name = State, AveNo, AveRt, No_2014, Rt_2014, No_2015, Rt_2015, No_2016, Rt_2016,
#                                     No_2017, Rt_2017, No_2018, Rt_2018)
# 
# # Save final dataset
# write.csv(hepC_clean, "Policy_Scan/data_final/Health02_S.csv")
