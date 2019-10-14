# Clean bup physicians

library(tidyverse)
library(readxl)
library(sf)

bup_phys <- read_excel("data/IL Waivered Physicians 5.7.19 geocoded.xlsx")

bup_sf <- bup_phys %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

bup_sf_final <- bup_sf %>% 
  mutate(category_service = "bup_moud") %>% 
  select(name = `Name Full`,
         category_service)

st_write(bup_sf_final, "data-output/01_bup.geojson")
