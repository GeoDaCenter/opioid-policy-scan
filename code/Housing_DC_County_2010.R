# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 2010 housing data (county)
# for policy scan based on the 2010 decennial census.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Housing Variables from Summary File 1 (SF)

## Occupancy Status

## Variables from SF1:H3: Occupancy Status
# 1. totUnits   SF1_H0030001   Housing Units (Estimate)
# 2. occupied   SF1_H0030002   Occupied (Estimate)
# 3. vacant     SF1_H0030003   Vacant (Estimate)


# Read the data

countyHouse10 <- read_csv("~/Desktop/Task 2/2010/Housing_DC_2010_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SF1_H0030001, SF1_H0030002, SF1_H0030003)

# Rename the columns

colnames(countyHouse10) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

countyHouse10$year = c(2010)

head(countyHouse10)


# Percentages

countyHouse10P <- countyHouse10 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(countyHouse10P)

# Save the data

write.csv(countyHouse10P, "~/Desktop/HS01_C_2010_DC.csv")
