# Visualize IL-wide metrics by Vidal, 30/60 min threshold 
# June 16, 2020

library(tmap)

time <- read_csv("data/access_results/access_time/IL-AccessTime-results.csv")
count <- read_csv("data/access_results/access_count_30/IL-30_thresh_AccessCount-results.csv")
access <- read_csv("data/access_results/access_model_30/IL-30_thresh_AccessModel-results.csv")

time <- read_csv("data/access_results/access_time/IL-AccessTime-results.csv")
count <- read_csv("data/access_results/access_count_60/IL-60_thresh_AccessCount-results.csv")
access <- read_csv("data/access_results/access_model_60/IL-60_thresh_AccessModel-results.csv")


all_metrics <- full_join(access, count, by = "X1") %>% 
  full_join(time, by = "X1") %>% 
  mutate(X1 = as.character(X1)) %>% 
  rename(zcta = X1)

all_metrics_long <- all_metrics %>% 
  pivot_longer(-zcta, names_to = "type")

zips_simp <- read_sf("data-output/zips_simp.gpkg")

all_metrics_sf <- full_join(zips_simp, all_metrics)
all_metrics_long_sf <- full_join(zips_simp, all_metrics_long)

bup_long_sf <- filter(all_metrics_long_sf,
                      str_detect(type, "buprenorphine"))

meth_long_sf <- filter(all_metrics_long_sf,
                       str_detect(type, "meth")) %>%
  # this is to make sure access score is first in the plot (as versus count - prevents against mislabeling)
  mutate(type = case_when(type == "methadone_score" ~ "access_score",
                          TRUE ~ type))

naltrex_long_sf <- filter(all_metrics_long_sf,
                          str_detect(type, "naltrex")) %>% 
  mutate(type = case_when(type == "naltrexone_score" ~ "access_score",
                                                                               TRUE ~ type))

illinois <- read_sf("data-output/illinois.gpkg")

b <- tm_shape(illinois) +
  tm_fill("grey") +
  tm_shape(bup_long_sf) +
  tm_fill("value",
          style = c("jenks", "jenks", "jenks"),
          breaks = list(NULL, NULL, NULL),
          labels = list(NULL, NULL, NULL),
          title = c("Score", "Count", "Time (min)"),
          palette = list("-YlOrBr", "-YlOrBr", "YlOrBr")) +
  tm_facets(by = "type", free.scales = TRUE) +
  tm_layout(panel.labels = c("Access Score", "Count Within 60 Min", "Time to Nearest (min)"),
            main.title = "Buprenorphine Access Metrics (60 min threshold)")

b


m <- tm_shape(illinois) +
  tm_fill("grey") +
  tm_shape(meth_long_sf) +
  tm_fill("value",
          style = c("jenks", "fixed", "fixed"),
          breaks = list(NULL, c(0, 1, 2, 3, 5, 10, 124), c(0, 30, 45, 60, 120, 240)),
          labels = list(NULL, c("0", "1", "2", "3 to 4", "5 to 9", "10 to 61"), NULL),
          title = c("Score", "Count", "Time (min)"),
          palette = list("-YlOrBr", "-YlOrBr", "YlOrBr")) +
  tm_facets(by = "type", free.scales = TRUE) +
  tm_layout(panel.labels = c("Access Score", "Count Within 30 Min", "Time to Nearest (min)"),
            main.title = "Methadone Access Metrics (30 min threshold)")

m

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
  tm_layout(panel.labels = c("Access Score", "Count Within 30 Min", "Time to Nearest (min)"),
            main.title = "Naltrexone Access Metrics (30 min threshold)")

n

beepr::beep()


