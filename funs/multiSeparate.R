
#### ---- Separate/split multiple response column ----
# This function creates new variable based on multiple response entry and creates new columns. 

## Input
# df - Dataframe
# vars - Multiple response variables
# pattern - Character string separating the entries
# remove - TRUE/FALSE. If true, parent multiple response variable will not be returned.
# drop_ns - Whether to return a counts for the selections for every multiple response variable.

## Value
# Dataframe with the new variables. Created variables inherits names from the parent name + _number. Counts for number of selections per case inherits the name from parent variable + _nselected.

multiSeparate <- function(df, vars, pattern, remove = FALSE, drop_ns = FALSE){
   for (var in vars){
      nselected <- paste0(var, "_nselected")
      df <- (df
         %>% rename(temp_multi = var)
         %>% mutate(temp_nselected = sapply(
               regmatches(temp_multi, gregexpr(pattern, temp_multi))
               , length
            ) + 1
         )
      )
      # Max number of new variables to create
      maxselected <- max(pull(df, temp_nselected))

      # Create the new variable
      df <- (df
         %>% separate_("temp_multi"
            , c(paste0(rep(var, maxselected), "_", 1:maxselected))
            , sep = pattern
            , remove = remove
            , convert = TRUE
         )
         %>% rename_(.dots = setNames(c("temp_multi", "temp_nselected"), c(var, nselected)))
      )
      if(drop_ns){
         df <- select(df, -c(grep("_nselected$", colnames(df), value = TRUE)))
      }
   }
   return(df)
}

