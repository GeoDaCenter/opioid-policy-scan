# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 1990 housing data (county)
# for policy scan based on the 2010 decennial census.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Housing Variables from Summary Explorer (SE)

## Occupancy Status

## Variables from SE:T54: Occupancy Status
# 1. totUnits   SE_T054_001   Housing Units (Estimate)
# 2. occupied   SE_T054_002   Occupied (Estimate)
# 3. vacant     SE_T054_003   Vacant (Estimate)


# Read the data

countyHouse90 <- read_csv("~/Desktop/Task 2/1990/Housing_DC_1990_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T054_001, SE_T054_002, SE_T054_003)

# Rename the columns

colnames(countyHouse90) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

countyHouse90$year = c(1990)

head(countyHouse90)


# Percentages

countyHouse90P <- countyHouse90 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(countyHouse90P)

# Save the data

write.csv(countyHouse90P, "~/Desktop/HS01_C_1990_DC.csv")
