# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will download the 2010 geometries for policy scan 
# using tidycensus package based on the ACS 5-year estimates.

# Libraries

library(tidycensus)
library(sf)
library(tidyverse)

# Install a census API key

#census_api_key("key", install = TRUE)

# Initialize variables

yeartoFetch <- 2010
crsToSet <- 4326
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
zctasToBeExcluded <- c('969','00') # PR and other islands


# Download the geometries
## Downloading the total population with geometry

## State Level

states   <- get_acs('state', 'B01003_001', geometry = TRUE, year = yeartoFetch) %>% 
  select(GEOID, NAME, estimate, geometry) %>% 
  rename(pop2010 = estimate) %>%
  st_transform(crsToSet)  %>%
  filter(!(GEOID %in% territoriesToBeExcluded))

### Save the data

st_write(states, "~/Desktop/states2010.shp")


## County Level

counties <- get_acs('county', 'B01003_001', geometry = TRUE, year = yeartoFetch) %>% 
  select(GEOID, NAME, estimate, geometry) %>% 
  rename(pop2010 = estimate) %>%
  st_transform(crsToSet) %>%
  filter(! startsWith(GEOID,territoriesToBeExcluded))

### Save the data

st_write(counties, "~/Desktop/counties2010.shp")


## Census Tract Level
# Tracts shapefiles need state as input, doesnt work for entire country like other functions.

us <- unique(fips_codes$state)[1:51]

tracts <- reduce(
  map(us, 
      function(x) {
        get_acs(geography = "tract", variables = "B01001_001", 
                state = x, geometry = TRUE, year = yeartoFetch) 
      }), 
  rbind)

# Exclude ones in territories

tracts <- tracts %>% 
  select(GEOID, NAME, estimate, geometry) %>% 
  rename(ppop2010 = estimate)  %>% 
  st_transform(crsToSet)  %>% 
  filter(! startsWith(GEOID, territoriesToBeExcluded))

### Save the data

st_write(tracts, "~/Desktop/tracts2010.shp")


## Zipcode Level

if (yeartoFetch != 2010){
  zctas    <- get_acs('zcta', 'B01003_001', geometry = TRUE, year = yeartoFetch) %>% 
    select(GEOID, NAME, estimate, geometry) %>% 
    rename(pop2010 = estimate) %>%
    st_transform(crsToSet) %>%
    filter(!(GEOID %in% zctasToBeExcluded))
}else{
  zctas    <- get_decennial('zcta', 'P001001', geometry = TRUE, year = yeartoFetch) %>% 
    select(GEOID, NAME, value, geometry) %>% 
    rename(pop2010 = value) %>%
    st_transform(crsToSet) %>%
    filter(!(GEOID %in% zctasToBeExcluded))
}

### Save the data

st_write(zctas, "~/Desktop/zctas2010.shp")

