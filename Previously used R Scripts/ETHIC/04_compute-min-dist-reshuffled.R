# Compute min dists for reshuffled locations too

library(sf)
library(tidyverse)

reshuffle1 <- st_read("data-shared/reshuffle1.gpkg") %>% 
  st_set_crs(32616)
reshuffle2 <- st_read("data-shared/reshuffle2.gpkg") %>% 
  st_set_crs(32616)

r1_bup <- reshuffle1 %>% 
  filter(as.character(marks) == "MOUD - Buprenorphine")
r1_meth <- reshuffle1 %>% 
  filter(as.character(marks) == "MOUD - Methadone")
r1_nal <- reshuffle1 %>% 
  filter(as.character(marks) == "MOUD - Naltrexone")

r2_bup <- reshuffle2 %>% 
  filter(as.character(marks) == "MOUD - Buprenorphine")
r2_meth <- reshuffle2 %>% 
  filter(as.character(marks) == "MOUD - Methadone")
r2_nal <- reshuffle2 %>% 
  filter(as.character(marks) == "MOUD - Naltrexone")

abm_zips <- read_sf("data-shared/abm_zips.gpkg") %>% 
  transmute(zip = as.numeric(as.character(ZCTA5CE10)))

# needed for next section
zips_centroids <- abm_zips %>% 
  st_centroid() 

source("R/00_functions-included.R")

zips <- zips_centroids %>% 
  st_drop_geometry()

actual_min_dists <- read_csv("data-output/min-dists-to-zip-centroid.csv") %>% 
  right_join(zips, by = c("Zip" = "zip")) %>% 
  select(real_bup = `MOUD - Buprenorphine - Nearest Distance to Centroid (mi)`,
         real_meth = `MOUD - Methadone - Nearest Distance to Centroid (mi)`,
         real_nal = `MOUD - Naltrexone - Nearest Distance to Centroid (mi)`)

min_dists_all <- 
  cbind(
    zips,
    actual_min_dists,
    s1_bup = get_min_dist(r1_bup),
    s1_meth = get_min_dist(r1_meth),
    s1_nal = get_min_dist(r1_nal),
    s2_bup = get_min_dist(r2_bup),
    s2_meth = get_min_dist(r2_meth),
    s2_nal = get_min_dist(r2_nal)
  ) %>% 
  as_tibble()

head(min_dists_all) # success



# Check with ggplot2
p <- min_dists_all %>% 
  pivot_longer(-zip, names_to = "scenario", values_to = "min distance (mi)") %>% 
  ggplot(aes(x = scenario, y = `min distance (mi)`)) +
  geom_boxplot()

p

p_zoomed <- boxplots +
  ylim(0, 50)

p_zoomed



# Make geo object
min_dists_all_sf <- min_dists_all %>% 
  right_join(abm_zips)

head(min_dists_all_sf)



# Save as csv and geo object
write_csv(min_dists_all, "data-shared/min_dist_real_reshuffled.csv")

write_sf(min_dists_all_sf, "data-shared/min_dist_real_reshuffled.shp")
