---
layout: lab
title: Practice Problems 
image: practice.png
image-width: 150px
---

<div class = "uk-container uk-container-small">

<br>
<br>


# Week 05

-----------------------

* TOC
{:toc}

-----------------------

<br>
  
  
## Week 05 
  
**TIDY DATA** 

This exercises introduces the _**extremely important but simple**_ concept of **tidy data**. 

---

*The development of tidy data has been driven by my experience working with real-world datasets. With few, if any, constraints on their organisation, such datasets are often 
constructed in bizarre ways. I have spent countless hours struggling to get such datasets organised in a way that makes data analysis possible, let alone easy. I have also struggled to impart these skills to my students so they could tackle real-world datasets on their own. In the course of these struggles I developed the reshape and reshape2 (Wickham 2007) packages. While I could intuitively use the tools and teach them through examples, I lacked the framework to make my intuition explicit. This paper provides that framework. It provides a comprehensive “philosophy of data”: one that underlies my work in the plyr (Wickham 2011) and ggplot2 (Wickham 2009) packages.*

*Tidy data is a standard way of mapping the meaning of a dataset to its structure. A dataset is messy or tidy depending on how rows, columns and tables are matched up with observations, variables and types.* 

*In tidy data:*

1. *Each variable forms a column.*  
2. *Each observation forms a row.*  
3. *Each type of observational unit forms a table.*  

---

The basic idea is that data should be _**selectable**_ with code, so attributes should not be coded as row or column names. They should be represented as distinct variables. 

This makes data exploration and manipulation feasible and efficient. 

You have seen that there are many **tidyverse** functions (from the **dplyr** package especially) that replicate core R functions, but return tidy results instead of default formats:

```r
table( dat$Gender_Drv1, dat$Gender_Drv2 )
         
          Female Male Unknown
  Female    4622 5463      85
  Male      5637 7707      96
  Unknown    776  835      25
  
dplyr::count( dat, Gender_Drv1, Gender_Drv2 )

  Gender_Drv1 Gender_Drv2    n
1      Female      Female 4622
2      Female        Male 5463
3      Female     Unknown   85
4        Male      Female 5637
5        Male        Male 7707
6        Male     Unknown   96
7     Unknown      Female  776
8     Unknown        Male  835
9     Unknown     Unknown   25

```

These two tables are equivalent, but in the second case we can do things like drill down further into the data by isolating accidents caused by male drivers (Driver 1), or we can color-code male and female data on a graph using a driver attribute with *col=factor(Gender_Drv2)*. 

In the default table version we can't even get a range of group size since we can't analyze table values *easily* (you can always re-convert the table object back to vectors and extract column and row attributes, but it takes some work). 

When attributes are built into the table as row names and column names they can no longer be manipulated directly. This is the general idea of tidy data - retain all of the information and store it in a way that makes it useful for subsequent analysis. 

In the tidyverse specifically, most analytical and graphical packages will assume that your data is in a tidy format as the default way to organize data. That is not true with older R packages. 

The convention has gained traction, though, and there is a big movement toward using tidy data as the standard for data frames and function outputs in R. This makes work-flow much easier! Using pipes to create a data recipe, for example, is possible primarily because of tidy conventions. 

To learn more, read pages 1-8 of the article that introduced this concept focusing on understand what a tidy dataset looks like (the examples of tidy versus non-tidy datasets are most useful). You can skim the remaining pages that discuss some advanced approaches to automate conversion from non-tidy to tidy formats. For now understanding the concept is more important than automation of conversion steps.  

