# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will create the 2010 demography data (county)
# for policy scan based on the 2010 decennial census. Missing data in the 2010
# decennial census is pulled from the 2010 ACS 5-year estimates.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)


# Demographic Variables from Summary File 1 (SF)

## Race and Ethnicity

## Variables from SF1:P5: Hispanic Or Latino Origin By Race
# 1. totPopE     SF1_P0050001   Total Population (Estimate)
# 2. white       SF1_P0050003   White (non-Hispanic) (Estimate)
# 3. black       SF1_P0050004   Black or African American (non-Hispanic) (Estimate)
# 4. hispanic    SF1_P0050010   Hispanic or Latino (Estimate)

## Age

## Variables from SF1:P12: Sex By Age
# 1.  ageMale0_4      SF1_P0120003   Male Age <5  (Estimate)
# 2.  ageMale5_9      SF1_P0120004   Male Age 5-9 (Estimate)
# 3.  ageMale10_14    SF1_P0120005   Male Age 10-14 (Estimate)
# 4.  ageMele15_17    SF1_P0120006   Male Age 15-17 (Estimate)
# 5.  ageMale35_39    SF1_P0120013   Male Age 35-39 (Estimate)
# 6.  ageMale40_44    SF1_P0120014   Male Age 40-44 (Estimate)
# 7.  ageMale45_49    SF1_P0120015   Male Age 45-49 (Estimate)
# 8.  ageMale50_54    SF1_P0120016   Male Age 50-54 (Estimate)
# 9.  ageMale55_59    SF1_P0120017   Male Age 55-59 (Estimate)
# 10. ageMale60_61    SF1_P0120018   Male Age 60-61 (Estimate)
# 11. ageMale62_64    SF1_P0120019   Male Age 62-64 (Estimate)
# 12. ageMale65_66    SF1_P0120020   Male Age 65-66 (Estimate)
# 13. ageMale67_69    SF1_P0120021   Male Age 67-69 (Estimate)
# 14. ageMale70_74    SF1_P0120022   Male Age 70-74 (Estimate)
# 15. ageMale75_79    SF1_P0120023   Male Age 75-79 (Estimate)
# 16. ageMale80_84    SF1_P0120024   Male Age 80-84 (Estimate)
# 17. ageMaleOv85     SF1_P0120025   Male Age >85 (Estimate)
# 18. ageFem0_4       SF1_P0120027   Female Age <5  (Estimate)
# 19. ageFem5_9       SF1_P0120028   Female Age 5-9 (Estimate)
# 20. ageFem10_14     SF1_P0120029   Female Age 10-14 (Estimate)
# 21. ageFem15_17     SF1_P0120030   Female Age 15-17 (Estimate)
# 22. ageFem35_39     SF1_P0120037   Female Age 35-39 (Estimate)
# 23. ageFem40_44     SF1_P0120038   Female Age 40-44 (Estimate)
# 24. ageFem45_49     SF1_P0120039   Female Age 45-49 (Estimate)
# 25. ageFem50_54     SF1_P0120040   Female Age 50-54 (Estimate)
# 26. ageFem55_59     SF1_P0120041   Female Age 55-59 (Estimate)
# 27. ageFem60_61     SF1_P0120042   Female Age 60-61 (Estimate)
# 28. ageFem62_64     SF1_P0120043   Female Age 62-64 (Estimate)
# 29. ageFem65_66     SF1_P0120044   Female Age 65-66 (Estimate)
# 30. ageFem67_69     SF1_P0120045   Female Age 67-69 (Estimate)
# 31. ageFem70_74     SF1_P0120046   Female Age 70-74 (Estimate)
# 32. ageFem75_79     SF1_P0120047   Female Age 75-79 (Estimate)
# 33. ageFem80_84     SF1_P0120048   Female Age 8-84 (Estimate)
# 34. ageFemOv85      SF1_P0120049   Female Age >85 (Estimate)


# Demographic Variables from the 2010 ACS 5-year Estimates

library(tidycensus)

## Install a census API key

# census_api_key("key", install = TRUE)


## Population with a Disability

## Variables from DP02
# 1. disbP       DP02_0071P   Disability Status of the Civilian 
#                             Noninstitutionalized Population (Percent Estimate)
## This information is not available. 


## Educational Attainment 

## Variables from B06009: PLACE OF BIRTH BY EDUCATIONAL ATTAINMENT IN THE UNITED
##                        STATES
# 1. popOver25   B06009_001   Population over 25 (Estimate)
# 2. eduNoHS     B06009_002   Less than high school graduate population over 25 
#                             (Estimate)

## Veteran Population

# 1.  TotalPop          B21001_001     Total Population 18 years or over (Estimate)
# 2.  TotalVetPop       B21001_002     Total Veteran Population (Estimate)


