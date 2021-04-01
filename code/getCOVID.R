# Author : Qinyun Lin
# Date : March 12th, 2021
# This code rename variables from covid data. 

library(readr)
library(tidyverse)
library(lubridate)

COVID01_S <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_state_culmulative.csv", col_types = cols(X1 = col_skip()))
COVID01_S <- COVID01_S %>% 
  select(-c(state_name, state_abbr))
names(COVID01_S)[1] <- "GEOID"
x <- names(COVID01_S)[2:409]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID01_S)[2:409] <-paste("Cm", x, sep = "")
write.csv(COVID01_S, "Policy_Scan/data_final/COVID01_S.csv", row.names = F)

COVID01_C <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_county_culmulative.csv", col_types = cols(X1 = col_skip()))
COVID01_C <- COVID01_C %>% 
  select(-c(STATEFP, NAME, state_name, state_abbr))
names(COVID01_C)[1] <- "GEOID"
x <- names(COVID01_C)[2:ncol(COVID01_C)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID01_C)[2:ncol(COVID01_C)] <-paste("Cm", x, sep = "")
write.csv(COVID01_C, "Policy_Scan/data_final/COVID01_C.csv", row.names = F)

COVID02_S <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_state_culmulative_population.csv", col_types = cols(X1 = col_skip()))
COVID02_S <- COVID02_S %>% 
  select(-c(state_name, state_abbr))
names(COVID02_S)[1] <- "GEOID"
x <- names(COVID02_S)[3:ncol(COVID02_S)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID02_S)[3:ncol(COVID02_S)] <-paste("CmAd", x, sep = "")
write.csv(COVID02_S, "Policy_Scan/data_final/COVID02_S.csv", row.names = F)

COVID02_C <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_county_culmulative_population.csv", col_types = cols(X1 = col_skip()))
COVID02_C <- COVID02_C %>% 
  select(-c(STATEFP, NAME, state_name, state_abbr))
names(COVID02_C)[1] <- "GEOID"
x <- names(COVID02_C)[3:ncol(COVID02_C)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID02_C)[3:ncol(COVID02_C)] <-paste("CmAd", x, sep = "")
write.csv(COVID02_C, "Policy_Scan/data_final/COVID02_C.csv", row.names = F)


COVID03_S <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_state_seven_day.csv", col_types = cols(X1 = col_skip()))
COVID03_S <- COVID03_S %>% 
  select(-c(state_name, state_abbr))
names(COVID01_S)[1] <- "GEOID"
x <- names(COVID03_S)[2:ncol(COVID03_S)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID03_S)[2:ncol(COVID03_S)] <-paste("Wk", x, sep = "")
write.csv(COVID03_S, "Policy_Scan/data_final/COVID03_S.csv", row.names = F)

COVID03_C <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_county_seven_day.csv", col_types = cols(X1 = col_skip()))
COVID03_C <- COVID03_C %>% 
  select(-c(STATEFP, NAME, state_name, state_abbr))
names(COVID03_C)[1] <- "GEOID"
x <- names(COVID03_C)[2:ncol(COVID03_C)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID03_C)[2:ncol(COVID03_C)] <-paste("Wk", x, sep = "")
write.csv(COVID03_C, "Policy_Scan/data_final/COVID03_C.csv", row.names = F)

COVID04_S <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_state_seven_day_population.csv", col_types = cols(X1 = col_skip()))
COVID04_S <- COVID04_S %>% 
  select(-c(state_name, state_abbr))
names(COVID04_S)[1] <- "GEOID"
x <- names(COVID04_S)[3:ncol(COVID04_S)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID04_S)[3:ncol(COVID04_S)] <-paste("WkAd", x, sep = "")
write.csv(COVID04_S, "Policy_Scan/data_final/COVID04_S.csv", row.names = F)

COVID04_C <- read_csv("Policy_Scan/data_raw/NYT_data[9]/nyt_county_seven_day_population.csv", col_types = cols(X1 = col_skip()))
COVID04_C <- COVID04_C %>% 
  select(-c(STATEFP, NAME, state_name, state_abbr))
names(COVID04_C)[1] <- "GEOID"
x <- names(COVID04_C)[3:ncol(COVID04_C)]
x <- ymd(x)
x <- x %>% 
  format('%y%m%d')
colnames(COVID04_C)[3:ncol(COVID04_C)] <-paste("WkAd", x, sep = "")
write.csv(COVID04_C, "Policy_Scan/data_final/COVID04_C.csv", row.names = F)
