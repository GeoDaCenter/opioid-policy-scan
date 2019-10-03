# Join access proxy variable and buprenorphene capacity spreadsheet by zip

library(tidyverse)
library(readxl)

bup_capacity <- read_excel("data/IL_DATA_WAIVED_PROVIDER_CAPACITY_20190705.xls")

glimpse(bup_capacity) # use provider_30 for this

joined_zip <- left_join(____, bup_capacity, by = c("___" = "zipcode")