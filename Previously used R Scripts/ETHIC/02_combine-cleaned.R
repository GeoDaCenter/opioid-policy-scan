# Combine all cleaned point datasets

library(sf)
library(tidyverse)

nalox <- read_sf("data-output/01_nalox.gpkg")
hiv_testing <- read_sf("data-output/01_hiv_testing.gpkg")
hcv_testing <- read_sf("data-output/01_hcv_testing.gpkg")
bup <- read_sf("data-output/01_bup.gpkg")
ers_trauma <- read_sf("data-output/01_ers_trauma.gpkg")
naltrex <- read_sf("data-output/01_naltrex.gpkg")
fqhc <- read_sf("data-output/01_fqhc.gpkg")
meth <- read_sf("data-output/01_meth.gpkg")

pt_master <- rbind(nalox, hiv_testing, hcv_testing, bup, ers_trauma, naltrex, fqhc, meth)

# Join county names to final point dataset

il_counties <- st_read("data-output/il_counties.gpkg", stringsAsFactors = FALSE)
il_counties <- st_transform(il_counties, 32616) %>% 
  select(County = NAME)

pt_master <- st_join(pt_master, il_counties)

# # Check counts by county
# pt_master %>% count(County) %>% arrange(desc(n))

# Clean up
pt_master <- pt_master %>% 
  mutate(ID = row_number(),
         City = str_to_title(City)) %>% 
  select(ID, Name, Address, City, County, Zip, Category, geom)

pt_summary <- pt_master %>% 
  group_by(Category) %>% 
  count() %>% 
  arrange(Category)

# Add MOUD -All dataset

moud_all <- filter(pt_master, Category == "MOUD - Buprenorphine" | Category == "MOUD - Methadone" | Category == "MOUD - Naltrexone")

# Save final versions ------------------------------------------------------

st_write(moud_all, "data-output/02_moud-all.gpkg", delete_dsn = TRUE)
st_write(pt_master, "data-output/02_point-master.gpkg", delete_dsn = TRUE)
st_write(pt_master, "data-output/point-master.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
st_write(pt_summary, "data-output/point-summary.csv", layer_options = "GEOMETRY=AS_XY", delete_dsn = TRUE)
