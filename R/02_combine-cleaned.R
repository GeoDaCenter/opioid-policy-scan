# Combine all cleaned point datasets

library(sf)
library(tidyverse)

nalox <- read_sf("data-output/01_nalox.gpkg")
hiv_testing <- read_sf("data-output/01_hiv_testing.gpkg")
bup <- read_sf("data-output/01_bup.gpkg")
ers_trauma <- read_sf("data-output/01_ers_trauma.gpkg")
naltrex <- read_sf("data-output/01_naltrex.gpkg")
fqhc <- read_sf("data-output/01_fqhc.gpkg")
meth <- read_sf("data-output/01_meth.gpkg")

pt_master <- rbind(nalox, hiv_testing, bup, ers_trauma, naltrex, fqhc, meth) %>% 
  mutate(ID = row_number()) %>% 
  select(ID, everything())

pt_summary <- pt_master %>% 
  group_by(Category) %>% 
  count() %>% 
  arrange(Category)


# Save final versions ------------------------------------------------------

st_write(pt_master, "data-output/02_point-master.gpkg", delete_dsn = TRUE)
st_write(pt_master, "data-output/point-master.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
st_write(pt_summary, "data-output/point-summary.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
