# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will download the 2010 veteran data 
# for policy scan based on the ACS 5-year estimates.

# Preparation
## Libraries
library(sf)
library(tidycensus)
library(tidyverse)

## A census API key is already installed.

# Downloading the demographic data

## Demographic Variables

### Veteran Population

# 1.  TotalPop          B21001_001     Total Population 18 years or over
# 2.  TotalVetPop       B21001_002     Total Veteran Population
# 3.  MalePop           B21001_004     Total Male Population
# 4.  MaleVetPop        B21001_005     Male Veteran Population
# 5.  Male18To34        B21001_007     Male Population 18-34
# 6.  MaleVet18To34     B21001_008     Male Veteran Population 18-34
# 7.  Male35To54        B21001_010     Male Poulation 35-54
# 8.  MaleVet35To54     B21001_011     Male veteran population 35-54
# 9.  Male55To64        B21001_013     Male Population 55-64
# 10. MaleVet55To64     B21001_014     Male Veteran Population 55-64 
# 11. Male65To74        B21001_016     Male Population 65-74
# 12. MaleVet65To74     B21001_017     Male Veteran Population 65-74
# 13. Male75Plus        B21001_019     Male Population 75+
# 14. MaleVet75Plus     B21001_020     Male Veteran Population 75+
# 15. FemalePop         B21001_022     Total Female Population 
# 16. FemaleVetPop      B21001_023     Female Veteran Population
# 17. Female18To34      B21001_025     Female Population 18-34
# 18. FemaleVet18To34   B21001_026     Female Veteran Population 18-34
# 19. Female35To54      B21001_028     Female Population 35-54
# 20. FemaleVet35To54   B21001_029     Female Veteran Population 35-54
# 21. Female55To64      B21001_031     Female Population 55-64
# 22. FemaleVet55To64   B21001_032     Female Veteran Population 55-64
# 23. Female65To74      B21001_034     Female Population 65-74
# 24. FemaleVet65To74   B21001_035     Female Veteran Population 65-74
# 25. Female75Plus      B21001_037     Female Population 75+
# 26. FemaleVet75Plus   B21001_038     Female Veteran Population 75+



# State level

stateVet10 <- get_acs(geography = 'state', variables = c(TotalPop = "B21001_001",
                  TotalVetPop = "B21001_002", MalePop = "B21001_004", 
                  MaleVetPop = "B21001_005", Male18To34 = "B21001_007", 
                  MaleVet18To34 = "B21001_008", Male35To54 = "B21001_010",
                  MaleVet35To54 = "B21001_011", Male55To64 = "B21001_013", 
                  MaleVet55To64 = "B21001_014", Male65To74 = "B21001_016",
                  MaleVet65To74 = "B21001_017", Male75Plus = "B21001_019",
                  MaleVet75Plus = "B21001_020", FemalePop = "B21001_022",
                  FemaleVetPop = "B21001_023", Female18To34 = "B21001_025", 
                  FemaleVet18To34 = "B21001_026", Female35To54 = "B21001_028", 
                  FemaleVet35To54 = "B21001_029", Female55To64 = "B21001_031", 
                  FemaleVet55To64 = "B21001_032", Female65To74 = "B21001_034", 
                  FemaleVet65To74 = "B21001_035", Female75Plus = "B21001_037", 
                  FemaleVet75Plus = "B21001_038"), 
                      year = 2010, geometry = FALSE)


head(stateVet10)

## Percentages

stateVet10P <- stateVet10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, VetPercent = round(TotalVetPop/TotalPop*100, 2)) %>%
  select('GEOID', 'year', 'TotalPop', 'TotalVetPop', 'VetPercent', 'MalePop', 
         'MaleVetPop', 'Male18To34', 'MaleVet18To34', 'Male35To54', 
         'MaleVet35To54', 'Male55To64', 'MaleVet55To64', 'Male65To74', 
         'MaleVet65To74', 'Male75Plus', 'MaleVet75Plus', 'FemalePop', 
         'FemaleVetPop', 'Female18To34', 'FemaleVet18To34', 'Female35To54', 
         'FemaleVet35To54', 'Female55To64', 'FemaleVet55To64', 'Female65To74', 
         'FemaleVet65To74', 'Female75Plus', 'FemaleVet75Plus')
         
