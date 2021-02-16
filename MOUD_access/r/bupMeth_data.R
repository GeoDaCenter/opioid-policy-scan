#### Set up ----

library(tidyverse)

#### Buprenorphone data ---- 

# Load data
bup_data <- read.csv("data_raw/accesstoBup.csv")

# Clean data
bup_data$ZCTA <- sprintf("%05d", bup_data$ZCTA)

#### Methadone data ----

# Load data
meth_data <- read.csv("data_raw/accesstoMeth.csv")

# Clean data
meth_data$ZCTA <- sprintf("%05d", meth_data$ZCTA)

# Merge data
bupMeth <- merge(bup_data, meth_data, by = "ZCTA")

#### Save datasets ----
write.csv(bup_data, "data_final/bup_access.csv")
write.csv(meth_data, "data_final/meth_access.csv")

#### FIN ----


