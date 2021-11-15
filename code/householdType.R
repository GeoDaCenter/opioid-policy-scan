### ABOUT --- 
# This code will wrangle 2018-5 year census data on populations by household types at the state, county, tract, and zip levels.
# Data is sourced from ACS 2018 5-yr, table B09019: Household Type by Relationship. 
# Date: Nov 15, 2021

# Load libraries
library(tidyverse)
library(sf)
library(tidycensus)

#census_api_key("4c645df575f0b945d20f4fd8d66f679017b08dca", install=TRUE)

# See relevant variables here: https://api.census.gov/data/2018/acs/acs5/groups/B09019.html 
# B09019_001E - Total population 
# B09019_002E - Total population in households
# B09019_003E - Total population in family households
# B09019_018E - Total nonrelatives in family households
# Calculate - % nonrelatives in family households
# B09019_024E - Total population in non-family households
# B09019_032E - Total nonrelatives in non-family households
# Calculate - % nonrelatives in non-family households
# B09019_038E - Total in group quarters
# Calculate - % group quarters (group quar / total pop)

# State variables ----

state <- get_acs(geography = 'state', variables = c(totalP = "B09019_001E",
                                                    totalP_hh = "B09019_002E",
                                                    totalP_fhh = "B09019_003E",
                                                    nonRel_fhh = "B09019_018E",
                                                    totalP_nfhh = "B09019_024E",
                                                    nonRel_nfhh = "B09019_032E",
                                                    groupQuar = "B09019_026E"),
                 year = 2018, #gets 5 year av.
                 output = "wide",
                 geometry = FALSE) %>%
  select(-ends_with("M"))

# Calculate rates
# % nonrelatives in family households
state$nonRel_fhhR <- (state$nonRel_fhh / state$totalP_fhh) * 100
# % nonrelatives in non-family households
state$nonRel_nfhhR <- (state$nonRel_nfhh / state$totalP_nfhh) * 100
# % group quarters (group quar / total pop)
state$groupQuarR <- (state$groupQuar / state$totalP) * 100

state_final <- state %>% select(STATEFP = GEOID, state = NAME, totalP, totalP_hh, 
                                totalP_fhh, nonRel_fhh, nonRel_fhhR,
                                totalP_nfhh, nonRel_nfhh, nonRel_nfhhR,
                                groupQuar, groupQuarR)

# County variables -----

county <- get_acs(geography = 'county', variables = c(totalP = "B09019_001E",
                                                      totalP_hh = "B09019_002E",
                                                      totalP_fhh = "B09019_003E",
                                                      nonRel_fhh = "B09019_018E",
                                                      totalP_nfhh = "B09019_024E",
                                                      nonRel_nfhh = "B09019_032E",
                                                      groupQuar = "B09019_026E"),
                  year = 2018, #gets 5 year av.
                  output = "wide",
                  geometry = FALSE) %>%
  select(-ends_with("M"))

# Calculate rates
# % nonrelatives in family households
county$nonRel_fhhR <- (county$nonRel_fhh / county$totalP_fhh) * 100
# % nonrelatives in non-family households
county$nonRel_nfhhR <- (county$nonRel_nfhh / county$totalP_nfhh) * 100
# % group quarters (group quar / total pop)
county$groupQuarR <- (county$groupQuar / county$totalP) * 100

county_final <- county %>% select(COUNTYFP = GEOID, county = NAME, totalP, totalP_hh, 
                                  totalP_fhh, nonRel_fhh, nonRel_fhhR,
                                  totalP_nfhh, nonRel_nfhh, nonRel_nfhhR,
                                  groupQuar, groupQuarR)

# Zip code variables -----

zip <- get_acs(geography = 'zcta', variables = c(totalP = "B09019_001E",
                                                 totalP_hh = "B09019_002E",
                                                 totalP_fhh = "B09019_003E",
                                                 nonRel_fhh = "B09019_018E",
                                                 totalP_nfhh = "B09019_024E",
                                                 nonRel_nfhh = "B09019_032E",
                                                 groupQuar = "B09019_026E"),
               year = 2018, #gets 5 year av.
               output = "wide",
               geometry = FALSE) %>%
  select(-ends_with("M"))

# Calculate rates
# % nonrelatives in family households
zip$nonRel_fhhR <- (zip$nonRel_fhh / zip$totalP_fhh) * 100
# % nonrelatives in non-family households
zip$nonRel_nfhhR <- (zip$nonRel_nfhh / zip$totalP_nfhh) * 100
# % group quarters (group quar / total pop)
zip$groupQuarR <- (zip$groupQuar / zip$totalP) * 100

# Extract last 5 integers from GEOID variable to make 5-digit ZCTA variable
n_last <- 5
zip$ZCTA <- substr(zip$GEOID, nchar(zip$GEOID) - n_last + 1, nchar(zip$GEOID))
zip$STATEFP <- substr(zip$GEOID, 1, 2)

zip_final <- zip %>% select(ZCTA, STATEFP, totalP, totalP_hh,
                            totalP_fhh, nonRel_fhh, nonRel_fhhR,
                            totalP_nfhh, nonRel_nfhh, nonRel_nfhhR,
                            groupQuar, groupQuarR)


# Tract variables -----

library(tigris)
states <- tigris::states(year = 2018)
territoriesToBeExcluded <- c('60','72','66','69','78') # US territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

tract <- get_acs(geography = 'tract', state = states$STATEFP,
                 variables = c(totalP = "B09019_001E",
                               totalP_hh = "B09019_002E",
                               totalP_fhh = "B09019_003E",
                               nonRel_fhh = "B09019_018E",
                               totalP_nfhh = "B09019_024E",
                               nonRel_nfhh = "B09019_032E",
                               groupQuar = "B09019_026E"),
                 year = 2018, #gets 5 year av.
                 output = "wide",
                 geometry = FALSE) %>%
  select(-ends_with("M"))

# Calculate rates
# % nonrelatives in family households
tract$nonRel_fhhR <- (tract$nonRel_fhh / tract$totalP_fhh) * 100
# % nonrelatives in non-family households
tract$nonRel_nfhhR <- (tract$nonRel_nfhh / tract$totalP_nfhh) * 100
# % group quarters (group quar / total pop)
tract$groupQuarR <- (tract$groupQuar / tract$totalP) * 100

tract_final <- tract %>% select(GEOID, NAME, totalP, totalP_hh,
                                totalP_fhh, nonRel_fhh, nonRel_fhhR,
                                totalP_nfhh, nonRel_nfhh, nonRel_nfhhR,
                                groupQuar, groupQuarR)

# Save final data ----

write.csv(state_final, "data_final/DS05_S.csv", row.names = FALSE)
write.csv(county_final, "data_final/DS05_C.csv", row.names = FALSE)
write.csv(zip_final, "data_final/DS05_Z.csv", row.names = FALSE)
write.csv(tract_final, "data_final/DS05_T.csv", row.names = FALSE)
