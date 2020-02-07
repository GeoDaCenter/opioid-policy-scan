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
reshuffle2 <- as.data.frame(CSRlabel1)

for (i in 2:1383) {
  n_B <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_B_assign
  n_M <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_M_assign
  n_N <- atrisk_IL[atrisk_IL$GEOID==zips_sp[i,]$GEOID10,]$MOUD_N_assign
  n_total <- n_B + n_M + n_N
  CSRi <- runifpoint(n_total, win=as.owin(zips_sp[i,]))
  medication <- as.factor(c(rep("MOUD - Buprenorphine", n_B), 
                            rep("MOUD - Methadone", n_M),
                            rep("MOUD - Naltrexone", n_N)))
  CSRi$marks <- medication
  CSRlabeli <- rlabel(CSRi, labels = marks(CSRi), permute=T, nsim=1, drop=T)
  reshufflei <- as.data.frame(CSRlabeli)
  reshuffle2 <- rbind(reshuffle2, reshufflei)
}

head(reshuffle2)
table(reshuffle2$marks)
reshuffle2_sp <- SpatialPointsDataFrame(reshuffle2[,1:2], reshuffle2, proj4string =  CRS("+init=EPSG:32616"))

## check MOUD locations after reshuffling - Methadone
plot(st_geometry(illinois), main = "Reshuffled MOUD Methadone in IL")
plot(reshuffle2_sp[reshuffle2_sp$marks=="MOUD - Methadone",], pch=1, cex=0.5, col="red", add=T)

plot(st_geometry(illinois), main = "Real MOUD Methadone in IL")
plot(point_MOUD_sp[point_MOUD_sp$Category=="MOUD - Methadone",], pch=1, cex=0.5, col="red", add=T)

## check MOUD locations after reshuffling - Buprenorphine
plot(st_geometry(illinois), main = "Reshuffled MOUD Buprenorphine in IL")
plot(reshuffle2_sp[reshuffle2_sp$marks=="MOUD - Buprenorphine",], pch=1, cex=0.5, col="blue", add=T)

plot(st_geometry(illinois), main = "Real MOUD Buprenorphine in IL")
plot(point_MOUD_sp[point_MOUD_sp$Category=="MOUD - Buprenorphine",], pch=1, cex=0.5, col="blue", add=T)

## check MOUD locations after reshuffling (within study area) - Naltrexone
plot(st_geometry(illinois), main = "Reshuffled MOUD Naltrexone in IL")
plot(reshuffle2_sp[reshuffle2_sp$marks=="MOUD - Naltrexone",], pch=1, cex=0.5, col="green", add=T)

plot(st_geometry(illinois), main = "Real MOUD Naltrexone in IL")
plot(point_MOUD_sp[point_MOUD_sp$Category=="MOUD - Naltrexone",], pch=1, cex=0.5, col="green", add=T)

write.csv(reshuffle2, file="output/reshuffle2.csv")
writeOGR(reshuffle2_sp, dsn="output/reshuffle2.gpkg", layer="", driver="GPKG")

# may need to plot the atrisk population to double check the reshuffle result 
zips_IL <- right_join(atrisk_IL, zips_sf, by = c("GEOID" = "GEOID10")) %>% 
  st_as_sf() %>%
  st_set_crs(32616)
tmap_mode(mode = "view")
  # tmap mode set to interactive viewing 
tm_shape(zips_IL) + tm_polygons("ratio")
tmap_mode(mode = "plot")
tm_shape(zips_IL) + tm_polygons("ratio", style = "quantile")


