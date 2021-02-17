library(readr)
library(tidyverse)

accesstoNalVivitrol <- read_csv("data_raw/NaltrexoneVivtrolCalcs_fromMoksha/accesstoNalVivitrol.csv")
minDis <- read_csv("data_raw/Access01_Z.csv", col_types = cols(originGEOID = col_double()))
minDis <- minDis %>% 
  select(-"minDisBup")
rurality <- read_csv("data_raw/HS02_RUCA_Z.csv", col_types = cols(RUCA1 = col_skip(), RUCA2 = col_skip()))
rurality$GEOID <- as.numeric(rurality$ZIP_CODE)
minDis <- left_join(minDis, rurality, by = c("originGEOID" = "GEOID"))
 ## notice that there are zip code areas that are missing 
data <- left_join(minDis, accesstoNalVivitrol, by = c("originGEOID" = "ZCTA"))
 ## notice that the travel time has 0 and 999? 

## bup_data_us <- read_csv("data_final/bup_access.csv", col_types = cols(ZCTA = col_character()))
## bup_data_us$X1 <- NULL

meth_data_us <- read_csv("data_final/meth_access.csv", col_types = cols(ZCTA = col_character()))
meth_data_us$X1 <- NULL

## data <- left_join(data, bup_data_us, by = c("ZIP_CODE" = "ZCTA"))
data <- left_join(data, meth_data_us, by = c("ZIP_CODE" = "ZCTA"))

###summary(data$time_to_nearest_buprenorphine)
## data$time_to_nearest_buprenorphine <- 
##  ifelse(data$time_to_nearest_buprenorphine == 999, NA, data$time_to_nearest_buprenorphine)

summary(data$time_to_nearest_methadone)
data$time_to_nearest_methadone <- 
  ifelse(data$time_to_nearest_methadone == 999, NA, data$time_to_nearest_methadone)

summary(data$`time_to_nearest_naltrexone/vivitrol`)
data$`time_to_nearest_naltrexone/vivitrol` <- 
  ifelse(data$`time_to_nearest_naltrexone/vivitrol` == 999, NA, data$`time_to_nearest_naltrexone/vivitrol`)

SVI2018_US <- read_csv("data_raw/SVI2018_US.csv") 
SVI <- SVI2018_US %>% 
  select(FIPS, RPL_THEME1, RPL_THEME2, RPL_THEME3, RPL_THEME4, RPL_THEMES)

library(readxl)
ZIP_TRACT_122020 <- read_excel("data_raw/ZIP_TRACT_122020.xlsx", 
                               col_types = c("text", "text", "numeric", "numeric", "numeric", "numeric"))

ZIP_TRACT <- ZIP_TRACT_122020 %>% 
  group_by(ZIP) %>% 
  filter(RES_RATIO == max(RES_RATIO)) %>% 
  select(ZIP, TRACT)

data <- left_join(data, ZIP_TRACT, by = c("ZIP_CODE" = "ZIP"))
data <- left_join(data, SVI, by = c("TRACT" = "FIPS"))

data$RPL_THEME1[data$RPL_THEME1 == -999] <- NA
data$RPL_THEME2[data$RPL_THEME2 == -999] <- NA
data$RPL_THEME3[data$RPL_THEME3 == -999] <- NA
data$RPL_THEME4[data$RPL_THEME4 == -999] <- NA
data$RPL_THEMES[data$RPL_THEMES == -999] <- NA

minDistDialy <- read_csv("intmed_output/Access_Dialysis_Z.csv")

data <- left_join(data, minDistDialy, by = "originGEOID")

Access_Bup_Z_minDist <- read_csv("intmed_output/Access_Bup_Z_minDist.csv")
data <- left_join(data, Access_Bup_Z_minDist, by = "originGEOID")

write_csv(data, "data_final/allaccess_SVI_rurality_missingBupAdAccess.csv")

## 0216 - add in updated bup advanced access metrics and dialysis advanced metrics
data <- read_csv("data_final/allaccess_SVI_rurality_missingBupAdAccess.csv")

bup_adaccess <- bup_adaccess <- read_csv("data_final/bup_access.csv", col_types = cols(X1 = col_skip()))
data <- left_join(data, bup_adaccess, by = c("originGEOID" = "ZCTA"))

summary(data$time_to_nearest_buprenorphine)
data$time_to_nearest_buprenorphine <- 
  ifelse(data$time_to_nearest_buprenorphine == 999, NA, data$time_to_nearest_buprenorphine)

access_Dialysis <- read_csv("data_raw/accesstoDialysis.csv")
data <- left_join(data, access_Dialysis, by = c("originGEOID" = "ZCTA")) 

summary(data$time_to_nearest_dialysis)
data$time_to_nearest_dialysis <- 
  ifelse(data$time_to_nearest_dialysis == 999, NA, data$time_to_nearest_dialysis)

write_csv(data, "data_final/allaccess_SVI_rurality.csv")



