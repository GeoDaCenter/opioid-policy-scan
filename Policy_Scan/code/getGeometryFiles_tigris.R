# Author : Moksha Menghaney
# Date : October 27th, 2020
# This piece of code will download geometries for a particular year 
# for policy scan using Tigris package
# this generates fairly large files for zcta and tracts. 
# recommend using get_acs for smaller files, check getGeometryFiles_tidycensus.R

library(tigris)
library(sf)
library(tidyverse)
library(geojsonio)


#census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf", install = TRUE)

## initialize variables

yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
crsToSet <- 4326
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
zctasToBeExcluded <- c('969','00') # PR and other islands


## get the geometries using tigris 
counties <- counties(year = yeartoFetch, cb = TRUE)
states   <- states(year = yeartoFetch, cb = TRUE)
zctas    <- zctas(year = yeartoFetch, cb = TRUE)

counties <- st_transform(counties, crsToSet)
states <- st_transform(states, crsToSet)
zctas <- st_transform(zctas, crsToSet)

# tracts shapefiles need state as input, doesnt work for entire country like other functions.
#tracts    <- tracts(year = yeartoFetch)
colNameS <- colnames(states)[startsWith(colnames(states),"STATE")]
colNameC <- colnames(counties)[startsWith(colnames(counties),"STATE")]

tracts <- map(.x = as.numeric(data.frame(states[colNameS])[,1]),
              .f = ~ tracts(state = .x, county = NULL, year = yeartoFetch, cb = TRUE))
tracts <- lapply(tracts, function(x) st_transform(x, crsToSet))
tracts <- do.call(rbind, tracts)


# ## exclude ones in territories
counties <- counties[!(as.numeric(data.frame(states[colNameS])[,1]) %in% territoriesToBeExcluded),]
states <- states[!(as.numeric(data.frame(states[colNameS])[,1]) %in% territoriesToBeExcluded),]
tracts <- tracts[!(tracts$STATEFP %in% territoriesToBeExcluded),]
for (i in 1: length(zctasToBeExcluded))
{
  zctas <- zctas[!(startsWith(zctas$ZCTA5,zctasToBeExcluded[i])),]
}


## change the names according to year.
st_write(counties,dsn ='geometryFiles/tl_2018_county/counties2018.shp')
st_write(tracts,dsn ='geometryFiles/tl_2018_tract/tracts2018.shp')
st_write(states,dsn ='geometryFiles/tl_2018_state/states2018.shp')
st_write(zctas,dsn ='geometryFiles/tl_2018_zcta/zctas2018.shp')


# geojson_write(counties, file = paste0("counties_",yeartoFetch,".geojson"))
# geojson_write(states, file = paste0("states_",yeartoFetch,".geojson"))
# geojson_write(tracts, file = paste0("tracts_",yeartoFetch,".geojson"))
# geojson_write(zctas, file = paste0("zctas_",yeartoFetch,".geojson"))
# 
