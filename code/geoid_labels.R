library(tidyverse)
library(data.table)
library(purrr)

# Take all State/County/Tract/Zip files (ending in "_S", "_C", "_T", "_Z")
# Add new ID var - S_GEOID, C_GEOID, T_GEOID, Z_GEOID

states <- 
  list.files("data_final/", pattern = "*_S.csv", full.names = TRUE)
statesDf <- lapply(states, read.csv)

states2 <- 
  list.files("data_final/", pattern = "*_S.csv", full.names = TRUE) %>%
  map_df(~read.csv(.))

for (i in seq_along(statesDf)) 
  { statesDf[[i]][, dim(statesDf[[i]])[2] + 1] = as.character(rep(year,dim(statesDf[[i]])[1])) year = year + 1 }

# year = 2001 
# L <- list(bhps01, bhps02) 
# for (i in seq_along(L)) 
# { L[[i]][, dim(L[[i]])[2] + 1] = as.character(rep(year,dim(L[[i]])[1])) year = year + 1 }

test <- statesDf %>%
  mutate_at(vars(STATEFP), funs(ifelse(S_GEOID==STATEFP, .)))


test <- 
  statesDf %>%
  map(~if("S_GEOID" %in% names(.x)) rename(.x, STATEFP=S_GEOID) else .x)
test


lapply(states, function(x){
  S_GEOID = "STATEFP"
  cbind(x, S_GEOID)
  return(x)
})

lapply(statesDf, function(x){
  S_GEOID = "STATEFP"
  cbind(x, S_GEOID)
  return(x)
})

states2 <- lapply(states, function(x){
  cbind(x, setNames(x['STATEFP'], 'S_GEOID'))
  })


  

# Take Geometry files for all geographies
# Add new ID var - S_GEOID, C_GEOID, T_GEOID, Z_GEOID