head(stateVet10P)

## Saving the data

write.csv(stateVet10P, "~/Desktop/DS04_S_2010.csv")


# County level

countyVet10 <- get_acs(geography = 'county', variables = c(TotalPop = "B21001_001",
                                                         TotalVetPop = "B21001_002", MalePop = "B21001_004", 
                                                         MaleVetPop = "B21001_005", Male18To34 = "B21001_007", 
                                                         MaleVet18To34 = "B21001_008", Male35To54 = "B21001_010",
                                                         MaleVet35To54 = "B21001_011", Male55To64 = "B21001_013", 
                                                         MaleVet55To64 = "B21001_014", Male65To74 = "B21001_016",
                                                         MaleVet65To74 = "B21001_017", Male75Plus = "B21001_019",
                                                         MaleVet75Plus = "B21001_020", FemalePop = "B21001_022",
                                                         FemaleVetPop = "B21001_023", Female18To34 = "B21001_025", 
                                                         FemaleVet18To34 = "B21001_026", Female35To54 = "B21001_028", 
                                                         FemaleVet35To54 = "B21001_029", Female55To64 = "B21001_031", 
                                                         FemaleVet55To64 = "B21001_032", Female65To74 = "B21001_034", 
                                                         FemaleVet65To74 = "B21001_035", Female75Plus = "B21001_037", 
                                                         FemaleVet75Plus = "B21001_038"), 
                      year = 2010, geometry = FALSE)


head(countyVet10)

## Percentages

countyVet10P <- countyVet10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, VetPercent = round(TotalVetPop/TotalPop*100, 2)) %>%
  select('GEOID', 'year', 'TotalPop', 'TotalVetPop', 'VetPercent', 'MalePop', 
         'MaleVetPop', 'Male18To34', 'MaleVet18To34', 'Male35To54', 
         'MaleVet35To54', 'Male55To64', 'MaleVet55To64', 'Male65To74', 
         'MaleVet65To74', 'Male75Plus', 'MaleVet75Plus', 'FemalePop', 
         'FemaleVetPop', 'Female18To34', 'FemaleVet18To34', 'Female35To54', 
         'FemaleVet35To54', 'Female55To64', 'FemaleVet55To64', 'Female65To74', 
         'FemaleVet65To74', 'Female75Plus', 'FemaleVet75Plus')

head(countyVet10P)

## Saving the data

write.csv(countyVet10P, "~/Desktop/DS04_C_2010.csv")


# Census Tract Level

states <- tigris::states(year = 2010)
territoriesToBeExcluded <- c('60', '72', '66', '69', '78') # American territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

tractVet10 <- map_df(.x = as.numeric(states$STATEFP),
                     ~ get_acs(geography = "tract", state = .x,
                               variables = c(TotalPop = "B21001_001",
                              TotalVetPop = "B21001_002", MalePop = "B21001_004", 
                              MaleVetPop = "B21001_005", Male18To34 = "B21001_007", 
                              MaleVet18To34 = "B21001_008", Male35To54 = "B21001_010",
                              MaleVet35To54 = "B21001_011", Male55To64 = "B21001_013", 
                              MaleVet55To64 = "B21001_014", Male65To74 = "B21001_016",
                              MaleVet65To74 = "B21001_017", Male75Plus = "B21001_019",
                              MaleVet75Plus = "B21001_020", FemalePop = "B21001_022",
                              FemaleVetPop = "B21001_023", Female18To34 = "B21001_025", 
                              FemaleVet18To34 = "B21001_026", Female35To54 = "B21001_028", 
                              FemaleVet35To54 = "B21001_029", Female55To64 = "B21001_031", 
                              FemaleVet55To64 = "B21001_032", Female65To74 = "B21001_034", 
                              FemaleVet65To74 = "B21001_035", Female75Plus = "B21001_037", 
                              FemaleVet75Plus = "B21001_038"), 
                               year = 2010, geometry = FALSE))

