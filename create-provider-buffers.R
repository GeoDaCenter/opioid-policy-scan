# Create buffers for ~300 providers in Excel sheet
# Create buffers for bup physicians in Excel sheet
# Make access proxy vars by zip code based on how many buffers intersect 
# with that zip code

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

save(il_msas, file = "data-output/il_msas.rda")

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
substance_treatment_centers_all10 <- filter(providers_buffer, substance_treatment)
substance_treatment_centers_urban <- filter(providers_urban_buffer, substance_treatment)

plot(substance_treatment_centers["geometry"])


## Map places with testing
testing_centers_all10 <- filter(providers_buffer, testing)
testing_centers_urban <- filter(providers_urban_buffer, testing)

plot(testing_centers["geometry"])


# Read bup physicians in and buffer ---------------------------------------

bup_phys <- read_excel("data/IL Waivered Physicians 5.7.19 geocoded.xlsx")

bup_sf <- bup_phys %>% 
  st_as_sf(coords = c("Longitude", "Latitude")) %>% 
  st_set_crs(4269) %>% 
  st_transform(32616)

bup_buffer <- st_buffer(bup_sf, 16093)

plot(bup_buffer["geometry"])

# Split by urban/rural bup providers

bup_type <- st_join(bup_sf, il_msas) %>% 
  mutate(urban = replace_na(urban, 0))

# st_write(bup_type, "data-output/bup_with_type.shp")
# bup_type <- st_read("data-output/bup_with_type.shp")

urban_bup <- filter(bup_type, urban == 1)
rural_bup <- filter(bup_type, urban == 0)

# Buffer separately, then combine with rbind()
urban_bup_buffer <- st_buffer(urban_bup, 1609) # 1 mile ~ 1609 meters
rural_bup_buffer <- st_buffer(rural_bup, 16093) # 10 miles ~ 16093 meters

bup_urban_buffer <- rbind(urban_bup_buffer, rural_bup_buffer)

# Plot to check work
plot(bup_urban_buffer["geometry"])


# Read naloxone providers in and buffer ---------------------------------------

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

nalox_newly_geocoded <- read_csv("data-output/nalox_to_geocode_1570482642_geocoded.csv")

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

nalox_sf <- rbind(nalox_geocoded_sf, nalox_missing_geocoded_sf)

nalox_buffer <- st_buffer(nalox_sf, 16093)

plot(nalox_buffer["geometry"])


# Get counts of buffers by zip code ---------------------------------------

# zips <- tigris::zctas(state = "Illinois") # takes like 5 min
# zips_sf <- st_as_sf(zips, coords = c("INTPTLAT10", "INTPTLON10")) %>%
#   st_transform(32616) # takes like 20 seconds
# save(zips, file = "data-output/zips.rda")
st_write(zips_sf, "data-output/zips.shp")

# zips <- load("data-output/zips.rda")
# zips_sf <- load(file = "data-output/zips_sf.rda") # take 15 seconds

providers_intersect_all10 <- st_intersects(zips_sf, providers_buffer) # takes like 20 seconds
providers_intersect_urban <- st_intersects(zips_sf, providers_urban_buffer) # takes like 20 seconds
bup_intersect_all10 <- st_intersects(zips_sf, bup_buffer)
bup_intersect_urban <- st_intersects(zips_sf, bup_urban_buffer)
providers_substance_intersect_all10 <- st_intersects(zips_sf, substance_treatment_centers_all10)
providers_substance_intersect_urban <- st_intersects(zips_sf, substance_treatment_centers_urban)
providers_testing_intersect_all10 <- st_intersects(zips_sf, testing_centers_all10)
providers_testing_intersect_urban <- st_intersects(zips_sf, testing_centers_urban)

counts_by_zip <- mutate(zips_sf, 
                        providers_all10 = lengths(providers_intersect_all10),
                        providers_urban = lengths(providers_intersect_urban),
                        providers_substance_all10 = lengths(providers_substance_intersect_all10),
                        providers_substance_urban = lengths(providers_substance_intersect_urban),
                        providers_testing_all10 = lengths(providers_testing_intersect_all10),
                        providers_testing_urban = lengths(providers_testing_intersect_urban),
                        bup_all10 = lengths(bup_intersect_all10),
                        bup_urban = lengths(bup_intersect_urban))

st_write(counts_by_zip, "data-output/buffer_counts_by_zip.gpkg")

head(counts_by_zip)

# look at counts of buffers by zip
arrange(counts_by_zip, desc(number_buffers))
arrange(counts_by_zip, desc(number_buffers))

hist(log(counts_by_zip$number_buffers))
hist(log(counts_by_zip$number_buffers))

ggplot(data = counts_by_zip, aes(x = bup_all10)) + 
  geom_histogram()


# Make some maps! ---------------------------------------------------------

states <- tigris::states(cb = TRUE) %>% 
  st_as_sf()

illinois <- filter(states, NAME == "Illinois") %>% 
  st_transform(32616)

il_msas_crop <- st_intersection(il_msas, illinois) %>% 
  st_cast("GEOMETRYCOLLECTION")

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_polygons(col = "green", alpha = 0.1) +
  tm_text("name") +
  tm_shape(providers_buffer) + 
  tm_polygons(alpha = 0) +
  tm_shape(providers_sf) + 
  tm_dots() +
  tm_layout(title = "All Providers, 10-Mile Buffer",
            inner.margins = c(0.1, 0.1, .1, 0.1))

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_text("name") +
  tm_polygons(col = "green", alpha = 0.1) +
  tm_shape(providers_urban_buffer) + 
  tm_polygons(alpha = 0) +
  tm_shape(providers_sf) + 
  tm_dots() +
  tm_layout(title = "All Providers, 10-Mile Buffer Rural, 1-Mile Buffer Urban",
            inner.margins = c(0.1, 0.1, .1, 0.1))

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_text("name") +
  tm_polygons(col = "green", alpha = 0.1) +
  tm_shape(bup_buffer) + 
  tm_polygons(alpha = 0) +
  tm_shape(bup_sf) + 
  tm_dots() +
  tm_layout(title = "Buprenorphine Physicians, 10-Mile Buffer",
            inner.margins = c(0.1, 0.1, .1, 0.1))

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_text("name") +
  tm_polygons(col = "green", alpha = 0.1) +
  tm_shape(bup_urban_buffer) + 
  tm_polygons(alpha = 0) +
  tm_shape(bup_sf) + 
  tm_dots() +
  tm_layout(title = "Buprenorphine Physicians, 10-Mile Buffer Rural, 1-Mile Buffer Urban",
            inner.margins = c(0.1, 0.1, .1, 0.1))


## Q: Are the places with FALSE coded for both sub abuse and testing just missing data?
## Q: how to just get Illinois CBAs from API? Is this possible with tigris?
## TODO: save to data-output
