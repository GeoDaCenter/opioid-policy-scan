# Check correlation between min dist and average driving distance

library(tidyverse)
library(sf)

avg_dist_moud <- read_sf("data-output/access_sf.gpkg") %>% 
  select(zip = ZCTA5CE10, contains("dist")) %>% 
  mutate_if(is.double, function(x) x * 0.621371) %>% 
  rename_if(is.double, function(x) str_replace(x, "km", "mi")) %>% 
  mutate(zip = as.numeric(zip))

min_dist_moud <- read_csv("data-output/min-dists-to-zip-centroid.csv") %>% 
  select(Zip, starts_with("MOUD")) %>% 
  `names<-`(., c("zip", "bup_min_dist_mi", "meth_min_dist_mi", "nal_min_dist_mi"))

joined_moud <- right_join(min_dist_moud, avg_dist_moud, by = "zip") %>% 
  select(zip, sort(names(.)), -geom)

# Find correlations between the two
cor(joined_moud$bup_avg_dist_mi, joined_moud$bup_min_dist_mi)
cor(joined_moud$meth_avg_dist_mi, joined_moud$meth_min_dist_mi, use = "complete.obs")
cor(joined_moud$nal_avg_dist_mi, joined_moud$nal_min_dist_mi)


# Make ggplot comparing the two
joined_moud_tidy <- joined_moud %>% 
  pivot_longer(-zip, names_to = "moud_type", values_to = "miles") %>% 
  separate(moud_type, into = c("moud", "access_dist_type")) %>% 
  mutate(zip = as.factor(zip))

labels <- joined_moud_tidy$zip[seq(1, length(joined_moud_tidy$zip), by = 100)]
# https://stackoverflow.com/questions/55033695/x-axis-labels-illegible-display-every-other-label-on-x-axis-ggplot2

ggplot(joined_moud_tidy, aes(x = zip, y = miles, col = access_dist_type)) +
  geom_point() +
  # geom_segment(aes(x = zip, xend = zip, y = 0, yend = miles)) +
  facet_wrap(~moud) +
  scale_x_discrete(breaks = labels) +
  coord_flip()

