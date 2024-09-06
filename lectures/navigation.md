---
layout: lab
title: Directory Navigation Functions   
image: model.svg
image-width: 150px
---

<div class = "uk-container uk-container-small">

-----------------------

* TOC
{:toc}

-----------------------

<br>


## Some helpful navigation functions in R 

### Vocabulary 

- **directory**: folder
- **path**: `folder/hierarchy/in/which/file/lives`
- **file path**: `folder/hierarchy/FILENAME.CSV` 
- **absolute path**:  `C:/user/project/subfolder/filename.csv`  (location relative to root directory on a specific computer)
- **relative path**:  `subfolder/filename.csv` (location relative to the current directory)
- **dot**: `./subfolder/` means navigate from the current directory (usually works the same as `subfolder/` or `/subfolder/`)
- **double-dot**: `../subfolder/` go up one level, then into the subfolder


### Path Style 

Note that windows OS uses backslashes for paths (they lean backwards):

```
setwd( "C:\users\username\" )
# > Error in setwd( "C:\users\username\" ) : cannot change working directory
```

Whereas R uses forward slashes: 

```
setwd( "C:/users/username/" )  # this works 
```

### Functions  

```r
######################################
######################################     CURRENT FOLDER
######################################


getwd()
[1] "C:/Users/lecy/Documents"

dir()   # LIST FILES IN DIRECTORY

# [1] "AWS"                                                       
# [2] "AWS-NCCS-EFILE.csv"  
# [3] "bmf"
# [4] "2023-05-POL-ORGS-SCHED-A.csv"                              
# [5] "2023-05-POL-ORGS-SCHED-B.csv"                              
# [6] "2023-05-POL-ORGS-SCHED-D.csv"


######################################
######################################     BASIC NAVIGATION
######################################


# NOTE DIFFERENCE BETWEEEN FOLDERS AND FILES


setwd( "AWS-NCCS-EFILE.csv" )     # FILES HAVE EXTENSIONS

# > Error in setwd( "AWS-NCCS-EFILE.csv" ) : cannot change working directory

dir.exists( "AWS-NCCS-EFILE.csv" )
[1] FALSE
file.exists( "AWS-NCCS-EFILE.csv" )
[1] TRUE


dir.exists( "AWS-NCCS-EFILE.csv" )
[1] FALSE
file.exists( "AWS-NCCS-EFILE.csv" )
[1] TRUE


dir.exists( "AWS" )     # FOLDERS DO NOT HAVE EXTENSIONS
[1] TRUE
file.exists( "AWS" )
[1] FALSE

setwd( "AWS" )      

getwd()
# [1] "C:/Users/lecy/Documents/AWS"


setwd( ".." )     # RETURN TO PARENT FOLDER
getwd()
# [1] "C:/Users/lecy/Documents"

setwd( "bmf" )

getwd()
# [1] "C:/Users/lecy/Documents/bmf"

dir()
# [1] "BMF-2022-01-501CX-NONPROFIT-PX.csv" "BMF-2022-08-501CX-NONPROFIT-PX.csv"
# [3] "BMF-LABELED-TEMP.rds"               "BMF_TAX_EXEMPT_PURP.csv"           
# [5] "BMF_UNIFIED_V1.1.csv"               "BMF_UNIFIED_V1.2.csv"              

file.exists( "BMF_UNIFIED_V1.1.csv" )
[1] TRUE

file.exists( "WRONG_NAME.csv" )
[1] FALSE


######################################
######################################     CREATE NEW FOLDERS
######################################

dir()
# [1] "BMF-2022-01-501CX-NONPROFIT-PX.csv" "BMF-2022-08-501CX-NONPROFIT-PX.csv"
# [3] "BMF-LABELED-TEMP.rds"               "BMF_TAX_EXEMPT_PURP.csv"           
# [5] "BMF_UNIFIED_V1.1.csv"               "BMF_UNIFIED_V1.2.csv"              


setwd( "TEST" )
# > Error in setwd( "TEST" ) : cannot change working directory

dir.create( "TEST" ) 
dir()

# [1] "BMF-2022-01-501CX-NONPROFIT-PX.csv" "BMF-2022-08-501CX-NONPROFIT-PX.csv"
# [3] "BMF-LABELED-TEMP.rds"               "BMF_TAX_EXEMPT_PURP.csv"           
# [5] "BMF_UNIFIED_V1.1.csv"               "BMF_UNIFIED_V1.2.csv"                           
# [7] "TEST"

setwd( "TEST" )

getwd()
# [1] "C:/Users/lecy/Documents/bmf/TEST"

dir()  # EMPTY FOLDER
# character(0)


######################################
######################################     RELATIVE NAVIGATION 
######################################

getwd()
# [1] "C:/Users/lecy/Documents/bmf/TEST"

setwd( "../.." )  # GO UP TWO LEVELS 
getwd()
# [1] "C:/Users/lecy/Documents"

setwd( "bmf/TEST" )  # GO DOWN TWO LEVELS (FOLDER IN A FOLDER)
getwd()
# [1] "C:/Users/lecy/Documents/bmf/TEST"
```

### Show All Contents 

If you ever want an inventory of project files try the **fs** package. 

```r
## PRINT CONTENT MAP
library( fs )
setwd( ".../intro-data-science-TEMPLATE" )
dir_tree( path="units" )
```

```
units
+-- 00-foundations
|   +-- handouts
|   |   +-- base-r-cheatsheet.pdf
|   |   +-- data-wrangling-cheatsheet.pdf
|   |   +-- dplyr-cheatsheet.pdf
|   |   \-- rstudio-IDE-cheatsheet.pdf
|   +-- img
|   |   +-- ch-001-image1.jpg
|   |   +-- ch-001-image2.jpg
|   |   \-- ch-001-image3.jpg
|   +-- pubs
|   |   +-- data-science-sexiest-job-21st-century.pdf
|   |   +-- helpful-vocabulary.docx
|   |   +-- r-is-still-hot.pdf
|   |   \-- r-style-guide.docx
```

<br>
<br>
<hr>
<br>
<br>

</div>
