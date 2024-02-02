---
title: "String Processing in R"
output:
  html_document:
    theme: readable
    df_print: paged
    highlight: tango
    number_sections: true
    toc: true
    toc_float: false
    css: textbook.css
---



**Working with Text:** 

As a data analyst you will inevitably encounter situations where you need to process *STRINGS*. It might be to conduct a simple content analysis (counting word occurrences), but most likely you will use these tools at the data cleaning and database preparation steps. 

Text analysis is a large and complex field with packages that specialize in natural language processing tools, but you will be surprised at how sophisticated you can get with a handful of core R string functions.


# Vocabulary

When you work with text in computer programs, it is called 'string processing' because the computer does not know anything about words or concepts, so it treats text as strings of characters. 

![](figures/namebracelet.JPG)

Some basic vocabulary common to tasks that treat text as data: 

* **String**- anything comprised of characters or characters + numbers.  
* **Text** - the full document, sometimes called a corpus.  
* **Word** - text surrounded by spaces, sometimes called **tokens**.  

We can **atomize** a large body of text by breaking it into sentences, words, letters, etc. 



```r
x <- c("This is a string.", "These", "words","are", "also", "strings." )

x
```

```
## [1] "This is a string." "These"             "words"            
## [4] "are"               "also"              "strings."
```

```r
# putting text together

paste( "This is a string.", "These", "words","are", "also", "strings.", sep=" ")
```

```
## [1] "This is a string. These words are also strings."
```

```r
# breaking it apart

unlist( strsplit( x, " " ) )
```

```
## [1] "This"     "is"       "a"        "string."  "These"    "words"    "are"     
## [8] "also"     "strings."
```

```r
unlist( strsplit( x, "" ) )
```

```
##  [1] "T" "h" "i" "s" " " "i" "s" " " "a" " " "s" "t" "r" "i" "n" "g" "." "T" "h"
## [20] "e" "s" "e" "w" "o" "r" "d" "s" "a" "r" "e" "a" "l" "s" "o" "s" "t" "r" "i"
## [39] "n" "g" "s" "."
```



# Basic Text Functions in R

There are a handful of functions that you will use to work with strings. These functions find specific words or characters in your data, find parts of words, and replace them with other words or characters. There are also some functions to break text apart, put text together, or format it.


  Function | Use
-----------|-----
`grep()`     | Find a word or phrase (returns the proper string).
`grepl()`    | Find a word or phrase (returns a logical vector).
`regexpr()`  | Find a part of a word or phrase - very flexible.
`agrep()`    | Find an approximate match.
`sub()`      | Replace the first occurence of a word or phrase.
`gsub()`     | Replace ALL occurences of a word or phrase.
-----------|---------------------------------------------
`paste()`    | Combine multiple strings into a single string.
`strsplit()` | Split one string into multiple strings.
`substr()`   | Extract part of a string.


Let's look at some examples of these functions in action.






## Combining Numbers and Words


We often need to combine several pieces of text into one string, called concatenation. R's function for this is paste().


```r
paste( "My","name","is","mud.")
```

```
## [1] "My name is mud."
```

```r
a <- "mud."
paste("My","name","is", a ) # it can handle objects as arguments
```

```
## [1] "My name is mud."
```

```r
b <- c("Larry","Moe","Curly")
paste("My","name","is", b ) # it is vectorized
```

```
## [1] "My name is Larry" "My name is Moe"   "My name is Curly"
```

```r
# Need to create some vector names?

paste("x",1:3,sep="")
```

```
## [1] "x1" "x2" "x3"
```


## Format Case



```r
toupper( "AbCdEfG" )  
```

```
## [1] "ABCDEFG"
```

```r
tolower( "AbCdEfG" )
```

```
## [1] "abcdefg"
```



## Counting Characters


Need to sort a column of text by the length of words? You count characters with the function nchar():


```r
nchar( c("micky","snuffleupagus") )
```

```
## [1]  5 13
```


## Counting Words


