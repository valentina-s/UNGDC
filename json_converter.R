library(jsonlite)

# directory containing the JSON files
json_directory <- "UNGDC/output_json"

# list to store data frames for each file
file_df_list <- list()

# loop through each JSON file in the directory
for (json_file in list.files(json_directory, pattern = "*.json")) {
  # read the JSON file and convert to a data frame
  file_data <- fromJSON(paste(readLines(file.path(json_directory, json_file)), collapse = ""))
  file_df <- data.frame(file_name = file_data$file_name, file_text = file_data$file_text)

  # add the data frame to the list
  file_df_list[[json_file]] <- file_df
}

# combine all data frames into one data frame
combined_df <- do.call(rbind, file_df_list)

saveRDS(combined_df, file = "UNGDC.rds")

