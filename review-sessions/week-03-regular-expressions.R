
##########  
##########    REGEX: regular expressions
##########



###   MATCH A STRING
###
###   GREP = Global Regular Expression search and Print


strings <- c(  "abcd",  "cdab",  "cabd",  "c abd" )

grep(  "dab", strings )              # returns the position of the match
grep(  "dab", strings, value=TRUE )  # returns the matching text 
grepl( "dab", strings )              # returns a logical vector

# matches can be anywhere in the string
grep( "ab", strings, value=TRUE )




###   stringr package

library( stringr )

#  stringr function equivalent 
#  to grep( "abd", strings, value=T )

str_subset( strings, "abd" )  
 
x <- c( "grey wolf", "feeling grey", "david grey" )

x %>%
  str_replace_all( "grey", "gray" ) %>%
  str_to_upper()




### LOCATION OF STRING

# ^		start of a string
# $		end of a string
# \\b	word boundary
# \\B	middle of the word 




strings <- c("abcd", "cdab", "cabd", "c abd")

# anywhere in the text
grep( "ab", strings, value=TRUE )

# at the beginning of a STRING
grep( "^ab", strings, value=TRUE )

# at the end of a STRING
grep( "ab$", strings, value=TRUE )

# at the beginning of a WORD
grep( "\\bab", strings, value=TRUE )

# in the middle of a WORD
grep( "\\Bab", strings, value=TRUE )



##  start of a new word, 
##   but NOT at the start of the string

condition.01 <- grepl( "^ab", strings )
condition.02 <- grepl( "\\bab", strings )

condition.02 & ! condition.01

strings[ condition.02 & ! condition.01 ]




# replace land with LAND in all country names

gsub( "land", "LAND", c("finland", "iceland", "michael landon") )

# need to anchor the word to the end

gsub( "land$", "LAND", c("finland", "iceland", "michael landon") )










##########  
##########    REGEX OPERATORS
##########

# \\ 	escape character - turns a regex operator into plain text
# \\’  : single quote.
# \\"  : double quote.
# \\n  : newline.
# \\r  : carriage return.
# \\t  : tab character.

# \\x	also turns some letters into operators
# \\b  : matches the empty string at the edge of a word.
# \\B  : matches the string provided it is NOT at an edge of a word.

# .		wild card for single character
# x?		match any time a preceding character x appears 0 or 1 times
# x*		match any time a preceding character x appears 0 or more times
# x+		match any time a preceding character x appears 1 or more times


# .?		match a word with or without: b.?an matches bean and ban
# .*		matches everything
# a+		every string that contains an a



# |		OR statement - match either statement given: le|oan matches lean or loan
# [ ]	OR statement - match any of the characters given: l[eo]an matches lean or loan
# [^ ]	match any characters EXCEPT those given in the list

### QUANTIFIERS

# x{n}		match when x occurs exactly n times 
# x{n,m}	match when x occurs between n and m times
# x{n,}		match when x occurs a minimum of n times  



strings <- c("ht","hot","hoot","hooot")

# match at least zero times

grep("h*t", strings, value = TRUE)

# match ONLY one time

grep("h.t", strings, value = TRUE)

# match at least one times

grep("ho+t", strings, value = TRUE)

# match zero or one times

grep("ho?t", strings, value = TRUE)

# match exactly n times

grep("ho{1,2}t", strings, value = TRUE)

# match at least n times

grep("ho{2,}t", strings, value = TRUE)

# match between n and m times

grep("ho{1,2}t", strings, value = TRUE)





strings <- c("ded", "dead","dad","deed", "deaad", "deeed" )

# wildcard character
grep( "dead", strings, value=TRUE )
grep( "de.d", strings, value=TRUE )

# quantifiers go after character x
# x? = 0 or 1 times 
# x* = 0 or more times 
# x+ = 1 or more times 

# equivalent to quantifiers:
# x? = x{0,1) 
# x* = x{0,}
# x+ = x{1,}

# any repeated letters
# .+ = .{1,)

grep( "dead", strings, value=TRUE )

grep( "dea?d", strings, value=TRUE )
grep( "dea{0,1}d", strings, value=TRUE )

grep( "dea*d", strings, value=TRUE )
grep( "dea{0,}d", strings, value=TRUE )

grep( "dea+d", strings, value=TRUE )
grep( "dea{1,}d", strings, value=TRUE )

grep( "de.+d", strings, value=TRUE )

