# Author : Caglayan Bal
# Date : July 29, 2022
# About : This piece of code will create the 1980 demography data (census tract)
# for policy scan based on the 1980 decennial census on 2010 geographies.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Demographic Variables from Social Explorer (SE) Tables

## Race and Ethnicity

## Variables from SE:T13: Race By Spanish Origin Status
# 1. totPopE     SE_T013_001   Total Population (Estimate)
# 2. white       SE_T013_003   White (non-Hispanic) (Estimate)
# 3. black       SE_T013_004   Black or African American (non-Hispanic) (Estimate)
# 4. hispanic    SE_T013_007   Persons of Spanish Origin (Estimate)

## Age

## Variables from SE:T7: Age
# 1.  age0_4     SE_T007_002   Age <5 (Estimate)
# 2.  age5_9     SE_T007_003   Age 5-9 (Estimate)
# 3.  age10_14   SE_T007_004   Age 10-14 (Estimate)
# 4.  age15_17   SE_T007_005   Age 15-17 (Estimate)
# 5.  age65_74   SE_T007_011   Age 65-74 (Estimate)
# 6.  age75_84   SE_T007_012   Age 75-84 (Estimate)
# 7.  ageOv85    SE_T007_013   Age >85 (Estimate)

## Educational Attainment

## Variables from SE:T29: Educational Attainment for Population 25 Years and Over
# 1. popOver25   SE_T029_001   Population over 25 (Estimate)
# 2. eduNoHS     SE_T029_002   Elementary (0 to 8 years) (Estimate)   

## Veteran Population

## Variables from SE:T96: Veteran Status (Civilian Persons 16 Years and Over)
# 1. TotVetPop   SE_T096_002   Veteran (Estimate)


# Read the data

tractDem80 <- read_csv("~/Desktop/Task 2/1980/Demographics_DC_1980_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T013_001, SE_T013_003, SE_T013_004, 
                SE_T013_007, SE_T007_002, SE_T007_003, SE_T007_004, SE_T007_005,
                SE_T007_011, SE_T007_012, SE_T007_013, SE_T029_001, SE_T029_002,
                SE_T096_002)
                
# Rename the columns

colnames(tractDem80) = c("NAME", "FIPS", "totPopE", "white", "black", "hispanic",
                          "age0_4", "age5_9", "age10_14", "age15_17", "age65_74",
                          "age75_84", "ageOv85", "popOver25", "eduNoHS", "TotVetPop")
                          

# Create a column for year

tractDem80$year = c(1980)

head(tractDem80)


# Percentages

tractDem80P <- tractDem80 %>%
  dplyr::mutate(whiteP = round(white/totPopE*100, 2), blackP = round(black/totPopE*100, 2),
                hispanicP = round(hispanic/totPopE*100, 2), 
                und18P = round((age0_4 + age5_9 + age10_14 + age15_17)/totPopE*100, 2), 
                ovr65P = round((age65_74 + age75_84 + ageOv85)/totPopE*100, 2),
                noHSP = round(eduNoHS/popOver25*100, 2), 
                vetPercent = round(TotVetPop/totPopE*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totPopE', 'whiteP', 'blackP', 'hispanicP',
                         'und18P', 'ovr65P', 'vetPercent', 'noHSP') 
 
head(tractDem80P)

# Save the data

write.csv(tractDem80P, "~/Desktop/DS01_T_1980_DC.csv")
