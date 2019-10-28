# Get ZCTAs, MSAs, and Illinois geometries from Census API

library(sf)
library(tigris) # all geometries from year 2017

# Illinois boundary
illinois <- tigris::states(cb = TRUE) %>%
  st_as_sf() %>% 
  filter(NAME == "Illinois") %>%
  st_transform(32616)

# 1383 ZCTAs in Illinois
zips <- zctas(starts_with = c("60", "61", "62")) # takes like 5 min
zips_sf <- st_as_sf(zips, coords = c("INTPTLON10", "INTPTLAT10")) %>%
  st_transform(32616) # takes like 20 seconds

# 102 Counties in Illinois
il_counties <- counties(state = "Illinois")
il_counties_sf <- st_as_sf(il_counties, coords = c("INTPTLON", "INTPTLAT")) %>% 
  st_transform(32616)
# Clip to IL shape
il_counties_sf <- st_intersection(il_counties_sf, illinois)
# plot(il_counties_sf["geometry"])

# 13 MSAs in Illinois
il_msas <- core_based_statistical_areas(class = "sf") %>% 
  separate(NAME, sep = ", ", into = c("name", "state")) %>%
  filter(str_detect(state, "IL")) %>%
  filter(LSAD == "M1") %>%  # only metropolitan, not micropolitan
  st_transform(32616) %>%
  select(name) %>%
  add_column(urban = TRUE)

# 45 Counties Bordering Illinois 
il_border_counties <- counties(state = c("Indiana", "Wisconsin", "Iowa", "Missouri", "Kentucky"))
il_border_counties_sf <- st_as_sf(il_border_counties, coords = c("INTPTLON", "INTPTLAT")) %>% 
  st_transform(32616)

il_border_counties_sf <- il_border_counties_sf[lengths(st_touches(il_border_counties_sf, il_counties_sf)) > 0,]
# plot(il_border_counties_sf["geometry"])

# Clip to Wisconsin boundary
wisconsin <- tigris::states(cb = TRUE) %>%
  st_as_sf() %>% 
  filter(NAME == "Wisconsin") %>%
  st_transform(32616)

in_wisc <- filter(il_border_counties_sf, STATEFP == "55")
not_in_wisc <- filter(il_border_counties_sf, STATEFP != "55")
wisc_border_counties <- st_intersection(in_wisc, wisconsin["geometry"])

border_counties <- rbind(wisc_border_counties, not_in_wisc)
# plot(border_counties["geometry"])

# Save final versions ------------------------------------------------------

st_write(zips_sf, "data-output/zips.gpkg", delete_dsn = TRUE)
saveRDS(zips_sf, "data-output/zips.rds")

st_write(il_counties_sf, "data-output/il_counties.gpkg", delete_dsn = TRUE)
saveRDS(il_counties_sf, "data-output/il_counties.rds")

st_write(il_msas, "data-output/il-msas.gpkg", delete_dsn = TRUE)

st_write(illinois, "data-output/illinois.gpkg", delete_dsn = TRUE)

st_write(border_counties, "data-output/il_border_counties.gpkg", delete_dsn = TRUE)
