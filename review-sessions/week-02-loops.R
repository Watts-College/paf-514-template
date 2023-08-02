# BOOTSTRAPPING TYPE II ERRORS
# Examine Type II Errors
# as a function of sample size

# load data and helper functions
source( "https://raw.githubusercontent.com/DS4PS/cpp-527-fall-2020/master/lectures/loop-example.R" )
head( d )                       # data frame with X and Y 
get_sample_slope( d, n=10 )     # returns a single value
test_for_null_slope( d, n=10 )  # returns a one-row data frame

## EXAMINE SLOPES
## sample size = 10





### CONSTRUCTOR EXAMPLES

# always define constructors outside the loop 

slopes <- NULL  # collector vector





## BOOKSHELF CONSTRUCTOR
# [ 1 ] <- "a"
# [ 2 ] <- "b"
# [ 3 ] <- "c"

slopes[ i ] <- b1 


slopes <- NULL  # collector vector 

for( i in 1:1000 )  # iterator i
{

  b1 <- get_sample_slope( d, n=10 )
  slopes[ i ] <- b1   
 
}

# sampling distribution 
hist( slopes, breaks=25, col="gray20", border="white" )







# APPEND CONSTRUCTOR
# append adds something to the end of a vector

x <- 1:10
c( x, 44 )

slopes <- c( slopes, b1 )








### ANALYSIS OF SALES BY ZIP CODE
# d database of sales
# type = books, gardening, tech
# id
# zip
# product.id
# cost

ave.cost.per.zip <- NULL  # collector vector

all.zips <- c( 55246, 23652, 77392, 55246 )
# only want to analyze each zip code once
unique.zips <- unique( all.zips )

loop.count <- 1

for( i in unique.zips )  # iterator i
{
  d.sub <- filter( type="books", zip == i  )
  ave.cost <- mean( d.sub$cost ) 
  
  # these both work
  ave.cost.per.zip <- c( ave.cost.per.zip, ave.cost )
  ave.cost.per.zip[ loop.count  ] <- ave.cost 
  
  # this one doesn't because i is a zip code
  ave.cost.per.zip[ i ] <- ave.cost 

  loop.count <- loop.count + 1
 
}









### DOUBLE ITERATOR EXAMPLE

# edge scenario analysis for monty hall
#
# how many times will the sample function
# break in the game because we try to take
# a random draw from a single value:
#
# sample( 3, size=1 )
#
# instead of from a vector of values:
#
# sample( c(1,3), size=1 )

# This can only occur when:
# (1) We select a goat in the first round 
# (2) The remaining door must be door 2 or 3
#
# if the last door is one sample( 1, size=1 ) still works


# Outer loop represents the state of the game
# Inner loop represents the player draw
# Each scenario is some combination of i and j


for( i in 1:3 )
{
  for( j in 1:3 )
  {
     # pseudocode to examine if sample will break
     game.i.j <- scenario[ i , j ] 
     condition.01 <- length( doors ) < 2
     condition.02 <- door != 1
     sample.breaks <- condition.01 & condition.02
  }
}








### LIST CONSTRUCTORS
# double bookshelf
# [[ 1 ]] <- "a"
# [[ 2 ]] <- "b"
# [[ 3 ]] <- "c"


models <- list() # collector vector 



for( i in 1:10 )  # iterator i
{

  m <- lm( y ~ x, data=d )
  models[[ i ]] <- m  
 
}






## EXAMINE CONFIDENCE INTERVALS
## sample size = 10

# build the
# results data frame 
# using row binding


results <- NULL

for( i in 1:50 )
{

  null.slope.test <- test_for_null_slope( d, n=10 )
  results <- rbind( results, null.slope.test )

}

plot_ci( df=results )




### WHILE LOOPS 
#
# while( condition is TRUE )
# {
#    # keep doing this  
# }


# RAISING A PIG
#
# feed the pig until it reaches 
# 200 lbs then sell it

# pig gains 1 lb each day
feed_pig <- function( weight )
{  
   new.weight <- weight + 1
   return( new.weight ) 
}


current.pig.weight <- 100

# history of weights 
old.weight <- pig.weight

loop.count <- 1

while( current.pig.weight < 200 )
{

  new.weight <- feed_pig( pig.weight )
  old.weight <- c( old.weight, new.weight )
  current.pig.weight <- new.weight
  
  # to see data while loop is running 
  # print( pig.weight )

}

sell_pig()






loop.count <- 1

while( ! at.center(tootsie.loop) )
{

  tootsie.pop <- lick( tootsie.pop )
  loop.count <- loop.count + 1

}

# how many licks did it take?
loop.count 





# gambling example
#
# casino has 1,000 tourists visit each day
# on average they bring $10 each to gamble
#
# need to estimate tables needed at peak
# 
# must estimate average time they will spend in the casino;
# they play roullette, each spin takes 1 minute
#
# they gample until they lose all of their money 

cash <- 10  
results <- NULL
loop.count <- 1  

while( cash > 0 )
{
  cash <- cash +  sample( c(-1,0,1), size=1 )  
  results[ loop.count ] <- cash  
  loop.count <- loop.count + 1  

  # in case of winning streak
  if( loop.count > 100000 )
  { break } 
}

results











