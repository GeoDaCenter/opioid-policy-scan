# Are there HCV testing places that are not HIV testing places?

library(readxl)

providers <- read_excel("data/Illinois data_September2019.xlsx") %>%
  mutate(id = row_number(),
         `Testing services` = as.character(`Testing services`),
         `Testing services` = na_if(`Testing services`, "NULL")) %>%
  select(id, everything())

# Add columns for if providers have substance treatment or testing based on columns
providers <- mutate(providers,
                    hiv_testing = str_detect(`Testing services`, "HIV Testing"),
                    hcv_testing = str_detect(`Testing services`, "Hepatitis C Testing"),
                    hiv_v_hcv = case_when(
                      hiv_testing & !hcv_testing ~ "HIV Only",
                      hcv_testing & !hiv_testing ~ "HCV Only",
                      hiv_testing & hcv_testing ~ "Both"
                    )) 

count(providers, hiv_v_hcv) 

filter(providers, hiv_v_hcv == "HCV Only") %>% glimpse()
                    