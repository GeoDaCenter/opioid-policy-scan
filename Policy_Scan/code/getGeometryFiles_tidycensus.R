# Author : Moksha Menghaney
# Date : October 27th, 2020
# This piece of code will download geometries for a particular year 
# for policy scan using tidycensus package
# this generates smaller sized files for zcta and tracts 
# as compared to the one generated from tigris

library(tidycensus)
library(sf)
library(tidyverse)


#census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf", install = TRUE)

## initialize variables

yeartoFetch <- 2010
crsToSet <- 4326
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
zctasToBeExcluded <- c('969','00') # PR and other islands


## get the geometries using tidycensus 
counties <- get_acs('county', 'B01003_0001', geometry = TRUE, year = yeartoFetch) %>% 
            select(GEOID, NAME,estimate,geometry) %>% 
            rename(paste0("pop",yeartoFetch) = estimate) %>%
            st_transform(crsToSet) %>%
            filter(! startsWith(GEOID,territoriesToBeExcluded))

states   <- get_acs('state', 'B01003_0001', geometry = TRUE, year = yeartoFetch) %>% 
            select(GEOID, NAME,estimate,geometry) %>% 
            rename(paste0("pop",yeartoFetch) = estimate) %>%
            st_transform(crsToSet)  %>%
            filter(!(GEOID %in% territoriesToBeExcluded))

if (yeartoFetch != 2010){
  zctas    <- get_acs('zcta', 'B01003_0001', geometry = TRUE, year = yeartoFetch) %>% 
              select(GEOID, NAME,estimate,geometry) %>% 
              rename(paste0("pop",yeartoFetch) = estimate) %>%
              st_transform(crsToSet) %>%
              filter(!(GEOID %in% zctasToBeExcluded))
}else{
  zctas    <- get_decennial('zcta', 'P001001', geometry = TRUE, year = yeartoFetch) %>% 
  select(GEOID, NAME,value,geometry) %>% 
  rename(pop2010 = value) %>%
  st_transform(crsToSet) %>%
  filter(!(GEOID %in% zctasToBeExcluded))
}

# tracts shapefiles need state as input, doesnt work for entire country like other functions.
#tracts    <- tracts(year = yeartoFetch)

us <- unique(fips_codes$state)[1:51]

tracts <- reduce(
            map(us, 
                function(x) {
                  get_acs(geography = "tract", variables = "B01001_001", 
                          state = x, geometry = TRUE, year = yeartoFetch) 
                  }), 
          rbind)
# ## exclude ones in territories
tracts <- tracts %>% 
          select(GEOID, NAME,estimate,geometry) %>% 
          rename(paste0("pop",yeartoFetch) = estimate)  %>% 
          st_transform(crsToSet)  %>% 
          filter(! startsWith(GEOID,territoriesToBeExcluded))


## change the names according to year.
st_write(counties,dsn ='geometryFiles/tl_2010_county/counties2010.shp')
st_write(tracts,dsn ='geometryFiles/tl_2010_tract/tracts2010.shp')
st_write(states,dsn ='geometryFiles/tl_2010_state/states2010.shp')
st_write(zctas,dsn ='geometryFiles/tl_2010_zcta/zctas2010.shp')


