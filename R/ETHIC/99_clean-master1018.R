library(sf)
library(tidyverse)

master1018 <- read_csv("data/master1018.csv")
zips_sf <- readRDS("data-output/zips.rds")

zips_small <- filter(zips_sf, ZCTA5CE10 %in% master1018$zcta) %>% 
  select(zcta = ZCTA5CE10) %>% 
  mutate(zcta = as.numeric(as.character(zcta))) # factors!!

master1018_sf <- zips_small %>% 
  right_join(master1018, by = "zcta")

st_write(master1018_sf, "data-output/master1018_sf.gpkg")
