# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 1980 housing data (census tract)
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

tractHouse80 <- read_csv("~/Desktop/Task 2/1980/Housing_1980_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T067_001, SE_T067_002, SE_T067_003)

# Rename the columns

colnames(tractHouse80) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

tractHouse80$year = c(1980)

head(tractHouse80)


# Percentages

tractHouse80P <- tractHouse80 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(tractHouse80P)

# Save the data

write.csv(tractHouse80P, "~/Desktop/HS01_T_1980_DC.csv")
