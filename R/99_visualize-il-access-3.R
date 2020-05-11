# Visualize IL-wide access metrics Vidal generated for 3 medications, round three
# Last updated: April 30, 2020

library(tidyverse)
library(sf)
library(tmap)

access <- read_csv("data/results_using_osrm/access_mouds_all_illinois_osrm.csv")
access <- mutate_all(access, round, 2)
# Need to round scores to 2 degrees otherwise won't plot

count <- read_csv("data/results_using_osrm/count_within_60min_mouds_all_il_osrm.csv")
time <- read_csv("data/results_using_osrm/shortest_time_mouds_all_il_osrm.csv")

summary(access)
summary(count)
summary(time)

# Join on zip
all_metrics <- full_join(access, count, by = "X1") %>% 
  full_join(time, by = "X1") %>% 
  mutate(X1 = as.character(X1)) %>% 
  rename(zcta = X1)

# 62225 is missing
# all_metrics[!complete.cases(all_metrics),]

all_metrics_long <- all_metrics %>% 
  pivot_longer(-zcta, names_to = "type")


# # Join to spatial zip boundary file
# zips <- readRDS("data-output/zips.rds") %>% 
#   select(zcta = ZCTA5CE10)
# class(zips)
# 
# zips_simp <- rmapshaper::ms_simplify(zips)
# # takes around 2 minutes

zips_simp <- read_sf("data-output/zips_simp.gpkg")

all_metrics_sf <- full_join(zips_simp, all_metrics)
all_metrics_long_sf <- full_join(zips_simp, all_metrics_long)


# This can be used to visualize in CARTO
# write_sf(all_metrics_sf, "data-output/results_logans_pkg.gpkg")


# Visualize in R  ---------------------------------------------------------

# Filter in order to do facets
bup_long_sf <- filter(all_metrics_long_sf,
                      str_detect(type, "Bup"))

meth_long_sf <- filter(all_metrics_long_sf,
                       str_detect(type, "Meth")) %>% 
  mutate(type = case_when(type == "Methadone_score" ~ "access_score",
                          TRUE ~ type))

naltrex_long_sf <- filter(all_metrics_long_sf,
                          str_detect(type, "Naltrex")) %>% 
  mutate(type = case_when(type == "Naltrexone_score" ~ "access_score",
                          TRUE ~ type))

illinois <- read_sf("data-output/illinois.gpkg")

b <- tm_shape(illinois) +
  tm_fill("grey") +
  tm_shape(bup_long_sf) +
  tm_fill("value",
          style = c("jenks", "fixed", "fixed"),
          breaks = list(NULL, c(0, 1, 5, 10, 50, 320), c(0, 15, 30, 45, 60, 107)),
          labels = list(NULL, c("None", "1 to 4", "5 to 9", "10 to 49", "50 to 320"), NULL),
          title = c("Score", "Count", "Time (min)"),
          palette = list("-YlOrBr", "-YlOrBr", "YlOrBr")) +
  tm_facets(by = "type", free.scales = TRUE) +
  tm_layout(panel.labels = c("Access Score", "Count Within 60 Min", "Time to Nearest (min)"),
            main.title = "Buprenorphine Access Metrics")

tmap_save(b, "output/bup_osrm.png", width = 6, height = 4)

m <- tm_shape(illinois) +
  tm_fill("grey") +
  tm_shape(meth_long_sf) +
  tm_fill("value",
          style = c("jenks", "fixed", "fixed"),
          breaks = list(NULL, c(0, 1, 2, 3, 5, 10, 61), c(0, 30, 45, 60, 120, 240)),
          labels = list(NULL, c("0", "1", "2", "3 to 4", "5 to 9", "10 to 61"), NULL),
          title = c("Score", "Count", "Time (min)"),
          palette = list("-YlOrBr", "-YlOrBr", "YlOrBr")) +
  tm_facets(by = "type", free.scales = TRUE) +
  tm_layout(panel.labels = c("Access Score", "Count Within 60 Min", "Time to Nearest (min)"),
            main.title = "Methadone Access Metrics")

tmap_save(m, "output/meth_osrm.png", width = 6, height = 4)

n <- tm_shape(illinois) +
  tm_fill("grey") +
  tm_shape(naltrex_long_sf) +
  tm_fill("value",
          style = c("jenks", "fixed", "fixed"),
          breaks = list(NULL, c(0, 1, 2, 3, 5, 10, 96), c(0, 30, 45, 60, 143)),
          labels = list(NULL, c("0", "1", "2", "3 to 4", "5 to 9", "10 to 96"), c("0 to 30", "30 to 45", "45 to 60", "60 to 143")),
          title = c("Score", "Count", "Time (min)"),
          palette = list("-YlOrBr", "-YlOrBr", "YlOrBr")) +
  tm_facets(by = "type", free.scales = TRUE) +
  tm_layout(panel.labels = c("Access Score", "Count Within 60 Min", "Time to Nearest (min)"),
            main.title = "Naltrexone Access Metrics")

tmap_save(n, "output/nal_osrm.png", width = 6, height = 4)

beepr::beep()
