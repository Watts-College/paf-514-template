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

 
###### 
######    FUNCTIONS AND WORKFLOWS
###### 


titles <- 
  c( "Want a Happier, More Fulfilling Life? 75-Year Harvard Study Says Focus on This 1 Thing",
     "How I Make Money on Airbnb Without Owning or Renting an Apartment",
     "To Be Well-Informed, Cut the News and Read These 7 Blogs Instead" )

###  Instructions: 
###   create a script that retrieves 
###   the first word of each title

### SIMPLIFY: 
### solve for one
### title first: 

x <- "To Be Well-Informed, Cut the News and Read These 7 Blogs Instead"


### PSEUDOCODE

# 1. split titles into words
#    1.5 convert list back to vector 
# 2. convert everything to lower case 
# 3. remove extra spaces 
# 4. extract the first word 

### RECIPE (script) VERSION

words.as.list <- strsplit( x, " " )   # 1.
words <- unlist( words.as.list )      # 2.
words <- tolower( words )             # 3. 
words <- trimws( words )              # 4. 
first.word <- words[1]                # 5.


### WRAPPING THE RECIPE IN A FUNCTION

get_first <- function( x )
{
  words.as.list <- strsplit( x, " " )
  words <- unlist( words.as.list )
  words <- tolower( words )
  words <- trimws( words )
  first.word <- words[1]
  return( first.word )    # add return value
}

get_first( x )  # test


### BREAKING OPEN A FUNCTION
###  (if you have to debug your code)

x <- "To Be Well-Informed, Cut the News and Read These 7 Blogs Instead"

# get_first <- function( x )
# {
    words.as.list <- strsplit( x, " " )
    words <- unlist( words.as.list )
    words <- tolower( words )
    words <- trimws( words )
    first.word <- words[1]
# return( first.word )
# }


### USE APPLY FUNCTIONS TO
### SCALE FROM SINGLE CASE 
### TO THE FULL VECTOR/LIST

lapply( titles, get_first ) %>% unlist()




### START WITH THE 
### END IN MIND

### If the goal is to summarize
### outputs by group then 
### you need a group variable
### and an outcome variable
### with matching dimensions


### MECHANICAL VERSION

claps <- c( 2, 17, 7, 14, 24, 23, 6, 22 )
f     <- c( "A","A","A","A","A","B","B","B" )

mean( claps )
mean( claps[ f == "A" ] )
mean( claps[ f == "B" ] )


### APPLY VERSION
###  tapply = apply group 
###  vector to numeric vector

tapply( claps, f, mean )


### DPLYR VERSION

df <- data.frame( claps, f )

df %>%
  group_by( f ) %>%
  summarise( ave=mean( claps ) )



### Note thtat grep() 
### returns a subset of
### titles that match,
### which changes the 
### vector dimensions 
### and makes it hard to 
### use in a workflow.

grep( reg.exp, missions, value=TRUE  )


### grepl() returns a
### logical vector that 
### will always be the 
### same size, is often
### easier to use in a
### workflow.

grepl( reg.exp, missions  )

matches <- grepl(...)
claps[ matches ]

df$matches <- matches
df %>% group_by(matches) %>% summarize(...)



