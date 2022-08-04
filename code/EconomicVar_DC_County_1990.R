# Author : Caglayan Bal
# Date : July 30, 2022
# About : This piece of code will create the 1990 economic variable data 
## (county) for policy scan based on the 1990 decennial census 
## on 2010 geographies.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Economic Variables from Social Explorer (SE) Tables

## Unemployment Rate for Civilian Population

## Variables from SE:T29: Unemployment Rate For Total Population 16 Years and
##                        Over
# 1. labor   SE_T029_001   Civilian Population In Labor Force 16 Years And Over 
#                          (Estimate)
# 2. Unemp   SE_T029_003   Unemployed (Estimate)

## Poverty Status

## Variables from SE:T65: Poverty Status in 1989 by Age Group
# 1. totPopE   SE_T065_001   Persons for whom poverty status is determined 
#                            (Estimate)
# 2. pov       SE_T065_006   Income in 1989 below poverty level (Estimate)


# Read the data

countyEcon90 <- read_csv("~/Desktop/Task 2/1990/EconomicVar_1990_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T029_001, SE_T029_003, SE_T065_001,
                SE_T065_006)
                

# Rename the columns

colnames(countyEcon90) = c("NAME", "FIPS", "labor", "Unemp", "totPopE", "pov")
                          

# Create a column for year

countyEcon90$year = c(1990)

head(countyEcon90)


# Percentages

countyEcon90P <- countyEcon90 %>%
  dplyr::mutate(UnempP = round(Unemp/labor*100, 2), povP = round(pov/totPopE*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'povP', 'UnempP') 
 
head(countyEcon90P)

# Save the data

write.csv(countyEcon90P, "~/Desktop/EC03_C_1990_DC.csv")
