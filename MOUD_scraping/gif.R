#libraries
library(readr)

# read U.S. map
us_states = read_sf('cb_2018_us_state_5m/cb_2018_us_state_5m.shp')

# #test single dt
# year = 1998
# key = 'ML'
# fname <- glue('{year}/{year}_g.csv')
# 
# library(data.table)
# sfd <- fread(fname, select = c("Keys","ID","Longitude","Latitude","Match Score")) %>%
#   st_as_sf(coords=c("Longitude","Latitude")) %>% #, crs=27700
#   filter(grepl(key, Keys))
# View(sfd)

# combine all datatables
d <- data.frame(year = c(1990, 1998, 2000, 2003, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2015, 2017),
                mm_key = c('MM', 'ML', 'ML', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM', 'MM'))
mm_1990_2017 <- data.frame(matrix(ncol = 15, nrow = 0))
x <- c("Name1", "Name2", "Name3", "Address1", "Address2", "Address3", "City", "State", "ZIP_Code", "Contact", "Keys", "ID", "Match.Score", "geometry", "year")
colnames(mm_1990_2017) <- x

for(i in seq_len(nrow(d))) {
  year_ = d[i,]$year
  mm_key_ = d[i,]$mm_key
  fname <- glue('{year_}/{year_}_g.csv')
  sfd <- fread(fname, select = c("Keys","ID","Longitude","Latitude","Match Score")) %>%
    st_as_sf(coords=c("Longitude","Latitude")) %>% #, crs=27700
    filter(grepl(key, Keys))
  sfd$year <- rep(year_, nrow(sfd))
  mm_1990_2017 <- rbind(mm_1990_2017, sfd)
}
  
View(mm_1990_2017)
# nrow(sfd)                

