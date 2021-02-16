#### Set up ----

library(tidyverse)

#### Buprenorphone data ---- 

# Load data
dial_data <- read.csv("data_raw/accesstoDialysis.csv")

# Clean data
dial_data$ZCTA <- sprintf("%05d", dial_data$ZCTA)
