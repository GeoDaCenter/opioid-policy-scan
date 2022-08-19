# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 1980 housing data (county)
# for policy scan based on the 2010 decennial census.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Housing Variables from Summary Explorer (SE)

## Occupancy Status

## Variables from SE:T67: Occupancy Status
# 1. totUnits   SE_T067_001   Housing Units (Estimate)
# 2. occupied   SE_T067_002   Occupied (Estimate)
# 3. vacant     SE_T067_003   Vacant (Estimate)


# Read the data

countyHouse80 <- read_csv("~/Desktop/Task 2/1980/Housing_DC_1980_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T067_001, SE_T067_002, SE_T067_003)

# Rename the columns

colnames(countyHouse80) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

countyHouse80$year = c(1980)

head(countyHouse80)


# Percentages

countyHouse80P <- countyHouse80 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(countyHouse80P)

# Save the data

write.csv(countyHouse80P, "~/Desktop/HS01_C_1980_DC.csv")
