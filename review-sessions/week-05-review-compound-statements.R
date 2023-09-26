library( dplyr )
library( pander )
library( quanteda )

URL <- "https://github.com/DS4PS/cpp-527-spr-2020/blob/master/labs/data/IRS-1023-EZ-MISSIONS.rds?raw=true"
dat <- readRDS(gzcon(url( URL )))
mission <- dat$mission



### Q1. How many missions start with the word “to”? 
###     Make sure it is the word “to” and not words that 
###     start with “to” like “towards”.


starts.with.to <- 
  grep( 
    "^to ", 
    dat$mission, 
    value = TRUE, 
    ignore.case = TRUE )

sample( starts.with.to, 100 )  # do they all look good?

### both fine:

grepl( "^to ", dat$mission, ignore.case = TRUE ) %>% sum()
grepl( "^to\\s", dat$mission, ignore.case = TRUE ) %>% sum()



### COMMON MISTAKES

###  forgot the space: 
###  returns 'tomorrow', 
###  'toward', etc

grepl( "^to", dat$mission, ignore.case=TRUE ) %>% sum()


###  misses all caps titles: "TO "
###  easy solution: 
###  add ignore.case = TRUE

to.missions <- 
  grep( 
    "^to |^To ",  
    dat$mission, 
    value = TRUE )

head( to.missions, 25 )   # looks good?

##  Inspection doesn't help
##  because you won't know 
##  you are missing allcaps
##  titles if they are not 
##  returned by your data
##  previews 







### COMPOUND EXPRESSIONS 
###
###   nesting logic often 
###   leads to unexpected 
###   behaviors and code 
###   that is impossible
###   to inspect and debug


grep( 
      "^(To |to )", 
      dat$mission, 
      value=TRUE  ) %>%

  head( 25 )




### BETTER OPTIONS 
### FOR LOGICAL STATEMENTS: 

###  keep your expressions simple
###  and combine the results

case1 <- grepl( "^To ", dat$mission ) 
case2 <- grepl( "^to ", dat$mission ) 
 
###  if the title matches
###  case1 OR case2 
###  then matches will be TRUE

case1 <- c(F,T,F)
case2 <- c(T,F,F)
matches <- case1 | case2     # returns logical vector
 
sum(  matches )
mean( matches )



### PRIORITIZE SIMPLICITY 

### regular expressions 
### can be tricky: which
### of these is correct ??? 

grepl( "^[one|two|three] ",   titles )
grepl( "^[one |two |three ]", titles )
grepl( "^(one|two|three) ",   titles )
grepl( "(^one|^two|^three) ", titles )

### simplify to keep code
### readable and avoid errors

case1 <- grepl( "^one ",   dat$mission ) 
case2 <- grepl( "^two ",   dat$mission ) 
case3 <- grepl( "^three ", dat$mission ) 
matches <- case1 | case2 | case3 

 




