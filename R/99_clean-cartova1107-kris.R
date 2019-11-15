library(sf)
library(tidyverse)
library(tmap)

cartova <- st_read("data/cartova117_use.gpkg")
cartova <- st_transform(cartova, 32616)
names(cartova)


# Kris' email -------------------------------------------------------------

# If a zip code is more than 50% in a MSA, code as urban
# Idea: use area calculation
# https://gis.stackexchange.com/questions/221171/spatial-join-if-more-than-50-of-join-feature-overlay-target-feature

il_msas <- st_read("data-output/il-msas.gpkg")
counties <- st_read("data-output/il_counties.gpkg")
cook_county <- filter(counties, County == "Cook")


# First do urban
area_in_msa <- st_intersection(cartova, il_msas) %>% 
  mutate(area_intersected = st_area(geom)) %>% 
  select(zip, area_intersected) %>% 
  st_drop_geometry()

urban_zips <- cartova %>% 
  mutate(area = st_area(geom)) %>%   
  left_join(area_in_msa, by = "zip") %>% 
  mutate(urban = ifelse(area_intersected >= 0.5 * area, 1, 0)) %>% 
  filter(urban == 1) %>% 
  select(urban, zip)

# Look at zips coded as urban
tm_shape(il_msas) +
  tm_polygons(col = "red") +
  tm_shape(urban_zips) +
  tm_polygons(alpha = 0) 

cartova_urban <- cartova %>% 
  left_join(st_drop_geometry(urban_zips), by = "zip") %>% 
  mutate(urban = replace_na(urban, 0))

# Check that it makes sense
cartova_urban %>% count(urban)


# Then do Cook County - if more than 50% in Cook County, counted as part of it
area_in_cook <- st_intersection(cartova, cook_county) %>% 
  mutate(area_intersected = st_area(geom)) %>% 
  select(zip, area_intersected) %>% 
  st_drop_geometry()

cook_zips <- cartova %>% 
  mutate(area = st_area(geom)) %>%   
  left_join(area_in_cook, by = "zip") %>% 
  mutate(cook = ifelse(area_intersected >= 0.5 * area, 1, 0)) %>% 
  filter(cook == 1) %>% 
  select(cook, zip)

# Look at zips in Cook County
tm_shape(cook_county) +
  tm_polygons(col = "red") +
  tm_shape(cook_zips) +
  tm_polygons(alpha = 0) 

cartova_cook <- cartova_urban %>% 
  left_join(st_drop_geometry(cook_zips), by = "zip") %>% 
  mutate(cook = replace_na(cook, 0))

# Check that it makes sense
cartova_cook %>% count(cook)


# Save output -------------------------------------------------------------

cartova_nonsensitive <- select(cartova_cook, 
                               -zcta,
                               -contains("count"),
                               -geom)
names(cartova_nonsensitive)

st_write(cartova_nonsensitive, "data-output/va_1115_nonsensitive.gpkg", delete_dsn = TRUE)
st_write(cartova_nonsensitive, "data-output/va_1115_nonsensitive.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
