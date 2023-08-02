

###############################################
###
###   FUNCTION ARGUMENTS + SCOPE (REVIEW)
###
###############################################



x <- 1:100
y <- 10 + 2*x + rnorm(100,0,25) 


m <- lm( y ~ x )
summary(m)
summary(y)
 
run_regression <- function( x, y )
{

  x2 <- x*x
  y <- log(y)  # replace y in function 

  m <- lm( y ~ x + x2 )  # overwrite m
  print( summary(m) )
  return( m )
 
}



m2 <- run_regression( x=x, y=y )
summary( m2 )

# model m altered inside function 
# but not impact outside
summary( m )  

# y was over-written by the
# logged version of y inside the 
# function but fine out here
summary(y) 


### SUPER ASSIGNMENT OPERATOR
 
run_regression <- function( x, y )
{

  x2 <- x*x
  y <- log(y)   

  # super-assignment (never use this)
  m <<- lm( y ~ x + x2 )  
  print( summary(m) )
  return( m )
 
}



m2 <- run_regression( x=x, y=y )
summary( m2 )

# the original model m was over-written
# by the super-assignment operator
# inside the function 
summary( m )
 






######################################
###
###   TITLE DATA
###
######################################



URL <- "https://raw.githubusercontent.com/DS4PS/cpp-527-fall-2020/master/labs/data/medium-data-utf8-v2.csv"
d <- read.csv( URL )

# replace weird spaces with regular spaces
d$title <- gsub( " ", " ", d$title )
d$title <- gsub( "\\s", " ", d$title )

# note the use of single-quote marks since double-quotes appear in the text
d$title <- gsub( '<strong class=\"markup--strong markup--h3-strong\">', "", d$title )
d$title <- gsub( '</strong>', "", d$title )

# must use double-escape in front of the plus sign
# since it is an operator in reg-ex
# <U+200A>—<U+200A>
d$title <- gsub( "<U\\+200A>—<U\\+200A>", "", d$title )




######################################
###
###   WORKING WITH LISTS
###
######################################



titles <- tolower( d$title ) # convert to lower case
titles <- gsub( "[0-9]", "", titles )  # remove numbers

words <- strsplit( titles, " " )

head( titles )
head( words )

length( titles ) == length( words )


one.sentence <- words[[1]]
first.word <- one.sentence[1]
last.word <- one.sentence[ length(one.sentence) ]

one.sentence <- words[[2]]
first.word <- one.sentence[1]
last.word <- one.sentence[ length(one.sentence) ]

one.sentence <- words[[3]]
first.word <- one.sentence[1]
last.word <- one.sentence[ length(one.sentence) ]





######################################
###
###   COUNT WORDS (SENTENCE LENGTH)
###
######################################

# LOOP VERSION



results <- NULL

for( i in 1:length(words) )
{
   # extract vector from list position i
   one.sentence <- words[[i]]
   
   # analysis with one sentence at a time
   num.words <- length( one.sentence )

   # save results
   results[i] <- num.words
}



# APPLY VERSIONS

apply(  list,  function )

results <- lapply( words, length )
results <- unlist( results )

results <- sapply( words, length )






####################################
###
###   GET FIRST AND LAST WORDS
###
####################################


results <- NULL

for( i in 1:length(words) )
{
   # extract vector from list position i
   one.sentence <- words[[i]]
   
   # analysis with one sentence at a time
   first.word <- one.sentence[1]

   # save results
   results[i] <- first.word
}


# CUSTOM FUNCTIONS 

get_first_word <- function( x )
{
  first.word <- x[1]
  return( first.word )
}

get_last_word <- function( x )
{
  last.word <- x[ length(x) ]
  return( last.word )
}


one.sentence <- words[[2]]
get_first_word( one.sentence )
get_last_word( one.sentence )


results <- sapply( words, get_last_word )



