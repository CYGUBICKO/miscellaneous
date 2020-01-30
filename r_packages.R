
# Install url/archived packages or github packages
pkgs_names <- c("https://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz"
	, "https://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz"
	, "https://cran.r-project.org/src/contrib/Archive/FCNN4R/FCNN4R_0.6.2.tar.gz"
	, "https://sites.google.com/a/aims.ac.za/cygu/research/cnre_1.0.tar.gz?attredirects=0&d=1"
	, "matloff/polyreg"
	, "data.table", "Amelia", "stringr" 
	, "dplyr", "corrplot" , "caret"
	, "MASS", "openxlsx", "ROCR"
	, "caTools", "e1071" , "ranger"
	, "nnet", "ggplot2", "readr"
	, "knitr", "rmarkdown", "httr"
	, "rvest", "xml2", "BiocManager"
	, "rprojroot", "DT", "webshot"
	, "dplyr", "tidyverse"
	, "mlr", "DMwR", "ROSE"
	, "rJava", "arules", "haven"
	, "summarytools", "psych"
	, "ztable", "ggthemes"
	, "shiny", "shinydashboard"
	, "plotly", "ggExtra"
	, "twitteR", "lubridate"
	, "tidytext", "stringr"
	, "tm", "wordcloud", "RColorBrewer"
	, "plotly", "crosstalk"
	, "davesteps/shinyFilters" # https://github.com/davesteps/shinyFilters
	, "longclust", "glmmTMB"
	, "blme", "brms", "rattle"
#	, "drizopoulos/JMbayes"
	, "https://cran.r-project.org/src/contrib/rgl_0.100.19.tar.gz" # Run apt-get install  libx11-dev mesa-common-dev libglu1-mesa-dev on the terminal
	, "https://cran.r-project.org/src/contrib/Archive/gridSVG/gridSVG_1.5-1.tar.gz", "plotROC"
	, "wesanderson", "viridis"
	, "expss", "logisticPCA", "dirichletprocess"
	, "DPpackage" #, "PReMiuM"
	, "plotMCMC", "broom.mixed", "afex"
	, "wbonat/mcglm", "broom"
	, "directlabels", "stargazer"
	, "survivalsvm", "survival"
	, "tabulizer", "pec"
	, "ggfortify", "gganimate"
	, "gifski", "wbstats"
	, "colorspace"
	, "REEMtree"
	, "splinetree"
)

# TRUE if you want to load the installed packages
pkgs_load <- FALSE

# Install devtools and pacman if not installed
if (!"devtools" %in% installed.packages()[,1]){
	install.packages("devtools")
}

if (!"pacman" %in% installed.packages()[,1]){
	install.packages("pacman")
}

pkgs_names <- pkgs_names[!pkgs_names %in% c("devtools", "pacman")]

pkgs_2install <- NULL
pkgs_2load <- NULL

for (pkg in pkgs_names){
	
	# Github names and github urls
	# Count / to determine if github name or url
	pos <- unlist(gregexpr("/", pkg, perl = TRUE))
	if (grepl("git", pkg) | (length(pos)==1 & (!"-1" %in% pos))){
		pieces <- unlist(strsplit(pkg, "/"))
		pkg_name <- pieces[length(pieces)]
		git_name <- paste(pieces[length(pieces) - 1]
			, "/"
			, pkg_name
			, sep = ""
			)
			if (!pkg_name %in% installed.packages()[,1]){
				devtools::install_github(git_name, dependencies = TRUE)
				pkgs_2install <- c(pkgs_2install, pkg_name)
			}
		  pkgs_2load <- c(pkgs_2load, pkg_name)
	}
	
	# CRAN archives and other webpages
	if (grepl("\\.tar|\\.gz", pkg)){
		pkg_url <- gsub("(.tar.gz).*", "\\1", pkg)
		pieces <- unlist(strsplit(pkg_url, "/"))
		archive_file <- grep("\\.tar|\\.gz", pieces, value = TRUE)
		archive_name <- gsub("_.*", "", archive_file)
		if (!archive_name %in% installed.packages()[,1]){
			devtools::install_url(pkg_url, dependencies = TRUE)
			pkgs_2install <- c(pkgs_2install, archive_name)
		}
		pkgs_2load <- c(pkgs_2load, archive_name)
	} 
	
	# Install packages available in CRAN
	if (length(grep("/", pkg)) == 0){
		if (!pkg %in% installed.packages()[,1]){
			install.packages(pkg, dependencies = TRUE)
			pkgs_2install <- c(pkgs_2install, pkg)
		}
	  pkgs_2load <- c(pkgs_2load, pkg)
	}
}

# Successful new installations
pkgs_installed <- pkgs_2install[pkgs_2install %in% installed.packages()[,1]]

# Check failed installations
pkgs_failed <- pkgs_2install[!pkgs_2install %in% installed.packages()[,1]]

# Load installed packages
pkgs_loaded <- pkgs_2load[pkgs_2load %in% installed.packages()[,1]]
if (pkgs_load){
	pacman::p_load(pkgs_loaded
		, install = FALSE
	   , character.only = TRUE
		, dependencies = TRUE
	)
	cat("\nFollowing packages were successfully loaded:\n"
	, paste(pkgs_loaded, "\n", sep = "")
	)
}

if (length(pkgs_2install)==0){
	cat("\nNo new package was installed. It seems you had the packages already installed!\n")
} 
if (length(pkgs_installed) > 0){
	cat("\nThe following 'new' packages were successfully installed:\n"
		, paste(pkgs_installed, "\n", sep = "")
	)
} 
if (length(pkgs_failed) > 0){
	cat("\nThe following packages could not be installed:\n"
		, paste(pkgs_failed, "\n", sep = "")
	)
}

# To convert html tables to pdf tables
# webshot::install_phantomjs()

# ~/.R/Makevars file for rstan
# CXX_STD = CXX14
# CXX14 = g++ -std=c++11
# CXX14FLAGS = -O3 -fPIC -Wno-unused-variable -Wno-unused-function -DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION

