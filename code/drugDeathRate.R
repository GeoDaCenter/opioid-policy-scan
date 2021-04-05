#### About ----
# This code wrangles U.S. CDC WONDER data on underlying cause of death from drug-related causes, 2009-2018.
# Dataset: Underlying Cause of Death, 1999-2019


#### Set up ---- 

library(tmap)
library(sf)
library(tidyverse)

#### CDC data / County ----

# Load drug-related death data
drug_related <- read.csv("Policy_Scan/data_raw/Drug-related causes 2009-2018.csv")

# Filter out AK, HI
drug_related <- drug_related[,1:7] %>%
  filter(!is.na(State.Code)) %>%
  filter(!State == "Alaska") %>%
  filter(!State == "Hawaii")

# Clean
drug_related$Deaths <- as.numeric(drug_related$Deaths)
drug_related$Population <- as.numeric(drug_related$Population)
drug_related$County.Code <- sprintf("%05s", as.character(drug_related$County.Code))
drug_related$State.Code <- sprintf("%02s", as.character(drug_related$State.Code))

# Create crude rate, normalized per 100K Pop
drug_related$Crude.Rate <- round((drug_related$Deaths / drug_related$Population) * 100000, 1)

# Select variables
drug_related_final <- drug_related %>%
  select(GEOID = County.Code, county = County, state.code = State.Code, state = State, deaths = Deaths, pop = Population, rawDeathRt = Crude.Rate)

# Save final dataset
write.csv(drug_related_final, "Policy_Scan/data_final/Health01_C.csv")


#### CDC data // State ----

# Load drug-related death data
drug_related_st <- read.csv("Policy_Scan/data_raw/Drug-related causes state 2009-2018.csv")

# Filter out AK, HI
drug_related_st <- drug_related_st %>%
  filter(!State == "Alaska") %>%
  filter(!State == "Hawaii")

# Clean
drug_related_st$Deaths <- as.numeric(drug_related_st$Deaths)
drug_related_st$Population <- as.numeric(drug_related_st$Population)
drug_related_st$State.Code <- sprintf("%02s", as.character(drug_related_st$State.Code))

# Create crude rate, normalized per 100K Pop
drug_related_st$Crude.Rate <- round((drug_related_st$Deaths / drug_related_st$Population) * 100000, 1)

# Select variables
drug_related_st <- drug_related_st %>%
  select(GEOID = State.Code, state = State, deaths = Deaths, pop = Population, rawDeathRt = Crude.Rate)

# Save final dataset
write.csv(drug_related_st, "Policy_Scan/data_final/Health01_S.csv")

#### FIN ----
