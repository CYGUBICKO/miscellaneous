#### ---- Dowunload dataset ----
# The function will check if the dataset is in the dir (and load) otherwise download (and load)

## filename: The name (can also be a pattern string) of the file to check or save as the output (without .filetype)
## filetype: file extension (no ".")
## url: Data url

downloadDf <- function(filename, filetype, df_url){
   if(length(list.files("."))>0 & sum(grepl(filename, list.files("."), ignore.case = TRUE))==1){
      df_name <- grep(filename, list.files(), value = T)
      cat("Reading dataset from your computer... \n")
      working_df <- read.csv(df_name)
      cat(paste0(filename, ".", filetype), " dataset already saved!!! \n")
   } else {
      # Download data
      cat("Downloading dataset from ", df_url, "\n")
      temp_df <- read.csv(df_url)
      write.csv(temp_df, paste0(filename, ".", filetype), row.names = FALSE)
      working_df <- temp_df
      cat(filename
         , " didn't exist!!! We've downloaded data from the url "
         , df_url, "\n Dataset dim: "
                        , dim(temp_df)
                        , "\n"
      )
   }
   return(working_df)
}


