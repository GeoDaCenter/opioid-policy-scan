### Author: Ashlynn Wimer
### Date: 8/14/2024
### About: This script takes tract level MOUD access metrics and attaches
###        them to the tract level tables.

# TODO: fix data loss on moud_latest.
#       as is, about ~40 data-containing entries are dropped
#       due to mismatch between 2018 and 2010 tracts. some should
#       be saveable!

library(dplyr)

clean_hist_access <- function(data) {
  data <- data |> 
    select('HEROP_ID',
           'MetRm30'='raam30',
           'MetRm60'='raam60',
           'MetRm90'='raam90') |>
    mutate(HEROP_ID = substr(HEROP_ID, 1, 16))
  
  return(data)
}

### Read in and clean access data ---

access1984 <- read.csv('../data_raw/Access_Gravity/access_met_1984.csv') |>
  clean_hist_access()

access1990 <- read.csv('../data_raw/Access_Gravity/access_met_1984.csv') |>
  clean_hist_access()

access2000 <- read.csv('../data_raw/Access_Gravity/access_met_1984.csv') |>
  clean_hist_access()

access2010 <- read.csv('../data_raw/Access_Gravity/access_met_1984.csv') |>
  clean_hist_access()

# organized differently than more historic data
access_latest <- read.csv('../data_raw/Access_Gravity/Access_Gravity.csv') |>
  mutate(HEROP_ID = substr(HEROP_I, 1, 16)) |>
  select("HEROP_ID", "BupRm30", "BupRm60", 
         "BupRm90", "MetRm30", "MetRm60", 
         "MetRm90", "NalRm30", "NalRm60", 
         "NalRm90")

### Read in tract data -----

T_1980   <- read.csv('../data_final/full_tables/T_1980.csv')
T_1990   <- read.csv('../data_final/full_tables/T_1990.csv')
T_2000   <- read.csv('../data_final/full_tables/T_2000.csv')
T_2010   <- read.csv('../data_final/full_tables/T_2010.csv')
T_Latest <- read.csv('../data_final/full_tables/T_Latest.csv')

### Merge and save ----

merged1984   <- left_join(T_1980,   access1984,   "HEROP_ID")
merged1990   <- left_join(T_1990,   access1990,   "HEROP_ID")
merged2000   <- left_join(T_2000,   access2000,   "HEROP_ID")
merged2010   <- left_join(T_2010,   access2010,   "HEROP_ID")
mergedLatest <- left_join(T_Latest, access_latest, "HEROP_ID")

write.csv(merged1984,   '../data_final/full_tables/T_1980.csv',   row.names=FALSE)
write.csv(merged1990,   '../data_final/full_tables/T_1990.csv',   row.names=FALSE)
write.csv(merged2000,   '../data_final/full_tables/T_2000.csv',   row.names=FALSE)
write.csv(merged2010,   '../data_final/full_tables/T_2010.csv',   row.names=FALSE)
write.csv(mergedLatest, '../data_final/full_tables/T_Latest.csv', row.names=FALSE)