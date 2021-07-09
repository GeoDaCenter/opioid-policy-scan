#### About ----

# Description: This script calculates three Racial Segregation Indices (Dissimilarity Index, Interaction Index, and Isolation Index) 
# for three racial minority groups (Black, Hispanic, and Asian) based on ACS 2018 5-year tract-level population estimates in the United States. 
# By: Susan Paykin, adapted from code by Fanmei Xia, UChicago
# Date: July 8, 2021

# Load libraries
library(tidycensus)
library(tidyverse)
library(tigris)
library(purrr)
library(USAboundaries)
library(tmap)
library(sf)

# Set API key
#census_api_key()

#### Loading ACS data ---- 

# The below ACS table gives population estimates by race and Hispanic ethnicity.
# Getting data from the 2018 5-year ACS
ACS18var <- load_variables(2018, "acs5", cache = TRUE)
view(ACS18var)

# Load fips codes for all states
 us <- unique(fips_codes$state)[1:51]

## Load ACS5 variables for 2018 from table B03002 and caching the dataset for faster future access
race_table <-  get_acs(geography = "tract", year=2018, geometry = F, output="wide", table = "B03002", cache_table = T, state = us)

trdat <- race_table %>%
  mutate(nhwhite=B03002_003E,
         nhblack=B03002_004E,
         nhasian=B03002_006E,
         nhother= B03002_005E+B03002_007E+B03002_008E+B03002_009E+B03002_010E,
         hisp=B03002_012E, 
         total=B03002_001E,
         year=2018,
         cofips=substr(GEOID, 1,5)) %>%
  select(GEOID, nhwhite, nhblack, nhasian, hisp, nhother, total, year, cofips )%>%
  arrange(cofips, GEOID)

head(trdat)

# Get county-level totals for the total population and each race group
codat<-trdat%>%
  group_by(cofips)%>%
  summarise(co_total=sum(total), co_wht=sum(nhwhite), co_blk=sum(nhblack), co_asian=sum(nhasian), co_oth=sum(nhother), co_hisp=sum(hisp))

# Merge the county data back to the tract data by the county FIPS code
merged<-left_join(x=trdat,y=codat, by="cofips")
head(merged)

##### Black segregation calculations ----

# Dissimilarity Index 
# First we calculate the tract-specific contribution to the county dissimilarity index, then we use the tapply() function to sum the tract-specific contributions within counties. 
# The Dissimilarity index formula for blacks and whites is: D=.5∗∑i ∣(bi/B) − (wi/W)∣,
# where bi is the number of blacks in each tract, B is the number of blacks in the county, wi is the number of whites in the tract, and W is the number of whites in the county.

co.dis.b <- merged %>%
  mutate(d.wb=abs(nhwhite/co_wht - nhblack/co_blk)) %>%
  group_by(cofips)%>%
  summarise(dissim.b= .5*sum(d.wb, na.rm=T))

# Interaction Index
# Next is the interaction index for blacks and whites. In the calculation first population is minority population, second is non-minority population. The formula is: 
# Interaction = ∑i bi/B ∗ wi/ti

co.int.b <- merged %>%
  mutate(int.bw=(nhblack/co_blk * nhwhite/total)) %>%
  group_by(cofips)%>%
  summarise(inter.bw= sum(int.bw, na.rm=T))

# Isolation Index
# Next is is the isolation index for blacks. The formula is:
# Isolation = ∑i bi/B ∗ bi/ti

co.iso.b <- merged %>%
  mutate(isob=(nhblack/co_blk * nhblack/total)) %>%
  group_by(cofips) %>%
  summarise(iso.b= sum(isob, na.rm=T))

seg_b <- list(co.dis.b, co.int.b, co.iso.b) %>% 
  reduce (left_join, by="cofips")

#### Hispanic segregation calculations ----

