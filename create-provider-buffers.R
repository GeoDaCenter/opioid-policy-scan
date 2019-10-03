# Create buffers for ~300 providers in Excel sheet, make access proxy var by
# zip code based on how many buffers intersect with that zip code

library(tidyverse)
library(readxl)
library(sf)
library(tmap)
library(tigris)

# Import providers data
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


# Make into sf object to perform spatial operations -----------------------

providers_sf <- st_as_sf(providers, coords = c("lon", "lat")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

# Buffer all areas by 10 miles
providers_buffer <- st_buffer(providers_sf, 16093)

plot(providers_buffer["geometry"])


# Buffer differently based on urban vs. rural -----------------------------

# Get Census outlines for MSAs 
msas <- core_based_statistical_areas() %>% # from year 2017
  st_as_sf(coords = c("INTPTLAT", "INTPTLON"))

# Pull out Illinois MSAs from all Census outlines and code as "urban"
il_msas <- msas %>%
  separate(NAME, sep = ", ", into = c("name", "state")) %>% 
  filter(str_detect(state, "IL")) %>% 
  filter(LSAD == "M1") %>%  # only metropolitan, not micropolitan
  st_transform(32616) %>% 
  select(name) %>% 
  add_column(urban = TRUE)

# Spatial join to add column with urban to providers_sf (0 if not, 1 if so)
providers_type <- st_join(providers_sf, il_msas) %>% 
  mutate(urban = replace_na(urban, 0))

# st_write(providers_type, "data-output/providers_with_type.shp")
# providers_type <- st_read("data-output/providers_with_type.shp")

urban_providers <- filter(providers_type, urban == 1)
rural_providers <- filter(providers_type, urban == 0)

# Buffer separately, then combine with rbind()
urban_providers_buffer <- st_buffer(urban_providers, 1609) # 1 mile ~ 1609 meters
rural_providers_buffer <- st_buffer(rural_providers, 16093) # 10 miles ~ 16093 meters

providers_urban_buffer <- rbind(urban_providers_buffer, rural_providers_buffer)

# Plot it to check our work
plot(providers_urban_buffer["geometry"])


# Make maps based on provider type ----------------------------------------

## Map places with substance treatment 
substance_treatment_centers <- filter(corrected_providers, substance_treatment)

plot(substance_treatment_centers["geometry"])


## Map places with testing
testing_centers <- filter(corrected_providers, testing)

plot(testing_centers["geometry"])


# Get counts of buffers by zip code ---------------------------------------

# zips <- tigris::zctas(state = "Illinois") # takes like 1 min
# zips_sf <- st_as_sf(zips, coords = c("INTPTLAT10", "INTPTLON10")) %>% 
#   st_transform(32616) # takes like 20 seconds
# 
# intersection <- st_intersects(zips_sf, corrected_providers) # takes like 20 seconds
# 
# counts_by_zip <- mutate(zips_sf, number_buffers = lengths(intersection))
# 
# # look at counts of buffers by zip
# arrange(counts_by_zip, desc(number_buffers))
# hist(log(counts_by_zip$number_buffers))


## Q: Are the places with FALSE coded for both sub abuse and testing just missing data?
## Q: how to just get Illinois CBAs from API? Is this possible with tigris?
## TODO: save to data-output
