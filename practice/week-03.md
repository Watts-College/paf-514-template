---
layout: lab
title: Practice Problems 
image: practice.png
image-width: 150px
---

<div class = "uk-container uk-container-small">

<br>
<br>


# Week 03

-----------------------

* TOC
{:toc}

-----------------------

<br>
  

ADD: 
  
* create regular expression to search for email address
* create regular expression to search for social media handles (@xxx)  
* search for dates XX-XX-XXXX; XXXX-XX-XX; jan-xx; Dec xx, xxxx;
* CHALLENGE: read dates in combination of M-D-Y format then determine which is which (only 12 months, only 31 days)
* search for proper nouns (capitalization, not at start of the sentence) 
* name parsing to guess first, middle, last names 
  
  
## Regular Expressions

The function **grep( pattern, string )** works as follows:

> Search for the **pattern** in each **string** in the character vector. 

*Recall a string is a value that is comprised of some combinations of text, punctuation, numbers, and spaces. It can be a single letter, a single word, a jumble of letters like a password, a sentence, or a paragraph. Typically we refer to words as strings (look back at the baby name bracelet metaphor in the lecture notes). Computers don't understand language, so text to them is just a bunch of letters strung together in some particular order. When doing analysis with numbers we focus on size and proportions. When doing analysis with text we focus on sets and orders of letters. For example, when two letters are transposed it creates a new word or represents an error in spelling. The order of words in a sentence is what generates meaning. A lot of text analysis entails learning how to decompose sentences and paragraphs into words, cleaning and standardizing the words by removing punctuation and conjugation ("stemming"), and then tabulating occurances or looking for patterns. Mastering a few basic text analysis functions like string splits and pattern search move you quickly along the path to becoming an expert text analyst.* 

The search pattern in each case below represents a regular expression. The vector **strings** is a character vector that contains multiple strings.

Note: GREP = _global regular expression print_. It is a regular expression convention, which is not specific to R. Most programming languages allow you to use regular expression syntax to search for patterns in data. 

```r
grep( pattern, x, ignore.case=FALSE, value=FALSE )
```

By default grep() returns the **position** of a match in the vector. Add **value=TRUE** to return the actual string. 

**grepl()** stands for grep LOGICAL, and returns a vector of TRUE / FALSE indicating matches. Note that the lenth of the return vector will be the number of matches in **grep()** and it will be the same length as x when using **grepl()**. 

Before running the code, review the regular expression operators and see if you can guess which values will match each search parameter below. 

For a full list of operators review this basic [cheat sheet](https://github.com/DS4PS/cpp-527-spr-2020/raw/master/lectures/regular-expressions%20one-page-cheat-sheet.pdf) and [Regular Expressions as used in R](https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html#:~:text=Two%20types%20of%20regular%20expressions,use%20a%20literal%20regular%20expression.):

*The fundamental building blocks are the regular expressions that match a single character. Most characters, including all letters and digits, are regular expressions that match themselves. Any metacharacter with special meaning may be quoted by preceding it with a backslash (or double-backslash in windows).*

**WARM-UP:** 
  
How many can your guess correctly before you run the code? 

```r

strings <- c("through","rough","thorough","throw","though","true","threw","thought","thru","trough")

# what will the following return? 

grep( pattern="th?rough", strings, value = TRUE)

grep( pattern=".ough", strings, value = TRUE)

grep( pattern="^.ough", strings, value = TRUE)

grep( pattern="ough.", strings, value = TRUE)

# note the difference between ordered text and sets of text

grep( pattern="ough", strings, value = TRUE)  # letter order matters

grep( pattern="[ough]", strings, value = TRUE) # unordered set

# sets operators are inclusive:  o OR u OR g OR h 

grep( pattern="[ough]", strings, value = TRUE) # compare results to

grep( pattern="[tough]", strings, value = TRUE) # doesn't have to include t

# ^ operator changes meaning inside of sets

grep( pattern="^rough", strings, value = TRUE) # anchor

grep( pattern="[^r]ough", strings, value = TRUE) # absence of

grep( pattern="[^ou]", strings, value = TRUE) # exclude both

grep( pattern="[^uo]", strings, value = TRUE) # does order matter in sets? 

# these are not as useful

grep( pattern="tr*", strings, value = TRUE)

grep( pattern="t*o", strings, value = TRUE)
```

<br>
<br>


## Q1 - Constructing Factors

Building on the lab from this week, we constructed groups of titles using the following code logic:  

```r
group.questions <- grepl( "//?$", titles )

# OR 

group.who <- grepl( "^Who", titles )
group.what <- grepl( "^What", titles )
group.where <- grepl( "^Where", titles )

group.www <- group.who | group.what | group.where 
```

What if we wanted to build a single factor that has distinct levels for all of our groups? Note that you would need to define MUTUALLY EXCLUSIVE groups in order for this to make sense. If the groups are not mutually exclusive (one title could belong to multiple groups) then it would not make sense to combine them into a single factor. 

```r
group.01 <- grepl( ..., titles )  # questions
group.02 <- grepl( ..., titles )  # colons 
group.03 <- grepl( ..., titles )  # power lists

# create factor f where each level represents a different kind of title
# and include an "other" category for those that don't fit into above groups
```



## Q2: RegEx Substring Application

We have an large database where all of the addresses and geographic coordinates are stored as follows:

```r
x <- c("100 LANGDON ST
MADISON, WI
(43.07794869500003, -89.39083342499998)", "00 N STOUGHTON RD E WASHINGTON AVE
MADISON, WI
(43.072951239000076, -89.38668964199996)")
```

Write a function that accepts the address vector **x** as the input, and returns a vector of numeric coordinates.

Note that the length of addresses can change, so you will need to use regular expressions (instead of just a substr() function) to generate proper results. 

  


  
<br>
<hr>
<br>

</div>
 
<style>
em {
    color: black;
} 
  
h1{
  font-size:calc(2em + 0.25vw) !important;
  margin-top:160px !important;
  margin-bottom:20px;
  } 
  
h2{
  font-size:calc(2em + 0.25vw) !important;
  font-weight:300;
  margin-top:80px !important;
  margin-bottom:20px;
  } 

h3{
  font-size:calc(1.4em + 0.25vw);
  font-weight:300;
  margin-top:40px !important;
  margin-bottom:10px;} 
   

ul a:hover {
  color: #337ab7;
  text-decoration: none;
  font-weight: normal;
} 

#markdown-toc ul {
  font-size:calc(0.85em + 0.25vw);
  line-height:1.2;
  font-weight: bold;
} 
#markdown-toc ul li {
  list-style-type: disc !important;
  font-size:calc(0.65em + 0.25vw);
  line-height:1.2;
  margin-left: 20px;
}  
#markdown-toc a {
  color: black;
  font-size:calc(0.65em + 0.25vw);
  line-height:1.2;
  font-weight: normal;
}  
#markdown-toc a:hover {
    color: black;
    text-decoration: none;
    font-weight: bold;
}

</style>
