describeBy(data, data$rurality)

library(readr) 
library(tidyverse)
library(Hmisc)

allaccess_SVI_rurality <- read_csv("data_final/allaccess_SVI_rurality.csv", col_types = cols(minDialysis = col_number()))

data <- allaccess_SVI_rurality %>% 
  select(starts_with("min"), starts_with("count"), starts_with("time"), ends_with("_score"), rurality)

library(gtsummary)
table <- tbl_summary(
  data,
  by = rurality, 
  missing = "no",
  digits = all_continuous() ~ 2,
) %>% 
  add_n() %>% 
  add_p() %>% 
  modify_header(label = "**Variable**") %>% # update the column header
  bold_labels() 



library(gtools)

data$theme1_qr <- quantcut(data$RPL_THEME1, q = 4, na.rm = T)          
data$theme2_qr <- quantcut(data$RPL_THEME2, q = 4, na.rm = T)          
data$theme3_qr <- quantcut(data$RPL_THEME3, q = 4, na.rm = T)          
data$theme4_qr <- quantcut(data$RPL_THEME4, q = 4, na.rm = T)          
data$themes_qr <- quantcut(data$RPL_THEMES, q = 4, na.rm = T)          

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
