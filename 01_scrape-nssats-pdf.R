# Scrape PDF of NSSATS directory

library(pdftools)
library(tidyverse)
pdf <- pdf_text("data/nssats_directory_2018.pdf")
# pages 313-360 are illinois

all_text <- pdf[[360]] %>% 
  str_split("\n") %>% 
  unlist()

first_col <- vector(mode = "character", length = length(all_text))
second_col <- vector(mode = "character", length = length(all_text))
third_col <- vector(mode = "character", length = length(all_text))

# How to do it!
for (i in (1:length(all_text))) {
  first_col[i] <- str_sub(all_text[i], 1, 39) # some need to be 38
  second_col[i] <- str_sub(all_text[i], 40, 79) 
  third_col[i] <- str_sub(all_text[i], 80, -1)
}
  
c(first_col, second_col, third_col)

# nchar(" Corporate Health Resource Center     M")

# check output
write.table(all_text, file = "all_text.txt")
write.table(first_col, file = "first_col.txt")
write.table(second_col, file = "second_col.txt")
write.table(third_col, file = "third_col.txt")


# Sandbox -----------------------------------------------------------------

# not the proper way to extract columns in this case
for (i in (1:length(all_text))) {
  extracted <- all_text[i] %>% 
    str_split_fixed("  ", 3)
  first_col[i] <- extracted[, 1] # leave as is
  
  if (first_col[i] == "") {
    first_col[i] <- " "
  }
  
  text_minus_first_column <- str_remove(all_text[i], first_col[i])
  extracted2 <- text_minus_first_column %>%
    str_trim(side = "left") %>%
    str_split_fixed("  ", 2)
  
  second_col[i] <- extracted[, 2] 
  third_col[i] <- extracted[, 3] 
}

