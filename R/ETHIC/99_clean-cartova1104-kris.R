library(sf)
library(tidyverse)

cartova <- st_read("data-output/cartova_1025_sf.gpkg")
names(cartova)

cartova_nonsensitive <- select(cartova, 
                               -zcta,
                               -contains("count"),
                               -hcv_rate, -od_rate, -hcv40_rate, -hiv_rate,
                               -totalnfod,
                               -delta, -kane, -peoria, -tazewell, -woodford,
                               -the_geom)
names(cartova_nonsensitive)

st_write(cartova_nonsensitive, "data-output/va_1104_nonsensitive.gpkg", delete_dsn = TRUE)
st_write(cartova_nonsensitive, "data-output/va_1104_nonsensitive.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
