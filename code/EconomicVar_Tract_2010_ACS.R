# Author: Ashlynn Wimer
# Date: 07/28/23
# About: This script uses tidycensus to grab tract level economic Decennial Census
# and ACS data.


# Libraries
library(tidycensus)
library(tidyr)
library(dplyr)
library(purrr)

# Get a list of all relevant states' FIPS codes.
states_fips <- tigris::fips_codes |> 
  filter(!state_code %in% c('60', '72', '66', '69', '78', '74')) |>
  select(state_code) |> unique() 

states_fips <- states_fips$state_code

# Acquire data
econ2010 <- map_dfr(.x = states_fips, ~ get_acs(geography = 'tract', 
        variables = c(
          NMMLFU    = 'B12006_006',  NMMLF  = 'B12006_004',
          NMFLFU    = 'B12006_011',  NMFLF  = 'B12006_009',
          MMLFU     = 'B12006_017',  MMLF   = 'B12006_015',
          MFLFU     = 'B12006_022',  MFLF   = 'B12006_020',
          SMLFU     = 'B12006_028',  SMLF   = 'B12006_026',
          SFLFU     = 'B12006_033',  SFLF   = 'B12006_031',
          WMLFU     = 'B12006_039',  WMLF   = 'B12006_037',
          WFLFU     = 'B12006_044',  WFLF   = 'B12006_042',
          DMLFU     = 'B12006_050',  DMLF   = 'B12006_048',
          DFLFU     = 'B12006_055',  DFLF   = 'B12006_053',
          pci       = 'B19301_001',  cntPov = 'B06012_002', 
          cntPovUni = 'B06012_001'), 
        year = 2010, state=.x)) 

# Clean the data
econ2010 <- econ2010 |> 
  select(GEOID, variable, estimate) |>
  spread("variable", "estimate") |>
  mutate(unempP = round(100 * (NMMLFU + NMFLFU + MMLFU +  
                               MFLFU + SMLFU + SFLFU +  
                               WMLFU + WFLFU + DMLFU +  
                               DFLFU) / 
                          (NMMLFU + NMMLF + NMFLFU + NMFLF + 
                           SMLFU  + SMLF  + SFLFU  + SFLF + 
                           MMLFU  + MMLF  + MFLFU  + MFLF + 
                           WMLFU  + WMLF  + WFLFU  + WFLF + 
                           DMLFU  + DFLF  + DFLFU  + DFLF), 
                        2),
         povP   = round(100 * cntPov / cntPovUni, 2)
         )|>
  select(GEOID, unempP, povP, pciE = pci)

# Final cleaning
econ2010 <- econ2010 |> 
  map_df(~ ifelse(is.nan(.x), NA, .x))

# Save
write.csv(econ2010, "../data_final/EC03_2010_T_ACS.csv", row.names = FALSE)
