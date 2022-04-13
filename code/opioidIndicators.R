##### About #####

# This script cleans county- and state-level opioid indicator data including 2018 opioid prescription rate and 
# 2014-2018 narcotic overdose mortality rates, sourced from HepVu. https://hepvu.org/data-methods/

# Created by: Susan Paykin
# Date: April 13, 2022

##### Set up #####

library(tidyverse)
library(readxl)

##### County #####

# Load in raw data
county_raw <- read_xlsx("data_raw/Opioid Indicators (2018) - HepVu/HepVu_County_Opioid_Indicators-02AUG21.xlsx", skip = 3)

# Rename variables
county <- rename(county_raw, 
       COUNTYFP = 'GEO ID',
       st_abb = 'State Abbreviation',
       cnty_name = 'County Name',
       opPrscRt = 'Opioid Prescription Rate',
       odMortRt14 = 'Narcotic Overdose Mortality Rate 2014',
       odMortRt15 = 'Narcotic Overdose Mortality Rate 2015',
       odMortRt16 = 'Narcotic Overdose Mortality Rate 2016',
       odMortRt17 = 'Narcotic Overdose Mortality Rate 2017',
       odMortRt18 = 'Narcotic Overdose Mortality Rate 2018'
       )

# Calculate 5-year average (2014-2018)
county <- county %>%
  mutate(odMortRtAv = rowMeans(across(odMortRt14:odMortRt18)))

##### State #####

# Load in raw data
state_raw <- read_xlsx("data_raw/Opioid Indicators (2018) - HepVu/HepVu_State_Opioid_Indicators-30JUL21.xlsx", skip = 3)

# Rename variables
state <- rename(state_raw, 
                STATEFP = 'GEO ID',
                st_abb = 'State Abbreviation',
                st_name = 'State',
                opPrscRt = 'Opioid Prescription Rate',
                prMisuse19 = 'Pain Reliever Misuse Percent',
                odMortRt14 = 'Narcotic Overdose Mortality Rate 2014',
                odMortRt15 = 'Narcotic Overdose Mortality Rate 2015',
                odMortRt16 = 'Narcotic Overdose Mortality Rate 2016',
                odMortRt17 = 'Narcotic Overdose Mortality Rate 2017',
                odMortRt18 = 'Narcotic Overdose Mortality Rate 2018',
                odMortRt19 = 'Narcotic Overdose Mortality Rate 2019'
                )

# Calculate average (2014-2019)
state <- state %>%
  mutate(odMortRtAv = rowMeans(across(odMortRt14:odMortRt19)))

state$odMortRtAv <- round(state$odMortRtAv, 2)

##### Save final datasets #####

write.csv(county, "data_final/Health04_C.csv", row.names = FALSE)
write.csv(state, "data_final/Health04_S.csv", row.names = FALSE)
