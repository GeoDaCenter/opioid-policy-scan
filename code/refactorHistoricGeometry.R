# Author : Ashlynn Wimer
# Date : June 21st, 2023
# This R script will transform the attribute data of the 2010 shapefiles to
# more closely align with the 2018 shapefiles. 

library(sf)
library(dplyr)

## Initialize relevant variables
## Column orders intend to mimic the 2018 data

tractsColOrder <- c("STATEFP", 'COUNTYFP', 'TRACTCE', 'AFFGEOID', 'GEOID', 'NAME', 'LSAD', 'CENSUSAREA', 'geometry')
countiesColOrder <- c("STATEFP", "COUNTYFP", "AFFGEOID", "GEOID", "NAME", "LSAD", "CENSUSAREA", "geometry")
statesColOrder <- c("STATEFP", "AFFGEOID", "GEOID", "STUSPS", "NAME", "LSAD", "CENSUSAREA", 'geometry')

## Extract relevant data

tracts2010 <- st_read('../data_final/geometryFiles/tl_2010_tract/tracts2010.shp')
counties2010 <- st_read('../data_final/geometryFiles/tl_2010_county/counties2010.shp')
states2010 <- st_read('../data_final/geometryFiles/tl_2010_state/states2010.shp')

stateAbbr <- st_read('../data_final/geometryFiles/tl_2018_state/states2018.shp') |>
  st_drop_geometry() |>
  select(STUSPS, NAME)


## Transform attributes of tracts2010

tracts2010.n <- tracts2010 |>
  select(-STATE, -COUNTY) |> # Drop duplicates
  rename(TRACTCE = TRACT,
         AFFGEOID = GEO_ID) |>
  mutate(GEOID = substr(AFFGEOID, start = 10, stop = 21)) 

tracts2010.n <- tracts2010.n[, tractsColOrder]


## Transform attributes of counties2010

counties2010.n <- counties2010 |>
  select(-STATE, -COUNTY) |>
  rename(AFFGEOID = GEO_ID) |>
  mutate(GEOID=substr(AFFGEOID, start = 10, stop = 14))

counties2010.n <- counties2010.n[, countiesColOrder]

## Transform attributes of states2010

states2010.n <- states2010 |>
  rename(STATEFP = STATE,
         AFFGEOID = GEO_ID) |>
  mutate(GEOID = STATEFP) |>
  merge(stateAbbr, by='NAME')

states2010.n$LSAD = "00"

states2010.n <- states2010.n[, statesColOrder]

## Write the files
st_write(states2010.n, dsn = '../data_final/geometryFiles/tl_2010_state/states2010.shp', append=FALSE)
st_write(counties2010.n, dsn = '../data_final/geometryFiles/tl_2010_county/counties2010.shp', append=FALSE)
st_write(tracts2010.n, dsn = '../data_final/geometryFiles/tl_2010_tract/tracts2010.shp', append=FALSE)
