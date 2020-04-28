# Produce location from SA data to use to calculate access metrics

library(readxl)
library(dplyr)
library(sf)
library(tigris)
library(units)

substance_abuse <- read_excel("data/2020-04-09-12.47_samhsa-data-download/substance-abuse/Behavioral_Health_Treament_Facility_listing_2020_04_09_135006.xlsx")

bup_sites <- substance_abuse %>% 
  filter(!is.na(bu)) %>% 
  select(1:17)

meth_sites <- substance_abuse %>% 
  filter(!is.na(mu)) %>% 
           # Methadone used in Treatment
  select(1:17)

nal_sites <- substance_abuse %>% 
  filter(!is.na(nu)) %>% 
  select(1:17)


# Convert to spatial
bup_sites_sf <- bup_sites %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

meth_sites_sf <- meth_sites %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

nal_sites_sf <- nal_sites %>% 
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)


# Get ZCTAs (~33000 in the US)
# us_zips <- zctas(cb = TRUE)
# us_zips_sf <- st_as_sf(us_zips) %>% 
#   st_transform(4326)
# saveRDS(us_zips_sf, "data-output/us_zips.rds")

us_zips_sf <- readRDS("data-output/us_zips.rds")

us_centroids <- st_centroid(us_zips_sf)

get_min_dists <- function(centroids_sf, resources_sf) {
  nearest_resource_indexes <- st_nearest_feature(centroids_sf, resources_sf)
  
  nearest_resource <- resources_sf[nearest_resource_indexes, ]
  
  min_dists <- st_distance(centroids_sf, nearest_resource, by_element = TRUE) # takes 2 minutes to run
  
  min_dists_mi <- set_units(min_dists, "mi")
  
  min_dists_mi
}

# nearest_meth_indexes <- st_nearest_feature(us_centroids, meth_sites_sf)
# 
# nearest_meth <- meth_sites_sf[nearest_meth_indexes, ]
# 
# meth_min_dists <- st_distance(us_centroids, nearest_meth, by_element = TRUE) # takes 2 minutes to run
# 
# meth_min_dists_mi <- set_units(meth_min_dists, "mi")

# Each of these takes around 3-4 minutes to finish up
bup_min_dists_mi <- get_min_dists(us_centroids, bup_sites_sf)
meth_min_dists_mi <- get_min_dists(us_centroids, meth_sites_sf)
nal_min_dists_mi <- get_min_dists(us_centroids, nal_sites_sf)

zip_access <- cbind(us_zips_sf, bup_min_dists_mi, meth_min_dists_mi, nal_min_dists_mi)
# Note: includes American Samoa, Aleutian Islands (crosses int'l date line), Alaska - leads to some crazy outliers



# Write out data ----------------------------------------------------------
write_sf(zip_access, "data-output/us_min_dists.csv", layer_options = "GEOMETRY=AS_XY")

write_sf(zip_access, "data-output/us_min_dists.shp")
write_sf(zip_access, "data-output/us_min_dists.geojson")
