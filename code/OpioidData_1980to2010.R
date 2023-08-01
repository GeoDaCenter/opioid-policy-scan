# Author : Caglayan Bal
# Date : August 19, 2022
# About : This piece of code will merge the 1980, 1990, 2000 and 2010 demography,
# economic, and housing data on county level for policy scan based on the 1980
# on 2010 geographies, 1990 on 2010 geographies, 2000 on 2010 geographies and
# 2010 decennial census. The missing data in the 2010 decennial census is pulled 
# from the 2010 ACS 5-year estimates.
# This piece of code will create the data in long and wide formats.

# Libraries
library(dplyr)
library(readr)
library(purrr)
library(reshape2)

# Long format

## Alternative 1: Merging the variables by each year

# Merge the 1980 variables 
# Files: DS01_C_1980_DC.csv, EC03_C_1980_DC.csv, HS01_C_1980_DC.csv

data_join80 <- list.files(path="~/Desktop/1980", 
                 full.names = TRUE) %>%
  lapply(read_csv) %>%
  reduce(full_join, by = c("NAME", "FIPS", "year")) %>%
  select(-...1.x, -...1.y, -...1)

write.csv(data_join80, "~/Desktop/data_join80.csv")


# Merge the 1990 variables
# Files: DS01_C_1990_DC.csv, EC03_C_1990_DC.csv, HS01_C_1990_DC.csv

data_join90 <- list.files(path="~/Desktop/1990", 
                          full.names = TRUE) %>%
  lapply(read_csv) %>%
  reduce(full_join, by = c("NAME", "FIPS", "year"))  %>%
  select(-...1.x, -...1.y, -...1)

write.csv(data_join90, "~/Desktop/data_join90.csv")

# Merge the 2000 variables
# Files: DS01_C_2000_DC.csv, EC03_C_2000_DC.csv, HS01_C_2000_DC.csv

data_join2000 <- list.files(path="~/Desktop/2000", 
                          full.names = TRUE) %>%
  lapply(read_csv) %>%
  reduce(full_join, by = c("NAME", "FIPS", "year"))  %>%
  select(-...1.x, -...1.y, -...1)

write.csv(data_join2000, "~/Desktop/data_join2000.csv")

# Merge the 2010 variables
# Files: DS01_C_2010_DC_ACS.csv, EC03_C_2010_DC_ACS.csv, HS01_C_2010_DC.csv

data_join2010 <- list.files(path="~/Desktop/2010", 
                            full.names = TRUE) %>%
  lapply(read_csv) %>%
  reduce(full_join, by = c("NAME", "FIPS", "year"))  %>%
  select(-...1.x, -...1.y, -...1)

write.csv(data_join2010, "~/Desktop/data_join2010.csv")

# Merge all the variables
# Files: data_join80.csv, data_join90.csv, data_join2000.csv, data_join2010.csv

data_join_long <- list.files(path="~/Desktop/DataJoin", 
                            full.names = TRUE) %>%
  lapply(read_csv) %>%
  reduce(full_join) %>%
  select(-...1)


## Alternative 2: Merging all the variables
# Files: DS01_C_1980_DC.csv, EC03_C_1980_DC.csv, HS01_C_1980_DC.csv,
# DS01_C_1990_DC.csv, EC03_C_1990_DC.csv, HS01_C_1990_DC.csv, 
# DS01_C_2000_DC.csv, EC03_C_2000_DC.csv, HS01_C_2000_DC.csv,
# DS01_C_2010_DC_ACS.csv, EC03_C_2010_DC_ACS.csv, HS01_C_2010_DC.csv

# data_join_long <- data_join_long <- list.files(path="~/Desktop/DataJoin1", 
#                                               full.names = TRUE) %>%
# lapply(read_csv) %>%
# reduce(full_join) %>%
# select(-...1)


# Save the data

write.csv(data_join_long, "~/Desktop/OpioidDataLong.csv")


# Wide format

# Switch from the long to the wide format

data_join_wide <- dcast(melt(data_join_long,
                             id.vars = c("NAME", "FIPS", "year")),
                        NAME+FIPS~variable+year)
  
# Save the data

write.csv(data_join_wide, "~/Desktop/OpioidDataWide.csv")
