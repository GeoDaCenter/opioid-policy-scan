# Author : Caglayan Bal
# Date : July 29, 2022
# About : This piece of code will create the 2000 economic variable data 
## (census tract) for policy scan based on the 2000 decennial census 
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

## Per Capita Income

## Variables from SE:T145: Per Capita Income in 1999 Dollars
# 1. pciE    SE_T145_001   Per Capita Income in 1999 Dollars (Estimate)

## Poverty Status

## Variables from RC2000SF3:P87: Poverty Status in 1999 by Age
# 1. totPopE   RC2000SF3_RC2000SF3_008_P087001   Total (Estimate)
# 2. pov       RC2000SF3_RC2000SF3_008_P087002   Income in 1999 Below Poverty 
#                                                Level (Estimate)


# Read the data

tractEcon2000 <- read_csv("~/Desktop/Task 2/2000/EconomicVar_2000_Tract.csv") %>%
  dplyr::select(Geo_QName, Geo_FIPS, SE_T071_001, SE_T071_003, SE_T145_001,
                RC2000SF3_RC2000SF3_008_P087001, RC2000SF3_RC2000SF3_008_P087002)
                

# Rename the columns

colnames(tractEcon2000) = c("NAME", "FIPS", "labor", "Unemp", "pciE", "totPopE",
                          "pov")
                          

# Create a column for year

tractEcon2000$year = c(2000)

head(tractEcon2000)


# Percentages

tractEcon2000P <- tractEcon2000 %>%
  dplyr::mutate(UnempP = round(Unemp/labor*100, 2), povP = round(pov/totPopE*100, 2)) %>%
                  select('NAME', 'FIPS', 'year', 'povP', 'UnempP', 'pciE') 
 
head(tractEcon2000P)

# Save the data

write.csv(tractEcon2000P, "~/Desktop/EC03_T_2000_DC.csv")
