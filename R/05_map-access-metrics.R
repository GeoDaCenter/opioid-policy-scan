# Join and map access metrics

library(readr)
library(dplyr)
library(sf)
library(tmap)

access <- read_csv("data/access_by_type_subset_buffer.csv") %>% 
  rename(zip = `- geoid`) %>% 
  mutate(zip = as.character(zip))
zips <- readRDS("data-output/zips.rds")
moud <- read_sf("data-output/02_moud-all.gpkg")

access_sf <- right_join(zips, access, by = c("GEOID10" = "zip"))



# Make maps
illinois <- read_sf("data-output/illinois.gpkg")

tm_shape(illinois) +
  tm_borders() +
  tm_shape(access_sf) +
  tm_polygons(c("MOUD - Buprenorphine - count", "MOUD - Methadone - count", "MOUD - Naltrexone - count"))

tm_shape(illinois) +
  tm_borders() +
tm_shape(access_sf) +
  tm_polygons(c("MOUD - Buprenorphine - km", "MOUD - Methadone - km", "MOUD - Naltrexone - km"))

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
