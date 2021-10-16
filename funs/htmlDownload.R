#### ---- Download tables from html pages -----

## url: webpage url

library(XML)
library(RCurl)
library(rlist)

htmlDownload <- function(url){
	url <- getURL(url 
		,.opts = list(ssl.verifypeer = FALSE)
	)
	extract_tabs <- readHTMLTable(url)
	clean_tabs <- list.clean(extract_tabs
		, fun = is.null
		, recursive = FALSE
	)
	tab_rows <- unlist(lapply(clean_tabs, function(t)dim(t)[1]))
	return(list(tables = clean_tabs, nrows = tab_rows))
}
