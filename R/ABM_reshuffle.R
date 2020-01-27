library(sp)
library(spatstat)
library(maptools)
library(rgdal)

point_master <- read.csv("data/point-master.csv")
allpoint <- SpatialPointsDataFrame(point_master[,1:2], point_master, proj4string =  CRS("+init=EPSG:32616"))
class(allpoint)

allpoint1 <- as.ppp(allpoint)

abm_zips <- readOGR("data/abm_zips.gpkg")
CSRpoint <- runifpoint(npoints(allpoint1), win=abm_zips)
plot(CSRpoint)

writeOGR(abm_zips, dsn=".", layer="output/abm_zips",driver="ESRI Shapefile")

marks(CSRpoint) <- point_master$Category
summary(marks(CSRpoint))
summary(point_master$Category)

CSRptrlabel <- rlabel(CSRpoint, labels = marks(CSRpoint), permute=T, nsim=1, drop=T)
head(marks(CSRpoint))
head(marks(CSRptrlabel))
summary(marks(CSRptrlabel))

# need to write the CSRptrlabel as a shape file 
