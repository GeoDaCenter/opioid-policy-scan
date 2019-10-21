# Get ZCTAs for Illinois and save object

library(sf)

zips <- tigris::zctas(starts_with = c("60", "61", "62")) # takes like 5 min, 1383 ZCTAs in IL
zips_sf <- st_as_sf(zips, coords = c("INTPTLAT10", "INTPTLON10")) %>%
  st_transform(32616) # takes like 20 seconds

st_write(zips_sf, "data-output/zips.gpkg")
saveRDS(zips_sf, "data-output/zips.rds")
