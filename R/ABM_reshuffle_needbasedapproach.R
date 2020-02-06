library(tidyverse)
library(sf)
library(dplyr)
library(readr)
library(tigris)

atrisk <- read.csv("output/atrisk.csv", colClasses = c(NA, "character",NA))
head(atrisk)

# Illinois boundary
illinois <- tigris::states(cb = TRUE) %>%
  st_as_sf() %>% 
  filter(NAME == "Illinois") %>%
  st_transform(32616)

# 1383 ZCTAs in Illinois
zips <- zctas(starts_with = c("60", "61", "62")) # takes like 5 min
zips_sf <- st_as_sf(zips, coords = c("INTPTLON10", "INTPTLAT10")) %>%
  st_transform(32616) # takes like 20 seconds

zips_sp <- as(zips_sf,"Spatial")

# select atrisk information for IL
atrisk_IL <- atrisk[atrisk$GEOID %in% zips_sp$GEOID10,]

# calculate ratio for each zip code
atrisk_IL %>% 
  summarize(sum(total_18_39))
atrisk_IL <- atrisk_IL %>%
  mutate(ratio = total_18_39/3833447)

# look at MOUDs in IL
point_master <- read.csv("data/point-master.csv")
dim(point_master)
  # 2805 by 9
point_MOUD <- filter(point_master, Category == "MOUD - Buprenorphine" | Category == "MOUD - Methadone" |
                       Category == "MOUD - Naltrexone")
dim(point_MOUD)
  # 669 by 9 
  # we have in total 669 MOUD locations
summary(point_MOUD$Category)
  # 447 B, 81 M. 141 N

# assign MOUDs to each zip code based on need
atrisk_IL <- atrisk_IL %>%
  mutate(
    MOUD_B = ratio * 447,
    MOUD_M = ratio * 81,
    MOUD_N = ratio * 141
    )

atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_B_int = floor(MOUD_B))
sum(atrisk_IL$MOUD_B_int)
  # 201, remainder = 447 - 201 = 246
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_B_digit = MOUD_B - MOUD_B_int)
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_B_digitrank = min_rank(MOUD_B_digit))
table(atrisk_IL$MOUD_B_digitrank > 1137)
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_B_remainder = 1*(atrisk_IL$MOUD_B_digitrank > 1137))
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_B_assign = MOUD_B_remainder + MOUD_B_int)

atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_M_int = floor(MOUD_M))
sum(atrisk_IL$MOUD_M_int)
  # 0, remainder = 81 - 0 = 81
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_M_digit = MOUD_M - MOUD_M_int,
         MOUD_M_digitrank = min_rank(MOUD_M_digit))
table(atrisk_IL$MOUD_M_digitrank > 1302)
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_M_remainder = 1*(atrisk_IL$MOUD_M_digitrank > 1302),
         MOUD_M_assign = MOUD_M_remainder + MOUD_M_int)
sum(atrisk_IL$MOUD_M_assign)

atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_N_int = floor(MOUD_N))
sum(atrisk_IL$MOUD_N_int)
 # 16, remainder = 141 - 16 = 125
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_N_digit = MOUD_N - MOUD_N_int,
         MOUD_N_digitrank = min_rank(MOUD_N_digit))
table(atrisk_IL$MOUD_N_digitrank > 1258)
atrisk_IL <- atrisk_IL %>%
  mutate(MOUD_N_remainder = 1*(atrisk_IL$MOUD_N_digitrank > 1258),
         MOUD_N_assign = MOUD_N_remainder + MOUD_N_int)
sum(atrisk_IL$MOUD_N_assign)

i <- 1
n_B <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_B_assign
n_M <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_M_assign
n_N <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_N_assign
n_total <- n_B + n_M + n_N
CSR1 <- runifpoint(n_total, win=as.owin(zips_sp[i,]))
medication <- as.factor(c(rep("MOUD - Buprenorphine", n_B), 
                rep("MOUD - Methadone", n_M),
                rep("MOUD - Naltrexone", n_N)))
CSR1$marks <- medication
CSRlabel1 <- rlabel(CSR1, labels = marks(CSR1), permute=T, nsim=1, drop=T)
CSRlabel1_sp <- as.SpatialPointsDataFrame.ppp(CSRlabel1)


