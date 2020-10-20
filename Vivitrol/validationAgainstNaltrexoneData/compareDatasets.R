library(rgdal)
library(sp)
library(sf)
library(tidyverse)
library(ggplot2)
library(tmap)
library(tidygeocoder)
library(tmaptools)
library(beepr)
library(RANN)

geocoded <- read.csv("out_geocoded.csv", header= TRUE) 
dim(geocoded) # 4217    8
dim(geocoded %>%
      group_by(Longitude, Latitude) %>% mutate(dupe= n()) %>% filter(dupe >1)) # 84    9
# 84 entries duplicate long lat
# e.g. Michigan Addiction Center PLLC - All Opiates Detox, 
# also has another entry with doc name ID 3387 & 3386
# similarly facility type e.g. Outpatient vs Inpatient

vivitrol <- read.csv("vivitrol_providers.csv", header = TRUE) %>% mutate(ID = row_number()-1)
# not the best way but the addresses match one on one so introducing Id and joining on that.
vivitrol <- merge(vivitrol, geocoded, all.x = TRUE) 

# separate duplicated and identify why
duplicatedV <- vivitrol %>% group_by(Longitude, Latitude) %>% mutate(count = n()) %>% filter(count >1 )
vivitrol <- vivitrol %>% distinct(Longitude,Latitude, .keep_all =  TRUE)
vivitrol <- st_as_sf(vivitrol, coords = c("Longitude", "Latitude"), crs = 4326)
vivitrol[,c('Longitude','Latitude')] <- st_coordinates(vivitrol)


samhsa <- readOGR("us-wide-moud.gpkg", layer = "us-wide-moud")
samhsa <- st_as_sf(samhsa) %>% filter(category == 'naltrexone') #9862
samhsa[,c('Longitude','Latitude')] <- st_coordinates(samhsa)
duplicatedS <- samhsa %>% group_by(Longitude, Latitude) %>% mutate(count = n()) %>% filter(count >1 )

samhsa <- samhsa %>% 
          distinct(Longitude,Latitude, .keep_all =  TRUE) %>%
          mutate(Id = row_number())

dim(samhsa) # 4763   14
dim(vivitrol) # 4174   17
st_crs(samhsa) == st_crs(vivitrol) # check crs

# find nearest neighbor
samhsaCoords <- data.frame(samhsa[,c('Longitude','Latitude')])[,1:2]
vivitrolCoords <- data.frame(vivitrol[,c('Longitude','Latitude')])[,1:2]
r = 0.001 #  111 m approx

closest <- nn2(vivitrolCoords, samhsaCoords, k = 1, searchtype = "radius", radius = r)
closestMatrix <- data.frame(closest$nn.idx) %>% 
                  mutate(vivitrolRow = closest.nn.idx , samhsaId = row_number()) %>%
                  select(vivitrolRow, samhsaId)
samhsa <- merge(samhsa, closestMatrix, by.x = 'Id', by.y = 'samhsaId', all.x  = TRUE)

# samhsa %>% filter(vivitrolRow != 0) %>% count() 767

t1 <- data.frame(samhsa) %>% 
      group_by(zip) %>% 
      summarize (samhsaCount = n(), matched = sum(vivitrolRow > 0))

t2 <- data.frame(vivitrol) %>% 
  group_by(ZIP) %>% 
  summarize (vivitrolCount = n())


zcta <- readOGR("tl_2018_zcta/zctas2018.shp")
zcta <- st_as_sf(zcta, crs = 4326) 
zcta <- merge(zcta, t1, by.x = 'ZCTA5CE10', by.y = 'zip', all.x = TRUE)
zcta <- merge(zcta, t2, by.x = 'ZCTA5CE10', by.y = 'ZIP', all.x = TRUE) 

continental_bbox <- st_as_sfc("POLYGON((-126.3 50.6, -66.0 50.6, -66.0 20.1, -126.3 20.1, -126.3 50.6))") %>%
  st_as_sf(crs = 4326)

continental_zips <- st_intersection(continental_bbox, zcta) 
continental_zips <- continental_zips %>% mutate_at(vars(samhsaCount, vivitrolCount), ~replace_na(., 0))




