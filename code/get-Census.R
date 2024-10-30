
library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

sVarNames <- load_variables(2019, "acs5/subject", cache = TRUE)
pVarNames <- load_variables(2019, "acs5/profile", cache = TRUE)
otherVarNames <- load_variables(2019, "acs5", cache = TRUE)
otherVarNames18 <- load_variables(2018, "acs5", cache = TRUE)



View(pVarNames)
View(sVarNames)
View(otherVarNames)



### GROUP QUARTERS ## Below didn't work, unclear why
#S2603_C01_001 Estimate!!Total population!!Total population
#S2603_C02_001 Estimate!!Total group quarters population!!Total population
#S2603_C03_001 Estimate!!Adult correctional facilities!!Total population
#S2603_C04_001 Estimate!!Nursing facilities/skilled nursing facilities!!Total population
#S2603_C06_001 Estimate!!College/university housing!!Total population
#S2603_C07_001 Estimate!!Military quarters/military ships!!Total population

### GROUP QUARTERS ## 
#B26216_001 Estimate!!Total:
#B26216_002 Estimate!!Total:!!Group quarters population:
#B26216_004 Estimate!!Total:!!Group quarters population:!!Institutionalized group quarters population:!!Adult correctional facilities
#B26216_005 Estimate!!Total:!!Group quarters population:!!Institutionalized group quarters population:!!Nursing facilities/skilled nursing facilities
#B26216_008 Estimate!!Total:!!Group quarters population:!!Noninstitutionalized group quarters population:!!College/university student housing
#B26216_009 Estimate!!Total:!!Group quarters population:!!Noninstitutionalized group quarters population:!!Military quarters/military ships


### CROWDED HOUSING
### Matched CDC SVI Guidelines from 2018 for "Crowded Housing as >1 occupant per room"

#B25014_001 Estimate!!Total:
#B25014_005 Estimate!!Total:!!Owner occupied:!!1.01 to 1.50 occupants per room
#B25014_006 Estimate!!Total:!!Owner occupied:!!1.51 to 2.00 occupants per room
#B25014_007 Estimate!!Total:!!Owner occupied:!!2.01 or more occupants per room
#B25014_011 Estimate!!Total:!!Renter occupied:!!1.01 to 1.50 occupants per room
#B25014_012 Estimate!!Total:!!Renter occupied:!!1.51 to 2.00 occupants per room
#B25014_013 Estimate!!Total:!!Renter occupied:!!2.01 or more occupants per room


### ENGLISH PROFICIENCY
### Matched CDC SVI Guidelines from 2018 for "Limited English Proficiency"
# B16005A_001 Estimate!!Total:
# B16005_007 Estimate!!Total:!!Native:!!Speak Spanish:!!Speak English "not well"
# B16005_012 Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not well"
# B16005_017 Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
# B16005_022 Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not well"
# B16005_029 Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not well"
# B16005_034 Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not well"
# B16005_039 Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
# B16005_044 Estimate!!Total:!!Foreign born:!!Speak other languages:!!Speak English "not well"
# B16005_018 Estimate!!Total:!!Native:!!Speak Spanish:!!Speak English "not at all"
# B16005_013 Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not at all"
# B16005_018 Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
# B16005_023 Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not at all"
# B16005_030 Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not at all"
# B16005_035 Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not at all"
# B16005_040 Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
# B16005_045 Estimate!!Total:!!Foreign born:!!Speak other languages:!!Speak English "not at all"

