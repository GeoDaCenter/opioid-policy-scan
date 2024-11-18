#setwd("~/Code/opioid-policy-scan/code")

library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

#sVarNames <- load_variables(2019, "acs5/subject", cache = TRUE)
#pVarNames <- load_variables(2019, "acs5/profile", cache = TRUE)
#otherVarNames <- load_variables(2019, "acs5", cache = TRUE)

# B26001_001 works for total group quarters population

county19 <- get_acs(geography = 'county', variables = (totPop19 = "B26001_001"),
                    year = 2019, geometry = FALSE)
head(county19) #matched us census website


county18 <- get_acs(geography = 'county', variables = c(totPop18 = "B01003_001", 
                                                        groupQt18 ="B26001_001"), 
                    year = 2018, geometry = FALSE) %>%
  select(GEOID, NAME, variable, estimate) %>% 
  spread(variable, estimate) %>% 
  mutate(groupQt18r  = groupQt18/totPop18) %>%
  select(GEOID,totPop18,groupQt18r)

head(county18) #matched us census website
hist(county18$groupQt18r)

write.csv(county18, "../data_final/temp/group_quarters_county18.csv")



#BELOW DOES NOT WORK -- PULLS NA. ONLY AVAILABLE AT US-LEVEL NOW


### GROUP QUARTERS ## 
#B26216_001 Estimate!!Total:
#B26216_002 Estimate!!Total:!!Group quarters population:
#B26216_004 Estimate!!Total:!!Group quarters population:!!Institutionalized group quarters population:!!Adult correctional facilities
#B26216_005 Estimate!!Total:!!Group quarters population:!!Institutionalized group quarters population:!!Nursing facilities/skilled nursing facilities
#B26216_008 Estimate!!Total:!!Group quarters population:!!Noninstitutionalized group quarters population:!!College/university student housing
#B26216_009 Estimate!!Total:!!Group quarters population:!!Noninstitutionalized group quarters population:!!Military quarters/military ships


#Using 2019 ACS 5-Year Data
county19 <- get_acs(geography = 'county', variables = c(totPop19 = "B26216_001", 
                                                      groupQt19 ="B26216_002", 
                                                      corrct19 = "B26216_004",
                                                      nursing19 = "B26216_005", 
                                                      univ19 = "B26216_008",
                                                      military19 = "B26216_009"), 
                   year = 2019, geometry = FALSE) %>%
  select(GEOID, NAME, variable, estimate) %>% 
  spread(variable, estimate) %>% 
  mutate(groupQt19r  = groupQt19/totPop19, corrct19r = corrct19/totPop19,
         nursing19r = nursing19/totPop19, univ19r = univ19/totPop19) %>%
  select(GEOID,totPop19,groupQt19r,corrct19r,nursing19r, univ19r)

head(county19)
summary(county19) #returning nulls -- need to redo, may be API issue

