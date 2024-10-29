
library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

#sVarNames <- load_variables(2019, "acs5/subject", cache = TRUE)
#pVarNames <- load_variables(2019, "acs5/profile", cache = TRUE)
#otherVarNames <- load_variables(2019, "acs5", cache = TRUE)


### ENGLISH PROFICIENCY
### Matched CDC SVI Guidelines from 2018 for "Limited English Proficiency"
# B16005_001 Estimate!!Total:
# B16005_007 Estimate!!Total:!!Native:!!Speak Spanish:!!Speak English "not well"
# B16005_012 Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not well"
# B16005_017 Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
# B16005_022 Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not well"
# B16005_029 Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not well"
# B16005_034 Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not well"
# B16005_039 Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
# B16005_044 Estimate!!Total:!!Foreign born:!!Speak other languages:!!Speak English "not well"
# B16005_008 Estimate!!Total:!!Native:!!Speak Spanish:!!Speak English "not at all"
# B16005_013 Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not at all"
# B16005_018 Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
# B16005_023 Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not at all"
# B16005_030 Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not at all"
# B16005_035 Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not at all"
# B16005_040 Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
# B16005_045 Estimate!!Total:!!Foreign born:!!Speak other languages:!!Speak English "not at all"


county19 <- get_acs(geography = 'county', variables = (totPop19 = "B16005A_001"),
                    year = 2019, geometry = FALSE)
head(county19)


#Using 2019 ACS 5-Year Data
county19 <- get_acs(geography = 'county', variables = c(totPop19 = "B16005_001", 
                                                        B16005_007 ="B16005_007", 
                                                        B16005_012 = "B16005_012",
                                                        B16005_017 = "B16005_017", 
                                                        B16005_022 = "B16005_022",
                                                        B16005_029 = "B16005_029",
                                                        B16005_034 = "B16005_034",
                                                        B16005_039 = "B16005_039",
                                                        B16005_044 = "B16005_044",
                                                        B16005_008 = "B16005_008",
                                                        B16005_013 = "B16005_013",
                                                        B16005_018 = "B16005_018",
                                                        B16005_023 = "B16005_023",
                                                        B16005_030 = "B16005_030",
                                                        B16005_035 = "B16005_035",
                                                        B16005_040 = "B16005_040",
                                                        B16005_045 = "B16005_045"), 
                    year = 2019, geometry = FALSE) %>%
  select(GEOID, NAME, variable, estimate) %>% 
  spread(variable, estimate) %>% 
  mutate(engProf19  = (B16005_007+B16005_012+B16005_017+B16005_022+
                         B16005_029+ B16005_034+B16005_039+ B16005_044+
                         B16005_008+B16005_013+B16005_018+B16005_023+
                         B16005_030+B16005_035+B16005_040+B16005_045)/totPop19) %>%
  select(GEOID,totPop19,engProf19)

head(county19)
summary(county19) 

hist(county19$engProf19)

#write.csv(county19, "../data_final/temp/limEng_county19.csv")
