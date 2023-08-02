---
layout: lab
title: Practice Problems 
image: practice.png
image-width: 150px
---

<div class = "uk-container uk-container-small">

<br>
<br>


## Week 00: Warmup


Non-obvious bugs can EASILY work there way into your code. Once you identify the problem always seems obvious in retrospect. But it is often unclear why code is not working as expected. 

These practice problems are largely an opportunity to review content from CPP 526 and develop a sensitivity for the importance of writing **robust and maintainable code** and testing for unexpected behaviors. 

Many of these questions are similar to riddles or brain teasers that help sharpen your critical thinking skills when working with code. Work through them on your own, then discuss your ideas on YellowDig with classmates. 

For the topics this week, you will find that reviewing the lecture notes on one-dimensional data types useful: [VECTORS IN R](http://ds4ps.org/dp4ss-textbook/ch-050-vectors.html).

------

Explain the following unexpected behaviors: 

**Q1: When is 5 larger than 10?**

```r
> (1:10) > 5
 [1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
> (1:10) > "5"
 [1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
```


**Q2: Invisible Dogs**

x is a factor cataloging animals in a shelter, recording the type of animal. 

Why can't I count dogs? 

```r
> x  # TYPE OF ANIMAL (FACTOR)
[1] cat   dog   mouse
Levels: cat dog  mouse

> x == "cat" 
[1]  TRUE FALSE FALSE
> x == "dog"
[1] FALSE FALSE FALSE
> x == "mouse" 
[1] FALSE FALSE  TRUE
```


**Q3: Average Years of Edu** 

I have a sample of 10 people and am trying to determine their average level of education. 12= high school degree, 16 = four-year college degree, etc. 

My data is stored as a factor (which it should be since it is a categorical variable. But that makes it hard to calculate averages. 

What is going wrong here? 

```r
grade.levels <- factor( c(12, 16, 12, 7, 7, 5, 6, 5, 9, 10) )

> # want to know average level of 
> # schooling for sample:
> mean( grade.levels )
[1] NA
Warning message:
In mean.default(grade.levels) :
  argument is not numeric or logical: returning NA
> 
> # mean requires a numeric variable
> mean( as.numeric( grade.levels ) )
[1] 3.8
```


**Q4: String Sorting and Alphabetilization in R**

Note that just as we compare numbers using greater-than, less-than, and equal-to operators, we can also compare strings. 

Greater-than means that something occurs further along in the alphabet. 

```r
"b" > "a"
[1] TRUE
"a" > "b"
[1] FALSE
> "b" == "a"
[1] FALSE
```

Strings (words) that begin with identical letters are compared using subsequent letters:

```r
"adam" > "abram"
[1] TRUE
```

When there is a tie capitalization also matters: 

```r
"A" > "a"
[1] TRUE
"a" > "A"
[1] FALSE
> "A" == "a"
[1] FALSE

"Aaron" > "aaron"
[1] TRUE
"aaron" > "Aaron" 
[1] FALSE

"b" > "a"
[1] TRUE
> "b" > "A"
[1] TRUE
```

Considering these rules above, what might you guess about what the following statement will return? 

```r
"Aaron" > "abram"
```

Try it out in R to see if you guessed correctly. What does this tell us about how alphabetization occurs using logical operators? 

-----

**Post your ideas to YellowDig** 
  
Each question has it's own pin. Share your solutions by adding comments to the pins. 

  
  
<br>
<hr>
<br>

</div>
 
 