p1 <- 
  tm_shape(continental_zips) +
  tm_fill("samhsaCount", 
          breaks = c(0,1,5,10,20), 
          title = "Count",
          palette = c("#edf8e9", "#a1d99b", "#74c476", "#31a354","#006d2c")) +
  tm_layout(main.title = "Zipcode SAMHSA location counts", 
            main.title.position = c('center','top'))

tmap_save(p1, "Zipcode SAMHSA location counts no Dup.png")
beep(sound = 1)

p2 <- 
  tm_shape(continental_zips) +
  tm_fill("vivitrolCount", 
          breaks = c(0,1,5,10,20), 
          title = "Count",
          palette = c("#edf8e9", "#a1d99b", "#74c476", "#31a354","#006d2c")) +
  tm_layout(main.title = "Zipcode Vivitrol location counts", 
            main.title.position = c('center','top'))

tmap_save(p2, "Zipcode Vivitrol location counts no Dup.png")
beep(sound = 1)

continental_zips <- continental_zips %>% mutate(diff = ifelse(samhsaCount < vivitrolCount ,'moreV',ifelse(samhsaCount > vivitrolCount,'moreS','Missing or same')))
continental_zips <- continental_zips %>% mutate(diff = factor(diff))


p3 <- 
  tm_shape(continental_zips) +
  tm_fill("diff", 
          title = "Difference",
          palette = c("#99d8c9", "#ef8a62", "#67a9cf")) +
  tm_layout(main.title = "Difference in datasets", 
            main.title.position = c('center','top'))

tmap_save(p3, "Difference in datasets.png")
beep(sound = 1)


#count by zipcodes


# 
# closest <- nn2(samhsaCoords, vivitrolCoords, k = 1, searchtype = "radius", radius = r)
# closestMatrix <- data.frame(closest$nn.idx) %>% 
#   mutate(samhsaId = closest.nn.idx , vivitrolId = row_number()) %>%
#   select(vivitrolId, samhsaId)
# 
# vivitrol <- merge(vivitrol, closestMatrix, by.x = 'ID', by.y = 'vivitrolId', all.x = TRUE)
# 
# 
# 
# 
# ------------------------------------------------------------------------------
# # distMatrix <- st_distance(samhsa,vivitrol)
# # distMatrix <- data.frame(distMatrix)
# # 
# # closestToS <- distMatrix %>% 
# #               mutate(samhsa=rownames(.)) %>% 
# #               gather('vivitrol','dist',-samhsa) %>% 
# #               group_by(samhsa) %>% 
# #               slice(which.min(dist)) %>%
# #               mutate(samhsaId = as.numeric(samhsa) , vivitrol = as.numeric(gsub("X","",vivitrol)))
# # 
# # closestToV <- data.frame(t(distMatrix)) %>% 
# #               mutate(vivitrol=rownames(.)) %>% 
# #               gather('samhsa','dist',-vivitrol) %>% 
# #               group_by(vivitrol) %>% 
# #               slice(which.min(dist)) %>%
# #               mutate(samhsa = as.numeric(gsub("X","",samhsa)), vivitrol = as.numeric(gsub("X","",vivitrol))-1)
# # 
# # 
# # 
# # units(vivitrol$dist) <- "meters"
# # 
# # threshold <- 100
# # units(threshold) <- "meters"
# # 
# # 
# # ggplot() + geom_sf(data = vivitrol %>% filter(dist <= threshold), color = 'blue') +
# #   geom_sf(data = samhsa %>% filter(dist <= threshold), color = 'red') + 
# #   ggtitle('Points that had a match')
# # 
# # 
# # # 
# # # near <- distMatrix %>% 
# # #         mutate(samhsa=rownames(.)) %>% 
# # #         gather('vivitrol','dist',-samhsa) %>% 
# # #         filter(!is.na(dist),dist <= threshold) %>% 
# # #         group_by(samhsa) %>% 
# # #         arrange(dist) %>% 
# # #         mutate(rank=1:n())
# # 
# # 
# # 
# # 
