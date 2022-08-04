# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 1990 housing data (census tract)
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

tractHouse90 <- read_csv("~/Desktop/Task 2/1990/Housing_1990_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T054_001, SE_T054_002, SE_T054_003)

# Rename the columns

colnames(tractHouse90) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

tractHouse90$year = c(1990)

head(tractHouse90)


# Percentages

tractHouse90P <- tractHouse90 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(tractHouse90P)

# Save the data

write.csv(tractHouse90P, "~/Desktop/HS01_T_1990_DC.csv")
