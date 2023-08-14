# Author: Ashlynn Wimer
# Date: 7/19/2023
# About: This R Script grabs additional tract level data from the 2014-2018
# ACS 5-Year Estimates, does some mild refactoring, and then exports them to be
# later added to the larger merged tracts data table.

# Specifically, it grabs Median Income and Gini Coefficient.

## Libraries
library(tidycensus)
library(dplyr)
library(tidyr)
library(purrr)

### Tract Level

# Tract level tidycensus pulls fail unless provided a state.
# So we get all the STATEFPs and then use use a purrr:map_df
# to perform this data pull state by state.
# (This method was stolen from a script written by Moksha
# Menghaney)

states <- tigris::states(year = 2018)
excludedStateFP <- c('60', '72', '66', '69', '78') 
states <- states[! (states$STATEFP %in% excludedStateFP) ,]

data <- map_df(.x = states$STATEFP, 
                   ~ get_acs(geography = 'tract',
                    variables = c('GiniCoeff' = 'B19083_001',
                                  'MedInc'    = 'B06011_001'),
                    year      = 2018,
                    geometry  = FALSE,
                    state = .x
                    )) |>
  select(-moe) |> 
  spread(variable, estimate) 

## Save results

# write.csv(data, 
#           "../data_raw/additionalEconomicData.csv", 
#           row.names = FALSE)


### Zip Level

# Same issue as above

dataZip <- map_df(.x = states$STATEFP, 
                  ~ get_acs(geography = 'zcta',
                            variables = c('GiniCoeff' = 'B19083_001',
                                          'MedInc'    = 'B06011_001'),
                            year      = 2018,
                            geometry  = FALSE,
                            state = .x)) |>
  select(-moe) |>
  spread(variable, estimate)

## Save results

# write.csv(dataZip,
#           '../data_raw/additionalEconomicDataZip.csv',
#           row.names = FALSE)


### State Level

dataState <- get_acs(geography ='state',
                     variables = c('GiniCoeff' = 'B19083_001',
                                   'MedInc'    = 'B06011_001'),
                     year      = 2018,
                     geometry  = FALSE) |>
  select(-moe) |>
  spread(variable, estimate) |>
  filter(GEOID != 72) |>
  mutate(G_STATEFP = paste('G', GEOID, sep = ''))

## Save results

write.csv(dataState,
          '../data_raw/additionalEconomicDataState.csv',
          row.names = FALSE)

### County Level

dataCounty <- get_acs(geography = 'county',
                      variables = c('GiniCoeff' = 'B19083_001',
                                    'MedInc'    = 'B06011_001'),
                      year = 2018,
                      geometry = FALSE) |>
  select(-moe, -NAME) |>
  spread(variable, estimate)

## Save results

write.csv(dataCounty,
          '../data_raw/additionalEconomicDataCounty.csv',
          row.names = F)
