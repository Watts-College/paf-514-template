###   <  STEP 0  >
###   ------------
###   install packages


  #   Windows users: 
  #   install Rtools from
  #   https://cran.r-project.org/bin/windows/Rtools/ 



install.packages(
  c( "devtools", "roxygen2",
     "usethis", "testthat",
     "knitr" ) )


  #   check if ready to build:
  #   in basic R console (recommended) 

library( devtools )

options( buildtools.check = function(action) TRUE )
has_devel()


  #   in R Studio (not recommended)

library( devtools )
has_devel()


  #   DIRECTORY SETUP: 
  #   your default directory is 
  #   usually my documents;
  #   if you don't want to create
  #   the package in your default 
  #   working directory navigate
  #   to your desired folder

  #   setwd( ".../path/to/class/folder/..." )

  #   create subdirectory for package assignment:

getwd()              
dir.create( "pkg" )
setwd( "pkg" )
getwd()


  #   >>> put your R scripts in "pkg" folder
  #       check to see if they are there

dir()  



  #   save root project directory
  #   for easy navigation later: 
  #   root.dir = .../documents/pkg

root.dir <- getwd() 


  #   documents 
  #   ├─ pkg                   <<< you are here      
  #   │  ├─ montyhall-pkg.R  
  #   │  ├─ annotated-pkg-creation.R

  




###   <  STEP 1  >
###   ------------
###   create the package skeleton

usethis::create_package( "montyhall" )

getwd()   # inside montyhall 
dir()     # /R, DESCRIPTION, +


  #   documents 
  #   ├─ pkg          
  #   │  ├─ montyhall   <<<
  #   │     ├─ R





###   <  STEP 2  >
###   ------------ 
###   move R script to montyhall/R folder
###   after completing documentation fields 


  #   you can move it manually,
  #   this step for demo purposes 

mhp.path <- paste0( root.dir, "/montyhall-pkg.R" )
r.folder <- paste0( root.dir, "/montyhall/R/montyhall-pkg.R" )
file.copy( from=mhp.path, to=r.folder )


  #   see how you did: 

setwd( "R" )
dir()
file.show( "montyhall.R" )


  #   documents 
  #   ├─ pkg        
  #   │  ├─ montyhall  
  #   │     ├─ R                    <<<
  #   │        ├─ montyhall-pkg.R   





###   <  STEP 3  >
###   ------------
###   document your functions 

setwd( ".." )
getwd()  # should be .../montyhall


  #   documents 
  #   ├─ pkg         
  #   │  ├─ montyhall  <<<
  #   │     ├─ R


devtools::document()

  #   documents 
  #   ├─ pkg         
  #   │  ├─ montyhall  
  #   │     ├─ R
  #   │     ├─ man    <<< new folder


  #   see how you did:

dir()
setwd("man")
dir()
file.show( "create_game.Rd" )







###   <  STEP 4  >
###   ------------
###   install package 
###   and test it 

setwd( root.dir )
getwd()  # should be .../pkg


  #   documents 
  #   ├─ pkg           <<<
  #   │  ├─ montyhall  
  #   │     ├─ R
  #   │     ├─ man    


devtools::install( "montyhall" )
montyhall::create_game()

library( montyhall )
create_game()




###   <  STEP 5  >
###   ------------
###   remove package installation; 
###   install package from github

detach( "package:montyhall" )  # closes the package so not locked
remove.packages( "montyhall" ) # deletes from your computer 

library( montyhall )

  #   SHOULD BE: 
  #   Error in library(montyhall) : there is no package called ‘montyhall’


  #   AFTER you have moved all files to github,
  #   close R and re-open a fresh console

devtools::install_github( "yourGitHubName/montyhall" )


  #   see how you did:

montyhall::create_game()









###   <  SEE ALL PACKAGE FILES  >
###   ---------------------------
###   for a nice visual of your completed 
###   package print the full directory:  


install.packages( "fs" )
setwd( root.dir )
fs::dir_tree( path="units" )







###   <  SAVE THIS FILE  >
###   --------------------
###   if you want to save these steps 
###   in case you need to update the 
###   package sometime in the future:

montyhall.folder <- paste0( root.dir, "/montyhall" )
setwd( montyhall.folder )
dir.create( "notes" )

  #   save script first if you made changes, then: 

mhp.path <- paste0( root.dir, "/annotated-pkg-creation.R" )
notes.folder <- paste0( root.dir, "/montyhall/notes/annotated-pkg-creation.R" )
file.copy( from=mhp.path, to=notes.folder )


  #   see how you did: 

setwd( "notes" )
dir()
file.show( "annotated-pkg-creation.R" )


  #   documents 
  #   ├─ pkg           
  #   │  ├─ montyhall  
  #   │     ├─ notes    
  #   │        ├─ annotated-pkg-creation.R    <<<