# Read the data

countyDem10 <- read_csv("~/Desktop/Task 2/2010/Demographics_DC_2010_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SF1_P0050001, SF1_P0050003, SF1_P0050004,
                SF1_P0050010, SF1_P0120003, SF1_P0120004, SF1_P0120005,
                SF1_P0120006, SF1_P0120013, SF1_P0120014, SF1_P0120015, 
                SF1_P0120016, SF1_P0120017, SF1_P0120018, SF1_P0120019,
                SF1_P0120020, SF1_P0120021, SF1_P0120022, SF1_P0120023, 
                SF1_P0120024, SF1_P0120025, SF1_P0120027, SF1_P0120028, 
                SF1_P0120029, SF1_P0120030, SF1_P0120037, SF1_P0120038, 
                SF1_P0120039, SF1_P0120040, SF1_P0120041, SF1_P0120042, 
                SF1_P0120043, SF1_P0120044, SF1_P0120045, SF1_P0120046,
                SF1_P0120047, SF1_P0120048, SF1_P0120049)

# Rename the columns

colnames(countyDem10) = c("NAME", "FIPS", "totPopE", "white", "black", "hispanic",
                          "ageMale0_4", "ageMale5_9", "ageMale10_14", 
                          "ageMale15_17", "ageMale35_39", "ageMale40_44",
                          "ageMale45_49", "ageMale50_54", "ageMale55_59", 
                          "ageMale60_61", "ageMale62_64", "ageMale65_66", 
                          "ageMale67_69", "ageMale70_74", "ageMale75_79", 
                          "ageMale80_84", "ageMaleOv85", "ageFem0_4", 
                          "ageFem5_9", "ageFem10_14", "ageFem15_17",
                          "ageFem35_39", "ageFem40_44", "ageFem45_49",
                          "ageFem50_54", "ageFem55_59", "ageFem60_61", 
                          "ageFem62_64", "ageFem65_66", "ageFem67_69", 
                          "ageFem70_74", "ageFem75_79", "ageFem80_84", "ageFemOv85") 

# Create a column for year

countyDem10$year = c(2010)

head(countyDem10)


# Percentages

countyDem10P <- countyDem10 %>%
  dplyr::mutate(whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2),
                hispanicP = round(hispanic/totPopE*100, 2), 
                und18P = round((ageMale0_4 + ageMale5_9 + ageMale10_14 + 
                                  ageMale15_17 + ageFem0_4 + ageFem5_9 +
                                  ageFem10_14 + ageFem15_17)/totPopE*100, 2), 
                age35_49P = round((ageMale35_39 + ageMale40_44 + ageMale45_49 +
                                     ageFem35_39 + ageFem40_44 + ageFem45_49)/totPopE*100, 2),
                age50_64P = round((ageMale50_54 + ageMale55_59 + ageMale60_61 + ageMale62_64 +
                                     ageFem50_54 + ageFem55_59 + ageFem60_61 + ageFem62_64)/totPopE*100, 2),
                ovr65P = round((ageMale65_66 + ageMale67_69 + ageMale70_74 + ageMale75_79 +
                                  ageMale80_84 + ageMaleOv85 + ageFem65_66 + ageFem67_69 +
                                  ageFem70_74 + ageFem75_79 + ageFem80_84 + ageFemOv85)/
                                 totPopE*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totPopE', 'whiteP', 'blackP', 'hispanicP',
                         'und18P', 'age35_49P', 'age50_64P', 'ovr65P') 
 
head(countyDem10P)

# Get the data from the 2010 ACS 5-year estimates

# County Level
## It includes 72 - Puerto Rico.

countyDem10ACS <- get_acs(geography = 'county', variables = c(
                                  disbP = "DP02_0071P", popOver25 = "B06009_001", 
                                  eduNoHS = "B06009_002", TotalPop = "B21001_001",
                                  TotalVetPop = "B21001_002"), 
                       year = 2010, geometry = FALSE)

head(countyDem10ACS)

## Percentages

countyDem10ACSP <- countyDem10ACS %>%
  select(GEOID, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(noHSP = round(eduNoHS/popOver25*100, 2), VetPercent = round(TotalVetPop/TotalPop*100, 2)) %>%
  select('GEOID', 'VetPercent', 'noHSP', 'disbP')

# Change the name of the column GEOID

colnames(countyDem10ACSP) = c("FIPS", "VetPercent", "noHSP", "disbP")


head(countyDem10ACSP)


# Merge the 2010 DC and ACS 5-year estimates data

countyDem10PFin <- merge(countyDem10P, countyDem10ACSP, by = "FIPS")


# Save the data

write.csv(countyDem10PFin, "~/Desktop/DS01_C_2010_DC_ACS.csv")
