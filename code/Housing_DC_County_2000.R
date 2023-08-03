# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 2000 housing data (county)
# for policy scan based on the 2010 decennial census.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Housing Variables from Social Explorer (SE) Tables

## Occupancy Status

## Variables from SE1:T157: Occupancy Status
# 1. totUnits   SE_T157_001   Housing Units (Estimate)
# 2. occupied   SE_T157_002   Occupied (Estimate)
# 3. vacant     SE_T157_003   Vacant (Estimate)


# Read the data

countyHouse2000 <- read_csv("~/Desktop/Task 2/2000/Housing_DC_2000_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T157_001, SE_T157_002, SE_T157_003)

# Rename the columns

colnames(countyHouse2000) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

countyHouse2000$year = c(2000)

head(countyHouse2000)


# Percentages

countyHouse2000P <- countyHouse2000 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(countyHouse2000P)

# Save the data

write.csv(countyHouse2000P, "~/Desktop/HS01_C_2000_DC.csv")