This is a little more complicated since text is often processed as a single character string.


```r
nchar( "a b c")
```

```
## [1] 5
```

```r
nchar( "This is all one piece of text." )
```

```
## [1] 30
```

We can split text using the string split function strsplit(). We just need to tell it the delimiters, which is just a space in this case.


```r
strsplit( "This is all one piece of text.", split=" " )
```

```
## [[1]]
## [1] "This"  "is"    "all"   "one"   "piece" "of"    "text."
```

```r
length( strsplit( "This is all one piece of text.", split=" " )[[1]] )
```

```
## [1] 7
```

If we want to split everything we give it an empty split set:


```r
strsplit("abc", "") # returns 3 element vector "a","b","c"
```

```
## [[1]]
## [1] "a" "b" "c"
```

```r
nchar( "This is all one piece of text." )
```

```
## [1] 30
```

```r
length( strsplit( "This is all one piece of text.", split="" )[[1]] )
```

```
## [1] 30
```


## Extracting Part of Text


Recall that the census downloads contain a field called GEO.id which consists of several fips codes pasted together. If we inspect this ID we can see that the county fips (the one we often use for merges) is includes as the last five digits. How can we use this variable to exta the county fips codes?

The function substr() takes character vectors as their argument and returns the substring specified by the start and end positions.


```r
substr( "Micky", start=2, stop=4 )
```

```
## [1] "ick"
```

```r
GEO.id <- c("0500000US01001","0500000US01003","0500000US01005")

substr( GEO.id, start=10, stop=15 ) # returns county fips codes only
```

```
## [1] "01001" "01003" "01005"
```

```r
# replacement using substr

substr( GEO.id, 2, 4) <- "22222"

GEO.id
```

```
## [1] "0222000US01001" "0222000US01003" "0222000US01005"
```



## Search Text for a Match


If we want to search text for a keyword we use **grep()**.

In case you are curious about what 'grep' means, it is a term inherited from Unix operating systems.

GREP (g/re/p):  Globally search for a Regular Expression and Print



```r
my.text <- c("micky","minnie","goofy","pluto")

grep( pattern="goofy", my.text ) # correctly returns the third line
```

```
## [1] 3
```

```r
grep( pattern="Goofy", my.text ) # whoops! case matters
```

```
## integer(0)
```

```r
grep( pattern="Goofy", my.text, ignore.case=T )  # there we go
```

```
## [1] 3
```

```r
# returns each line that contains the match text

grep( "new", c("california","new york","new jersey","tennessee") )
```

```
## [1] 2 3
```

```r
# perhaps we want to see all of the lines that match

grep( "new", c("california","new york","new jersey","tennessee"), value=T )
```

```
## [1] "new york"   "new jersey"
```


## Replacing Text


Find and replace the first case in a string with **sub()** or all cases with **gsub()**:


```r
sub( pattern="New", replacement="Old", "We are traveling from New York to New Jersey" )
```

```
## [1] "We are traveling from Old York to New Jersey"
```

```r
sub( pattern="new", replacement="old", c("california","new york","new jersey","tennessee") )
```

```
## [1] "california" "old york"   "old jersey" "tennessee"
```

```r
sub( pattern="rave", replacement="party", "We are traveling from New York to New Jersey" )
```

```
## [1] "We are tpartyling from New York to New Jersey"
```

```r
gsub( pattern="New", replacement="Old", "We are traveling from New York to New Jersey" )
```

```
## [1] "We are traveling from Old York to Old Jersey"
```

```r
gsub( pattern="new", replacement="old", c("california","new york","new jersey","tennessee") )
```

```
## [1] "california" "old york"   "old jersey" "tennessee"
```

```r
# must us escapes for special characters

sub("?",".","Hello there?") # that's not right
```

```
## [1] ".Hello there?"
```

```r
sub("\\?",".","Hello there?") # there we go
```

```
## [1] "Hello there."
```

```r
sub("\\s",".","Hello There") # this works for spaces
```

