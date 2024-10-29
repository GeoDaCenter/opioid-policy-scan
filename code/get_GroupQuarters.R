
library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

#sVarNames <- load_variables(2019, "acs5/subject", cache = TRUE)
#pVarNames <- load_variables(2019, "acs5/profile", cache = TRUE)
#otherVarNames <- load_variables(2019, "acs5", cache = TRUE)

#S2603_C01_001 Estimate!!Total population!!Total population
#S2603_C02_001 Estimate!!Total group quarters population!!Total population
#S2603_C03_001 Estimate!!Adult correctional facilities!!Total population
#S2603_C04_001 Estimate!!Nursing facilities/skilled nursing facilities!!Total population
#S2603_C06_001 Estimate!!College/university housing!!Total population
#S2603_C07_001 Estimate!!Military quarters/military ships!!Total population


county19 <- get_acs(geography = 'county', variables = (totPop19 = "S2603_C01_001"),
                    year = 2019, geometry = FALSE)
head(county19)


#Using 2019 ACS 5-Year Data
county19 <- get_acs(geography = 'county', variables = c(totPop19 = "S2603_C01_001", 
                                                      groupQt19 ="S2603_C02_001", 
                                                      corrct19 = "S2603_C03_001",
                                                      nursing19 = "S2603_C04_001", 
                                                      univ19 = "S2603_C06_001",
                                                      military19 = "S2603_C07_001"), 
                   year = 2019, geometry = FALSE) %>%
  select(GEOID, NAME, variable, estimate) %>% 
  spread(variable, estimate) %>% 
  mutate(groupQt19r  = groupQt19/totPop19, corrct19r = corrct19/totPop19,
         nursing19r = nursing19/totPop19, univ19r = univ19/totPop19) %>%
  select(GEOID,totPop19,groupQt19r,corrct19r,nursing19r, univ19r)

head(county19)
summary(county19) #returning nulls -- need to redo, may be API issue

#write.csv(county19, "../data_final/temp/group_quarters_county19.csv")
