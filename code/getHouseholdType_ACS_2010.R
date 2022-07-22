# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will download the 2010 household type data 
# for policy scan based on the ACS 5-year estimates.

# Preparation
## Libraries
library(sf)
library(tidycensus)
library(tidyverse)
library(tigris)

## Install a census API key

# census_api_key("key", install = TRUE)


# Downloading the demographic data

## Demographic Variables

### Household Type

## Variables from B09016: HOUSEHOLD TYPE (INCLUDING LIVING ALONE) BY RELATIONSHIP
# 1. totalP        B09016_001   Total Population (Estimate)
# 2. totalP_hh     B09016_002   Total population in households (Estimate)
# 3. totalP_fhh    B09016_003   Total population in family households (Estimate)
# 4. nonRel_fhh    B09016_013   Total nonrelatives in family households (Estimate)
# 5. totalP_nfhh   B09016_019   Total population in non-family households (Estimate)
# 6. nonRel_nfhh   B09016_027   Total nonrelatives in non-family households (Estimate)
# 7. groupQuar     B09016_033   Total in group quarters (Estimate)



# State level

stateHH10 <- get_acs(geography = 'state', variables = c(totalP = "B09016_001", 
                   totalP_hh = "B09016_002", totalP_fhh = "B09016_003",
                   nonRel_fhh = "B09016_013", totalP_nfhh = "B09016_019",
                   nonRel_nfhh = "B09016_027", groupQuar = "B09016_033"), 
                   year = 2010, geometry = FALSE)

head(stateHH10)

## Percentages

stateHH10P <- stateHH10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, nonRel_fhhP = round(nonRel_fhh/totalP_fhh*100, 2), 
         nonRel_nfhhP = round(nonRel_nfhh/totalP_nfhh*100, 2),
         groupQuarP = round(groupQuar/totalP*100, 2)) %>%
  select('GEOID', 'year', 'totalP', 'totalP_hh', 'totalP_fhh', 'nonRel_fhh', 
         'nonRel_fhhP', 'totalP_nfhh','nonRel_nfhh','nonRel_nfhhP', 'groupQuar',
         'groupQuarP')

head(stateHH10P)

## Saving the data

write.csv(stateHH10P, "~/Desktop/DS05_S_2010.csv")


# County Level

countyHH10 <- get_acs(geography = 'county', variables = c(totalP = "B09016_001", 
                   totalP_hh = "B09016_002", totalP_fhh = "B09016_003",
                   nonRel_fhh = "B09016_013", totalP_nfhh = "B09016_019",
                   nonRel_nfhh = "B09016_027", groupQuar = "B09016_033"), 
                   year = 2010, geometry = FALSE)

head(countyHH10)

## Percentages

countyHH10P <- countyHH10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, nonRel_fhhP = round(nonRel_fhh/totalP_fhh*100, 2), 
         nonRel_nfhhP = round(nonRel_nfhh/totalP_nfhh*100, 2),
         groupQuarP = round(groupQuar/totalP*100, 2)) %>%
  select('GEOID', 'year', 'totalP', 'totalP_hh', 'totalP_fhh', 'nonRel_fhh', 
         'nonRel_fhhP', 'totalP_nfhh', 'nonRel_nfhh','nonRel_nfhhP', 'groupQuar', 
         'groupQuarP')

head(countyHH10P)

## Saving the data

write.csv(countyHH10P, "~/Desktop/DS05_C_2010.csv")


# Census Tract Level

states <- tigris::states(year = 2010)
territoriesToBeExcluded <- c('60', '72', '66', '69', '78') # American territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

tractHH10 <- map_df(.x = as.numeric(states$STATEFP),
                    ~ get_acs(geography = "tract", state = .x,
                       variables = c(totalP = "B09016_001", 
                       totalP_hh = "B09016_002", totalP_fhh = "B09016_003",
                       nonRel_fhh = "B09016_013", totalP_nfhh = "B09016_019",
                       nonRel_nfhh = "B09016_027", groupQuar = "B09016_033"), 
                    year = 2010, geometry = FALSE))

head(tractHH10)

## Percentages

tractHH10P <- tractHH10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, nonRel_fhhP = round(nonRel_fhh/totalP_fhh*100, 2), 
         nonRel_nfhhP = round(nonRel_nfhh/totalP_nfhh*100, 2),
         groupQuarP = round(groupQuar/totalP*100, 2)) %>%
  select('GEOID', 'year', 'totalP', 'totalP_hh', 'totalP_fhh', 'nonRel_fhh', 
         'nonRel_fhhP', 'totalP_nfhh', 'nonRel_nfhh','nonRel_nfhhP', 'groupQuar', 
         'groupQuarP')

head(tractHH10P)

## Saving the data

write.csv(tractHH10P, "~/Desktop/DS05_T_2010.csv")


# Zipcode Level
## It works for 2018 but does not work for 2010. Please note that the variable
## names are different for the 2018 data.
## Error message:
## Error: Your API call has errors.  
## The API message returned is error: unknown/unsupported geography heirarchy.

zctaHH10 <- get_acs(geography = 'zcta',  variables = c(totalP = "B09016_001", 
                    totalP_hh = "B09016_002", totalP_fhh = "B09016_003",
                    nonRel_fhh = "B09016_013", totalP_nfhh = "B09016_019",
                    nonRel_nfhh = "B09016_027", groupQuar = "B09016_033"),
                    year = 2010, output = "wide", geometry = FALSE)

head(zctaHH10)

## Percentages

zctaHH10P <- zctaHH10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, nonRel_fhhP = round(nonRel_fhh/totalP_fhh*100, 2), 
         nonRel_nfhhP = round(nonRel_nfhh/totalP_nfhh*100, 2),
         groupQuarP = round(groupQuar/totalP*100, 2), 
         ZCTA = (substr(GEOID, nchar(GEOID - 5 + 1, nchar(GEOID)))), # Extract last 5 integers from GEOID variable to make 5-digit ZCTA variable
         STATEFP = substr(GEOID, 1, 2)) %>%
  select('ZCTA', 'STATEFP', 'year', 'totalP', 'totalP_hh', 'totalP_fhh', 'nonRel_fhh', 
         'nonRel_fhhP', 'totalP_nfhh', 'nonRel_nfhh','nonRel_nfhhP', 'groupQuar', 
         'groupQuarP')

head(zctaHH10P)

## Saving the data

write.csv(zctaHH10P, "~/Desktop/DS05_Z_2010.csv")