```
## [1] "Hello.There"
```








# Regular Expressions

We often need to search large bodies of text for patterns.

Regular expressions are a stylized syntax that are used to query bodies of text to return very specific results. It uses symbols that help match groups of characters, as well as expressions to query locations within strings (a pattern at the beginning of a word or end of a sentence).

*Note that this section borrows heavily from Gloria Li and Jenny Bryan ( [original link, but now defunct](https://stat545-ubc.github.io/block022_regular-expression.html) ).* 

Some more clear examples provided by Dean Attali at:

https://github.com/daattali/UBC-STAT545/blob/master/reference/regex/regularExpressions.md




## Regular Expression Operators

Recall that logical operators are symbols that allow us to translate nuanced questions into computer code. For example, how many left-handed batters have been inducted into the Baseball Hall of Fame?

Similarly, regular expression operators allow us to create complex search terms.

Instead of saying, search for the word "cat" in the text, we might want to say, search for word "cat", only at the beginning of sentences, and do not return instances like "catch" that contain "cat".

In order to specify these searches, we need a more flexible language. Regular expressions gives us this.

Each of these symbols functions as an operator in the regular expressions framework:

$ * + . ? [ ] ^ { } | ( ) \

Here are the uses of some of these:

Operator | Use
-------|----------
.      | matches any single character (wild card for single character)
^      | start of a string
$      | end of a string
?      | match any time a preceding character appears 0 or 1 times
*      | match any time a preceding character appears 0 or more times 
+      | match any time a preceding character appears 1 or more times
\|      | OR statement - match either statement given
[ ]    | OR statement - match any of the characters given
[^ ]   | match any characters EXCEPT those given in the list
\\      | escape character - turns an operator into plain text


Note that the position of RegEx operators matters and they are not all the same. For example, the position of anchors change with the anchor type: 


```r
"^word"  # start of string anchor acts on W, precedes letter
"word$"  # end of string anchor acts on D, follows letter
```

The quantifiers ?, * and + always follow the letter they act upon. 


```r
"loo?se"  # matches lose or loose 
```



```r
strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12", "ab$")

# match anything that starts with ab followed by any character

grep("ab.", strings, value = TRUE)
```

```
## [1] "abc"   "abd"   "abe"   "ab 12" "ab$"
```

```r
# search for abc OR abd

grep("abc|abd", strings, value = TRUE)
```

```
## [1] "abc" "abd"
```

```r
# match abc OR abd OR abe

grep("ab[c-e]", strings, value = TRUE)
```

```
## [1] "abc" "abd" "abe"
```

```r
# match anything that is NOT abc

grep("ab[^c]", strings, value = TRUE)
```

```
## [1] "abd"   "abe"   "ab 12" "ab$"
```

```r
# match any string where ab occurs at the beginning

grep("^ab", strings, value = TRUE)
```

```
## [1] "ab"    "abc"   "abd"   "abe"   "ab 12" "ab$"
```

```r
# match any string where ab occurs at the end

grep("ab$", strings, value = TRUE)
```

```
## [1] "^ab" "ab"
```

```r
# search for matches that contain the character ^

grep("^", strings, value = TRUE)
```

```
## [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12" "ab$"
```

```r
# try again

grep("\\^", strings, value = TRUE)
```

```
## [1] "^ab"
```

```r
# same here

grep("$", strings, value = TRUE)
```

```
## [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12" "ab$"
```

```r
grep("\\$", strings, value = TRUE)
```

```
## [1] "ab$"
```


If we want to search for one of these special operators in our text, we need to tell R that we are looking for the operator, and not trying to use a regular expression statement. We accomplish this with an escape sequence.

Create an escape sequence by placeing the double backslash "\\" in front of a special operator. For example, to search for a quote, a newline, or a tab in the text use these:

* \\\\': single quote.
* \\\\": double quote.
* \\\\n: newline.
* \\\\r: carriage return.
* \\\\t: tab character.
* \\\\b: matches the empty string at either edge of a WORD.
* \\\\B: matches the string provided it is NOT at an edge of a word.





```r
string <- "Here is a long string
           of text that contains 
           some breaks."

string
```

```
## [1] "Here is a long string\n           of text that contains \n           some breaks."
```

```r
# find the positions of the breaks

nchar( string )
```

```
## [1] 79
```

```r
gregexpr( "\\n", string )
```

```
## [[1]]
## [1] 22 56
## attr(,"match.length")
## [1] 1 1
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

```r
# find all of the blank spaces

gregexpr( "\\b ", string )
```

```
## [[1]]
## [1]  5  8 10 15 36 41 46 55 72
## attr(,"match.length")
## [1] 1 1 1 1 1 1 1 1 1
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

```r
# all of the o's at the beginning of words

gregexpr( "\\bo", string )
```

```
## [[1]]
## [1] 34
## attr(,"match.length")
## [1] 1
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

```r
# all of the o's in the middle of words

gregexpr( "\\Bo", string )
```

```
## [[1]]
## [1] 12 48 69
## attr(,"match.length")
## [1] 1 1 1
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

The **regexpr()** and **gregexpr()** functions are odd because they return a character position instead of an element from the character vector. These start and stop positions are used to extract pieces of text from the whole body of text.



```r
# extracting text using start and stop values

regexpr( "c.*g", "abcdefghi" )
```

```
## [1] 3
## attr(,"match.length")
## [1] 5
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

```r
start.pos <- regexpr( "c.*g", "abcdefghi" )

stop.pos <- start.pos + attr( regexpr( "c.*g", "abcdefghi" ), "match.length" )

substr( "abcdefghi", start=start.pos, stop=stop.pos )
```

```
## [1] "cdefgh"
```




## Quantifiers

The quantifiers allow us to specify the number of times a character is repeated.

Operator | Use
---------|-----
*        | matches at least 0 times.
.        | matches only one time
+        | matches at least 1 times.
?        | matches at most 1 times.
{n}      | matches exactly n times.
{n,}     | matches at least n times.
{n,m}    | matches between n and m times.



```r
strings <- c("ht","hot","hoot","hooot")



# match at least zero times

grep("h*t", strings, value = TRUE)
```

```
## [1] "ht"    "hot"   "hoot"  "hooot"
```

```r
# match ONLY one time

grep("h.t", strings, value = TRUE)
```

```
## [1] "hot"
```

```r
# match at least one times

grep("ho+t", strings, value = TRUE)
```

```
## [1] "hot"   "hoot"  "hooot"
```

```r
# match zero or one times

grep("ho?t", strings, value = TRUE)
```

```
## [1] "ht"  "hot"
```

```r
# match exactly n times

grep("ho{2}t", strings, value = TRUE)
```

```
## [1] "hoot"
```

```r
# match at least n times

grep("ho{2,}t", strings, value = TRUE)
```

```
## [1] "hoot"  "hooot"
```

```r
# match between n and m times

grep("ho{1,2}t", strings, value = TRUE)
```

```
## [1] "hot"  "hoot"
```


### Greedy vs Reluctant Search 

When applying quantifiers to search strings, especially those using wildcards, pay attention to the difference between "greedy" and "reluctant" matches. 

**Greedy search** tries to find the biggest string possible that matches the expression. 

**Reluctant search** tries to find the smallest string possible that matches the expression. 


[**Example: From A to Z (quoted directly from StackOverflow)**](https://stackoverflow.com/questions/3075130/what-is-the-difference-between-and-regular-expressions)

Let's compare these two patterns: `A.*Z` and `A.*?Z`.

Given the following input:

```
eeeAiiZuuuuAoooZeeee
```

The patterns yield the following matches:


`A.*Z` yields 1 match: `AiiZuuuuAoooZ`  

`A.*?Z` yields 2 matches: `AiiZ and AoooZ` 

Let's first focus on what `A.*Z` does. When it matched the first `A`, the `.*`, being greedy, first tries to match as many `.` as possible. In order to do this, once encountering an `A.*` (A followed by any other characters 0 or more times) the algorithm jumps to the end of the string and scans backwards, looking for anything that matches `Z`:

```
eeeAiiZuuuuAoooZeeee
   \_______________/
    A.* matched, Z can't match
```

Since the `Z` doesn't match, the engine backtracks, and `.*` must then match one fewer `.`:

```
eeeAiiZuuuuAoooZeeee
   \______________/
    A.* matched, Z still can't match
```

This happens a few more times, until finally we come to this:

```
eeeAiiZuuuuAoooZeeee
   \__________/
    A.* matched, Z can now match
```

Now `Z` can match, so the overall pattern matches:

```
eeeAiiZuuuuAoooZeeee
   \___________/
    A.*Z matched
```

By contrast, the reluctant repetition in `A.*?Z` first matches as few `.` as possible, and then taking more `.` as necessary. It would iteratively look for the following: 

* `AZ` 
* `A.Z` 
* `A..Z` 
* `A...Z` 

Until `A. ... .Z` it reaches the full string length. This explains why it finds two matches in the input.


```
eeeAiiZuuuuAoooZeeee
   \__/    \___/ 
   A..Z    A...Z
```

Here's a visual representation of what the two patterns matched:

```
eeeAiiZuuuuAoooZeeee
   \__/r   \___/r      r = reluctant
    \____g____/        g = greedy
```


For more control over matches using greedy versus reluctant search see: 

[**Quantifier Cheat Sheet**](https://www.rexegg.com/regex-quantifiers.html#cheat_sheet)


**Challenge Question**

Given what you learned above, what would the following return and why? 


```r
# str_match_all() returns substring

x <- "eeeAiAiZuuuuAoZooZeeee"
stringr::str_match_all( x, "A.*?Z" )
```

```
## [[1]]
##      [,1]   
## [1,] "AiAiZ"
## [2,] "AoZ"
```

Here are all of the possible matches: 


```
eeeAiAiZuuuuAoZooZeeee
   \___/
   
eeeAiAiZuuuuAoZooZeeee
     \_/
     
eeeAiAiZuuuuAoZooZeeee
            \_/
            
eeeAiAiZuuuuAoZooZeeee
            \____/
   
eeeAiAiZuuuuAoZooZeeee
     \________/

eeeAiAiZuuuuAoZooZeeee
     \___________/
     
eeeAiAiZuuuuAoZooZeeee
   \__________/
   
eeeAiAiZuuuuAoZooZeeee
   \_____________/
```

**Answer:**

```r
x <- "eeeAiAiZuuuuAoZooZeeee"
stringr::str_match_all( x, "A.*?Z" )
  
[1,] "AiAiZ"
[2,] "AoZ"  

eeeAiAiZuuuuAoZooZeeee
   \___/
   
eeeAiAiZuuuuAoZooZeeee
            \_/
```

Starting from the left and moving right, any time we encounter `A.` then we begin the search for the rest of the string `Z`, expanding until we find a match. 

The important thing to note is that once a substring becomes a match it will not be used in subsequent matches, otherwise the second case would have been identified as well.

```
eeeAiAiZuuuuAoZooZeeee
   \___/
   
eeeAiAiZuuuuAoZooZeeee
     \_/
```

Similarly, after identifying the first match here, moving left to right, the second is part of the same substring so it is omitted: 

```
eeeAiAiZuuuuAoZooZeeee
            \_/
            
eeeAiAiZuuuuAoZooZeeee
            \____/
```




## Position

The position specified whether the characters occur at the beginning, middle, or end or a word or phrase.

Note that "a dog" is a STRING that contains two WORDS for the definitions below.

Operator | Use
---------|-----
 ^       |  matches the start of the STRING.
 $       |  matches the end of the STRING.
 \\\\b    |  matches the empty string at either edge of a WORD.
 \\\\B    |  matches the string provided it is NOT at an edge of a word.



```r
strings <- c("abcd", "cdab", "cabd", "c abd")

# anywhere in the text

grep("ab", strings, value = TRUE)
```

```
## [1] "abcd"  "cdab"  "cabd"  "c abd"
```

```r
# at the beginning of a STRING

grep("^ab", strings, value = TRUE)
```

```
## [1] "abcd"
```

```r
# at the end of a STRING

grep("ab$", strings, value = TRUE)
```

```
## [1] "cdab"
```

```r
# at the beginning of a WORD

grep("\\bab", strings, value = TRUE)
```

```
## [1] "abcd"  "c abd"
```

```r
## [1] "abcd"  "c abd"

# in the middle of a WORD

grep("\\Bab", strings, value = TRUE)
```

```
## [1] "cdab" "cabd"
```




```r
# Searching for special characters using escape

regexpr( "\\*", "abcd*efghi" )
```

```
## [1] 5
## attr(,"match.length")
## [1] 1
## attr(,"index.type")
## [1] "chars"
## attr(,"useBytes")
## [1] TRUE
```

```r
my.text <- c("micky","minnie","goofy","pluto")

grep( pattern="g*fy", my.text )
```

```
## [1] 3
```

```r
grep( pattern="g*y", my.text )
```

```
## [1] 1 3
```

```r
grep( pattern="pluo?to", my.text )
```

```
## [1] 4
```

```r
grep( pattern="pluo?t", my.text )
```

```
## [1] 4
```

```r
grep( pattern="plo?to", my.text )
```

```
## integer(0)
```

```r
grep( pattern="mi*", my.text )
```

```
## [1] 1 2
```

```r
# FormA OR FormB OR FormC

my.text <- c( "FormA", "FormC", "FormE" )

grep( pattern="Form[ABC]", my.text )
```

```
## [1] 1 2
```

```r
grep( pattern="h[oi]t" , c("hot","hat","hit","hop") )
```

```
## [1] 1 3
```

```r
# replace land with LAND in all country names

gsub( "land", "LAND", c("finland", "iceland", "michael landon") )
```

```
## [1] "finLAND"        "iceLAND"        "michael LANDon"
```

```r
# need to anchor the word to the end

gsub( "land$", "LAND", c("finland", "iceland", "michael landon") )
```

```
## [1] "finLAND"        "iceLAND"        "michael landon"
```









# Dates in R

R has a special class of text elements for dates. This class translates letters and numbers into calendar dates, and it knows how to translate these elements easily between days and years. 

You would use this function in order to re-cast characters from a database into calendar dates, or to calculate time between events.

## Print the Date



```r
date()
```

```
## [1] "Thu Feb 01 13:17:44 2024"
```

Perhaps we are running simulations and need to print output to a file in a way that we can generate random names for the files but still keep track of the order. We can create filenames using dates:


```r
paste( date(), ".pdf", sep="" )
```

```
## [1] "Thu Feb 01 13:17:44 2024.pdf"
```

That's a complicated title. Perhaps we want a simple representation of the full date. We can format a date object using some simple commands. For a full list see strptime().


```r
Sys.time()
```

```
## [1] "2024-02-01 13:17:44 MST"
```

```r
format(Sys.time(), "%a %b %d %Y"  )
```

```
## [1] "Thu Feb 01 2024"
```


## Time Between Dates


Suppose you want to calculate the time between two datas in your data set:


```r
start.date <- c("2011/06/13","2011/07/25","2011/05/24")

end.date <- c("2012/01/01","2012/01/01","2012/03/19")

start.date
```

```
## [1] "2011/06/13" "2011/07/25" "2011/05/24"
```

```r
class( start.date )
```

```
## [1] "character"
```

```r
# you will get an error here:

# end.date - start.date
```

You will notice that our dates were read in as characters, so we first need to translate them to the date class in order to make any meaningful comparisons between them. So we cast them as dates.


```r
as.Date( end.date )
```

```
## [1] "2012-01-01" "2012-01-01" "2012-03-19"
```

```r
as.Date( end.date ) - as.Date( start.date )
```

```
## Time differences in days
## [1] 202 160 300
```

It worked! Let's be a little more careful, though, about how we are conducting the translation to make sure we are not introducing any errors. We can explicitly specify the format of the dates to ensure they are interpretted correctly:


```r
as.Date( start.date, format="%Y/%m/%d")
```

```
## [1] "2011-06-13" "2011-07-25" "2011-05-24"
```

That works correctly. What if we mix up days and months, though (European dates and American dates often have different ordering of days and months).


```r
as.Date( start.date, format="%Y/%d/%m")
```

```
## [1] NA NA NA
```

```r
as.Date( "2004/30/06", format="%Y/%d/%m" ) # ok
```

```
## [1] "2004-06-30"
```

```r
as.Date( "2004/31/06", format="%Y/%d/%m" ) # June only has 30 days
```

```
## [1] NA
```

At least R is smart enough to know there are no months higher than 12 and only 30 days in June, and no recycling here!


## Creating a Sequence of Dates


We can use the sequence function to generate lists of dates as long as the arguments are dates.


```r
a <- as.Date("2010/01/01")
b <- as.Date("2010/02/01")
c <- as.Date("2011/01/15")

seq( from=a, to=b, by=1 ) # sequence of days
```

```
##  [1] "2010-01-01" "2010-01-02" "2010-01-03" "2010-01-04" "2010-01-05"
##  [6] "2010-01-06" "2010-01-07" "2010-01-08" "2010-01-09" "2010-01-10"
## [11] "2010-01-11" "2010-01-12" "2010-01-13" "2010-01-14" "2010-01-15"
## [16] "2010-01-16" "2010-01-17" "2010-01-18" "2010-01-19" "2010-01-20"
## [21] "2010-01-21" "2010-01-22" "2010-01-23" "2010-01-24" "2010-01-25"
## [26] "2010-01-26" "2010-01-27" "2010-01-28" "2010-01-29" "2010-01-30"
## [31] "2010-01-31" "2010-02-01"
```

```r
seq( from=a, to=b, by=7 ) # sequence of weeks
```

```
## [1] "2010-01-01" "2010-01-08" "2010-01-15" "2010-01-22" "2010-01-29"
```

```r
seq( from=a, to=b, by="week" ) # same output
```

```
## [1] "2010-01-01" "2010-01-08" "2010-01-15" "2010-01-22" "2010-01-29"
```

```r
seq( from=a, to=c, by="month" ) # end date does not land on the 15th
```

```
##  [1] "2010-01-01" "2010-02-01" "2010-03-01" "2010-04-01" "2010-05-01"
##  [6] "2010-06-01" "2010-07-01" "2010-08-01" "2010-09-01" "2010-10-01"
## [11] "2010-11-01" "2010-12-01" "2011-01-01"
```







# Non-ASCII Characters


ASCII stands for the American Standard Code for Information Interchange, a standard table of letters, numbers and punctuation based upon the American alphabet. ASCII defines 128 characters, 95 print characters (letters, numbers, etc.) and 33 control characters (end of line, tab, etc.). The American alphabet is limited to text without accent marks or special characters. ASCII was originally the standard character encoding of the World Wide Web but it was changed to UTF-8, a more flexible global standard.

Data analysis can be adversely affected if foreign characters find their way into datasets. If it's causing you trouble, it's useful to know some tricks to find and remove non-ASCII text. The iconv() function is one option:



```r
# not run because returns an error

# x <- c("Ekstr\xf8m", "J\xf6reskog", "bi\xdfchen Z\xfcrcher") # e.g. from ?iconv
# Encoding(x) <- "latin1"  # (just to make sure)
#
# x
# 
# iconv(x, "latin1", "ASCII", sub="" )
#
# iconv(x, "latin1", "ASCII", sub="_" )
```



