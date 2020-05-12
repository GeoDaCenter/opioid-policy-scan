# Calculate min-dist dialysis metrics

library(sf)
library(units)

source("R/00_functions-included.R") #for get_min_dists function

us_zips_sf <- readRDS("data-output/us_zips.rds")
us_centroids <- st_centroid(us_zips_sf)

dialysis_sf <- read_sf("data/2020-05-12_dialysis-download/Dialysis Facility Compare - Listing by Facility/geo_export_e623488b-6977-4481-ba5b-b7569ec51b5b.shp") %>% 
  st_transform(st_crs(us_centroids))

dialysis_dists <- get_min_dists(us_centroids, dialysis_sf)
beepr::beep()

dialysis_access <- cbind(us_zips_sf, dialysis_dists)


# Write out data ----------------------------------------------------------
write_sf(dialysis_access, "data-output/dialysis_min_dists.csv")
write_sf(dialysis_access, "data-output/dialysis_min_dists.shp")
write_sf(dialysis_access, "data-output/dialysis_min_dists.geojson")
