library(readr) 
library(corrplot)
library(tidyverse)
library(Hmisc)

allaccess_SVI_rurality <- read_csv("data_final/allaccess_SVI_rurality.csv", col_types = cols(minDialysis = col_number()))

data <- allaccess_SVI_rurality %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("RPL"))


names(data) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                 "timNalV", "timMet", "timBup", "timDia",
                 "SVI1", "SVI2", "SVI3", "SVI4", "SVI")

data_cor <- cor(data, use = "pairwise.complete.obs")
corrplot.mixed(data_cor)

data_corp <- rcorr(as.matrix(data)) 
corrplot(data_corp$r, method = "square",  
         p.mat = data_corp$P, sig.level = 0.001, insig = "blank")


### stratify by rurality to see if any difference

##### urban
data_urban <- allaccess_SVI_rurality %>% 
  filter(rurality == "Urban") %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("RPL"), -c("RPL_THEMES"))

names(data_urban) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                       "timNalV", "timMet", "timBup", "timDia",
                       "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_urban <- cor(data_urban, use = "pairwise.complete.obs")
corrplot.mixed(data_cor_urban)

data_cor_urbanp <- rcorr(as.matrix(data_urban)) 
corrplot(data_cor_urbanp$r, method = "square", 
         p.mat = data_cor_urbanp$P, sig.level = 0.001, insig = "blank")


##### suburban
data_suburban <- allaccess_SVI_rurality %>% 
  filter(rurality == "Suburban") %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("RPL"), -c("RPL_THEMES"))

names(data_suburban) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                          "timNalV", "timMet", "timBup", "timDia",
                          "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_suburban <- cor(data_suburban, use = "pairwise.complete.obs")
corrplot.mixed(data_cor_suburban)

data_cor_suburbanp <- rcorr(as.matrix(data_suburban)) 
corrplot(data_cor_suburbanp$r,  method = "square", 
         p.mat = data_cor_suburbanp$P, sig.level = 0.001, insig = "blank")

corrplot(data_cor_suburbanp$r, type = "upper", 
         p.mat = data_cor_suburbanp$P, sig.level = 0.001, insig = "blank")


##### rural
data_rural <- allaccess_SVI_rurality %>% 
  filter(rurality == "Rural") %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("RPL"), -c("RPL_THEMES"))


names(data_rural) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                       "timNalV", "timMet", "timBup", "timDia",
                       "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_rural <- cor(data_rural, use = "pairwise.complete.obs")
corrplot.mixed(data_cor_rural)

data_cor_ruralp <- rcorr(as.matrix(data_rural)) 
corrplot(data_cor_ruralp$r,  method = "square",
         p.mat = data_cor_ruralp$P, sig.level = 0.001, insig = "blank")

corrplot(data_cor_ruralp$r, type = "upper", 
         p.mat = data_cor_ruralp$P, sig.level = 0.001, insig = "blank")

