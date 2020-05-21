library(tidycensus)
library(dplyr)

# Before this code works, you need to set up a Census API key, see info here: https://walkerke.github.io/tidycensus/articles/basic-usage.html

# Look at variables
vars <- load_variables(2018, "acs5", cache = TRUE)
View(vars)

sample <- get_acs(geography = "zcta", variables = c(
  "B01001_007", "B01001_008", "B01001_009", "B01001_010", "B01001_011", "B01001_012", "B01001_013", "B01001_031",
  "B01001_032", "B01001_033", "B01001_034", "B01001_035", "B01001_036", "B01001_037"), cache_table = TRUE)

atrisk <- sample %>% 
  group_by(GEOID) %>% 
  summarize(total_18_39 = sum(estimate))

# population 16-40
# zip code level
# dp02/dp03

atrisk <- write.csv(atrisk, file = "data-output/atrisk.csv")