head(tractVet10)

## Percentages

tractVet10P <- tractVet10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, VetPercent = round(TotalVetPop/TotalPop*100, 2)) %>%
  select('GEOID', 'year', 'TotalPop', 'TotalVetPop', 'VetPercent', 'MalePop', 
         'MaleVetPop', 'Male18To34', 'MaleVet18To34', 'Male35To54', 
         'MaleVet35To54', 'Male55To64', 'MaleVet55To64', 'Male65To74', 
         'MaleVet65To74', 'Male75Plus', 'MaleVet75Plus', 'FemalePop', 
         'FemaleVetPop', 'Female18To34', 'FemaleVet18To34', 'Female35To54', 
         'FemaleVet35To54', 'Female55To64', 'FemaleVet55To64', 'Female65To74', 
         'FemaleVet65To74', 'Female75Plus', 'FemaleVet75Plus')

head(tractVet10P)

## Saving the data

write.csv(tractVet10P, "~/Desktop/DS04_T_2010.csv")


# Zipcode Level
## It does not work. 
## Error message:
## Error: Your API call has errors.  The API message returned is error: 
## unknown/unsupported geography heirarchy.

states <- tigris::states(year = 2010)
territoriesToBeExcluded <- c('60', '72', '66', '69', '78') # American territories
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
states$STATEFP <- as.numeric(states$STATEFP)

zctaVet10 <- map_df(.x = as.numeric(states$STATEFP),
                     ~ get_acs(geography = "zcta", state = .x,
                               variables = c(TotalPop = "B21001_001",
                                             TotalVetPop = "B21001_002", MalePop = "B21001_004", 
                                             MaleVetPop = "B21001_005", Male18To34 = "B21001_007", 
                                             MaleVet18To34 = "B21001_008", Male35To54 = "B21001_010",
                                             MaleVet35To54 = "B21001_011", Male55To64 = "B21001_013", 
                                             MaleVet55To64 = "B21001_014", Male65To74 = "B21001_016",
                                             MaleVet65To74 = "B21001_017", Male75Plus = "B21001_019",
                                             MaleVet75Plus = "B21001_020", FemalePop = "B21001_022",
                                             FemaleVetPop = "B21001_023", Female18To34 = "B21001_025", 
                                             FemaleVet18To34 = "B21001_026", Female35To54 = "B21001_028", 
                                             FemaleVet35To54 = "B21001_029", Female55To64 = "B21001_031", 
                                             FemaleVet55To64 = "B21001_032", Female65To74 = "B21001_034", 
                                             FemaleVet65To74 = "B21001_035", Female75Plus = "B21001_037", 
                                             FemaleVet75Plus = "B21001_038"), 
                               year = 2010, geometry = FALSE))

head(zctaVet10)

## Percentages

zctaVet10P <- zctaVet10 %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010, VetPercent = round(TotalVetPop/TotalPop*100, 2)) %>%
  select('GEOID', 'year', 'TotalPop', 'TotalVetPop', 'VetPercent', 'MalePop', 
         'MaleVetPop', 'Male18To34', 'MaleVet18To34', 'Male35To54', 
         'MaleVet35To54', 'Male55To64', 'MaleVet55To64', 'Male65To74', 
         'MaleVet65To74', 'Male75Plus', 'MaleVet75Plus', 'FemalePop', 
         'FemaleVetPop', 'Female18To34', 'FemaleVet18To34', 'Female35To54', 
         'FemaleVet35To54', 'Female55To64', 'FemaleVet55To64', 'Female65To74', 
         'FemaleVet65To74', 'Female75Plus', 'FemaleVet75Plus')

head(zctaVet10P)

## Saving the data

write.csv(zctaVet10P, "~/Desktop/DS04_Z_2010.csv")
