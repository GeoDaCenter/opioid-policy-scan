# Get pop (18-64 and total) by zip code

library(tidycensus)
library(tidyverse)

v18 <- load_variables(2018, "acs5", cache = TRUE)
# View(v18)
pop18_64vars <- c(v18$name[9:21], v18$name[33:45])

pop18_64 <- get_acs(geography = "zcta",
                    variables = pop18_64vars)
poptotal <- get_acs(geography = "zcta",
                    variables = "B01001_001") %>% 
  select(GEOID, poptotal = estimate)

head(pop18_64)

# 2014-2018 ACS, ages 18-64 (could also do 15-64?)
pop_by_zip <- pop18_64 %>% 
  group_by(GEOID) %>% 
  summarize(pop18_64 = sum(estimate)) %>% 
  full_join(poptotal)

write_csv(pop_by_zip, "data-output/pop_by_zip.csv")