# note operator position and scope: 
# ^d  e|a  d$
grep( "^de|ad$", strings, value=TRUE )




### USING THE OR OPERATOR

# FormA OR FormB OR FormC

my.text <- c( "FormA", "FormC", "FormE" )

grep( pattern="Form[ABC]", my.text, value=T )

grep( pattern="h[oi]t" , c("hot","hat","hoit","hop"), value=T )


# note different OR options
# string1 | string2 (order matters)
# [abcd]  (set of letters)
#  e|a      e or a only
# [ea]{2}   ee, aa, ea, or ae
# [ea]{1,2} e, a, ee, aa, ea, or ae

strings <- c("ded", "dead","dad","deed", "deaad", "deeed" )

grep( "^de|ad$", strings, value=TRUE )
grep( "^dee|ad$", strings, value=TRUE )
grep( "^d[ea]d$", strings, value=TRUE )
grep( "^d[ea]{2}d$", strings, value=TRUE )
 


### ESCAPE OPERATOR

# Searching for special characters using escape

regexpr( "*", "abcd*efghi" )

regexpr( "\\*", "abcd*efghi" )






### EXAMPLES

strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12", "ab$")


# match anything that starts with ab followed by any character

grep("ab.", strings, value = TRUE)


# search for abc OR abd

grep("abc|abd", strings, value = TRUE)


# match abc OR abd OR abe

grep("ab[c-e]", strings, value = TRUE)


# match anything that is NOT abc

grep("ab[^c]", strings, value = TRUE)


# match any string where ab occurs at the beginning

grep("^ab", strings, value = TRUE)
grep("\\^ab", strings, value = TRUE)


# match any string where ab occurs at the end

grep("ab$", strings, value = TRUE)
grep("ab\\$", strings, value = TRUE)


# search for matches that contain the character ^

grep("^", strings, value = TRUE)


# try again

grep("\\^", strings, value = TRUE)


# same here

grep("$", strings, value = TRUE)

grep("\\$", strings, value = TRUE)




###   REPLACE SUBSET OF STRING: 
###
###    set inside parentheses referenced by \\1:
###    > search for:    (word) string (word) 
###    > replace with:  \\1 new string \\2 
###
###    Convert: "exec direct, trustee" --> "exec director & trustee"
###    gsub( "(.*), ([A-Z])", "\\1 & \\2", x )
###    retains sets \\1 and \\2, replaces comma with &

x <- "exec direct, trustee"
gsub( "(.*), ([a-z])", "\\1 & \\2", x )

###   convert 'WIDE 7.5"' to 'WIDE 7.5IN'
###
###   search for digit followed by double quote: (\\d)"
###   \\1 references (\\d), keep digits and replace quotes with IN 

x <- 'BELT, "V" 5L610, LONG 4.5" WIDE 7.5", TYPE "K"'
gsub( '(\\d)"', "\\1 INCHES", x)  







### PRACTICE - what will these return?

my.text <- c("micky","minnie","goofy","pluto")


grep( pattern="g*fy", my.text )


grep( pattern="pluo?to", my.text )


grep( pattern="pluo?t", my.text )


grep( pattern="plo?to", my.text )


grep( pattern="mi*", my.text )






# URL SLUG - no caps, spaces, or special chars
#
# <title> The Hangover Part 3 </title>
# <content> A silly comedy movie </content>
# <slug> the-hangover-part-3 </slug>


# regex to search for slugs in URLs: 
# match patterns xxx-xx-xxxxx-xxx

x <- c( "https://www.imdb.com/title/the-hangover-part-3", 
        "the-hangover-part-3", 
        "https://www.imdb.com/title/the-hangover-part-3/cast" )

grep( "[a-z0-9-]+", x, value=TRUE )
grep( "/[a-z0-9-]+/", x, value=TRUE )
grep( "^[a-z0-9-]+$", x, value=TRUE )


x <- c( "The Hangover Part 3",
        "the-hangover-part-3",  # slugified
        "The Hangover Part #", 
        "The-Hangover-Part-3",  # contains capitals
        "the-hangover-part-&" ) # contains special chars

# regex pseudocode: [a-z0-9-]
# contains lowercase a-z
# contains numbers 0-9
# contains dash -

grep( "^[a-z0-9-]+$", x, value=TRUE )
grep( "^[a-z0-9-]+$", x, value=TRUE, ignore.case=TRUE )
grep( "^[a-zA-Z0-9-]+$", x, value=TRUE, ignore.case=TRUE )




