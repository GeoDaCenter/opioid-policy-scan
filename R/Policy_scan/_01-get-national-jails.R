# Get jails data from National Census of Jails, data from BJS National Jail Census
# https://www.bjs.gov/index.cfm?ty=tp&tid=123

# Stored on ICPSR
# ICPSR 36128 - 2013 census (no addresses)
# ICPSR 26602 - 2006 census
# ICPSR 03318 - 1999 census

library(tidyverse)

jails99 <- read_tsv("data/Jails/ICPSR_03318/DS0001/03318-0001-Data.tsv")
jails06 <- read_tsv("data/Jails/ICPSR_26602/DS0001/26602-0001-Data.tsv")
load("data/Jails/ICPSR_36128/DS0001/36128-0001-Data.rda")
jails13 <- da36128.0001
state_codes <- read_csv("data/Jails/state-codes.csv")

jails13_address <- left_join(jails13, jails06, by = c("FACID" = "V1")) %>% 
  select(NAME, V5, V6, V2, V7, V8, FACID)

View(jails13_address) # Pretty good initial dataset that we can try geocoding



filter(jails13_address, is.na(V5)) %>% View() #599 jails w/o addresses

# Can get states from codes!

jails13_address %>% 
  mutate(stateID = str_sub(FACID, 1, 2)) %>% 
  left_join(state_codes, by = c("stateID" = "code"))


# Try to get more addresses for some of the 599 jails w/o addresses, use 1999 data?
# Try to get addresses from 1999 jails...?

select(jails99, V1076, V1113, V1151)

jails99_withID <- jails99 %>% 
  mutate_at(vars(starts_with("V1")), as.character) %>%
  mutate(V1A = str_pad(V1A, width = 2, side = "left", pad = "0"),
         V1C = str_pad(V1C, width = 3, side = "left", pad = "0"),
         V1D = str_pad(V1D, width = 3, side = "left", pad = "0"),
         V1E = str_pad(V1E, width = 2, side = "left", pad = "0"),
         V1F = str_pad(V1F, width = 5, side = "left", pad = "0"),
         V1G = str_pad(V1G, width = 3, side = "left", pad = "0")) %>% 
  mutate(ID = paste0(V1A, V1B, V1C, V1D, V1E, V1F, V1G, V1H),
         length_ID = nchar(ID)) %>% 
  select(ID, length_ID, 1:20)

View(jails99_withID)


011001001061000000000
011001001061000000000