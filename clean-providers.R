library(tidyverse)
library(sf)
library(tmap)
library(tigris)

# Import providers data & project
providers <- readxl::read_excel("data/Illinois data_September2019.xlsx")

providers_sf <- st_as_sf(providers, coords = c("lon", "lat")) %>% 
  st_set_crs(4269)

# Get Census outlines for MSAs
msas <- core_based_statistical_areas() %>% 
  st_as_sf(coords = c("INTPTLAT", "INTPTLON"))

il_msas <- msas %>%
  separate(NAME, sep = ", ", into = c("name", "state")) %>% 
  filter(str_detect(state, "IL")) %>% 
  filter(LSAD == "M1") # only metropolitan, not micropolitan

il_msas_geo <- il_msas %>% 
  select(name) %>% 
  add_column(urban = TRUE)

# Spatial join to add column with urban (0 if not, 1 if so)
providers_type <- st_join(providers_sf, il_msas_geo) %>% 
  mutate(urban = replace_na(urban, 0))

urban_providers <- filter(providers_type, urban == 1)
rural_providers <- filter(providers_type, urban == 0)

# Buffer, then combine with bind_rows()
# Need to project first!