[Tidy Data by Hadley Wickham](https://vita.had.co.nz/papers/tidy-data.pdf)

The concept is also explained in simple language with examples in in the article [Data Organization in Spreadsheets](https://github.com/DS4PS/cpp-527-spr-2021/raw/main/articles/data-organization-in-spreadsheets.pdf). 

----

Practice the concept with the problems below: 

### Q1: Table Conversion

R contains some built-in datasets that consist of pre-tabulated data.  

Convert one of the three sets of tables to a tidy dataset.

* Titanic 
* HairEyeColor 
* UCBAdmissions 

Share the tidy dataset (not the code) on YellowDig. 

*Note that it is a conceptual exercise, not a programming exercise. The goal is to get the tidy table structure correct, not find a function that can automate the process (the paper presents some automation steps you can ignore for now).* 

*You can do the exercise in Excel, or you can build vectors manually and combine them into a data frame. You just need to share the tidy table, not the process used to create it.* 



```r
Titanic
, , Age = Child, Survived = No

      Sex
Class  Male Female
  1st     0      0
  2nd     0      0
  3rd    35     17
  Crew    0      0

, , Age = Adult, Survived = No

      Sex
Class  Male Female
  1st   118      4
  2nd   154     13
  3rd   387     89
  Crew  670      3

, , Age = Child, Survived = Yes

      Sex
Class  Male Female
  1st     5      1
  2nd    11     13
  3rd    13     14
  Crew    0      0

, , Age = Adult, Survived = Yes

      Sex
Class  Male Female
  1st    57    140
  2nd    14     80
  3rd    75     76
  Crew  192     20


HairEyeColor
, , Sex = Male

       Eye
Hair    Brown Blue Hazel Green
  Black    32   11    10     3
  Brown    53   50    25    15
  Red      10   10     7     7
  Blond     3   30     5     8

, , Sex = Female

       Eye
Hair    Brown Blue Hazel Green
  Black    36    9     5     2
  Brown    66   34    29    14
  Red      16    7     7     7
  Blond     4   64     5     8


UCBAdmissions
, , Dept = A

          Gender
Admit      Male Female
  Admitted  512     89
  Rejected  313     19

, , Dept = B

          Gender
Admit      Male Female
  Admitted  353     17
  Rejected  207      8

, , Dept = C

          Gender
Admit      Male Female
  Admitted  120    202
  Rejected  205    391

, , Dept = D

          Gender
Admit      Male Female
  Admitted  138    131
  Rejected  279    244

, , Dept = E

          Gender
Admit      Male Female
  Admitted   53     94
  Rejected  138    299

, , Dept = F

          Gender
Admit      Male Female
  Admitted   22     24
  Rejected  351    317

```


<br>
<hr>
<br>

### Q2: Dummy Variable Conversion

This data frame contains some outcome Y for observations in four states. 

```r
dat
   Y NY AL FL MN
1 54  1  0  0  0
2 27  1  0  0  0
3 35  0  1  0  0
4 19  0  1  0  0
5 99  0  0  1  0
6 84  0  0  1  0
7 34  0  0  0  1
8 29  0  0  0  1
```

The states are currently presented as dummy variables. 

To make the dataset tidy convert the four dummy variables into a single STATE factor. 

```r
dat
   Y STATE 
1 54    NY 
2 27    NY 
3 35    AL 
4 19    AL 
5 99    FL 
6 84    FL 
7 34    MN 
8 29    MN 
```

This problem should be done programmatically. There are several ways to do this effectively. 

Here is the original dataframe (copy and paste into R): 

```r
# dput( dat )
dat <- 
structure(list(Y = c(54L, 27L, 35L, 19L, 99L, 84L, 34L, 29L), 
    NY = c(1, 1, 0, 0, 0, 0, 0, 0), AL = c(0, 0, 1, 1, 0, 0, 
    0, 0), FL = c(0, 0, 0, 0, 1, 1, 0, 0), MN = c(0, 0, 0, 0, 
    0, 0, 1, 1)), class = "data.frame", row.names = c(NA, -8L
))
```


**Bonus**: after you have created a single STATE factor, identify a function that will re-convert the factor into dummy variables. 


<br>
<hr>
<br>

### Challenge Question

Convert this dplyr count table into a regular table format that can be included in a report. 

```r
d2
  Gender_Drv1 Gender_Drv2    n
1      Female      Female 4622
2      Female        Male 5463
3      Female     Unknown   85
4        Male      Female 5637
5        Male        Male 7707
6        Male     Unknown   96
7     Unknown      Female  776
8     Unknown        Male  835
9     Unknown     Unknown   25

d2 <-
structure(list(Gender_Drv1 = structure(c(1L, 1L, 1L, 2L, 2L, 
2L, 3L, 3L, 3L), .Label = c("Female", "Male", "Unknown"), class = "factor"), 
    Gender_Drv2 = structure(c(1L, 2L, 3L, 1L, 2L, 3L, 1L, 2L, 
    3L), .Label = c("Female", "Male", "Unknown"), class = "factor"), 
    n = c(4622L, 5463L, 85L, 5637L, 7707L, 96L, 776L, 835L, 25L
    )), row.names = c(NA, -9L), class = "data.frame")
```

Regular format: 

```r
          Female Male Unknown
  Female    4622 5463      85
  Male      5637 7707      96
  Unknown    776  835      25
```



  
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
