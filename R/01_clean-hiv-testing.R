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
  filter(testing) %>% 
  mutate(Category = "HIV Testing") %>% 
  select(Name = `Organization Name`,
         City = `City Name`,
         Category)

# Save cleaned version (shp and csv) to Google Drive
st_write(providers_sf_final, "data-output/providers_cleaned.gpkg", delete_dsn = TRUE)
st_write(providers_sf_final, "data-output/providers_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

# Save slim version to combine into point dataset
st_write(providers_sf_final, "data-output/01_hiv_testing.gpkg", delete_dsn = TRUE)


## Q: Are the places with FALSE coded for both sub abuse and testing just missing data?
## What's the warning about?
