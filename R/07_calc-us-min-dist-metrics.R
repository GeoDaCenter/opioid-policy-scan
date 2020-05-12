# Produce location from SA data to use to calculate access metrics

library(readxl)
library(dplyr)
library(sf)
library(tigris)
library(units)

source("R/00_functions-included.R") #for get_min_dists function

substance_abuse <- read_excel("data/2020-04-09-12.47_samhsa-data-download/substance-abuse/Behavioral_Health_Treament_Facility_listing_2020_04_09_135006.xlsx")

service_codes_df <- read_excel("data/2020-04-09-12.47_samhsa-data-download/service-codes.xlsx", sheet = 2)

service_codes <- service_codes_df %>% 
  pull(service_code) %>% 
  tolower()

all_sites <- substance_abuse %>% 
  select(1:17, service_codes)

# # Take a look at Meth Detox vs. Meth Maintenance
# meth_type <- all_sites %>% 
#   filter(!is.na(mm) | !is.na(dm)) %>% 
#   mutate(meth_type = case_when(!is.na(mm) & is.na(dm) ~ "maintenance_only",
#                                !is.na(mm) & !is.na(dm) ~ "both",
#                                is.na(mm) & !is.na(dm) ~ "detox_only")) %>% 
#   st_as_sf(coords = c("longitude", "latitude"), crs = 4326)
# 
# filter(all_sites, is.na(dm) & is.na(mm) & is.na(mmw) & !is.na(meth)) %>% 
#   st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>% 
#   tm_shape() +
#   tm_dots(size = 0.1)
# 
# 
# # write_sf(meth_type, "data-output/meth_type.gpkg")
# 
# tmap_mode("view")
# 
# meth_type %>% 
#   st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>% 
#   tm_shape() +
#   tm_dots(size = 0.1, col = "meth_type")


bup_sites <- all_sites %>% 
  filter(!is.na(bum)) # Buprenorphine Maintenance

meth_sites <- all_sites %>% 
  filter(!is.na(mm)) # Methadone Maintenance

nal_sites <- all_sites %>% 
  filter(!is.na(vtrl)) # Naltrexone (extended-release, injectable naltrexone (Vivitrol®))


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
