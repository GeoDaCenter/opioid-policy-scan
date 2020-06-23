# Try to pull pharmacy location from WaPo

library(arcos)
library(sf)
library(dplyr)

il_pharm <- pharm_latlon(state = "IL", key = "WaPo") %>% 
  st_as_sf(coords = c("lon", "lat"), crs = 4326)

illinois <- st_read("data-output/illinois.gpkg") %>% 
  st_transform(4326)

miscoded <- st_difference(il_pharm, illinois)
correct <- st_intersection(il_pharm, illinois)

addresses <- buyer_addresses(state = "IL", key = "WaPo")
miscoded_addresses <- filter(addresses, BUYER_DEA_NO %in% miscoded$BUYER_DEA_NO)

# View(miscoded_addresses)

# Go properly geocode these things

