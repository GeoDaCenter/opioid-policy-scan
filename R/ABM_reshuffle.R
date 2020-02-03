library(sp)
library(spatstat)
library(maptools)
library(rgdal)
library(dplyr)
library(tmap)
library(sf)

point_master <- read.csv("data/point-master.csv")
dim(point_master)
 #2805 by 9
point_MOUD <- filter(point_master, Category == "MOUD - Buprenorphine" | Category == "MOUD - Methadone" |
                       Category == "MOUD - Naltrexone")
dim(point_MOUD)
 #669 by 9 
 # we have in total 669 MOUD locations
summary(point_MOUD$Category)
 # 447 B, 81 M. 141 N

allpoint_sp <- SpatialPointsDataFrame(point_master[,1:2], point_master, proj4string =  CRS("+init=EPSG:32616"))
class(allpoint_sp)
allpoint_ppp <- as.ppp(allpoint_sp)

point_MOUD_sp <- SpatialPointsDataFrame(point_MOUD[,1:2], point_MOUD, proj4string =  CRS("+init=EPSG:32616"))
class(point_MOUD_sp)
summary(point_MOUD_sp)
point_MOUD_ppp <- as.ppp(point_MOUD_sp)

abm_zips <- readOGR("data/abm_zips.gpkg")
writeOGR(abm_zips, dsn=".", layer="output/abm_zips",driver="ESRI Shapefile")
abm_zips_df <- as.data.frame(abm_zips)

point_MOUD$Zipcode <- substr(as.character(point_MOUD_sp$Zip),1,5)
point_MOUD_abm <- point_MOUD[point_MOUD$Zipcode %in% as.character(abm_zips_df$ZCTA5CE10),]
dim(point_MOUD_abm)
 #495 by 10 
point_MOUD_abm_sp <- SpatialPointsDataFrame(point_MOUD_abm[,1:2], point_MOUD_abm, proj4string =  CRS("+init=EPSG:32616"))
point_MOUD_abm_ppp <- as.ppp(point_MOUD_abm_sp)

abm_zips_sp <- readShapeSpatial("output/abm_zips.shp")
class(abm_zips_sp)
summary(abm_zips_sp)
names(abm_zips_sp)
unique(abm_zips_sp$ZCTA5CE)

summary(test[!(test %in% as.character(abm_zips_sp$GEOID10))])
# there are 90 zipcodes from point_MOUD_sp that are not included abm_zips

plot(abm_zips_sp, main = "All MOUD locations in IL")
plot(point_MOUD_sp, pch=1, cex=0.5, col="blue", add=T)
# there are blue dots that not in the area covered by abm_zips_sp

plot(abm_zips_sp, main = "MOUD locations in study area")
plot(point_MOUD_abm_sp, pch=1, cex=0.5, col="blue", add=T)
 # Now all blue dots (MOUD locations) are within our study area 

summary(point_MOUD_abm$Category)
 # B 333; M 62; N 100

plot(abm_zips_sp, main = "MOUD locations in study area")
plot(point_MOUD_abm_sp, pch=1, cex=0.5, col=point_MOUD_abm$Category, add=T)


# now reshuffling
CSRpoint <- runifpoint(npoints(point_MOUD_abm_ppp), win=abm_zips)
plot(CSRpoint)

marks(CSRpoint) <- point_MOUD_abm_sp$Category
summary(marks(CSRpoint))
summary(point_MOUD_abm_sp$Category)

CSRptrlabel <- rlabel(CSRpoint, labels = marks(CSRpoint), permute=T, nsim=1, drop=T)
head(marks(CSRpoint))
head(marks(CSRptrlabel))
summary(marks(CSRptrlabel))

plot(abm_zips_sp, main = "Reshuffled MOUD locations in study area")
plot(CSRptrlabel[CSRptrlabel$marks=="MOUD - Methadone",], pch=1, cex=0.5, col=marks(CSRptrlabel), add=T)

plot(abm_zips_sp, main = "Reshuffled MOUD Methadone in study area")
plot(CSRptrlabel[CSRptrlabel$marks=="MOUD - Methadone",], pch=1, cex=0.5, col="red", add=T)

plot(abm_zips_sp, main = "Real MOUD Methadone in study area")
plot(point_MOUD_abm_sp[point_MOUD_abm_sp$Category=="MOUD - Methadone",], pch=1, cex=0.5, col="red", add=T)

plot(abm_zips_sp, main = "Reshuffled MOUD Buprenorphine in study area")
plot(CSRptrlabel[CSRptrlabel$marks=="MOUD - Buprenorphine",], pch=1, cex=0.5, col="blue", add=T)

plot(abm_zips_sp, main = "Real MOUD Buprenorphine in study area")
plot(point_MOUD_abm_sp[point_MOUD_abm_sp$Category=="MOUD - Buprenorphine",], pch=1, cex=0.5, col="blue", add=T)

plot(abm_zips_sp, main = "Reshuffled MOUD Naltrexone in study area")
plot(CSRptrlabel[CSRptrlabel$marks=="MOUD - Naltrexone",], pch=1, cex=0.5, col="green", add=T)

plot(abm_zips_sp, main = "Real MOUD Naltrexone in study area")
plot(point_MOUD_abm_sp[point_MOUD_abm_sp$Category=="MOUD - Naltrexone",], pch=1, cex=0.5, col="green", add=T)

CSRptrlabelshape <- as.SpatialPointsDataFrame.ppp(CSRptrlabel)

writeOGR(CSRptrlabelshape, dsn=".", layer="output/CSRptrlabel",driver="ESRI Shapefile")
writeOGR(CSRptrlabelshape, dsn="output/CSRptrlabel.gpkg", layer="", driver="GPKG")


