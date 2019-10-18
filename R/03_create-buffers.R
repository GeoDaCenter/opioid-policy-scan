# Create buffers for point dataset

library(sf)
library(tidyverse)
library(tigris)

pts_master <- read_sf("data-output/02_point-master.gpkg")


# Buffer all areas by 10 miles --------------------------------------------

pts_buffer <- st_buffer(pts_master, 16093)
plot(pts_buffer["geom"])

st_write(pts_buffer, "data-output/03_pts_buffer.gpkg", delete_dsn = TRUE)


# Buffer differently based on urban vs. rural -----------------------------

# Get Census outlines for MSAs 
msas <- core_based_statistical_areas() %>% # from year 2017
  st_as_sf(coords = c("INTPTLAT", "INTPTLON"))

# Pull out Illinois MSAs from all Census outlines and code as "urban"

# il_msas <- msas %>%
#   separate(NAME, sep = ", ", into = c("name", "state")) %>%
#   filter(str_detect(state, "IL")) %>%
#   filter(LSAD == "M1") %>%  # only metropolitan, not micropolitan
#   st_transform(32616) %>%
#   select(name) %>%
#   add_column(urban = TRUE)
# 
# st_write(il_msas, "data-output/il-msas.gpkg", delete_dsn = TRUE)

il_msas <- st_read("data-output/il-msas.gpkg")

# Spatial join to add column with urban to providers_sf (0 if not, 1 if so)
pts_type <- st_join(pts_master, il_msas) %>% 
  mutate(urban = replace_na(urban, 0))

# st_write(providers_type, "data-output/providers_with_type.shp")
# providers_type <- st_read("data-output/providers_with_type.shp")

urban_pts <- filter(pts_type, urban == 1)
rural_pts <- filter(pts_type, urban == 0)

# Buffer separately, then combine with rbind()
urban_pts_buffer <- st_buffer(urban_pts, 1609) # 1 mile ~ 1609 meters
rural_pts_buffer <- st_buffer(rural_pts, 16093) # 10 miles ~ 16093 meters

pts_urban_buffer <- rbind(urban_pts_buffer, rural_pts_buffer)

# Plot it to check our work
plot(pts_urban_buffer["geom"])

st_write(pts_urban_buffer, "data-output/03_pts_urban_buffer.gpkg", delete_dsn = TRUE)

## Q: how to just get Illinois CBAs from API? Is this possible with tigris?
