# Clean emergency depts data

library(tidyverse)
library(readxl)

ers <- read_excel("data/Emergency-Departments.xlsx")

ers_to_geocode <- 
  mutate(ers, ID = row_number()) %>% 
  separate(Location, into = c("CITY", "STATE"), sep = ", ") %>% 
  select(ID,
         ADDRESS = Hospital,
         CITY,
         STATE)

write_csv(ers_to_geocode, "data-output/ers_to_geocode.csv")

# Then go geocode it: https://geocoder.rcc.uchicago.edu/upload

ers_geocoded <- read_csv("data-output/geocoded/ers_to_geocode_1570813925_geocoded.csv")

ers_final <- select(ers_geocoded, ID, Longitude, Latitude) %>% 
  left_join(ers_to_geocode, ers_geocoded, by = "ID")

ers_sf <- ers_final %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

ers_sf_final <- ers_sf %>% 
  mutate(Category = "ER Trauma Centers") %>% 
  select(Name = `ADDRESS`,
         City = CITY,
         Category)

# Save final versions ------------------------------------------------------

st_write(ers_sf_final, "data-output/ers_cleaned.gpkg", delete_dsn = TRUE)
st_write(ers_sf_final, "data-output/ers_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(ers_sf_final, "data-output/01_ers_trauma.gpkg", delete_dsn = TRUE)
