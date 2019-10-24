library(tidyverse)
library(readxl)
library(sf)

# Old dataset - 29 observations
# methadone_old <- read_csv("data/Behavioral_Health_Treament_Facility_listing_2019_10_18_131733.csv")

# New data from Kris - 81 observations
methadone <- read_csv("data/IL MAT Clinics_geocoded.csv")

meth_sf <- methadone %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

meth_sf_final <- meth_sf %>% 
  mutate(Category = "MOUD - Methadone") %>% 
  select(Name,
         City,
         Category)

# Save final versions ------------------------------------------------------

st_write(meth_sf_final, "data-output/meth_cleaned.gpkg", delete_dsn = TRUE)
st_write(meth_sf, "data-output/meth_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(meth_sf_final, "data-output/01_meth.gpkg", delete_dsn = TRUE)
