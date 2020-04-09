# How many sites fall under each service code? (And which criteria should be used to pull the data from the locator here?)
# https://findtreatment.samhsa.gov/locator

library(readxl)
library(tidyverse)

# get service codes to filter SAMHSA Locator Substance Abuse data by

service_codes <- read_excel("data/2020-04-09-12.47_samhsa-data-download/service-codes.xlsx")

bup_codes <- filter(service_codes, 
                            str_detect(service_description, "[Bb]up") | 
                              str_detect(service_name, "[Bb]up"))

meth_codes <- filter(service_codes, 
                            str_detect(service_description, "[Mm]eth") | 
                              str_detect(service_name, "[Mm]eth"))

nal_codes <- filter(service_codes,
                    str_detect(service_description, "[Nn]altrex") |
                    str_detect(service_name, "[Nn]altrex"))

all_codes_df <- rbind(bup_codes, meth_codes, nal_codes) 

all_codes <- all_codes_df %>% 
  pull(service_code) %>% 
  tolower()


# Use codes to narrow down dataset
substance_abuse <- read_excel("data/2020-04-09-12.47_samhsa-data-download/substance-abuse/Behavioral_Health_Treament_Facility_listing_2020_04_09_135006.xlsx")

all_sa <- substance_abuse %>% 
  select(name1, name2, street1, city, state, zip, latitude, longitude, all_of(all_codes))

# Make some charts of site counts by criteria

counts_per_service_code <- all_sa %>% 
  select(name1, all_of(all_codes)) %>% 
  pivot_longer(-name1, names_to = "service_code", values_to = "if_yes") %>% 
  filter(!is.na(if_yes)) %>% 
  count(service_code) %>% 
  arrange(n) %>% 
  mutate(service_code = toupper(service_code)) %>% 
  left_join(all_codes_df, by = "service_code") %>% 
  mutate(med_type = case_when((str_detect(service_description, "[Bb]up") | 
                                str_detect(service_name, "[Bb]up") ~ "bup"),
                              (str_detect(service_description, "[Mm]eth") | 
                                str_detect(service_name, "[Mm]eth")) ~ "meth",
                              (str_detect(service_description, "[Nn]altrex") |
                              str_detect(service_name, "[Nn]altrex")) ~ "nal"))

# Buprenorphine
bup_plot <- 
  filter(counts_per_service_code, med_type == "bup", service_code != "OMB", service_code != "NSC") %>% 
  mutate(service_name = fct_reorder(service_name, n)) %>% 
  ggplot(aes(x = service_name, y = n, label = n, fill = category_name)) +
    geom_col() +
  geom_label() +
  # facet_wrap(~category_name) +
    coord_flip() +
  xlab("") +
  ylab("Number of Sites") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 15))  
  
# Methadone
meth_plot <-
  filter(counts_per_service_code, med_type == "meth", service_code != "OMB", service_code != "CMI", service_code != "MDTX") %>% 
  mutate(service_name = fct_reorder(service_name, n)) %>% 
  ggplot(aes(x = service_name, y = n, label = n, fill = category_name)) +
  geom_col() +
  geom_label() +
  coord_flip() +
  xlab("") +
  ylab("Number of Sites") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 15))

# Naltrexone
naltrex_plot <- 
filter(counts_per_service_code, med_type == "nal") %>% 
  mutate(service_name = fct_reorder(service_name, n)) %>% 
  ggplot(aes(x = service_name, y = n, label = n, fill = category_name)) +
  geom_col() +
  geom_label() +
  coord_flip() +
  xlab("") +
  ylab("Number of Sites") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 15)) +
  scale_fill_manual(values=c("#7CAE00", "#00BFC4", "#C77CFF"))

ggsave("output/bup_site_codes.png", plot = bup_plot)
ggsave("output/meth_site_codes.png", plot = meth_plot)
ggsave("output/nal_site_codes.png", plot = naltrex_plot)