# Dissimilarity Index - Hispanic
# First we calculate the tract-specific contribution to the county dissimilarity index, then we use the tapply() function to sum the tract-specific contributions within counties. 
# The Dissimilarity index formula for Hispanics and whites is: D=.5∗∑i ∣(hi/H) − (wi/W)∣ 
# where hi is the number of Hispanics in each tract, H is the number of Hispanics in the county, wi is the number of whites in the tract, and W is the number of whites in the county.

co.dis.h <- merged %>%
  mutate(d.wh=abs(nhwhite/co_wht - hisp/co_hisp))%>%
  group_by(cofips)%>%
  summarise(dissim.h = .5*sum(d.wh, na.rm=T))

# Interaction Index - Hispanic
# Next is the interaction index for Hispanics and whites. In the calculation first population is minority population, second is non-minority population. The formula is: 
# Interaction = ∑i hi/H ∗ wi/ti

co.int.h <- merged %>%
  mutate(int.hw = (hisp/co_hisp * nhwhite/total)) %>%
  group_by(cofips)%>%
  summarise(inter.hw = sum(int.hw, na.rm=T))

# Isolation Index
# Next is is the isolation index for Hispanics. The formula is:
# Isolation=∑i hi/H ∗ hi/ti

co.iso.h <- merged %>%
  mutate(isoh = (hisp/co_hisp * hisp/total))%>%
  group_by(cofips)%>%
  summarise(iso.h= sum(isoh, na.rm=T))

seg_h <- list(co.dis.h, co.int.h, co.iso.h) %>% 
  reduce(left_join, by="cofips")

#### Asian segregation calculations ----

# Dissimilarity Index -- Asian
# First we calculate the tract-specific contribution to the county dissimilarity index, then we use the tapply() function to sum the tract-specific contributions within counties. 
# The Dissimilarity index formula for Asians and whites is: D=.5∗∑i ∣(ai/A) − (wi/W)∣ 
# where ai is the number of Asians in each tract, A is the number of Asians in the county, wi is the number of whites in the tract, and W is the number of whites in the county.

co.dis.a <- merged %>%
  mutate(d.wa=abs(nhwhite/co_wht - nhasian/co_asian))%>%
  group_by(cofips)%>%
  summarise(dissim.a = .5*sum(d.wa, na.rm=T))

# Interaction Index - Asian
# Next is the interaction index for Hispanics and whites. In the calculation first population is minority population, second is non-minority population. The formula is: 
# Interaction = ∑i hi/H ∗ wi/ti

co.int.a <- merged %>%
  mutate(int.aw = (nhasian/co_asian * nhwhite/total)) %>%
  group_by(cofips)%>%
  summarise(inter.aw = sum(int.aw, na.rm=T))

# Isolation Index - Asian
# Next is is the isolation index for Hispanics. The formula is:
# Isolation=∑i hi/H ∗ hi/ti

co.iso.a <- merged %>%
  mutate(iso.a = (nhasian/co_asian * nhasian/total))%>%
  group_by(cofips)%>%
  summarise(iso.a = sum(iso.a, na.rm=T))

seg_a <- list(co.dis.a, co.int.a, co.iso.a) %>% 
  reduce(left_join, by="cofips")

#### Visualize and map data ----
counties <- us_counties()
str(counties)

seg_indices.sf <- merge(counties, seg_indices,  by.x = "geoid", by.y = "COUNTYFP", sort = TRUE)
str(seg_indices.sf)

# map
tmap_mode("view")

# Black
tm_shape(seg_indices.sf) +
  tm_fill("iso.b", palette = "Blues")
# Hispanic
tm_shape(seg_indices.sf) +
  tm_fill("iso.h", palette = "Oranges")
# Asian
tm_shape(seg_indices.sf) +
  tm_fill("iso.a", palette = "Greens")


#### Prepare final dataset ----

seg_indices <- list(seg_b, seg_h, seg_a) %>%
  reduce(left_join, by = "cofips")

# rename county variable
colnames(seg_indices)[1] <- "COUNTYFP"

# Save final dataset
write.csv(seg_indices, "data_final/BE05_C.csv")

