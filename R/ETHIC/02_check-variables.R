library(sf)
library(tmap)

illinois <- st_read("data-output/illinois.gpkg")

tm_shape(illinois) +
  tm_polygons() +
  tm_shape(naltrex_sf_final) + 
  tm_dots(size = 0.1)

!st_intersects(illinois, naltrex_sf_final)
