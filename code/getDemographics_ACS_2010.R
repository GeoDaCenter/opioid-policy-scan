# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will download the 2010 demography data 
# for policy scan based on the ACS 5-year estimates.

## Libraries
library(sf)
library(tidycensus)
library(tidyverse)
library(tigris)

## Install a census API key

# census_api_key("key", install = TRUE)


# Download the demographic data

## Demographic Variables

### Race and Ethnicity

## Variables from B02001: RACE table
# 1. totPopE     B02001_001   Total Population (Estimate)
# 2. white       B02001_002   White (Estimate)
# 3. black       B02001_003   Black or African American (Estimate)
# 4. amerInd     B02001_004   American Indian and Alaska Native (Estimate)
# 5. asian       B02001_005   Asian (Estimate)
# 6. pacificIs   B02001_006   Native Hawaiian and Other Pacific Islander (Estimate)

## Variables from B03003: HISPANIC OR LATINO ORIGIN BY RACE
# 1. hispanic    B03003_003   Hispanic or Latino (Estimate)

### Age and Sex

## Variables from S0101: AGE & SEX
# 1.  age0_4      S0101_C01_002   Age <5  (Estimate)
# 2.  age5_14     S0101_C01_020   Age 5-14 (Estimate)
# 3.  age15_19    S0101_C01_005   Age 15-19 (Estimate)
# 4.  age20_24    S0101_C01_006   Age 20-24 (Estimate)
# 5.  age15_44    S0101_C01_023   Age 15-44 (Estimate)
# 6.  age45_49    S0101_C01_011   Age 45-49 (Estimate)
# 7.  age50_54    S0101_C01_012   Age 50-54 (Estimate)
# 8.  age55_59    S0101_C01_013   Age 55-59 (Estimate)
# 9.  age60_64    S0101_C01_014   Age 60-64 (Estimate)
# 10. ageOv65     S0101_C01_028   Age >=65 (Estimate)
# 11. ageOv18     S0101_C01_025   Age >=18 (Estimate)

### Population with a Disability

## Variables from DP02
# 1. disbP       DP02_0071P   Disability Status of the Civilian 
#                             Noninstitutionalized Population (Percent Estimate)

### Educational Attainment 

## Variables from B06009: PLACE OF BIRTH BY EDUCATIONAL ATTAINMENT IN THE UNITED
##                        STATES
# 1. popOver25   B06009_001   Population over 25 (Estimate)
# 2. eduNoHS     B06009_002   Less than high school graduate population over 25 
#                             (Estimate)



# State level
## It includes 72 - Puerto Rico.

stateDem10 <- get_acs(geography = 'state', variables = c(totPopE = "B02001_001",
                   white = "B02001_002", black = "B02001_003", amerInd = "B02001_004",
                   asian = "B02001_005", pacificIs = "B02001_006", 
                   hispanic = "B03003_003", age0_4 = "S0101_C01_002", 
                   age5_14 = "S0101_C01_020", age15_19 = "S0101_C01_005", 
                   age20_24 = "S0101_C01_006", age15_44 = "S0101_C01_023", 
                   age45_49 = "S0101_C01_011", age50_54 = "S0101_C01_012", 
                   age55_59 = "S0101_C01_013", age60_64 = "S0101_C01_014", 
                   ageOv65 = "S0101_C01_028", ageOv18 = "S0101_C01_025", 
                   disbP = "DP02_0071P", popOver25 = "B06009_001", 
                   eduNoHS = "B06009_002"), 
                   year = 2010, geometry = FALSE)

head(stateDem10)

## Percentages

stateDem10P <- stateDem10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2), 
         amIndP = round(amerInd/totPopE*100, 2), asianP = round(asian/totPopE*100, 2), 
         pacIsP = round(pacificIs/totPopE*100, 2), otherP = round(100 - 
         (whiteP + blackP + amIndP + asianP + pacIsP), 2), hispP = round(hispanic/totPopE*100, 2), 
         noHSP = round(eduNoHS/popOver25*100, 2), age18_64 = round(ageOv18 - ageOv65, 2), 
         a15_24P = round((age15_19 + age20_24)/totPopE*100, 2),
         und45P = round((age0_4 + age5_14 + age15_44)/totPopE*100, 2), 
         ovr65P = round(ageOv65/totPopE*100, 2)) %>%
  select('GEOID', 'year', 'totPopE', 'whiteP', 'blackP', 'amIndP', 'asianP', 
         'pacIsP', 'otherP', 'hispP', 'noHSP', 'age0_4', 'age5_14', 'age15_19',
         'age20_24', 'age15_44', 'age45_49', 'age50_54', 'age55_59', 'age60_64', 
         'ageOv65', 'ageOv18', 'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')

