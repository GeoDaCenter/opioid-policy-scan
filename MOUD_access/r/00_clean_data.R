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
meth_data_us$GEOID <- as.numeric(meth_data_us$ZCTA)

## data <- left_join(data, bup_data_us, by = c("ZIP_CODE" = "ZCTA"))
data <- left_join(data, meth_data_us, by = c("originGEOID" = "GEOID"))

###summary(data$time_to_nearest_buprenorphine)
## data$time_to_nearest_buprenorphine <- 
##  ifelse(data$time_to_nearest_buprenorphine == 999, NA, data$time_to_nearest_buprenorphine)

summary(data$time_to_nearest_methadone)
data$time_to_nearest_methadone <- 
  ifelse(data$time_to_nearest_methadone == 999, NA, data$time_to_nearest_methadone)

summary(data$`time_to_nearest_naltrexone/vivitrol`)
data$`time_to_nearest_naltrexone/vivitrol` <- 
  ifelse(data$`time_to_nearest_naltrexone/vivitrol` == 999, NA, data$`time_to_nearest_naltrexone/vivitrol`)

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

###### fix the problem for one zip code may relate to multiple tracts because of same RES_RATIO

data <- read_csv("data_final/allaccess_SVI_rurality.csv")
 
data <- data %>% 
  select(-starts_with("RPL_THEME"), -TRACT) %>% 
  distinct()

library(readxl)
ZIP_TRACT_122020 <- read_excel("data_raw/ZIP_TRACT_122020.xlsx", 
                               col_types = c("text", "text", "numeric", "numeric", "numeric", "numeric"))

ZIP_TRACT <- ZIP_TRACT_122020 %>%
  select(ZIP, TRACT, TOT_RATIO)
  
SVI2018_US <- read_csv("data_raw/SVI2018_US.csv") 
SVI <- SVI2018_US %>% 
  select(FIPS, RPL_THEME1, RPL_THEME2, RPL_THEME3, RPL_THEME4, RPL_THEMES)

SVI$RPL_THEME1[SVI$RPL_THEME1 == -999] <- NA
SVI$RPL_THEME2[SVI$RPL_THEME2 == -999] <- NA
SVI$RPL_THEME3[SVI$RPL_THEME3 == -999] <- NA
SVI$RPL_THEME4[SVI$RPL_THEME4 == -999] <- NA
SVI$RPL_THEMES[SVI$RPL_THEMES == -999] <- NA

SVI_ZIP <- SVI %>% 
  group_by(ZIP) %>% 
  mutate(SVI1 = weighted.mean(RPL_THEME1, w = TOT_RATIO, na.rm = T),
         SVI2 = weighted.mean(RPL_THEME2, w = TOT_RATIO, na.rm = T),
         SVI3 = weighted.mean(RPL_THEME3, w = TOT_RATIO, na.rm = T),
         SVI4 = weighted.mean(RPL_THEME4, w = TOT_RATIO, na.rm = T),
         SVIS = weighted.mean(RPL_THEMES, w = TOT_RATIO, na.rm = T)) %>% 
  select(ZIP, starts_with("SVI")) %>% 
  distinct()
 
SVI_ZIP$GEOID <- as.numeric(SVI_ZIP$ZIP) 
data <- left_join(data, SVI_ZIP, by = c("originGEOID" = "GEOID")) %>% 
  select(-ZIP_CODE, -ZCTA, -ZIP)

write_csv(data, "data_final/allaccess_SVI_rurality.csv")



