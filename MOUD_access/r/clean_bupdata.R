library(tidyverse)
library(sf)
library(tidygeocoder)
library(tmap)

#### Load and clean data ----

# Read in data
bup_raw <- read.csv("data_raw/locator_export.csv")

# Find missing lat long columns
nrow(bup_raw[is.na(bup_raw$latitude),])
nrow(bup_raw[is.na(bup_raw$longitude),]) #1112 missing total


#### Geocode ----

# Prepare for geocoding missing lat/long addresses
bup_geo <- bup_raw %>% filter(is.na(latitude))
bup_geo <- bup_geo[,7:18]
bup_geo <- bup_geo[,1:5]

bup_geo$fullAdd <- paste(as.character(bup_geo$addressLine1),
                         as.character(bup_geo$city),
                         as.character(bup_geo$state),
                         as.character(bup_geo$zipCode))

# Geocode addresses
bup_geo <- geocode(bup_geo, address = 'fullAdd', 
                   lat = latitude, long = longitude, method = 'cascade')

# Find which are still missing/NA
nrow(bup_geo[is.na(bup_geo$latitude),]) # 302 still NA

# Save those remaining NAs as separate dataset, export to CSV for outside geocoding
bup_geo_NA <- bup_geo %>% filter(is.na(latitude))
write.csv(bup_geo_NA, "intmed_output/bup_NA.csv")

# Add former missing, now geocoded lat/long columns to bup_raw
bup_raw$latitude[is.na(bup_raw$latitude)] <- bup_geo$latitude[bup_geo$zipCode %in% bup_raw$zipCode]
bup_raw$longitude[is.na(bup_raw$longitude)] <- bup_geo$longitude[bup_geo$zipCode %in% bup_raw$zipCode]

# Read in newly RCC geocoded 
bup_geo2 <- read.csv("intmed_output/bup_NA_1612998676_geocoded.csv")

# Add former missing, now geocoded lat/long columns to bup_raw
bup_raw$latitude[is.na(bup_raw$latitude)] <- bup_geo2$Latitude[bup_geo2$zip %in% bup_raw$zipCode]
bup_raw$longitude[is.na(bup_raw$longitude)] <- bup_geo2$Longitude[bup_geo2$zip %in% bup_raw$zipCode]

# still missing?
nrow(bup_raw[is.na(bup_raw$latitude),])
nrow(bup_raw[is.na(bup_raw$longitude),])

# Filter out PR, AK, HI, "GU", "VI", "MP"
bup_clean <- bup_raw %>% filter(!state %in% c("AE", "AK", "HI", "GU", "VI", "MP", "PR")) %>%
  select(7:14)

bup_clean$category <- "buprenorphine"
bup_clean$name1 <- "Practitioner"
bup_clean$name2 <- ""
bup_clean$source <- "SAMHSA"

#### Convert to sf
bup.clean.sf <- st_as_sf(bup_clean,
                      crs = 4326,
                      coords = c("longitude", "latitude"))

bup.clean.sf <- clip_to_continental_us(bup.clean.sf)

# quick plot
tmap_mode("plot")

tm_shape(bup.clean.sf) +
  tm_dots() 

# Export as gpkg
st_write(bup.clean.sf, "intmed_output/bup_providers.gpkg")

# Export as csv
write.csv(bup.clean.sf, "intmed_output/bup_providers.csv")

# Use in colab to calculate access metrics

clip_to_continental_us <- function(sf) {
  
  continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>% 
    st_as_sf(crs = 4326) %>% 
    st_transform(st_crs(sf))
  
  continental_sf <- st_intersection(continental_bbox, sf)
  
}
