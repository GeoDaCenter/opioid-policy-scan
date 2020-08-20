# Join and map access metrics

library(readr)
library(dplyr)
library(sf)
library(tmap)

access <- read_csv("data/access_by_zip_moud_subset.csv") %>% 
  rename(zip = `origin`) %>% 
  mutate(zip = as.character(zip))
zips <- readRDS("data-output/zips.rds")
moud <- read_sf("data-output/02_moud-all.gpkg")
bup <- read_sf("data-output/01_bup.gpkg")
meth <- read_sf("data-output/01_meth.gpkg")
naltrex <- read_sf("data-output/01_naltrex.gpkg")

access_sf <- right_join(zips, access, by = c("GEOID10" = "zip")) %>% 
  rename(bup_count = `MOUD - Buprenorphine - count`,
         bup_avg_drive_min = `MOUD - Buprenorphine - avg_drive_minutes`,
         bup_avg_dist_km = `MOUD - Buprenorphine - avg_distance_km`,
         meth_count = `MOUD - Methadone - count`,
         meth_avg_drive_min = `MOUD - Methadone - avg_drive_minutes`,
         meth_avg_dist_km = `MOUD - Methadone - avg_distance_km`,
         nal_count = `MOUD - Naltrexone - count`,
         nal_avg_drive_min = `MOUD - Naltrexone - avg_drive_minutes`,
         nal_avg_dist_km = `MOUD - Naltrexone - avg_distance_km`)

write_sf(access_sf, "data-output/access_sf.gpkg")

# Make maps
illinois <- read_sf("data-output/illinois.gpkg")

tmap_mode("plot")

bup_access <- 
  tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("bup_count", 
                "bup_avg_drive_min", 
                "bup_avg_dist_km"), style = "quantile") +
  tm_shape(bup) +
  tm_dots(size = 0.1) +
  tm_layout(main.title = "Buprenorphine Access Metrics")

meth_access <- 
  tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("meth_count", 
                "meth_avg_drive_min", 
                "meth_avg_dist_km"), style = "quantile") +
  tm_shape(meth) +
  tm_dots(size = 0.1) +
  tm_layout(main.title = "Methadone Access Metrics")

naltrex_access <-
  tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("nal_count", 
                "nal_avg_drive_min", 
                "nal_avg_dist_km"), style = "quantile") +
  tm_shape(naltrex) +
  tm_dots(size = 0.1) +
  tm_layout(main.title = "Naltrexone Access Metrics")

tmap_save(bup_access, "output/bup_access.png")
tmap_save(meth_access, "output/meth_access.png")
tmap_save(naltrex_access, "output/naltrex_access.png")

# What's with the NAs??
summary(access_sf)
filter(access_sf, "MOUD - Naltrexone - count" == "NA")
tail(access_sf)

filter(access, zip == "61759")
