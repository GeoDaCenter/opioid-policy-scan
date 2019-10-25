# Clean HIV testing and services (NPIN data)

library(tidyverse)
library(readxl)
library(sf)

# providers <- read_excel("data/Illinois data_September2019.xlsx") %>% 
#   mutate(id = row_number(),
#          `Testing services` = as.character(`Testing services`),
#          `Testing services` = na_if(`Testing services`, "NULL")) %>% 
#   select(id, everything())
# 
# # Add columns for if providers have substance treatment or testing based on columns
# providers <- mutate(providers,
#                     substance_treatment = str_detect(`Care AND Treatment Services`, "Substance Abuse Treatment"),
#                     testing = !is.na(`Testing services`)
# )
# 
# # Detour: there's one that's geocoded wrong -------------------------------
# 
# arrange(providers, desc(lon)) %>% 
#   slice(1) %>% 
#   select(id, `Organization Name`, Address, lon, lat)
# 
# # "American Association of Sexuality Educators Counselors and Therapists
# # 35 E Wacker Dr Chicago
# # lat = 41.886930
# # lon = -87.626480
# 
# providers$lat[67] <- 41.886930 # this is the id of the above point
# providers$lon[67] <- -87.626480 # this is the id of the above point
# 
# # Check that it's been corrected - yay!
# filter(providers, `Organization Name` == "American Association of Sexuality Educators Counselors and Therapists") %>% 
#   glimpse()


# Use Open Refine to just pull out HIV Testing ----------------------------
# 247 locations out of 314 -- use custom text facet on "Testing services" col

hiv_providers <- read_csv("data-output/Illinois-data_September2019-xlsx.csv")

hiv_providers_sf <- st_as_sf(hiv_providers, coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616) 

hiv_providers_sf_final <- hiv_providers_sf %>% 
  mutate(Category = "HIV Testing") %>% 
  select(Name = `Organization Name`,
         Address,
         City = `City Name`,
         Zip = `Zip Code`,
         Category)

# Save final versions -----------------------------------------------------

st_write(hiv_providers_sf_final, "data-output/hiv_testing_cleaned.gpkg", delete_dsn = TRUE)
st_write(hiv_providers_sf_final, "data-output/hiv_testing_cleaned.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)

st_write(hiv_providers_sf_final, "data-output/01_hiv_testing.gpkg", delete_dsn = TRUE)


## Q: Are the places with FALSE coded for both sub abuse and testing just missing data?
## What's the warning about?
