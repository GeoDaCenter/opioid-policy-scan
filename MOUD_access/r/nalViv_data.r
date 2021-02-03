#### Set up ----

library(tidyverse)

##### Load and clean data ----

# Read in data
NalViv_data <- read.csv("data_raw/NaltrexoneVivtrolCalcs_fromMoksha/accesstoNalVivitrol.csv")

# Make ZCTA character and add leading 0 
NalViv_data$ZCTA <- sprintf("%05d", NalViv_data$ZCTA)

##### Save data ####

write.csv(NalViv_data, "data_final/nalviv_access.csv")

