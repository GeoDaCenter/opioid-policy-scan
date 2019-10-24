# Calculate distance to zip centroids for closest resources

library(sf)
library(readr)

# zips_sf <- st_read("data-output/zips.gpkg") # takes 15 seconds
zips_sf <- readRDS("data-output/zips.rds")

# st_write(zips_centroids, "data-output/zips_centroids.gpkg", delete_dsn = TRUE)
# saveRDS(zips_centroids, "data-output/zips_centroids.rds")
zips_centroids <- readRDS("data-output/zips_centroids.rds")

bup <- st_read("data-output/01_bup.gpkg")
ers <- st_read("data-output/01_ers_trauma.gpkg")
fqhc <- st_read("data-output/01_fqhc.gpkg")
hiv <- st_read("data-output/01_hiv_testing.gpkg")
meth <- st_read("data-output/01_meth.gpkg")
nalox <- st_read("data-output/01_nalox.gpkg")
naltrex <- st_read("data-output/01_naltrex.gpkg")

get_min_dist <- function(resource_pts, centroid_pts = zips_centroids) {
  distance_matrix <- st_distance(resource_pts, centroid_pts)
  min_dists <- apply(distance_matrix, 2, min)
  
  min_dists
}

class(get_min_dist(ers))

# takes 8 seconds to run
min_dists <- cbind(Zip = zips_sf$ZCTA5CE10, 
                   `ER Trauma Centers - Nearest Distance to Centroid (m)` = get_min_dist(ers),
                   `FQHC Facility - Nearest Distance to Centroid (m)` = get_min_dist(fqhc),
                   `HIV Testing - Nearest Distance to Centroid (m)` = get_min_dist(hiv),
                   `MOUD - Buprenorphine - Nearest Distance to Centroid (m)` = get_min_dist(bup),
                   `MOUD - Methadone - Nearest Distance to Centroid (m)` = get_min_dist(meth),
                   `MOUD - Naltrexone - Nearest Distance to Centroid (m)` = get_min_dist(naltrex),
                   `Naloxone RX - Nearest Distance to Centroid (m)` = get_min_dist(nalox)) %>% 
  as.data.frame(stringsAsFactors = FALSE)

write_csv(min_dists, "data-output/min-dists-to-centroid.csv")
