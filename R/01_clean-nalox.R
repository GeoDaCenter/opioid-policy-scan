# Clean naloxone RX

library(tidyverse)
library(readxl)
library(sf)

nalox <- read_excel("data/Naloxone Registrants_Updated_Oct2019.xlsx") %>% 
  mutate(longitude = na_if(longitude, "."),
         Latitude = na_if(Latitude, "."),
         id = row_number()) %>% 
  select(id, everything()) %>% 
  rename(lon = longitude,
         lat = Latitude)

nalox_geocoded <- nalox %>% 
  filter(!is.na(lon), !is.na(lat)) %>% 
  mutate(lon = as.numeric(lon),
         lat = as.numeric(lat))

nalox_missing <- nalox %>%
  filter(is.na(lon)| is.na(lat)) %>% 
  select(-lon, -lat)

nalox_to_geocode <- nalox_missing %>% 
  rename(ID = id,
         ADDRESS = Address,
         CITY = City_1,
         STATE = State_1,
         ZIP = Zip_1) %>% 
  select(ID, ADDRESS, CITY, STATE, ZIP)

write_csv(nalox_to_geocode, "data-output/nalox_to_geocode.csv")

# Now run through UChicago geocoder here:
# https://uchicago.maps.arcgis.com/sharing/rest/oauth2/authorize?oauth_state=mDNWHkG0f9dFvyg1aLR4GzKLkKQdlv1OwByruZ-6kiyPk-dz0MQ_cYg2egcR_It5KgdGH9WXEDuccvwlB5cidiZ2YnEEY3NxGAPO9b5S0cDD_17YdoSMBvK3pvM2gHwXtmL_4f817DBvqUPcanYBqtbj7u1QUndy1G16P8U-bc5JNg7rnoVjpfJ-cm1W6EF7Qa5fkXxxsyf9RlnOfNv9Q9Foq4fMvKkrV_KZ1pdMt_oI-Vghr5iHDumzwX0gwe1x

# Some things aren't entered right *at all* - some test data in there, hmm :/
# There's also formatting data in the spreadsheet that's super hard to process, yikes

nalox_newly_geocoded <- read_csv("data-output/geocoded/nalox_to_geocode_1570482642_geocoded.csv")

# Check on geocoded facilities
arrange(nalox_newly_geocoded, `Match Score`)

nalox_missing_geocoded <- select(nalox_newly_geocoded, ID, Longitude, Latitude) %>% 
  left_join(nalox_missing, ., by = c("id" = "ID")) %>% 
  rename(lon = Longitude,
         lat = Latitude)

nalox_geocoded_sf <- nalox_geocoded %>% 
  st_as_sf(coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

nalox_missing_geocoded_sf <- nalox_missing_geocoded %>% 
  st_as_sf(coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

nalox_sf <- rbind(nalox_geocoded_sf, nalox_missing_geocoded_sf) %>% 
  arrange(id)

# Remove nalox out of state
nalox_sf <- arrange(nalox_sf, Zip_1) %>% 
  slice(-c(1:4))

nalox_sf_final <- nalox_sf %>% 
  mutate(Category = "Naloxone RX") %>% 
  select(Name = Pharmacy,
         Address,
         City = City_1,
         Zip = Zip_1,
         Category)

# Save final versions ------------------------------------------------------

st_write(nalox_sf_final, "data-output/nalox_cleaned.gpkg", delete_dsn = TRUE)
st_write(nalox_sf_final, "data-output/nalox_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(nalox_sf_final, "data-output/01_nalox.gpkg", delete_dsn = TRUE)
