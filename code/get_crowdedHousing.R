
library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

### CROWDED HOUSING
### Matched CDC SVI Guidelines from 2018 for "Crowded Housing as >1 occupant per room"
### Concept in otherVarNames - TENURE BY OCCUPANTS PER ROOM

#B25014_001 Estimate!!Total:
#B25014_005 Estimate!!Total:!!Owner occupied:!!1.01 to 1.50 occupants per room
#B25014_006 Estimate!!Total:!!Owner occupied:!!1.51 to 2.00 occupants per room
#B25014_007 Estimate!!Total:!!Owner occupied:!!2.01 or more occupants per room
#B25014_011 Estimate!!Total:!!Renter occupied:!!1.01 to 1.50 occupants per room
#B25014_012 Estimate!!Total:!!Renter occupied:!!1.51 to 2.00 occupants per room
#B25014_013 Estimate!!Total:!!Renter occupied:!!2.01 or more occupants per room


county19 <- get_acs(geography = 'county', variables = (totPop19 = "B25014_001"),
                    year = 2019, geometry = FALSE)
head(county19)


#Using 2019 ACS 5-Year Data
county19 <- get_acs(geography = 'county', variables = c(totPop19 = "B25014_001", 
                                                        B25014_005 ="B25014_005", 
                                                        B25014_006 = "B25014_006",
                                                        B25014_007 = "B25014_007", 
                                                        B25014_011 = "B25014_011",
                                                        B25014_012 = "B25014_012",
                                                        B25014_013 = "B25014_013"), 
                    year = 2019, geometry = FALSE) %>%
  select(GEOID, NAME, variable, estimate) %>% 
  spread(variable, estimate) %>% 
  mutate(crowdHsng19  = (B25014_005+B25014_006+B25014_007+
                           B25014_011+B25014_012+B25014_013)/totPop19) %>%
  select(GEOID,totPop19,crowdHsng19)

head(county19)
summary(county19) 

hist(county19$crowdHsng19)

write.csv(county19, "../data_final/temp/crwdHsng_county19.csv")
