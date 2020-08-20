## This code downloads geometries for a particular year for policy scan

library(tigris)
library(geojsonio)
library(tidyverse)


setwd("/Users/yashbansal/Desktop/CSDS_RA/Opioid/Policy scan/code")
#census_api_key("9cd7bfa4819ef1c36ca81f52c8a0796dfd2ce2bf", install = TRUE)

## initialize variables

yeartoFetch <- 2018
shapetoFetch <- c("county","zcta","state")
crsToSet <- 4326
territoriesToBeExcluded <- c('60','72','66','69','78') # american territories
zctasToBeExcluded <- c('969','00') # PR and other islands


## get the geometries using tigris 
counties <- counties(year = yeartoFetch)
states   <- states(year = yeartoFetch)
zctas    <- zctas(year = yeartoFetch)

counties <- st_transform(counties, crsToSet)
states <- st_transform(states, crsToSet)
zctas <- st_transform(zctas, crsToSet)

# tracts shapefiles need state as input, doesnt work for entire country like other functions.
#tracts    <- tracts(year = yeartoFetch)
tracts <- map(.x = as.numeric(states$STATEFP),
               .f = ~ tracts(state = .x, county = NULL, year = yeartoFetch))
tracts <- do.call(rbind.data.frame, tracts)
tracts <- st_transform(tracts, crsToSet)

# ## exclude ones in territories
counties <- counties[!(counties$STATEFP %in% territoriesToBeExcluded),]
states <- states[!(states$STATEFP %in% territoriesToBeExcluded),]
tracts <- tracts[!(tracts$STATEFP %in% territoriesToBeExcluded),]
for (i in 1: length(zctasToBeExcluded))
{
  zctas <- zctas[!(startsWith(zctas$ZCTA5CE10,zctasToBeExcluded[i])),]
}


st_write(counties,dsn ='geometryFiles/tl_2018_county/counties2018.shp')
st_write(tracts,dsn ='geometryFiles/tl_2018_tract/tracts2018.shp')
st_write(states,dsn ='geometryFiles/tl_2018_state/states2018.shp')
st_write(zctas,dsn ='geometryFiles/tl_2018_zcta/zctas2018.shp')

# # plot
# # from Angela's code using only to check plots
# continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>%
#   st_as_sf(crs = crsToSet)
# temp <- st_intersection(counties, continental_bbox)
# tmap::tm_shape(temp) + tmap::tm_borders(col = "grey25", alpha = 0.3) 


# geojson_write(counties, file = paste0("counties_",yeartoFetch,".geojson"))
# geojson_write(states, file = paste0("states_",yeartoFetch,".geojson"))
# geojson_write(tracts, file = paste0("tracts_",yeartoFetch,".geojson"))
# geojson_write(zctas, file = paste0("zctas_",yeartoFetch,".geojson"))
# 


  