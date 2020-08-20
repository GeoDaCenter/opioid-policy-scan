# Functions for visualizing IL access

combine_metrics <- function(folder_name, long = FALSE, sf = FALSE) {
  files <- list.files(folder_name, full.names = TRUE)
  
  access_file <- files[str_detect(files, "access")]
  count_file <- files[str_detect(files, "count")]
  time_file <- files[str_detect(files, "time")]
  
  access <- read_csv(access_file)
  #access <- mutate_all(access, round, 2)
  # Need to round scores to 2 degrees otherwise won't plot
  
  count <- read_csv(count_file)
  time <- read_csv(time_file)
  
  all_metrics <- full_join(access, count, by = "X1") %>% 
    full_join(time, by = "X1") %>% 
    mutate(X1 = as.character(X1)) %>% 
    rename(zcta = X1)
  
  if (long) {
    all_metrics <- all_metrics %>%
      pivot_longer(-zcta, names_to = "type")
  }
  
  if (sf) {
    all_metrics <- full_join(zips_simp, all_metrics)
  }
  
  all_metrics
  
}

osrm_wide <- combine_metrics("data/results_using_osrm/")

osrm <- combine_metrics("data/results_using_osrm/", long = TRUE) %>% 
  mutate(engine = "osrm")
logan <- combine_metrics("data/results_using_logans_package/", long = TRUE) %>% 
  mutate(engine = "logan")

both <- full_join(osrm, logan)

# Compare summary stats between two packages
group_by(both, type, engine) %>%   
  filter(str_detect(type, "time")) %>% 
  summarize(min = min(value),
            mean = mean(value),
            median = median(value),
            max = max(value)) %>% 
  ungroup() %>%
  mutate(type = str_remove(type, "time_to_nearest_")) %>% 
  pivot_longer(c(min, mean, median, max),
               names_to = "summary_stat") %>% 
  pivot_wider(names_from = engine,
              values_from = value) %>% 
  group_by(type) %>% 
  gt::gt() %>% 
  gt::fmt_number(columns = vars(logan, osrm), decimals = 2)


# Compare distribution of access time metrics between Logan's pkg and OSRM
both %>% 
  filter(str_detect(type, "time")) %>% 
  mutate(type = str_remove(type, "time_to_nearest_")) %>% 
ggplot(aes(x = value, fill = engine)) +
  geom_histogram(position = "dodge", binwidth = 50) +
  facet_wrap(~type) +
  labs(
    title = "Comparison of Travel Time Access Metrics",
    subtitle = "Time-to-nearest metrics look similar between the two packages",
    x = "Time to Nearest",
    y = "Count",
    fill = "Package Used"
  ) +
  theme_minimal(base_size = 16)

