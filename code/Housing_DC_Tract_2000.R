# Author : Caglayan Bal
# Date : July 31, 2022
# About : This piece of code will create the 2000 housing data (census tract)
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

tractHouse2000 <- read_csv("~/Desktop/Task 2/2000/Housing_2000_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T157_001, SE_T157_002, SE_T157_003)

# Rename the columns

colnames(tractHouse2000) = c("NAME", "FIPS", "totUnits", "occupied", "vacant") 

# Create a column for year

tractHouse2000$year = c(2000)

head(tractHouse2000)


# Percentages

tractHouse2000P <- tractHouse2000 %>%
  dplyr::mutate(occP = round(occupied/totUnits*100, 2), 
                vacantP = round(vacant/totUnits*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'totUnits', 'occP', 'vacantP') 
 
head(tractHouse2000P)

# Save the data

write.csv(tractHouse2000P, "~/Desktop/HS01_T_2000_DC.csv")
