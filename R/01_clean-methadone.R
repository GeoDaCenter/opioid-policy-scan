library(tidyverse)
library(readxl)
library(sf)

methadone <- read_csv("data/Behavioral_Health_Treament_Facility_listing_2019_10_18_131733.csv")

meth_sf <- methadone %>% 
  st_as_sf(coords = c("longitude", "latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

meth_sf_final <- meth_sf %>% 
  mutate(Category = "MOUD - Methadone") %>% 
  select(Name = name1,
         City = city,
         Category)

# Save final versions ------------------------------------------------------

st_write(meth_sf_final, "data-output/meth_cleaned.gpkg", delete_dsn = TRUE)
st_write(meth_sf, "data-output/meth_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(meth_sf_final, "data-output/01_meth.gpkg", delete_dsn = TRUE)
