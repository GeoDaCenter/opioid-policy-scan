# Author : Qinyun LIn
# Date : Jan 10th, 2021
# This code clean medicaid expenditure variables from the raw data. 

library(readxl)
library(tidyverse)
library(sf)
library(stringr)

# read in raw data
raw_data_medicaid_exp <- read_csv("data_raw/raw_data_medicaid_exp.csv", 
                                 col_types = cols(`Total Medicaid Spending` = col_character()))

# generate a new column for the expenditure
raw_data_medicaid_exp$expnum <- str_remove(raw_data_medicaid_exp$`Total Medicaid Spending`, "[$]")
raw_data_medicaid_exp$expnum <- as.numeric(gsub(",", "",  raw_data_medicaid_exp$expnum))

# check GEOID
state_2018 <- st_read("data_final/geometryFiles/tl_2018_state/states2018.shp")
state_2018$NAME[!(state_2018$NAME %in% raw_data_medicaid_exp$Location)]
raw_data_medicaid_exp$Location[!(raw_data_medicaid_exp$Location %in%state_2018$NAME)]
raw_data_medicaid_exp <- raw_data_medicaid_exp[-1,] # remove the row for United States


# add GEOID to the data file
state_2018_GEOID <- state_2018 %>% 
  select(GEOID, NAME)

raw_data_medicaid_exp <- merge(state_2018_GEOID, raw_data_medicaid_exp, by.x = "NAME", by.y = "Location") 
raw_data_medicaid_exp  <- as.data.frame(raw_data_medicaid_exp)
raw_data_medicaid_exp$geometry <- NULL
raw_data_medicaid_exp$NAME <- NULL
raw_data_medicaid_exp$Year <- "2019"

# rename variables 
colnames(raw_data_medicaid_exp) <- c("STATEFP", 
                        "TtlMedExpC", "TtlMedExpN", "Year")

# Save final dataset
write.csv(raw_data_medicaid_exp,"data_final/PS06_2019_S.csv", row.names = FALSE)






