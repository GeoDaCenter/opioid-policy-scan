# Create buffers for points

# Buffer all areas by 10 miles
providers_buffer <- st_buffer(providers_sf, 16093)

plot(providers_buffer["geometry"])

st_write(providers_buffer, "data-output/providers_buffer.shp")

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

# st_write(il_msas, "data-output/il-msas.shp")

il_msas <- st_read("data-output/il-msas.shp")

# Spatial join to add column with urban to providers_sf (0 if not, 1 if so)
providers_type <- st_join(providers_sf, il_msas) %>% 
  mutate(urban = replace_na(urban, 0))

# st_write(providers_type, "data-output/providers_with_type.shp")
# providers_type <- st_read("data-output/providers_with_type.shp")

urban_providers <- filter(providers_type, urban == 1)
rural_providers <- filter(providers_type, urban == 0)

# Buffer separately, then combine with rbind()
urban_providers_buffer <- st_buffer(urban_providers, 1609) # 1 mile ~ 1609 meters
rural_providers_buffer <- st_buffer(rural_providers, 16093) # 10 miles ~ 16093 meters

providers_urban_buffer <- rbind(urban_providers_buffer, rural_providers_buffer)

# Plot it to check our work
plot(providers_urban_buffer["geometry"])

st_write(providers_urban_buffer, "data-output/providers_urban_buffer.shp")

## Q: how to just get Illinois CBAs from API? Is this possible with tigris?
