# Get ZCTAs, MSAs, and Illinois geometries from Census API

library(sf)
library(tigris) # all geometries from year 2017

# 1383 ZCTAs in Illinois
zips <- tigris::zctas(starts_with = c("60", "61", "62")) # takes like 5 min
zips_sf <- st_as_sf(zips, coords = c("INTPTLAT10", "INTPTLON10")) %>%
  st_transform(32616) # takes like 20 seconds

# 13 MSAs in Illinois
il_msas <- core_based_statistical_areas(class = "sf") %>% 
  separate(NAME, sep = ", ", into = c("name", "state")) %>%
  filter(str_detect(state, "IL")) %>%
  filter(LSAD == "M1") %>%  # only metropolitan, not micropolitan
  st_transform(32616) %>%
  select(name) %>%
  add_column(urban = TRUE)

illinois <- tigris::states(cb = TRUE) %>%
  st_as_sf() %>% 
  filter(NAME == "Illinois") %>%
  st_transform(32616)

# Save final versions ------------------------------------------------------

st_write(zips_sf, "data-output/zips.gpkg", delete_dsn = TRUE)
saveRDS(zips_sf, "data-output/zips.rds")

st_write(il_msas, "data-output/il-msas.gpkg", delete_dsn = TRUE)

st_write(illinois, "data-output/illinois.gpkg", delete_dsn = TRUE)
