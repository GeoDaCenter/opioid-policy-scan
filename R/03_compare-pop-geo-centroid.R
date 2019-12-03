# Compare geographical centroid and population-weighted centroid (pulled from Census site) for IL counties
# Data from: https://www.census.gov/geographies/reference-files/time-series/geo/centers-population.html
# Centers of Population by County > Illinois

library(readr)
library(sf)
library(tmap)

pop_centroid <- read_csv("data/CenPop2010_Mean_CO17.csv")
pop_centroid <- st_as_sf(pop_centroid, 
                   coords = c("LONGITUDE", "LATITUDE"),
                   crs = 4326) %>% 
  st_transform(32616)

counties <- st_read("data-output/il_counties.gpkg")
geo_centroid <- st_centroid(counties)

# Map geographical centroid vs. population weighted centroid
tm_shape(counties) +
  tm_borders() +
tm_shape(geo_centroid) +
  tm_symbols(col = "black", size = 0.1) +
tm_shape(pop_centroid) +
  tm_symbols(col = "red", size = 0.1)
