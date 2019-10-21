# Get ZCTAs for Illinois

library(sf)

zips <- tigris::zctas(state = "Illinois") # takes like 5 min
zips_sf <- st_as_sf(zips, coords = c("INTPTLAT10", "INTPTLON10")) %>%
  st_transform(32616) # takes like 20 seconds

st_write(zips_sf, "data-output/zips.gpkg")