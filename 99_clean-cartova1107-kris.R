library(sf)
library(tidyverse)

cartova <- st_read("data/cartova117_use.gpkg")
names(cartova)

cartova_nonsensitive <- select(cartova, 
                               -zcta,
                               -contains("count"),
                               -geom)
names(cartova_nonsensitive)

st_write(cartova_nonsensitive, "data-output/va_1107_nonsensitive.gpkg", delete_dsn = TRUE)
st_write(cartova_nonsensitive, "data-output/va_1107_nonsensitive.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
