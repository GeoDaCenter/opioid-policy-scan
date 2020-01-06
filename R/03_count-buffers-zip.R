# Get counts of buffers by zip code

# Make access proxy vars by zip code based on how many buffers intersect 
# with that zip code

zips_sf <- st_read("data-output/zips.gpkg") # takes 15 seconds
zips_sf <- readRDS("data-output/zips.rds")

providers_intersect_all10 <- st_intersects(zips_sf, providers_buffer) # takes like 20 seconds
providers_intersect_urban <- st_intersects(zips_sf, providers_urban_buffer) # takes like 20 seconds
bup_intersect_all10 <- st_intersects(zips_sf, bup_buffer)
bup_intersect_urban <- st_intersects(zips_sf, bup_urban_buffer)
providers_substance_intersect_all10 <- st_intersects(zips_sf, substance_treatment_centers_all10)
providers_substance_intersect_urban <- st_intersects(zips_sf, substance_treatment_centers_urban)
providers_testing_intersect_all10 <- st_intersects(zips_sf, testing_centers_all10)
providers_testing_intersect_urban <- st_intersects(zips_sf, testing_centers_urban)

counts_by_zip <- mutate(zips_sf, 
                        providers_all10 = lengths(providers_intersect_all10),
                        providers_urban = lengths(providers_intersect_urban),
                        providers_substance_all10 = lengths(providers_substance_intersect_all10),
                        providers_substance_urban = lengths(providers_substance_intersect_urban),
                        providers_testing_all10 = lengths(providers_testing_intersect_all10),
                        providers_testing_urban = lengths(providers_testing_intersect_urban),
                        bup_all10 = lengths(bup_intersect_all10),
                        bup_urban = lengths(bup_intersect_urban))

st_write(counts_by_zip, "data-output/buffer_counts_by_zip.gpkg")

head(counts_by_zip)

# look at counts of buffers by zip
arrange(counts_by_zip, desc(number_buffers))
arrange(counts_by_zip, desc(number_buffers))

hist(log(counts_by_zip$number_buffers))
hist(log(counts_by_zip$number_buffers))

ggplot(data = counts_by_zip, aes(x = bup_all10)) + 
  geom_histogram()