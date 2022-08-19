# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 2010 housing data (census tract)
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

tractHouse10 <- read_csv("~/Desktop/Task 2/2010/Housing_DC_2010_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SF1_H0030001, SF1_H0030002, SF1_H0030003)

# Rename the columns

colnames(tractHouse10) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

tractHouse10$year = c(2010)

head(tractHouse10)


# Percentages

tractHouse10P <- tractHouse10 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(tractHouse10P)

# Save the data

write.csv(tractHouse10P, "~/Desktop/HS01_T_2010_DC.csv")
