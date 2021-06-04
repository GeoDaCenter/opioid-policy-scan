# Author : Qinyun LIn
# Date : August 25th, 2020
# This code select incarcenation variables from the raw data.
# Revised on June 4th 2021 to add in original counts. 

library(readxl)
library(tidyverse)
library(sf)

# read in raw data
incarceration_trends <- read_excel("data_raw/incarceration_trends.xlsx")

# select jail related variables 
jail_2017 <- incarceration_trends %>% 
  select(fips, yfips, year, state, county_name, 
         total_jail_pop_rate, female_jail_pop_rate, male_jail_pop_rate,
         aapi_jail_pop_rate, black_jail_pop_rate, latinx_jail_pop_rate, native_jail_pop_rate,white_jail_pop_rate, 
         total_jail_adm_rate, total_jail_pretrial_rate, 
         total_jail_pop, female_jail_pop, male_jail_pop,
         aapi_jail_pop, black_jail_pop, latinx_jail_pop, native_jail_pop,white_jail_pop, 
         total_jail_adm, total_jail_pretrial
         ) %>% 
  filter(year=="2017")

prison_2016 <- incarceration_trends %>% 
  select(fips, yfips, year, state, county_name, 
         total_prison_pop_rate, female_prison_pop_rate, male_prison_pop_rate,
         aapi_prison_pop_rate, black_prison_pop_rate, latinx_prison_pop_rate, native_prison_pop_rate,white_prison_pop_rate, 
         total_prison_adm_rate, female_prison_adm_rate, male_prison_adm_rate, 
         aapi_prison_adm_rate, black_prison_adm_rate, latinx_prison_adm_rate, native_prison_adm_rate, white_prison_adm_rate,
         total_prison_pop, female_prison_pop, male_prison_pop,
         aapi_prison_pop, black_prison_pop, latinx_prison_pop, native_prison_pop,white_prison_pop, 
         total_prison_adm, female_prison_adm, male_prison_adm, 
         aapi_prison_adm, black_prison_adm, latinx_prison_adm, native_prison_adm, white_prison_adm) %>% 
  filter(year=="2016")

# check GEOID
county_2018 <- st_read("data_final/geometryFiles/tl_2018_county/counties2018.shp")
county_2018$GEOID[!(county_2018$GEOID %in% jail_2017$fips)]
# "36047" "36081" "36085" "36005"
# these are four counties in New York (Queen, King, Bronx, and Richmond)
county_2018$GEOID[!(county_2018$GEOID %in% prison_2016$fips)]
# same as above
prison_2016$fips[!(prison_2016$fips %in% county_2018$GEOID)]
# 02270 - Wade Hampton Census Area - older name of Kusilvak Census Area in AK (02158)
jail_2017$fips[!(jail_2017$fips %in% county_2018$GEOID)]
# same as above

# remove 02270
jail_2017 <- jail_2017 %>% 
  filter(fips != "02270")
prison_2016 <- prison_2016 %>% 
  filter(fips != "02270")

# rename variables 

colnames(jail_2017) <- c("COUNTYFP", "YFips", "Year", "State", "CountyName", 
         "TtlJlPpr", "FmlJlPpr", "MlJlPpr", "AapiJlPpr", 
         "BlckJlPpr","LtnxJlPpr", "NtvJlPpr", "WhtJlPpr", 
         "TtlJlAdmr", "TtlJlPrtr",
         "TtlJlPp", "FmlJlPp", "MlJlPp", "AapiJlPp", 
         "BlckJlPp","LtnxJlPp", "NtvJlPp", "WhtJlPp", 
         "TtlJlAdm", "TtlJlPrt")

colnames(prison_2016) <- c("COUNTYFP", "YFips", "Year", "State", "CountyName", 
                           "TtlPrPpr", "FmlPrPpr", "MlPrPpr", "AapiPrPpr",
                           "BlckPrPpr","LtnxPrPpr", "NtvPrPpr", "WhtPrPpr",
                           "TtlPrAPpr", "FmlPrAPpr", "MlPrAPpr", "AapiPrAPpr",
                           "BlckPrAPpr","LtnxPrAPpr", "NtvPrAPpr", "WhtPrAPpr",
                           "TtlPrPp", "FmlPrPp", "MlPrPp", "AapiPrPp",
                           "BlckPrPp","LtnxPrPp", "NtvPrPp", "WhtPrPp",
                           "TtlPrAPp", "FmlPrAPp", "MlPrAPp", "AapiPrAPp",
                           "BlckPrAPp","LtnxPrAPp", "NtvPrAPp", "WhtPrAPp")

# Save datasets
write.csv(prison_2016, "data_final/PS01_2016_C.csv")
write.csv(jail_2017, "data_final/PS02_2017_C.csv")
