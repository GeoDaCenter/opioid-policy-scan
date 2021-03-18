library(readr) 
library(corrplot)
library(tidyverse)
library(Hmisc)

allaccess_SVI_rurality <- read_csv("MOUD_access/data_final/allaccess_SVI_rurality.csv", col_types = cols(minDialysis = col_number()))

data <- allaccess_SVI_rurality %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("SVI"))

data$`count_in_range_naltrexone/vivitrol` <- (-1)*data$`count_in_range_naltrexone/vivitrol`
data$count_in_range_methadone <- (-1)*data$count_in_range_methadone
data$count_in_range_buprenorphine <- (-1)*data$count_in_range_buprenorphine
data$count_in_range_dialysis <- (-1)*data$count_in_range_dialysis

names(data) <- c("-cntNalV", "-cntMet", "-cntBup", "-cntDia",
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
         starts_with("SVI"), -c("SVIS"))

data_urban$`count_in_range_naltrexone/vivitrol` <- (-1)*data_urban$`count_in_range_naltrexone/vivitrol`
data_urban$count_in_range_methadone <- (-1)*data_urban$count_in_range_methadone
data_urban$count_in_range_buprenorphine <- (-1)*data_urban$count_in_range_buprenorphine
data_urban$count_in_range_dialysis <- (-1)*data_urban$count_in_range_dialysis

names(data_urban) <- c("-cntNalV", "-cntMet", "-cntBup", "-cntDia",
                       "timNalV", "timMet", "timBup", "timDia",
                       "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_urban <- cor(data_urban, use = "pairwise.complete.obs", method = c("spearman"))
corrplot.mixed(data_cor_urban)

data_cor_urbanp <- rcorr(as.matrix(data_urban), type="spearman") 
corrplot(data_cor_urbanp$r, method = "square", 
         p.mat = data_cor_urbanp$P, sig.level = 0.001, 
         tl.col = "black",addCoef.col = "black", number.cex= 9/ncol(data_cor_urban), 
         diag=FALSE, tl.srt = 45,
         insig = "blank", type = "lower", cl.cex = 1,
         cl.lim = c(-1,1), col=colorRampPalette(c("#0571b0","white","#ca0020"))(200))

##### suburban
data_suburban <- allaccess_SVI_rurality %>% 
  filter(rurality == "Suburban") %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("SVI"), -c("SVIS"))

data_suburban$`count_in_range_naltrexone/vivitrol` <- (-1)*data_suburban$`count_in_range_naltrexone/vivitrol`
data_suburban$count_in_range_methadone <- (-1)*data_suburban$count_in_range_methadone
data_suburban$count_in_range_buprenorphine <- (-1)*data_suburban$count_in_range_buprenorphine
data_suburban$count_in_range_dialysis <- (-1)*data_suburban$count_in_range_dialysis

names(data_suburban) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                          "timNalV", "timMet", "timBup", "timDia",
                          "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_suburban <- cor(data_suburban, use = "pairwise.complete.obs", method = "spearman")
corrplot.mixed(data_cor_suburban)

data_cor_suburbanp <- rcorr(as.matrix(data_suburban), type = "spearman") 
corrplot(data_cor_suburbanp$r, method = "square", 
         p.mat = data_cor_suburbanp$P, sig.level = 0.001, 
         tl.col = "black", addCoef.col = "black", number.cex= 9/ncol(data_cor_suburban), 
         diag = FALSE, tl.srt = 45,
         insig = "blank", type = "lower", cl.cex = 1,
         cl.lim = c(-1,1), col=colorRampPalette(c("#0571b0","white","#ca0020"))(200))

##### rural
data_rural <- allaccess_SVI_rurality %>% 
  filter(rurality == "Rural") %>% 
  select(starts_with("count"), starts_with("time"),
         starts_with("SVI"), -c("SVIS"))

data_rural$`count_in_range_naltrexone/vivitrol` <- (-1)*data_rural$`count_in_range_naltrexone/vivitrol`
data_rural$count_in_range_methadone <- (-1)*data_rural$count_in_range_methadone
data_rural$count_in_range_buprenorphine <- (-1)*data_rural$count_in_range_buprenorphine
data_rural$count_in_range_dialysis <- (-1)*data_rural$count_in_range_dialysis

names(data_rural) <- c("cntNalV", "cntMet", "cntBup", "cntDia",
                       "timNalV", "timMet", "timBup", "timDia",
                       "SVI1", "SVI2", "SVI3", "SVI4")

data_cor_rural <- cor(data_rural, use = "pairwise.complete.obs", method = "spearman")
corrplot.mixed(data_cor_rural)

data_cor_ruralp <- rcorr(as.matrix(data_rural), type = "spearman") 
corrplot(data_cor_ruralp$r, method = "square", 
         p.mat = data_cor_ruralp$P, sig.level = 0.001, 
         tl.col = "black", addCoef.col = "black", number.cex= 9/ncol(data_cor_rural), 
         diag = FALSE, tl.srt = 45,
         insig = "blank", type = "lower", cl.cex = 1,
         cl.lim = c(-1,1), col=colorRampPalette(c("#0571b0","white","#ca0020"))(200))

