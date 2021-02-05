#### Set up ----

library(tidyverse)
library(readr)
library(plyr)

#### Count in 30 min range ----

mydir = "access_count_30"
myfiles = list.files(path = mydir, pattern ="*.csv", full.names = TRUE)

dat_csv <- ldply(myfiles, read_csv)
Count_BM <- dat_csv

Count_BM$GEOID <- sprintf("%05d", Count_BM$GEOID)

#### Travel time ----

mydir_time <- "access_time"
myfiles = list.files(path = mydir_time, pattern ="*.csv", full.names = TRUE)

Time_BM$GEOID <- sprintf("%05d", Time_BM$GEOID)

#### Access score ----

mydir_model <- "access_model_30"
myfiles = list.files(path = mydir_model, pattern ="*.csv", full.names = TRUE)

Model_BM <- ldply(myfiles, read_csv)

Model_BM$GEOID <- sprintf("%05d", Model_BM$GEOID)

#### Merge data ----

bupMeth <- merge(Count_BM, Time_BM, by = "GEOID")
bupMeth <- merge(bupMeth, Model_BM, by = "GEOID")

bup_data <- bupMeth %>% select(GEOID, count_in_range_buprenorphine, time_to_nearest_buprenorphine, buprenorphine_score)

meth_data <- bupMeth %>% select(GEOID, count_in_range_methadone, time_to_nearest_methadone, methadone_score)

#### Save final datasets ----

write.csv(bup_data, "data_final/bup_access.csv")
write.csv(meth_data, "data_final/meth_access.csv")


#### FIN ----


