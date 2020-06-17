# Bind travel times 
access_time_files <- list.files("data/access_results/access_time/")
files <- file.path("data/access_results/access_time", access_time_files)

access_time_results <- do.call("rbind", lapply(files, function(files){ read.csv(files)}))

write_csv(access_time_results, "data-output/access_results_combined/access_times.csv")


# Bind access score 

# time for a function
bind_and_write <- function(folder_path, outfile_name) {
  files <- list.files(folder_path)
  full_files <- file.path(folder_path, files)

  df_bound <- do.call("rbind", lapply(full_files, function(files){ read.csv(files)}))
  
  write_csv(df_bound, outfile_name)
}

bind_and_write("data/access_results/access_model_30/", 
               "data-output/access_results_combined/access_model_30.csv")

bind_and_write("data/access_results/access_model_60/", 
               "data-output/access_results_combined/access_model_60.csv")


# Bind counts
bind_and_write("data/access_results/access_count_30/", 
               "data-output/access_results_combined/access_count_30.csv")

bind_and_write("data/access_results/access_count_60/", 
               "data-output/access_results_combined/access_count_60.csv")
