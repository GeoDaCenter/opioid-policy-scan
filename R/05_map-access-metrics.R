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

access_sf <- right_join(zips, access, by = c("GEOID10" = "zip"))



# Make maps
illinois <- read_sf("data-output/illinois.gpkg")

tmap_mode("view")

tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("MOUD - Buprenorphine - count", 
                "MOUD - Buprenorphine - avg_drive_minutes", 
                "MOUD - Buprenorphine - avg_distance_km"), style = "quantile") +
  tm_shape(bup) +
  tm_dots(size = 0.1)

tm_shape(illinois) +
  tm_borders() +
tm_shape(access_sf) +
  tm_polygons(c("MOUD - Buprenorphine - avg_distance_km", "MOUD - Methadone - avg_distance_km", "MOUD - Naltrexone - avg_distance_km"), style = "quantile") +
  tm_shape(moud) +
  tm_dots(size = 0.1)

tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("MOUD - Buprenorphine - minutes", "MOUD - Methadone - minutes", "MOUD - Naltrexone - minutes")) +
  tm_shape(moud) +
  tm_dots(size = 0.1)

# What's with the NAs??
summary(access_sf)
filter(access_sf, "MOUD - Naltrexone - count" == "NA")
tail(access_sf)

filter(access, zip == "61759")
