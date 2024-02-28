
################

  git.hub.name  <-  # YOUR GITHUB USERNAME 

###############
  
  
  
pkgs <- c("tools","devtools","purrr","rmarkdown")
install.packages()

wd <- getwd()
dir.create("MONTY")


## GENERATE PACKAGE REPORT 

filepath <- paste0( wd, "/MONTY/montyhall-test-", toupper(git.hub.name), ".HTML" )

download.file( 
  url = "https://raw.githubusercontent.com/Watts-College/paf-514-template/main/labs/create-r-package-test.rmd",  
  destfile = "./MONTY/create-r-package-test.rmd" )

rmarkdown::render( 
  input = "./MONTY/create-r-package-test.rmd", 
  output_file = filepath,
  params = list( name=git.hub.name ) )


# file location
filepath

# preview file 
shell( filepath )


