# Calculate min-dist dialysis metrics

library(sf)
library(units)
library(tmap)

source("R/00_functions-included.R") #for get_min_dists function

us_zips_sf <- readRDS("data-output/us_zips.rds")
us_centroids <- st_centroid(us_zips_sf)

dialysis_sf <- read_sf("data/2020-05-12_dialysis-download/Dialysis Facility Compare - Listing by Facility/geo_export_e623488b-6977-4481-ba5b-b7569ec51b5b.shp") %>% 
  st_transform(st_crs(us_centroids))

dialysis_dists <- get_min_dists(us_centroids, dialysis_sf)
# beepr::beep() (takes 3 minutes)

dialysis_access <- cbind(us_zips_sf, dialysis_dists)


# Write out data ----------------------------------------------------------
write_sf(dialysis_access, "data-output/dialysis_min_dists.csv")
write_sf(dialysis_access, "data-output/dialysis_min_dists.shp")
write_sf(dialysis_access, "data-output/dialysis_min_dists.geojson")


# Map dialysis places

dialysis_continental <- clip_to_continental_us(dialysis_access) %>% 
  st_transform(102003)

dialysis_breaks <- as.numeric(get_hinge_breaks(dialysis_continental, "dialysis_dists"))

d <- 
  tm_shape(dialysis_continental) +
  tm_fill("dialysis_dists",
          breaks = c(0, 5, 10, 15, 30, 150),
          title = "Minimum Distance from \nZip to Resource (mi)",
          palette = c("#0571b0", "#92c5de", "#f7f7f7", "#f4a582", "#ca0020")) +
  tm_shape(continental_states) +
  tm_borders() +
  tm_layout(main.title = "Dialysis Access Metrics")

tmap_save(d, "output/dialysis_us_min_dist_fixed.png")
beepr::beep()
