# Author : Caglayan Bal
# Date : July 29, 2022
# About : This piece of code will create the 2000 economic variable data 
## (county) for policy scan based on the 2000 decennial census 
## on 2010 geographies.

# Libraries
library(sf)
library(tidyverse)
library(dplyr)

# Economic Variables from Social Explorer (SE) Tables and Summary File (SF) 3

## Unemployment Rate for Civilian Population

## Variables from SE:T71: Unemployment Rate for Civilian Population In Labor 
##                        Force 16 Years and Over
# 1. labor   SE_T071_001   Civilian Population in Labor Force 16 Years and Over 
#                          (Estimate)
# 2. Unemp   SE_T071_003   Unemployed (Estimate)

## Poverty Status

## Variables from RC2000SF3:P87: Poverty Status in 1999 by Age
# 1. totPopE   RC2000SF3_RC2000SF3_008_P087001   Total (Estimate)
# 2. pov       RC2000SF3_RC2000SF3_008_P087002   Income in 1999 Below Poverty 
#                                                Level (Estimate)


# Read the data

countyEcon2000 <- read_csv("~/Desktop/Task 2/2000/EconomicVar_DC_2000_County.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T071_001, SE_T071_003,
                RC2000SF3_RC2000SF3_008_P087001, RC2000SF3_RC2000SF3_008_P087002)
                

# Rename the columns

colnames(countyEcon2000) = c("NAME", "FIPS", "labor", "Unemp", "totPopE", "pov")
                          

# Create a column for year

countyEcon2000$year = c(2000)

head(countyEcon2000)


# Percentages

countyEcon2000P <- countyEcon2000 %>%
  dplyr::mutate(UnempP = round(Unemp/labor*100, 2), povP = round(pov/totPopE*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'povP', 'UnempP') 
 
head(countyEcon2000P)

# Save the data

write.csv(countyEcon2000P, "~/Desktop/EC03_C_2000_DC.csv")
