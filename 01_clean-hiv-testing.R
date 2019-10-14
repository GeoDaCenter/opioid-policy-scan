# Clean HIV testing and services (NPIN data)

library(tidyverse)
library(readxl)
library(sf)

providers <- read_excel("data/Illinois data_September2019.xlsx") %>% 
  mutate(id = row_number(),
         `Testing services` = as.character(`Testing services`),
         `Testing services` = na_if(`Testing services`, "NULL")) %>% 
  select(id, everything())

# Add columns for if providers have substance treatment or testing based on columns
providers <- mutate(providers,
                    substance_treatment = str_detect(`Care AND Treatment Services`, "Substance Abuse Treatment"),
                    testing = !is.na(`Testing services`)
)

# Detour: there's one that's geocoded wrong -------------------------------

arrange(providers, desc(lon)) %>% 
  slice(1) %>% 
  select(id, `Organization Name`, Address, lon, lat)

# "American Association of Sexuality Educators Counselors and Therapists
# 35 E Wacker Dr Chicago
# lat = 41.886930
# lon = -87.626480

providers$lat[67] <- 41.886930 # this is the id of the above point
providers$lon[67] <- -87.626480 # this is the id of the above point

# Check that it's been corrected - yay!
filter(providers, `Organization Name` == "American Association of Sexuality Educators Counselors and Therapists") %>% 
  glimpse()

providers_sf <- st_as_sf(providers, coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)


# Save final version ------------------------------------------------------

providers_sf_final <- providers_sf %>% 
  mutate(category_service = "hiv_testing") %>% 
  select(name = `Organization Name`,
         category_service)

st_write(providers_sf_final, "data-output/01_hiv_testing.geojson")

## Q: Are the places with FALSE coded for both sub abuse and testing just missing data?
