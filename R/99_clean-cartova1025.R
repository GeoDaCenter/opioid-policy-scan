library(sf)
library(tidyverse)

cartova_1025 <- read_csv("data/cartova_1025.csv")
zips_sf <- readRDS("data-output/zips.rds") %>% 
  mutate(zip = as.numeric(ZCTA5CE10)) %>% 
  select(zip)

# # Double check that zip is same as zcta, so can join on it
# identical(cartova_1025$zip, cartova_1025$zcta)

cartova_1025_sf <- zips_sf %>% 
  right_join(cartova_1025, by = "zip")

st_write(cartova_1025_sf, "data-output/cartova_1025_sf.gpkg", delete_dsn = TRUE)
