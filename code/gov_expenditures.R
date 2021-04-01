#### About ----

# This script wrangles and cleans data on state and local government expenditures for the following categories: 
# Public health and hospitals;
# Public welfare;
# Police and fire; and 
# Corrections system.

#### State Spending Data ----

# Load libraries
library(tidyverse)
library(sf)
library(tmap)

# Read in data
state_exp <- read.csv("Policy_Scan/data_raw/gov_expenditures/state_exp_2017.csv")

# Merge with state fips 
state_fips <- states %>% select(STATEFP, State = NAME) %>% st_drop_geometry()
state_exp <- left_join(state_fips, state_exp, by = "State")
str(state_exp)

# Make vars numeric
state_exp[,4:16] <- as.numeric(state_exp[,4.16])

# Create new sum variables
state_exp2 <- state_exp
state_exp2$crrctExp_S <- state_exp %>% select(5:7) %>% rowSums(na.rm = TRUE)
state_exp2$plcFireExp_S <- state_exp$X.E019..Police...Fire.Protection.Dir.Exp
state_exp2$healthExp_S <- state_exp %>% select(8:10) %>% rowSums(na.rm = TRUE)
state_exp2$wlfrExp_S <- state_exp %>% select(11:16) %>% rowSums(na.rm = TRUE)

# Select and rename variables
state_exp_final <- state_exp2 %>% select(geoid = STATEFP, state = State,
                                        crrctExp_S, plcFireExp_S, healthExp_S, wlfrExp_S)

#### Local Spending Data ----

# Read in data
local_exp <- read.csv("Policy_Scan/data_raw/gov_expenditures/local_exp_2017.csv")

# Make vars numeric
local_exp[,4:16] <- as.numeric(local_exp[,4.16])

# Create new sum variables
local_exp2 <- local_exp
local_exp2$crrctExp_L <- local_exp %>% select(5:7) %>% rowSums(na.rm = TRUE)
local_exp2$plcFireExp_L <- local_exp$X.E019..Police...Fire.Protection.Dir.Exp
local_exp2$healthExp_L <- local_exp %>% select(8:10) %>% rowSums(na.rm = TRUE)
local_exp2$wlfrExp_L <- local_exp %>% select(11:16) %>% rowSums(na.rm = TRUE)

# select and rename variables
local_exp_final<- local_exp2 %>% select(state = State, 
                                        crrctExp_L, plcFireExp_L, healthExp_L, wlfrExp_L)

#### Save final dataset ----

# Merge with state totals
state_local_exp_final <- left_join(state_exp_final, local_exp_final, by = "state")

# Sum state and local total spending
state_local_exp_final$crrctExp_T <- state_local_exp_final %>% select(c(3, 7)) %>% rowSums(na.rm = TRUE)
state_local_exp_final$plcFireExp_T <- state_local_exp_final %>% select(c(4, 8)) %>% rowSums(na.rm = TRUE)
state_local_exp_final$healthExp_T <- state_local_exp_final %>% select(c(5, 9)) %>% rowSums(na.rm = TRUE)
state_local_exp_final$wlfrExp_T <- state_local_exp_final %>% select(c(6, 10)) %>% rowSums(na.rm = TRUE)

# Save data 
write.csv(state_local_exp_final, "Policy_Scan/data_final/PS11_S.csv")

