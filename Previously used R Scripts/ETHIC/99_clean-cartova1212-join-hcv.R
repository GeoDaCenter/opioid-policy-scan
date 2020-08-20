# Join HCV variable to existing data from CARTO

library(tidyverse)
library(sf)

data_1212 <- read_csv("data/cartova1212_use.csv")
zip_distances <- read_csv("data-output/min-dists-to-zip-centroid.csv")

hcv_mi <- zip_distances %>% 
  select(zip = "Zip", hcv_t_mi = "HCV Testing - Nearest Distance to Centroid (mi)")

data_1212_hcv <- left_join(data_1212, hcv_mi)

write_csv(data_1212_hcv, "data-output/cartova_1212_hcv.csv")
