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
  mutate(Category = "MOUD - Buprenorphine") %>% 
  select(Name = `Name Full`,
         City,
         Category)

# Save final versions ------------------------------------------------------

st_write(bup_sf_final, "data-output/bup_cleaned.gpkg", delete_dsn = TRUE)
st_write(bup_sf_final, "data-output/bup_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(bup_sf_final, "data-output/01_bup.gpkg", delete_dsn = TRUE)
