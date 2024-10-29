
library(sf)
library(tidyverse)
library(tidycensus)

Sys.getenv("CENSUS_API_KEY")

sVarNames <- load_variables(2019, "acs5/subject", cache = TRUE)
pVarNames <- load_variables(2019, "acs5/profile", cache = TRUE)
otherVarNames <- load_variables(2019, "acs5", cache = TRUE)

View(pVarNames)
View(sVarNames)
View(otherVarNames)



### GROUP QUARTERS
#S2603_C01_001 Estimate!!Total population!!Total population
#S2603_C02_001 Estimate!!Total group quarters population!!Total population
#S2603_C03_001 Estimate!!Adult correctional facilities!!Total population
#S2603_C04_001 Estimate!!Nursing facilities/skilled nursing facilities!!Total population
#S2603_C06_001 Estimate!!College/university housing!!Total population
#S2603_C07_001 Estimate!!Military quarters/military ships!!Total population


+ Crowed_household: 
  
  


  
  + Limited_English_p

B16005A_001
v\Estimate!!Total:

B16005_007
Estimate!!Total:!!Native:!!Speak Spanish:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_012
Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_017
Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_022
Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_029
Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_034
Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_039
Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not well"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_044
Estimate!!Total:!!Foreign born:!!Speak other languages:!!Speak English "not well"

B16005_013 Estimate!!Total:!!Native:!!Speak other Indo-European languages:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_018 Estimate!!Total:!!Native:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_023 Estimate!!Total:!!Native:!!Speak other languages:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_030 Estimate!!Total:!!Foreign born:!!Speak Spanish:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_035 Estimate!!Total:!!Foreign born:!!Speak other Indo-European languages:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

B16005_040 Estimate!!Total:!!Foreign born:!!Speak Asian and Pacific Island languages:!!Speak English "not at all"
NATIVITY BY LANGUAGE SPOKEN AT HOME BY ABILITY TO SPEAK ENGLISH FOR THE POPULATION 5 YEARS AND OVER
tract

