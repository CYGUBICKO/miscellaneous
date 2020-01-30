#### ---- Missingness proportion ----

## Compute the proportion of missing data per variable 
### df: data.frame
### addpatttern: any additional patterns to consider as missing values

missProp <- function(df, addpatttern = NULL){
	n <- nrow(df)
	df <- as.data.frame(df)
	miss_count <- apply(df, 2
		, function(x){
		if (!is.null(addpatttern)){
			x <- ifelse(grepl(addpatttern, x, ignore.case = TRUE), NA, x)
		}
		return(sum(is.na(x)|as.factor(x)==""|x=="?"))
	})
	miss_df <- (miss_count
		%>% as_tibble(rownames = NA)
		%>% rownames_to_column("variable")
		%>% rename(miss_count = value)
		%>% mutate(miss_prop = miss_count/n)
		%>% mutate(miss_prop = round(miss_prop, digits = 3) * 100)
	)
}

