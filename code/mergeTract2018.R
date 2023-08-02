# Author: Ashlynn Wimer
# Date: July 12th, 2023
# About: You know those "merge" mobile games? Where you just combine things 
# and then receive dopamine? This file is that, but for tract level 2018 data.

# Libraries
library(dplyr)
library(stringr)

## Uncomment if running this in RStudio.
setwd(getSrcDirectory(function(){})[1])

files <- c(
  "../data_final/DS01_T.csv", "../data_final/DS02_T.csv", "../data_final/DS03_T.csv",
  "../data_final/DS04_T.csv", "../data_final/DS05_T.csv"
)

df <- read.csv(files[1])
expecCols <- length(names(df))

for (file in files[-1]) {
  next.df <- read.csv(file)
  expecCols <- expecCols + length(names(next.df))
  df <- df |> merge(next.df, by='GEOID')
}

