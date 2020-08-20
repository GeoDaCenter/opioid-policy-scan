# Scrape ILBRFSS data
# http://www.idph.state.il.us/brfss/countydata.asp?selTopicCounty=tobacco&areaCounty=Adams_1&show=freq&yrCounty=5&form=county&yr=&area=&selTopic=

library(rvest)
county_code <- read_csv("counties-txt.csv") %>% 
  as.list()

county_page <- read_html(paste0("http://www.idph.state.il.us/brfss/countydata.asp?selTopicCounty=tobacco&areaCounty=", county_code$county_code[1], "&show=freq&yrCounty=5&form=county&yr=&area=&selTopic="))

county_page %>% 
  html_nodes("font") %>% 
  html_text()

county_page %>% 
  html_nodes("table") %>% 
  .[[15]] %>% 
  html_table(fill = TRUE) %>% 
  `colnames<-`(c("var"))

county_page %>% 
  html_nodes("td td tr~ tr+ tr select") %>% 
  html_text()