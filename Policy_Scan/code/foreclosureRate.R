##### INTRO #####

# Author : Susan Paykin
# Date : January 26, 2021
# About: This code will:
# - Load and clean 2008 NSP2 dataset on foreclosures, save datasets for tract
# - load and clean 2014-2018 mean mortgage delingquency rate data, save datasets for county and state

##### Set Up #####

library(sf)
library(tmap)
library(tidyverse)

setwd("~/git/opioid-policy-scan/Policy_Scan")

#### Foreclosure data ----

# Load foreclosure data
# Data description here: https://www.huduser.gov/portal/NSP2datadesc.html

foreclosure1 <- read.csv("data_raw/NSP2 - US Total.csv")
foreclosure2 <- read.csv("data_raw/NSP2 - US Total2.csv")

foreclosure <- rbind(foreclosure1, foreclosure2)
str(foreclosure)

# Relevant variables: geoid, sta, cntyname, 
# nforeclose = Foreclosure Risk Score (range: 1 - 20)
# fordq_rate = Estimated percent of mortgages to start foreclosure process or be seriously delinquent in past 2 years

foreclosure_clean <- foreclosure %>% select(GEOID = geoid, state = sta, cntyname, fordq_rate, nforeclose)

# Convert variable to numeric 
foreclosure_clean$fordq_rate <- as.numeric(sub("%", "", foreclosure$fordq_rate))

# Save dataset
write.csv(foreclosure_clean, "data_final/EC04_T.csv")


#### 90+ Day Delinquency data ---

# Load state data - delinquency rates, mean 2014-2018
mortgages_st_raw <- read.csv("data_raw/StateMortgagesPercent-90-plusDaysLate-thru-2018-12.csv")
head(mortgages_st_raw)

# Save by total rate, mean 2014-2018 delinquency rate
mortgages_st <- mortgages_st_raw %>% select(FIPSCode, Name, delinqR = DelinqR)

# Load county data
mortgages_co_raw <- read.csv("data_raw/CountyMortgagesPercent-90-plusDaysLate-thru-2019-12.csv")
head(mortgages_co_raw)

# Create variable - mean 2014-2018 delinquency rate
mortgages_co_raw <- mortgages_co_raw %>% mutate(delinqR = rowMeans(.[, 6:64]))
mortgages_co_raw$delinqR <- sprintf(mortgages_co_raw$delinqR, fmt = '%#.2f')

# Save total rate, mean 2014-2018 delinquency rate
mortgages_co <- mortgages_co_raw %>% select(FIPSCode, State, Name, delinqR) 

# Save datasets
write.csv(mortgages_st, "data_final/EC04.1_S")
write.csv(mortgages_co, "data_final/EC04.1_C")
  
  