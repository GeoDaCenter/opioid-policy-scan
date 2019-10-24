# Map provider buffers
# Outputs images to output folder

library(sf)
library(tmap)
library(tigris)

illinois <- st_read("data-output/illinois.gpkg")
il_msas <- st_read("data-output/il-msas.shp")

bup_buffer <- st_read("data-output/bup_buffer.geojson")
bup_urban_buffer <- st_read("data-output/bup_urban_buffer.geojson")

nalox_buffer <- st_read("data-output/nalox_buffer.shp")
nalox_urban_buffer <- st_read("data-output/nalox_urban_buffer.shp")

# il_msas_crop <- st_intersection(il_msas, illinois) %>% 
#   st_cast("GEOMETRYCOLLECTION")

# HIV Testing (NPIN) --------------------------------------------------------

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_polygons(col = "green", alpha = 0.1) +
  tm_text("name") +
  tm_shape(testing_centers_all10) + 
  tm_polygons(alpha = 0) +
  tm_layout(title = "All Testing sites, 10-Mile Buffer",
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


# Bup ---------------------------------------------------------------------

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


# Naloxone ----------------------------------------------------------------

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_polygons(col = "green", alpha = 0.1) +
  tm_text("name") +
  tm_shape(nalox_buffer) + 
  tm_polygons(alpha = 0) +
  tm_layout(title = "Naloxone Providers, 10 mile buffer",
            inner.margins = c(0.1, 0.1, .1, 0.1))

tm_mode()

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(il_msas) + 
  tm_polygons(col = "green", alpha = 0.1) +
  tm_text("name") +
  tm_shape(nalox_urban_buffer) + 
  tm_polygons(alpha = 0) +
  tm_layout(title = "Naloxone Providers, 10-Mile Buffer Rural, 1-Mile Buffer Urban",
            inner.margins = c(0.1, 0.1, .1, 0.1))
