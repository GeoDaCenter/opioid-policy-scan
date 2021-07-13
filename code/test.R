# Test script

library(tidyverse)

test_data <- read.csv("data_raw/county_RUCA_rurality.csv")

write.csv(test_data, "data_final/test.csv")
