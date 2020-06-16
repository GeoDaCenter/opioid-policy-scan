# Combine proper bup prac and meth, nal

library(sf)
library(dplyr)

source("R/00_functions-included.R") #for get_min_dists function

bup_prac_access <- st_read("data-output/bup_prac_access.gpkg") %>% 
  rename(bup = min_dists)
meth_nal_access <- st_read("data-output/us_min_dists_06-03.gpkg") %>% 
  select(ZCTA5CE10, meth = meth_min_dists_mi, nal = nal_min_dists_mi) %>% 
  st_drop_geometry()
dialysis_access <- st_read("data-output/dialysis_min_dists.shp") %>% 
  select(ZCTA5CE, dialysis = dlyss_d) %>% 
  st_drop_geometry()

pop_by_zip <- read_csv("data-output/pop_by_zip.csv")

all_access <- full_join(bup_prac_access, meth_nal_access) %>% 
  full_join(dialysis_access, by = c("ZCTA5CE10" = "ZCTA5CE")) %>%
  full_join(pop_by_zip, by = c("ZCTA5CE10" = "GEOID")) 

all_access_us <- clip_to_continental_us(all_access) %>% 
  st_transform(102003)

st_write(all_access_us, "data-output/min_dists_all.csv")
