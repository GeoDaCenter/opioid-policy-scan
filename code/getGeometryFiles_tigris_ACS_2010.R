# Author : Caglayan Bal
# Date : July 19, 2022
# About : This piece of code will download the 2010 geometries for policy scan 
# using tigris package based on the ACS 5-year estimates.

# Libraries
library(tigris)
library(sf)
library(tidyverse)
library(geojsonio)

# Install a census API key

#census_api_key("key", install = TRUE)

# Initialize variables

yeartoFetch <- 2010
shapetoFetch <- c("county","zcta","state")
crsToSet <- 4326
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
zctasToBeExcluded <- c('969','00') # PR and other islands


# Download the geometries

states   <- states(year = yeartoFetch, cb = TRUE) %>%
  st_transform(crsToSet)


counties <- counties(year = yeartoFetch, cb = TRUE) %>%
  st_transform(crsToSet)


zctas    <- zctas(year = yeartoFetch, cb = TRUE) %>%
  st_transform(crsToSet)


# Tracts shapefiles need state as input, doesnt work for entire country like other functions.

colNameS <- colnames(states)[startsWith(colnames(states),"STATE")]
colNameC <- colnames(counties)[startsWith(colnames(counties),"STATE")]

tracts <- map(.x = as.numeric(data.frame(states[colNameS])[,1]),
              .f = ~ tracts(state = .x, county = NULL, year = yeartoFetch, cb = TRUE))
tracts <- lapply(tracts, function(x) st_transform(x, crsToSet))
tracts <- do.call(rbind, tracts)


# Exclude ones in territories

states <- states[!(as.numeric(data.frame(states[colNameS])[,1]) %in% territoriesToBeExcluded),]
counties <- counties[!(as.numeric(data.frame(states[colNameS])[,1]) %in% territoriesToBeExcluded),]
tracts <- tracts[!(tracts$STATEFP %in% territoriesToBeExcluded),]
for (i in 1: length(zctasToBeExcluded))
{
  zctas <- zctas[!(startsWith(zctas$ZCTA5,zctasToBeExcluded[i])),]
}


# Save the data

st_write(states, '~/Desktop/states2010.shp')
st_write(counties, '~/Desktop/counties2010.shp')
st_write(tracts, '~/Desktop/tracts2010.shp')
st_write(zctas, '~/Desktop/zctas2010.shp')
