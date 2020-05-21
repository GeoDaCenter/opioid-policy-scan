# Clean HCV testing and services (NPIN data)

library(tidyverse)
library(readxl)
library(sf)

# Use Open Refine to just pull out HIV Testing ----------------------------
# 119 locations out of 314 -- use custom text facet on "Testing services" col

hcv_testing <- read_csv("data-output/Illinois-data_September2019-xlsx-hcv.csv")

hcv_testing_sf <- st_as_sf(hcv_testing, coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616) 

hcv_testing_final <- hcv_testing_sf %>% 
  mutate(Category = "HCV Testing") %>% 
  select(Name = `Organization Name`,
         Address,
         City = `City Name`,
         Zip = `Zip Code`,
         Category)

# Save final versions -----------------------------------------------------

st_write(hcv_testing_final, "data-output/hcv_testing_cleaned.gpkg", delete_dsn = TRUE)
st_write(hcv_testing_final, "data-output/hcv_testing_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(hcv_testing_final, "data-output/01_hcv_testing.gpkg", delete_dsn = TRUE)
