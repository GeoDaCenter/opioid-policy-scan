# Clean naltrex 

library(tidyverse)
library(readxl)
library(sf)
naltrex <- read_csv("data/Behavioral_Health_Treament_Facility_listing_naltrox.csv")

naltrex_sf <- naltrex %>% 
  st_as_sf(coords = c("longitude", "latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

naltrex_sf_final <- naltrex_sf %>% 
  mutate(Category = "MOUD - Naltrexone") %>% 
  select(Name = name1,
         City = city,
         Category)

# Save final versions ------------------------------------------------------

st_write(naltrex_sf_final, "data-output/naltrex_cleaned.gpkg", delete_dsn = TRUE)
st_write(naltrex_sf_final, "data-output/naltrex_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(naltrex_sf_final, "data-output/01_naltrex.gpkg", delete_dsn = TRUE)
