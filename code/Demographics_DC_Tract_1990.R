# Author : Caglayan Bal
# Date : July 24, 2022
# About : This piece of code will create the 1990 demography data (census tract)
# for policy scan based on the 1990 decennial census on 2010 geographies.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Demographic Variables from Social Explorer (SE) Tables and Summary File (SF) 1

## Race and Ethnicity

## Variables from SE:T12: Hispanic Origin By Race
# 1. totPopE     SE_T012_001   Total Population (Estimate)
# 2. white       SE_T012_003   White (non-Hispanic) (Estimate)
# 3. black       SE_T012_004   Black or African American (non-Hispanic) (Estimate)
# 4. hispanic    SE_T012_008   Hispanic or Latino (Estimate)

## Age

## Variables from RC1990SF1:P11: Age
# 1.  age0       RC1990SF1_RC1990SF1_001_P011_002   Age <1 (Estimate)
# 2.  age1_2     RC1990SF1_RC1990SF1_001_P011_003   Age 1-2 (Estimate)
# 3.  age3_4     RC1990SF1_RC1990SF1_001_P011_004   Age 3-4 (Estimate)
# 4.  age5       RC1990SF1_RC1990SF1_001_P011_005   Age 5 (Estimate)
# 5.  age6       RC1990SF1_RC1990SF1_001_P011_006   Age 6 (Estimate)
# 6.  age7_9     RC1990SF1_RC1990SF1_001_P011_007   Age 7-9 (Estimate)
# 7.  age10_11   RC1990SF1_RC1990SF1_001_P011_008   Age 10-11 (Estimate)
# 8.  age12_13   RC1990SF1_RC1990SF1_001_P011_009   Age 12-13 (Estimate)
# 9.  age14      RC1990SF1_RC1990SF1_001_P011_010   Age 14 (Estimate)
# 10. age15      RC1990SF1_RC1990SF1_001_P011_011   Age 15 (Estimate)
# 11. age16      RC1990SF1_RC1990SF1_001_P011_012   Age 16 (Estimate)
# 12. age17      RC1990SF1_RC1990SF1_001_P011_013   Age 17 (Estimate)
# 13. age18      RC1990SF1_RC1990SF1_001_P011_014   Age 18 (Estimate)
# 14. age19      RC1990SF1_RC1990SF1_001_P011_015   Age 19 (Estimate)
# 15. age20      RC1990SF1_RC1990SF1_001_P011_016   Age 20 (Estimate)
# 16. age21      RC1990SF1_RC1990SF1_001_P011_017   Age 21 (Estimate)
# 17. age22_24   RC1990SF1_RC1990SF1_001_P011_018   Age 22-24 (Estimate)
# 18. age25_29   RC1990SF1_RC1990SF1_001_P011_019   Age 25-29 (Estimate)
# 19. age30_34   RC1990SF1_RC1990SF1_001_P011_020   Age 30-34 (Estimate)
# 20. age35_39   RC1990SF1_RC1990SF1_001_P011_021   Age 35-39 (Estimate)
# 21. age40_44   RC1990SF1_RC1990SF1_001_P011_022   Age 40-44 (Estimate)
# 22. age45_49   RC1990SF1_RC1990SF1_001_P011_023   Age 45-49 (Estimate)
# 23. age50_54   RC1990SF1_RC1990SF1_001_P011_024   Age 50-54 (Estimate)
# 24. age55_59   RC1990SF1_RC1990SF1_001_P011_025   Age 55-59 (Estimate)
# 25. age60_61   RC1990SF1_RC1990SF1_001_P011_026   Age 60-61 (Estimate)
# 26. age62_64   RC1990SF1_RC1990SF1_001_P011_027   Age 62-64 (Estimate)
# 27. age65_69   RC1990SF1_RC1990SF1_001_P011_028   Age 65-69 (Estimate)
# 28. age70_74   RC1990SF1_RC1990SF1_001_P011_029   Age 70-74 (Estimate)
# 29. age75_79   RC1990SF1_RC1990SF1_001_P011_030   Age 75-79 (Estimate)
# 30. age80_84   RC1990SF1_RC1990SF1_001_P011_031   Age 80-84 (Estimate)
# 31. ageOv85    RC1990SF1_RC1990SF1_001_P011_032   Age >85 (Estimate)

## Educational Attainment

## Variables from SE:T21: Educational Attainment for Population 25 Years and Over
# 1. popOver25   SE_T021_001   Population over 25 (Estimate)
# 2. eduNoHS     SE_T021_002   Less than high school graduate population over 25 
#                              (Estimate)   

## Veteran Population

## Variables from SE:T80: Veteran Status for Civilian Population By Age Group
# 1. TotVetPop   SE_T080_001   Veteran (16 Years and Over) (Estimate)

