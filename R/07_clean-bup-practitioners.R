# Clean bup prescribing practitioners

library(readxl)
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


bup_prac_pregeocoded <- filter(bup_prac, !(is.na(longitude) | is.na(latitude)))



bup_prac_sf <- st_as_sf(bup_prac, coords = c("longitude", "latitude"), crs = 4326)
