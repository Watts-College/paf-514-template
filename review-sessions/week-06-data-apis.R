library( censusapi )
library( jsonlite )
library( httr )

##################################################################
####      API QUERY:
##################################################################

API.BASE     <- "https://api.census.gov/data"
API.VINTAGE  <- "2015"
API.NAME     <- "acs/acs5"
VARIABLE     <- "B01001_001E"      # TOTAL POPULATION (E for Estimate)
STATE        <- "04"               # AZ STATE FIPS CODE
KEY          <- "your.unique.census.key.goes.here"

##################################################################

BASE.URL <- paste( API.NAME, API.VINTAGE, API.NAME, sep="/" )
BASE.URL

# [1] "https://api.census.gov/data/2015/acs/acs5"

FULL.URL <- paste( BASE.URL, "?get=NAME,", VARIABLE, "&for=state:", STATE, "&key=", KEY, sep="" )
FULL.URL

# [1] "https://api.census.gov/data/2015/acs/acs5?get=NAME,B01001_001E&for=state:04&key=your.unique.census.key.goes.here"
#
# [["NAME","B01001_001E","state"],
# ["Arizona","6641928","04"]]



### DATA PROCESSING FUNCTIONS 

api.data.raw <- httr::GET( FULL.URL )

matrix_to_df <- function( m )
{
  d <- as.data.frame(m)
  col.names <- d[ 1, ]    # get first row
  names(d) <- col.names   # assign as column names 
  d <- d[ -1 , ]          # delete first row
  return(d)
}


json_to_data_frame <- function( api.data.raw )
{
    data.as.json <- httr::content( api.data.raw, as = "text" )
    data.as.matrix <- jsonlite::fromJSON( data.as.json )
    data.as.df <- matrix_to_df( data.as.matrix )
    return( data.as.df )

}


json_to_data_frame( api.data.raw )  # returns a data frame 
     NAME   B01001_001E   state
2 Arizona       6641928      04

# intermediate data formats for reference 

data.as.json
[1] "[[\"NAME\",\"B01001_001E\",\"state\"],\n[\"Arizona\",\"6246816\",\"04\"]]"

data.as.matrix
     [,1]      [,2]          [,3]   
[1,] "NAME"    "B01001_001E" "state"
[2,] "Arizona" "6246816"     "04"   




### ALL STATES


KEY           <- "your.unique.census.key.goes.here"
API.NAME      <- "https://api.census.gov/data"
API.VINTAGE   <- "2015"
API.NAME      <- "acs/acs5"
VARIABLE      <- "B01001_001E"      # TOTAL POPULATION (E for Estimate)
STATE         <- "*"                # ALL STATES

BASE.URL <- paste( API.NAME, API.VINTAGE, API.NAME, sep="/" )
FULL.URL <- paste( BASE.URL, "?get=NAME,", VARIABLE, "&for=state:", STATE, "&key=", KEY, sep="" )

api.data.raw <- httr::GET( FULL.URL )

json_to_data_frame( api.data.raw )

                   NAME B01001_001E state
2               Alabama     4830620    01
3                Alaska      733375    02
4               Arizona     6641928    04
5              Arkansas     2958208    05
6            California    38421464    06
7              Colorado     5278906    08
8           Connecticut     3593222    09
9              Delaware      926454    10




### COUNTIES IN A STATE

for=county:*&in=state:*




### AVAILABLE APIs

apis <- censusapi::listCensusApis()
head( apis[,1:3], 25 )


### AS A FUNCTION 

get_census_data <- function( VINTAGE, API.NAME, VARIABLE, STATE, KEY )
{
   API.BASE <- "https://api.census.gov/data"
   BASE.URL <- paste( API.BASE, VINTAGE, API.NAME, sep="/" )
   FULL.URL <- paste( BASE.URL, "?get=NAME,", VARIABLE, "&for=state:", STATE, "&key=", KEY, sep="" )
   api.data.raw <- httr::GET( FULL.URL )
   df <- json_to_data_frame( api.data.raw )
   return( df )
}

