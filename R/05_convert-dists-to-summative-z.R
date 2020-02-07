library(tidyverse)
library(sf)

dists <- read_csv("data-output/min-dists-to-zip-centroid.csv")

names(dists) <- c("zip", "er", "fqhc", "hiv", "hcv", "moud_bup", "moud_met", "moud_naltrex", "nalox") # better to do this with rename...

zscores <- dists %>% 
  mutate(zip = as.character(zip)) %>% 
  mutate_if(is.numeric, scale)

sum_zscores <- zscores %>% 
  mutate(opiod_z = er + fqhc + moud_bup + moud_met + moud_naltrex + nalox,
         hcv_z = fqhc + hcv + moud_bup + moud_met + moud_naltrex,
         hiv_z = fqhc + hiv + nalox,
         # + moud_bup + moud_met + moud_naltrex + moud_nalox
         )

# Check that this works
# In the future: write a test for this script
# sum_zscores["fqhc"][1,] + sum_zscores["hiv"][1,]
# sum_zscores["hiv_z"][1,]

# Join to zips
zips_sf <- st_read("data-output/zips.gpkg")

sum_zscores_sf <- right_join(sum_zscores, zips_sf, by = c("zip" = "ZCTA5CE10"))

# Join population by zip to summative z
atrisk <- read_csv("data-output/atrisk.csv") %>% 
  select(-X1) %>% 
  rename(at_risk_pop = total_18_39)
sum_zscores_sf <- right_join(atrisk, sum_zscores_sf, by = c("GEOID" = "GEOID10")) 
# Write out
st_write(sum_zscores_sf, "data-output/sum_zscores.gpkg", delete_dsn = TRUE)
st_write(sum_zscores_sf, "data-output/sum_zscores.shp", delete_dsn = TRUE)
write_sf(sum_zscores_sf, "data-output/sum_zscores.csv")
