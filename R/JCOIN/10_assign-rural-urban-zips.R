# Assign zips to metro/micro areas

library(sf)
library(tidycensus)
library(tidyverse)

library(readxl)


# Summary stats by urban / rural

str(all_access_us)


urban_rural <- mutate(all_access_us, 
                      ALAND10 = 
                        units::set_units(
                          as.numeric(
                            as.character(ALAND10)), 
                          "m^2"),
                      mi2 = units::set_units(ALAND10, "mi^2"),
                      popdensity = as.numeric(poptotal / mi2),
                      rurality = case_when(
                        popdensity < 1000 ~ "rural",
                        popdensity >= 1000 & popdensity <= 3000 ~ "semi-urban",
                        popdensity > 3000 ~ "urban"))

r <- tm_shape(urban_rural) +
  tm_fill("rurality")

tmap_save(r, "output/rurality.png")
beepr::beep()



## Unsuccessful attempts at using micro/metropolitan areas 

# metros <- tigris::metro_divisions() %>% 
#   st_as_sf()
# 
# plot(st_geometry(metros))
# 
# msa <- get_acs(variables = c(medincome = "B19013_001"), 
#                geography = "metropolitan statistical area/micropolitan statistical area")
# 
# metro_micro <- msa %>% 
#   mutate(cba = case_when(
#     str_detect(NAME, "Micro") ~ "micro",
#     str_detect(NAME, "Metro") ~ "metro"
#   )) %>% 
#   select(CBSA = GEOID, cba)
# 
# %>% 
#   count(cba) 
# 
# metro_polygon <- metro_micro %>% 
#   select(-n) %>% 
#   slice(1)
# 
# micro_polygon <- metro_micro %>% 
#   select(-n) %>% 
#   slice(2)
# 
# 
# zip_cbsa <- read_excel("data/ZIP_CBSA_032020.xlsx") %>% 
#   select(ZIP, CBSA)
# 
# zip_metro <- left_join(zip_cbsa, metro_micro) %>% 
#   mutate(ZIP = as.numeric(ZIP),
#          CBSA = as.numeric(CBSA))
# 
# filter(zip_metro, is.na(cba)) %>% skim()
