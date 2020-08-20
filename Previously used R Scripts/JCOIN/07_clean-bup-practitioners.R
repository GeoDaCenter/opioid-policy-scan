# Clean bup prescribing practitioners

library(readxl)
library(readr)
library(dplyr)
library(sf)

bup_prac1 <- read_excel("data/2020-04-09-12.47_samhsa-data-download/bup-practitioners/Behavioral_Health_Treament_Facility_listing_2020_04_09_135136.xlsx")

bup_prac2 <- read_excel("data/2020-04-09-12.47_samhsa-data-download/bup-practitioners/Behavioral_Health_Treament_Facility_listing_2020_04_09_135155.xlsx")

bup_prac <- rbind(bup_prac1, bup_prac2)

# # Figure out which need to be geocoded
# bup_prac_to_geocode <- filter(bup_prac, is.na(longitude) | is.na(latitude)) %>%
#   mutate(ID = row_number(),
#          address = case_when(str_detect(street1, "[0-9]") ~ street1,
#                              !str_detect(street1, "[0-9]") ~ street2)) %>%
#   select(ID, address, city, state, subregion = county, zip)
# 
# write_csv(bup_prac_to_geocode, "data-output/bup_prac_to_geocode.csv")


bup_prac_pregeocoded <- filter(bup_prac, !(is.na(longitude) | is.na(latitude))) %>% 
  select(address = street1, city, state, county, zip, long = longitude, lat = latitude)

# bup_prac_geocoded <- read_csv("data/2020-05-12_dialysis-download/bup_prac_to_geocode_1589320348_geocoded.csv")
# filter(bup_prac_geocoded, `Match Score` <= 90) %>%
#   arrange(`Match Score`) %>% View()
# Edited one where Match Score was 0, also noted that one location is in Germany

bup_prac_geocoded <- read_csv("data/2020-05-12_dialysis-download/bup_geocoded_checked.csv", col_types = cols(zip = "c", Longitude = "c", Latitude = "c")) %>% 
  select(address, city, state, county = subregion, zip, long = Longitude, lat = Latitude)

bup_all <- rbind(bup_prac_pregeocoded, bup_prac_geocoded)

bup_prac_sf <- st_as_sf(bup_all, coords = c("long", "lat"), crs = 4326)


# Write out data 
st_write(bup_prac_sf, "data-output/bup_prac.gpkg", delete_dsn = TRUE)
st_write(bup_prac_sf, "data-output/bup_prac.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
