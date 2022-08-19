# Author : Caglayan Bal
# Date : July 20, 2022
# About : This piece of code will create the 2010 demography data (census tract)
# for policy scan based on the 2010 decennial census.

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


# Read the data

tractDem10 <- read_csv("~/Desktop/Task 2/2010/Demographics_DC_2010_Tract.csv") %>%
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

colnames(tractDem10) = c("NAME", "FIPS", "totPopE", "white", "black", "hispanic",
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

head(tractDem10)

# Create a column for year

tractDem10$year = c(2010)

head(tractDem10)

# Percentages

tractDem10P <- tractDem10 %>%
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
 
head(tractDem10P)

# Save the data

write.csv(tractDem10P, "~/Desktop/DS01_T_2010_DC.csv")
