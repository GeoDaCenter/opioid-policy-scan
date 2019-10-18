library(sf)
library(readxl)
library(readr)
library(dplyr)

fqhc1 <- read_excel("data/Health-Centers-10-17-2019.xlsx")
fqhc2 <- read_excel("data/Health-Centers-10-17-2019 (1).xlsx")
fqhc3 <- read_excel("data/Health-Centers-10-17-2019 (2).xlsx")

allfqhc <- rbind(fqhc1, fqhc2, fqhc3)

fqhc <- distinct(allfqhc)
fqhc_to_geocode <- fqhc %>% 
  mutate(ID = row_number()) %>% 
  select(ID,
         ADDRESS = `Street Address`,
         CITY = City,
         STATE = State,
         ZIP = `ZIP Code`)

write_csv(fqhc_to_geocode, "data-output/fqhc_to_geocode.csv")  
# Run through UChicago geocoder https://geocoder.rcc.uchicago.edu/upload

fqhc_geocoded <- read_csv("data-output/geocoded/fqhc_to_geocode_1571429078_geocoded.csv")

fqhc_final <- select(fqhc_geocoded, ID, Longitude, Latitude) %>% 
  left_join(fqhc_to_geocode, fqhc_geocoded, by = "ID")

fqhc_sf <- fqhc_final %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

fqhc_sf_final <- fqhc_sf %>% 
  mutate(Category = "FQHC Facility") %>% 
  select(Name = `ADDRESS`,
         City = CITY,
         Category)

# Save final versions ------------------------------------------------------

st_write(fqhc_sf_final, "data-output/fqhc_cleaned.gpkg", delete_dsn = TRUE)
st_write(fqhc_sf_final, "data-output/fqhc_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(fqhc_sf_final, "data-output/01_fqhc.gpkg", delete_dsn = TRUE)
