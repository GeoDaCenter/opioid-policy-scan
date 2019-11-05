library(sf)
library(tidyverse)

carto_115 <- read_csv("data/carto115.csv")
zips_sf <- readRDS("data-output/zips.rds") %>% 
  mutate(zip = as.numeric(ZCTA5CE10)) %>% 
  select(zip)

# Double check that zip is same as zcta, so can join on it
identical(carto_115$zip, carto_115$zcta)

carto_115_sf <- zips_sf %>% 
  right_join(carto_115, by = "zip") %>% 
  mutate(fid = as.integer(fid))

st_write(carto_115_sf, "data-output/carto_115_sf.gpkg", delete_layer = TRUE)