head(stateDem10P)

## Saving the data

write.csv(stateDem10P, "~/Desktop/DS01_S_2010.csv")


# County Level
## It includes 72 - Puerto Rico.

countyDem10 <- get_acs(geography = 'county', variables = c(totPopE = "B02001_001",
                   white = "B02001_002", black = "B02001_003", amerInd = "B02001_004",
                   asian = "B02001_005", pacificIs = "B02001_006", 
                   hispanic = "B03003_003", age0_4 = "S0101_C01_002", 
                   age5_14 = "S0101_C01_020", age15_19 = "S0101_C01_005",
                   age20_24 = "S0101_C01_006", age15_44 = "S0101_C01_023",
                   age45_49 = "S0101_C01_011", age50_54 = "S0101_C01_012",
                   age55_59 = "S0101_C01_013", age60_64 = "S0101_C01_014", 
                   ageOv65 = "S0101_C01_028", ageOv18 = "S0101_C01_025", 
                   disbP = "DP02_0071P", popOver25 = "B06009_001", 
                   eduNoHS = "B06009_002"), 
                   year = 2010, geometry = FALSE)

head(countyDem10)

## Percentages

countyDem10P <- countyDem10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2), 
         amIndP = round(amerInd/totPopE*100, 2), asianP = round(asian/totPopE*100, 2), 
         pacIsP = round(pacificIs/totPopE*100, 2), otherP = round(100 - 
         (whiteP + blackP + amIndP + asianP + pacIsP), 2), hispP = round(hispanic/totPopE*100, 2), 
         noHSP = round(eduNoHS/popOver25*100, 2), age18_64 = round(ageOv18 - ageOv65, 2), 
         a15_24P = round((age15_19 + age20_24)/totPopE*100, 2),
         und45P = round((age0_4 + age5_14 + age15_44)/totPopE*100, 2), 
         ovr65P = round(ageOv65/totPopE*100, 2)) %>%
  select('GEOID', 'year', 'totPopE', 'whiteP', 'blackP', 'amIndP', 'asianP', 
         'pacIsP', 'otherP', 'hispP', 'noHSP', 'age0_4', 'age5_14', 'age15_19',
         'age20_24', 'age15_44', 'age45_49', 'age50_54', 'age55_59', 'age60_64',
         'ageOv65', 'ageOv18', 'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')

head(countyDem10P)

## Saving the data

write.csv(countyDem10P, "~/Desktop/DS01_C_2010.csv")


# Census Tract Level

states <- tigris::states(year = 2010)
territoriesToBeExcluded <- c('60', '72', '66', '69', '78') # American territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

tractDem10 <- map_df(.x = as.numeric(states$STATEFP),
                    ~ get_acs(geography = "tract", state = .x,
                    variables = c(totPopE = "B02001_001",
                    white = "B02001_002", black = "B02001_003", amerInd = "B02001_004",
                    asian = "B02001_005", pacificIs = "B02001_006", 
                    hispanic = "B03003_003", age0_4 = "S0101_C01_002", 
                    age5_14 = "S0101_C01_020", age15_19 = "S0101_C01_005", 
                    age20_24 = "S0101_C01_006", age15_44 = "S0101_C01_023", 
                    age45_49 = "S0101_C01_011", age50_54 = "S0101_C01_012", 
                    age55_59 = "S0101_C01_013", age60_64 = "S0101_C01_014", 
                    ageOv65 = "S0101_C01_028", ageOv18 = "S0101_C01_025", 
                    disbP = "DP02_0071P", popOver25 = "B06009_001", 
                    eduNoHS = "B06009_002"), 
                    year = 2010, geometry = FALSE))

