# Author : Caglayan Bal
# Date : August 11, 2022
# About : This piece of code will download the 2010 economic data (county)
# for policy scan based on the ACS 5-year estimates. 
#         This codes was originally supposed be to tailored for the 2010 economic 
# data (county) based in the 2010 decennial census data from Social Explorer. 
# However, this variable is missing in the decennial census data.


## Libraries
library(sf)
library(tidycensus)
library(tidyverse)

## Install a census API key

# census_api_key("key", install = TRUE)


## Economic Variables

## Variables from DP03_0001P: Selected Economic Characteristics
# 1. UnempP   DP03_0005P   Unemployment Rate in Civilian Labor Force (Percent)


# Download the Economic Variable

countyEcon10 <- get_acs(geography = 'county', variables = c(UnempP = "DP03_0005P"), 
                   year = 2010, geometry = FALSE)

head(countyEcon10)

# Create a column for year

countyEcon10$year <- c(2010)

countyEcon10 <- countyEcon10 %>%
  select(GEOID, NAME, variable, estimate) %>%
  spread(variable, estimate) %>%
  mutate(year = 2010) %>%
  select('GEOID', 'NAME', 'year', 'UnempP')

# Change the column names

colnames(countyEcon10) <- c('FIPS', 'NAME', 'year', 'UnempP')

head(countyEcon10)


# Save the data

write.csv(countyEcon10, "~/Desktop/EC03_C_2010_DC_ACS.csv")
