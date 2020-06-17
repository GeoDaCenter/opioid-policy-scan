# Summary stats by urban / rural
# Non-spatial analysis

library(tidyverse)

# Min dist metrics
all_access_us <- read_csv("data-output/min_dists_all.csv")
str(all_access_us)

## Assign rurality by population density
urban_rural <- mutate(all_access_us, 
                      ALAND10 = 
                        units::set_units(
                          as.numeric(
                            as.character(ALAND10)), 
                          "m^2"),
                      mi2 = units::set_units(ALAND10, "mi^2"),
                      popdensity = as.numeric(poptotal / mi2),
                      rurality = case_when(
                        popdensity < 1000 ~ "rural",
                        popdensity >= 1000 & popdensity <= 3000 ~ "suburban",
                        popdensity > 3000 ~ "urban"))

urban_rural_zips <- urban_rural %>% 
  select(ZCTA5CE10, rurality)

r <- tm_shape(urban_rural) +
  tm_fill("rurality")

tmap_save(r, "output/rurality.png")
beepr::beep()



# Travel Times Metrics ----------------------------------------------------

travel_times <- read_csv("data-output/access_results_combined/access_times.csv") %>% 
  mutate(X = as.character(X))

travel_rurality <- full_join(travel_times, urban_rural_zips, by = c("X" = "ZCTA5CE10")) %>% 
  # why so many NAs? not continental?
  drop_na(rurality) %>% 
  rename(bup = time_to_nearest_buprenorphine,
         meth = time_to_nearest_methadone,
         nal = time_to_nearest_naltrexone)

travel_rurality %>% 
  group_by(rurality) %>%
  # vaguely concerning there are so many NAs
  summarize(bup_dist = mean(bup, na.rm = TRUE),
            bup_sd = sd(bup, na.rm = TRUE),
            meth_dist = mean(meth, na.rm = TRUE),
            meth_sd = sd(meth, na.rm = TRUE),
            nal_dist = mean(nal, na.rm = TRUE),
            nal_sd = sd(nal, na.rm = TRUE)) %>% 
  mutate_if(is.numeric, round, 2) %>% 
  gt::gt()



# Access Model Metrics ----------------------------------------------------

access_model_30 <- read_csv("data-output/access_results_combined/access_model_30.csv") %>% 
  mutate(X = as.character(X))

access_rurality <- full_join(access_model_30, urban_rural_zips, by = c("X" = "ZCTA5CE10")) %>% 
  drop_na(rurality) %>% 
  rename(bup = buprenorphine_score,
         meth = methadone_score,
         nal = naltrexone_score)

access_rurality %>% 
  group_by(rurality) %>%
  summarize(bup_dist = mean(bup, na.rm = TRUE),
            bup_sd = sd(bup, na.rm = TRUE),
            meth_dist = mean(meth, na.rm = TRUE),
            meth_sd = sd(meth, na.rm = TRUE),
            nal_dist = mean(nal, na.rm = TRUE),
            nal_sd = sd(nal, na.rm = TRUE)) %>% 
  mutate_if(is.numeric, round, 2) %>% 
  gt::gt()


# Minimum Distance Metrics ------------------------------------------------

urban_rural %>% 
  group_by(rurality) %>%
  summarize(bup_dist = mean(bup),
            bup_sd = sd(bup),
            meth_dist = mean(meth),
            meth_sd = sd(meth),
            nal_dist = mean(nal),
            nal_sd = sd(nal),
            dialysis_dist = mean(dialysis),
            dialysis_sd = sd(dialysis)) %>% 
  mutate_if(is.numeric, round, 2) %>% 
  gt::gt()


# Pivot the summary stats
urban_rural_long <- urban_rural %>% 
  select(zip = ZCTA5CE10, dialysis, meth, bup, nal, rurality) %>% 
  pivot_longer(-c(zip, rurality), names_to = "resource", values_to = "min_dist") %>% 
  pivot_wider(names_from = rurality, values_from = min_dist) 
  
summary_stats <- urban_rural_long %>% 
  group_by(resource) %>%
  summarize(rural_avg_dist = median(rural, na.rm = TRUE),
            rural_sd = sd(rural, na.rm = TRUE),
            suburban_avg_dist = median(suburban, na.rm = TRUE),
            suburban_sd = sd(suburban, na.rm = TRUE),
            urban_avg_dist = median(urban, na.rm = TRUE),
            urban_sd = sd(urban, na.rm = TRUE)
            ) %>% 
  mutate_if(is.numeric, round, 2)

urban_rural %>% 
  group_by(rurality) %>% 
  count()

gt::gt(summary_stats)

write_csv(summary_stats, "data-output/urban_rural_min_dist_median.csv")

p <- summary_stats %>% 
  pivot_longer(-resource) %>% 
  filter(!str_detect(name, "sd")) %>% 
  ggplot(aes(x = resource, y = value)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  facet_wrap(~name, ncol = 1) +
  labs(title = "Median Distance to Nearest Resource (mi)",
       y = "Distance to Nearest Resource (mi)") +
  ylim(0, 40)


ggsave("output/median-dist-compare.png", width = 5, height = 4)

ggplot(summary_stats, aes(x = resource, y = rural_avg_dist)) +
  geom_col() +
  geom_errorbar(aes(ymax = rural_avg_dist + rural_sd, ymin = rural_avg_dist - rural_sd)) +
  coord_flip() +
  theme_minimal()

ggplot(summary_stats, aes(x = resource, y = suburban_avg_dist)) +
  geom_col() +
  geom_errorbar(aes(ymax = suburban_avg_dist + suburban_sd, ymin = suburban_avg_dist - suburban_sd)) +
  coord_flip() +
  theme_minimal()

ggplot(summary_stats, aes(x = resource, y = urban_avg_dist)) +
  geom_col() +
  geom_errorbar(aes(ymax = urban_avg_dist + urban_sd, ymin = urban_avg_dist - urban_sd)) +
  coord_flip() +
  theme_minimal()






# Sandbox -----------------------------------------------------------------

## Unsuccessful attempts at using micro/metropolitan areas to assign 

# metros <- tigris::metro_divisions() %>% 
#   st_as_sf()
# 
# plot(st_geometry(metros))
# 
# msa <- get_acs(variables = c(medincome = "B19013_001"), 
#                geography = "metropolitan statistical area/micropolitan statistical area")
# 
# metro_micro <- msa %>% 
#   mutate(cba = case_when(
#     str_detect(NAME, "Micro") ~ "micro",
#     str_detect(NAME, "Metro") ~ "metro"
#   )) %>% 
#   select(CBSA = GEOID, cba)
# 
# %>% 
#   count(cba) 
# 
# metro_polygon <- metro_micro %>% 
#   select(-n) %>% 
#   slice(1)
# 
# micro_polygon <- metro_micro %>% 
#   select(-n) %>% 
#   slice(2)
# 
# 
# zip_cbsa <- read_excel("data/ZIP_CBSA_032020.xlsx") %>% 
#   select(ZIP, CBSA)
# 
# zip_metro <- left_join(zip_cbsa, metro_micro) %>% 
#   mutate(ZIP = as.numeric(ZIP),
#          CBSA = as.numeric(CBSA))
# 
# filter(zip_metro, is.na(cba)) %>% skim()
