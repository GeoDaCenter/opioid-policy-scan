# Author : Caglayan Bal
# Date : July 21, 2022
# About : This piece of code will create the 2000 demography data (county)
# for policy scan based on the 2000 decennial census on 2010 geographies.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Demographic Variables from Social Explorer (SE) Tables and Summary File (SF) 3

## Race and Ethnicity

## Variables from SE:T13: Hispanic or Latino by Race
# 1. totPopE     SE_T013_001   Total Population (Estimate)
# 2. white       SE_T013_003   White (non-Hispanic) (Estimate)
# 3. black       SE_T013_004   Black or African American (non-Hispanic) (Estimate)
# 4. hispanic    SE_T013_010   Hispanic or Latino (Estimate)

## Age

## Variables from SE:T9: Age
# 1.  age0_4      SE_T009_002   Age <5  (Estimate)
# 2.  age5_9      SE_T009_003   Age 5-9 (Estimate)
# 3.  age10_14    SE_T009_004   Age 10-14 (Estimate)
# 4.  age15_17    SE_T009_005   Age 15-17 (Estimate)
# 5.  age35_39    SE_T009_012   Age 35-39 (Estimate)
# 6.  age40_44    SE_T009_013   Age 40-44 (Estimate)
# 7.  age45_49    SE_T009_014   Age 45-49 (Estimate)
# 8.  age50_54    SE_T009_015   Age 50-54 (Estimate)
# 9.  age55_59    SE_T009_016   Age 55-59 (Estimate)
# 10. age60_61    SE_T009_017   Age 60-61 (Estimate)
# 11. age62_64    SE_T009_018   Age 62-64 (Estimate)
# 12. age65_66    SE_T009_019   Age 65-66 (Estimate)
# 13. age67_69    SE_T009_020   Age 67-69 (Estimate)
# 14. age70_74    SE_T009_021   Age 70-74 (Estimate)
# 15. age75_79    SE_T009_022   Age 75-79 (Estimate)
# 16. age80_84    SE_T009_023   Age 80-84 (Estimate)
# 17. ageOv85     SE_T009_024   Age >85 (Estimate)

## Educational Attainment

## Variables from SE:T38: Educational Attainment for Population 25 Years and Over
# 1. popOver25   SE_T038_001   Population over 25 (Estimate)
# 2. eduNoHS     SE_T038_002   Less than high school graduate population over 25 
#                              (Estimate)   

## Veteran Population

## Variables from SE:T200: Veteran Status for the Civilian Population
# 1. TotVetPop   SE_T200_002   Veteran (18 Years and Over) (Estimate)

## Population with a Disability

##Variables from RC2000SF3:P41: Age by Types of Disability for the Civilian
##                              Noninstitutionalized Population 5+ Years 
##                              with Disabilities
# 1. disb       RC2000SF3_RC2000SF3_004_P041001   Total Disabilities Tallied
#                                                 (Estimate)


# Read the data

countyDem2000 <- read_csv("~/Desktop/Task 2/2000/Demographics_2000_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T013_001, SE_T013_003, SE_T013_004, 
                SE_T013_010, SE_T009_002, SE_T009_003, SE_T009_004, SE_T009_005,
                SE_T009_012, SE_T009_013, SE_T009_014, SE_T009_015, SE_T009_016, 
                SE_T009_017, SE_T009_018, SE_T009_019, SE_T009_020, SE_T009_021,
                SE_T009_022, SE_T009_023, SE_T009_024, SE_T038_001, SE_T038_002,
                SE_T200_002, RC2000SF3_RC2000SF3_004_P041001)
                

# Rename the columns

colnames(countyDem2000) = c("NAME", "FIPS", "totPopE", "white", "black", "hispanic",
                          "age0_4", "age5_9", "age10_14", "age15_17", "age35_39",
                          "age40_44", "age45_49", "age50_54", "age55_59", 
                          "age60_61", "age62_64", "age65_66", "age67_69", 
                          "age70_74", "age75_79", "age80_84", "ageOv85", 
                          "popOver25", "eduNoHS", "TotVetPop", "disb")

# Create a column for year

countyDem2000$year = c(2000)

head(countyDem2000)


# Percentages

countyDem2000P <- countyDem2000 %>%
  dplyr::mutate(whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2),
                hispanicP = round(hispanic/totPopE*100, 2), 
                und18P = round((age0_4 + age5_9 + age10_14 + age15_17)/totPopE*100, 2), 
                age35_49P = round((age35_39 + age40_44 + age45_49)/totPopE*100, 2),
                age50_64P = round((age50_54 + age55_59 + age60_61 + age62_64)/totPopE*100, 2),
                ovr65P = round((age65_66 + age67_69 + age70_74 + age75_79 +
                                  age80_84 + ageOv85)/totPopE*100, 2),
                noHSP = round(eduNoHS/popOver25*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totPopE', 'whiteP', 'blackP', 'hispanicP',
                         'und18P', 'age35_49P', 'age50_64P', 'ovr65P', 'TotVetPop', 'noHSP', 'disb') 
 
head(countyDem2000P)

# Save the data

write.csv(countyDem2000P, "~/Desktop/DS01_C_2000_DC.csv")
