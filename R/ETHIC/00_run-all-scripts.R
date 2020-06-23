# Run all scripts at once

# Cleaning scripts --------------------------------------------------------

# cleaning_scripts <- list.files("R/", pattern = "01_", full.names = TRUE) %>% 
#   as.list()
# lapply(cleaning_scripts, source)

source("R/01_clean-bup.R")
source("R/01_clean-er-trauma.R")
source("R/01_clean-hiv-testing.R")
source("R/01_clean-nalox.R")

source("R/02_combine-cleaned.R")
