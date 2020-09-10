library(tidyverse)
library(rvest)
library(RSelenium)
library(sf)
library(ggmap)

#To scrape the website, we're inserting a bunch of addresses across the lower 48 -- this first part of the script gets those addresses by gridding the US, getting lon/lat coordinates, and reverse geocoding them
state_shps <- tigris::states(cb = T) %>% 
  filter(!(STATEFP %in% c("02", "15" ,"66","69","72","78","60"))) %>% 
  st_geometry()
state_grid <- st_make_grid(state_shps, n =c(50,30), what = "centers")#previously 30, 20 
revgeocode_format <- function(x){
  x <- as.numeric(x) %>% 
    revgeocode(output = "all") %>% 
    "[["("results")
  street_adds <- map(x, function(y) "street_address" %in% unlist(y$types)) %>% unlist()
  
  x <- x %>% 
    map(function(y) y$formatted_address) %>% 
    unlist()
  if(any(street_adds)) return(x[street_adds][1])
  return(x[1])
}
input_adds <- unlist(map(state_grid, revgeocode_format))
  

#This section contains some helper functions and vectors to scrape the website
pull_element <- function(res, node){
  element <- res %>% html_nodes(node) %>% 
    html_text() %>% str_squish() %>% 
    set_names(rep(names(node), length(.)))
  if(!length(element)) return("")
  return(element)
}
nodes <- c(name = ".facility_nameWrap", services = ".search-services",
           type = ".facility-type", treats = ".facility-treats",
           street = ".address-Street", city_state = ".address-state-city",
           phone = ".phone-no", hcps = ".hcp-count", 
           insurance = ".accepted-insurance"
           )
get_providers <- function(add){
  message(which(input_adds==add))
  address_input <- rd1$findElement(using = "xpath", value = "/html/body/div[1]/div[1]/div/div/article/table/tbody/tr[3]/td[1]/div/div[1]/form/div[1]/input")  #Finds the space where addresses should be typed in, and types them in
  address_input$clearElement()
  address_input$sendKeysToElement(list(add))
  dist_input <- rd1$findElement(using = "xpath", value = "/html/body/div[1]/div[1]/div/div/article/table/tbody/tr[3]/td[1]/div/div[1]/form/div[3]/div/select/option[6]")
  dist_input$clickElement() #set the search radius distance to 150miles
  search_btn <- rd1$findElement(using = "xpath", value ="/html/body/div[1]/div[1]/div/div/article/table/tbody/tr[3]/td[1]/div/div[1]/form/div[2]/input")
  search_btn$clickElement() #hit the search button
  Sys.sleep(3) #If you go too fast an error message is returned saying you tried to click a disabled button -- this could be either because 1) they want to prevent server overloading so they make you wait or 2) the page just didn't load yet so you're trying to click something that's not there
  #another disclaimer/disclosure thing can pop up
  results <- rd1$getPageSource()[[1]] %>% read_html() %>% 
    html_nodes(".media-result") 
  if(!length(results)){ warning("Address ", which(input_adds==add), " returned no results"); return(NULL)}
  #Think I have to iterate through each result because there are often pieces of information missing for each entry
  results <- map_dfr(1:length(results), function(i){
    result <- results[[i]]
    map_dfc(nodes, function(x) pull_element(result, x))
  })
  return(results)
}

rd <- rsDriver()
rd1 <- rd[["client"]]
rd1$open()
rd1$navigate("https://www.vivitrol.com/find-a-treatment-provider")
element <- rd1$findElement(using = "xpath", value = "/html/body/div[4]/div/div/div[1]/button") #there's a warning/disclosure message at the beginning, so we should close that
element$clickElement()
search_btn <- rd1$findElement(using = "xpath", value ="/html/body/div[1]/div[1]/div/div/article/table/tbody/tr[3]/td[1]/div/div[1]/form/div[2]/input")
search_btn$clickElement() #hit the search button to trigger another one-time disclosure/agreement
agree_btn <- rd1$findElement(using = "xpath", value ="/html/body/div[1]/div[2]/div/div/div[2]/div/a[1]") 
agree_btn$clickElement() 
#And now automation can begin
providers <- list()
#This breaks sometimes when my internet goes down or the website just doesn't load fast enough -- a for loop, as opposed to map() or lapply(), lets you start midway without losing progress
for(i in 1:length(input_adds)){
  providers[[i]] <- get_providers(input_adds[i])
}
saveRDS(providers, "data/raw/providers_list.RDS")
providers <- readRDS("data/raw/providers_list.RDS") %>% 
  bind_rows() %>% 
  unique() %>% 
  mutate(hcps = str_remove(hcps, "HCPs On-Site: "),
         hcps_count = as.numeric(word(hcps, 1)), 
         hcps_names = word(hcps, 2,-1),
         insurance = str_remove(insurance, "Accepted Insurance: ")) %>% 
  select(-hcps)
write_csv(providers, "data/clean/vivitrol_providers.csv")
