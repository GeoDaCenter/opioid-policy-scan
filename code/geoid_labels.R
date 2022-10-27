library(tidyverse)
library(data.table)
library(purrr)
library(stringr)


# Set WD
setwd("~/git/opioid-policy-scan")

# Read in all CSVs

# Take all State/County/Tract/Zip files (ending in "_S", "_C", "_T", "_Z")

state_files <- 
  list.files("data_final/", pattern = "*_S.csv", full.names = TRUE)

# Read in multiple data frames
for (i in 1:length(state_files)) assign(state_files[i], read.csv(state_files[i]))

# Read in as one list
statesDf <- lapply(state_files, read.csv)
names(statesDf) <- gsub(".csv","",
                        list.files("data_final/", pattern = "*_S.csv",
                                   full.names = FALSE),
                                   fixed = TRUE)


# Add leading zero
statesDf$Access01_S$STATEFP <- sprintf("%02s", statesDf$Access01_S$STATEFP)
statesDf$Access02_S$STATEFP <- sprintf("%02s", statesDf$Access02_S$STATEFP)

#statesDf[[i]]$STATEFP <- sprintf("%02s", statesDf[[i]]$STATEFP)

# Add leading zero -- apply to all
statesdf2 <- 
  Map(function(i, y) {
  statesDf[[i]][, 1] <- str_pad(statesDf[[i]][, 1], width = y, pad = "0")
  statesDf[[i]] # this gets returned
}, 
# you iterate over these two vectors in parallel
i = 1:length(statesDf), 
y = 2) 


# Create new ID variable, starting with G
#statesDf[[i]]$G_STATEFP <- statesDf[[i]]$STATEFP

#### For all
statesdf3 <- lapply(statesdf2, transform, "G_STATEFP" = statesdf2[[i]][,1])

# Change order
statesDf$Access01_S <- statesDf$Access01_S[,c(1, 12, 2:11)]

#### For all 
statesdf4 <- lapply(statesdf3, relocate, "G_STATEFP" %>% head())

# Add a G to start
statesDf$Access01_S$G_STATEFP <- sub("^", "G", statesDf$Access01_S$G_STATEFP)

#### For all 
#statesdf5 <- lapply(statesdf4, transform, sub("^", "G", G_STATEFP))
#statesdf5 <- lapply(statesdf4, transform, sub("^", "G", statesdf4[[i]][,1]))
#statesdf5 <- lapply(statesdf4, function(y) gsub("^", "G", y))

statesdf5 <- lapply(statesdf4, function(x) gsub("^", "G", x))


#statesdf5 <- lapply(statesdf4, transform, sprintf("%Gi", statesdf4[[i]]))





# 
# statesDf[STATEFP] <- sapply(statesDf[STATEFP], as.numeric)
# 
# statesDf <- lapply(statesDf[.], transform, STATEFP = as.character(STATEFP))
#   
# lapply(mget(paste0("DF", 1:7)), transform, 
#        Interval = ((Upperbound - Lowerbound)/actual)/2)



# states2 <- 
#   list.files("data_final/", pattern = "*_S.csv", full.names = TRUE) %>%
#   map_df(~read.csv(.))

# for (i in seq_along(statesDf)) 
#   { statesDf[[i]][, dim(statesDf[[i]])[2] + 1] = as.character(rep(year,dim(statesDf[[i]])[1])) year = year + 1 }

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
