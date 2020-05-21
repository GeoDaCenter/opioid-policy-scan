# Pull ABM area for Vidal

library(dplyr)
library(readr)
library(sf)

abm_zones <- read_csv("data/abm_zones.csv")
zips_sf <- readRDS("data-output/zips.rds")

abm_zones <- abm_zones %>% 
  mutate(Zipcode = as.character(Zipcode))

abm_zips <- zips_sf %>% 
  right_join(abm_zones, 
             by = c("ZCTA5CE10" = "Zipcode")) 

abm_area <- abm_zips %>% 
  st_union()

write_sf(abm_zips, "data-shared/abm_zips.gpkg")
write_sf(abm_area, "data-shared/abm_area.gpkg")

# # Check output
# illinois <- st_read("data-output/illinois.gpkg")
# plot(st_geometry(illinois))
# plot(abm_area, add = TRUE)
# plot(abm_zips, add = TRUE)