## Population with a Disability

##Variables from RC1990SF3:P66: Sex By Age By Work Disability Status and 
##                              Employment Status 
##                              (Civilian noninstitutionalized persons 16 years 
##                              and over)
# 1. disbMale   RC1990SF3_RC1990SF3_009_P066_002   Male (Estimate)
# 2. disbFem    RC1990SF3_RC1990SF3_009_P066_029   Female (Estimate) 

# Read the data

tractDem90 <- read_csv("~/Desktop/Task 2/1990/Demographics_1990_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T012_001, SE_T012_003, SE_T012_004,
                SE_T012_008, RC1990SF1_RC1990SF1_001_P011_002,
                RC1990SF1_RC1990SF1_001_P011_003, RC1990SF1_RC1990SF1_001_P011_004, 
                RC1990SF1_RC1990SF1_001_P011_005, RC1990SF1_RC1990SF1_001_P011_006,
                RC1990SF1_RC1990SF1_001_P011_007, RC1990SF1_RC1990SF1_001_P011_008,
                RC1990SF1_RC1990SF1_001_P011_009, RC1990SF1_RC1990SF1_001_P011_010,
                RC1990SF1_RC1990SF1_001_P011_011, RC1990SF1_RC1990SF1_001_P011_012,
                RC1990SF1_RC1990SF1_001_P011_013, RC1990SF1_RC1990SF1_001_P011_014, 
                RC1990SF1_RC1990SF1_001_P011_015, RC1990SF1_RC1990SF1_001_P011_016,
                RC1990SF1_RC1990SF1_001_P011_017, RC1990SF1_RC1990SF1_001_P011_018,
                RC1990SF1_RC1990SF1_001_P011_019, RC1990SF1_RC1990SF1_001_P011_020,
                RC1990SF1_RC1990SF1_001_P011_021, RC1990SF1_RC1990SF1_001_P011_022,
                RC1990SF1_RC1990SF1_001_P011_023, RC1990SF1_RC1990SF1_001_P011_024,
                RC1990SF1_RC1990SF1_001_P011_025, RC1990SF1_RC1990SF1_001_P011_026,
                RC1990SF1_RC1990SF1_001_P011_027, RC1990SF1_RC1990SF1_001_P011_028,
                RC1990SF1_RC1990SF1_001_P011_029, RC1990SF1_RC1990SF1_001_P011_030,
                RC1990SF1_RC1990SF1_001_P011_031, RC1990SF1_RC1990SF1_001_P011_032,
                SE_T021_001, SE_T021_002, SE_T080_001, 
                RC1990SF3_RC1990SF3_009_P066_002, RC1990SF3_RC1990SF3_009_P066_029)
                
# Rename the columns

colnames(tractDem90) = c("NAME", "FIPS", "totPopE", "white", "black", "hispanic",
                            "age0", "age1_2", "age3_4", "age5", "age6", "age7_9",
                            "age10_11", "age12_13", "age14", "age15", "age16",
                            "age17", "age18", "age19", "age20", "age21", "age22_24",
                            "age25_29", "age30_34", "age35_39", "age40_44", "age45_49",
                            "age50_54", "age55_59", "age60_61", "age62_64", "age65_69",
                            "age70_74", "age75_79", "age80_84", "ageOv85", "popOver25",
                            "eduNoHS", "TotVetPop", "disbMale", "disbFem")

# Create a column for year

tractDem90$year = c(1990)

head(tractDem90)


# Percentages

tractDem90P <- tractDem90 %>%
  dplyr::mutate(whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2),
                hispanicP = round(hispanic/totPopE*100, 2), 
                und18P = round((age0 + age1_2 + age3_4 + age5 + age6 + age7_9 +
                                  age10_11 + age12_13 + age14 + age15 + age16 +
                                  age17)/totPopE*100, 2), 
                age35_49P = round((age35_39 + age40_44 + age45_49)/totPopE*100, 2),
                age50_64P = round((age50_54 + age55_59 + age60_61 + age62_64)/totPopE*100, 2),
                ovr65P = round((age65_69 + age70_74 + age75_79 + age80_84 + ageOv85)/totPopE*100, 2),
                noHSP = round(eduNoHS/popOver25*100, 2), disb = (disbMale + disbFem)) %>%
                  select('NAME', 'FIPS', 'year', 'totPopE', 'whiteP', 'blackP', 'hispanicP',
                         'und18P', 'age35_49P', 'age50_64P', 'ovr65P', 'TotVetPop', 'noHSP', 'disb') 
 
head(tractDem90P)

# Save the data

write.csv(tractDem90P, "~/Desktop/DS01_T_1990_DC.csv")