head(tractDem10)

## Percentages

tractDem10P <- tractDem10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2), 
         amIndP = round(amerInd/totPopE*100, 2), asianP = round(asian/totPopE*100, 2), 
         pacIsP = round(pacificIs/totPopE*100, 2), otherP = round(100 - 
         (whiteP + blackP + amIndP + asianP + pacIsP), 2), hispP = round(hispanic/totPopE*100, 2), 
         noHSP = round(eduNoHS/popOver25*100, 2), age18_64 = round(ageOv18 - ageOv65, 2), 
         a15_24P = round((age15_19 + age20_24)/totPopE*100, 2),
         und45P = round((age0_4 + age5_14 + age15_44)/totPopE*100, 2), 
         ovr65P = round(ageOv65/totPopE*100, 2)) %>%
  select('GEOID', 'year', 'totPopE', 'whiteP', 'blackP', 'amIndP', 'asianP', 
         'pacIsP', 'otherP', 'hispP', 'noHSP', 'age0_4', 'age5_14', 'age15_19',
         'age20_24', 'age15_44', 'age45_49', 'age50_54', 'age55_59', 'age60_64', 'ageOv65',
         'ageOv18', 'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')

head(tractDem10P)

## Saving the data

write.csv(tractDem10P, "~/Desktop/DS01_T_2010.csv")


# Zipcode Level

## It works for 2018 but does not work for 2010.
## Error message: 
## Error in `stop_rate_excess()`:
## ! Request failed after 3 attempts
## Run `rlang::last_error()` to see where the error occurred.

## There seems to be a problem with the 2010 data.
## Please check: https://github.com/walkerke/tidycensus/issues/145 

states <- tigris::states(year = 2010)
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

zctaDem10 <- map_df(.x = as.numeric(states$STATEFP),
                    ~ get_acs(geography = "zcta",
                    variables = c(totPopE = "B02001_001",
                    white = "B02001_002", black = "B02001_003", amerInd = "B02001_004",
                    asian = "B02001_005", pacificIs = "B02001_006",
                    hispanic = "B03003_003", age0_4 = "S0101_C01_002",
                    age5_14 = "S0101_C01_020", age15_19 = "S0101_C01_005",
                    age20_24 = "S0101_C01_006", age15_44 = "S0101_C01_023", 
                    age45_49 = "S0101_C01_011", age50_54 = "S0101_C01_012", 
                    age55_59 = "S0101_C01_013", age60_64 = "S0101_C01_014", 
                    ageOv65 = "S0101_C01_028", ageOv18 = "S0101_C01_025", 
                    disbP = "DP02_0071P", popOver25 = "B06009_001", 
                    eduNoHS = "B06009_002"),
                              year = 2010, geometry = FALSE))

head(zctaDem10)

## Percentages

zctaDem10P <- zctaDem10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2), 
         amIndP = round(amerInd/totPopE*100, 2), asianP = round(asian/totPopE*100, 2), 
         pacIsP = round(pacificIs/totPopE*100, 2), otherP = round(100 - 
         (whiteP + blackP + amIndP + asianP + pacIsP), 2), hispP = round(hispanic/totPopE*100, 2), 
         noHSP = round(eduNoHS/popOver25*100, 2), age18_64 = round(ageOv18 - ageOv65, 2), 
         a15_24P = round((age15_19 + age20_24)/totPopE*100, 2),
         und45P = round((age0_4 + age5_14 + age15_44)/totPopE*100, 2), 
         ovr65P = round(ageOv65/totPopE*100, 2)) %>%
  select('GEOID', 'year', 'totPopE', 'whiteP', 'blackP', 'amIndP', 'asianP', 
         'pacIsP', 'otherP', 'hispP', 'noHSP', 'age0_4', 'age5_14', 'age15_19',
         'age20_24', 'age15_44', 'age45_49', 'age50_54', 'age55_59', 'age60_64', 'ageOv65',
         'ageOv18', 'age18_64', 'a15_24P', 'und45P', 'ovr65P', 'disbP')

head(zctaDem10P)

## Saving the data

write.csv(zctaDem10P, "~/Desktop/DS01_Z_2010.csv")
