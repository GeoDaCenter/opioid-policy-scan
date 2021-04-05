# Author : Qinyun LIn
# Date : Jan 10th, 2021
# This code clean medicaid expenditure variables from the raw data. 

library(readxl)
library(tidyverse)
library(sf)
library(stringr)

# read in raw data
medi_expan <- read_csv("data_raw/raw_data_medi_expan.csv")

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$NAME[!(state_2018$NAME %in% medi_expan$Location)]
medi_expan$Location[!(medi_expan$Location %in%state_2018$NAME)]
medi_expan <- medi_expan[-1,] # remove the row for United States

# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, NAME)

medi_expan <- merge(state_2018_GEOID, medi_expan, by.x = "NAME", by.y = "Location") 
medi_expan  <- as.data.frame(medi_expan)
medi_expan$geometry <- NULL
medi_expan$NAME <- NULL
medi_expan$Year <- "2018"

# rename variables 
colnames(medi_expan) <- c("STATEFP", 
                        "TtlMedExp", "TradFedExp", "TradSttExp", 
                        "ExpnFedExp", "ExpnSttExp", "Year")

# Save final dataaset
write.csv(medi_expan,"data_final/PS07_2018_S.csv", row.names = FALSE)






