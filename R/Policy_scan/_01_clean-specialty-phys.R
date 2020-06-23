# Clean specialty physicians

library(tidyverse)
library(readxl)
library(sf)

specialty <- read_csv("data/Specialists Data - Data.csv")

# How many doctors have 1, 2, or 3 specialties?
num_specialties <- specialty %>% 
  group_by(Zip, `First Name`, `Last Name`) %>% 
  count() 

num_specialties %>% 
  ggplot(aes(x = n)) +
  geom_histogram()

num_specialties %>% 
  group_by(n) %>% 
  count()

  