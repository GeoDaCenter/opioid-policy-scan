describeBy(data, data$rurality)

library(readr) 
library(tidyverse)
library(Hmisc)

allaccess_SVI_rurality <- read_csv("data_final/allaccess_SVI_rurality.csv", col_types = cols(minDialysis = col_number()))

# data <- allaccess_SVI_rurality %>% 
#  select(starts_with("min"), starts_with("count"), starts_with("time"), ends_with("_score"), rurality)

data <- allaccess_SVI_rurality %>% 
  select(starts_with("count"), starts_with("time"), rurality)

# col_order <- c("minDisNalV", "minDisMet", "minDialysis", "minDisBup",                           
#               "count_in_range_naltrexone/vivitrol", "count_in_range_methadone",
#               "time_to_nearest_naltrexone/vivitrol", "time_to_nearest_methadone",
#               "naltrexone/vivitrol_score", "methadone_score", "rurality")
# data_order <- data[, col_order]

col_order <- c( "count_in_range_methadone",  "count_in_range_naltrexone/vivitrol", "count_in_range_dialysis", "count_in_range_buprenorphine",
               "time_to_nearest_methadone", "time_to_nearest_naltrexone/vivitrol", "time_to_nearest_dialysis", "time_to_nearest_buprenorphine", 
               "rurality")
 data_order <- data[, col_order]

library(gtsummary)

theme_set(theme_bw(base_size=12))
 
table <- tbl_summary(
  data_order,
  by = rurality, 
  missing = "no",
  digits = all_continuous() ~ 2,
  label = list('count_in_range_methadone' ~ "count (Methadone)",
               'count_in_range_naltrexone/vivitrol' ~ "count (Naltrexone/Vivitrol)",
               'count_in_range_dialysis' ~ "count (Dialysis)",
               'count_in_range_buprenorphine' ~ "count (Buprenorphine)",
               'time_to_nearest_methadone' ~ "Time (Methadone)",
               'time_to_nearest_naltrexone/vivitrol' ~ "Time (Naltrexone/Vivitrol)",
               'time_to_nearest_dialysis' ~ "Time (Dialysis)",
               'time_to_nearest_buprenorphine' ~ "Time (Buprenorphine)")
) %>% 
  add_n() %>% 
  add_p() %>% 
  modify_header(label = "**Variable**") %>% # update the column header
  bold_labels() 
table

library(gtools)

data <- allaccess_SVI_rurality %>% 
  select(starts_with("time"), starts_with("SVI"), rurality)

data$theme1_qr <- quantcut(data$SVI1, q = 4, na.rm = T)          
data$theme2_qr <- quantcut(data$SVI2, q = 4, na.rm = T)          
data$theme3_qr <- quantcut(data$SVI3, q = 4, na.rm = T)          
data$theme4_qr <- quantcut(data$SVI4, q = 4, na.rm = T)          
data$themes_qr <- quantcut(data$SVIS, q = 4, na.rm = T)  
data$`time_to_nearest_naltrexone/vivitrol` 

th1 <- data %>% 
  group_by(rurality, theme1_qr) %>% 
  summarise(Meth = median(time_to_nearest_methadone, na.rm = T),
            NalV = median(`time_to_nearest_naltrexone/vivitrol`, na.rm = T),
            Dialysis = median(time_to_nearest_dialysis, na.rm = T),
            Buprenorphine = median(time_to_nearest_buprenorphine, na.rm = T)) %>% 
  filter(!is.na(theme1_qr))

th2 <- data %>% 
  group_by(rurality, theme2_qr) %>% 
  summarise(Meth = median(time_to_nearest_methadone, na.rm = T),
            NalV = median(`time_to_nearest_naltrexone/vivitrol`, na.rm = T),
            Dialysis = median(time_to_nearest_dialysis, na.rm = T),
            Buprenorphine = median(time_to_nearest_buprenorphine, na.rm = T)) %>% 
  filter(!is.na(theme2_qr))

th3 <- data %>% 
  group_by(rurality, theme3_qr) %>% 
  summarise(Meth = median(time_to_nearest_methadone, na.rm = T),
            NalV = median(`time_to_nearest_naltrexone/vivitrol`, na.rm = T),
            Dialysis = median(time_to_nearest_dialysis, na.rm = T),
            Buprenorphine = median(time_to_nearest_buprenorphine, na.rm = T)) %>% 
  filter(!is.na(theme3_qr))

th4 <- data %>% 
  group_by(rurality, theme4_qr) %>% 
  summarise(Meth = median(time_to_nearest_methadone, na.rm = T),
            NalV = median(`time_to_nearest_naltrexone/vivitrol`, na.rm = T),
            Dialysis = median(time_to_nearest_dialysis, na.rm = T),
            Buprenorphine = median(time_to_nearest_buprenorphine, na.rm = T)) %>% 
  filter(!is.na(theme4_qr))






##########################
minDis_th1 <- data %>% 
  group_by(rurality, theme1_qr) %>% 
  summarise(minDisMeth_mean = mean(minDisMet, na.rm = T),
            minDisBup_mean = mean(minDisBup, na.rm = T),
            minDisNalV_mean = mean(minDisNalV, na.rm = T)) %>% 
  filter(!is.na(theme1_qr))

minDis_th2 <- data %>% 
  group_by(rurality, theme2_qr) %>% 
  summarise(minDisMeth_mean = mean(minDisMet, na.rm = T),
            minDisBup_mean = mean(minDisBup, na.rm = T),
            minDisNalV_mean = mean(minDisNalV, na.rm = T)) %>% 
  filter(!is.na(theme2_qr))

minDis_th3 <- data %>% 
  group_by(rurality, theme3_qr) %>% 
  summarise(minDisMeth_mean = mean(minDisMet, na.rm = T),
            minDisBup_mean = mean(minDisBup, na.rm = T),
            minDisNalV_mean = mean(minDisNalV, na.rm = T)) %>% 
  filter(!is.na(theme3_qr))

minDis_th4 <- data %>% 
  group_by(rurality, theme4_qr) %>% 
  summarise(minDisMeth_mean = mean(minDisMet, na.rm = T),
            minDisBup_mean = mean(minDisBup, na.rm = T),
            minDisNalV_mean = mean(minDisNalV, na.rm = T)) %>% 
  filter(!is.na(theme4_qr))
