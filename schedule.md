---
layout: default
title: Schedule

canvas: 
  assignment_url: 'https://asu.instructure.com/courses/178112/assignments'
  
yellowdig_url: 'https://asu.instructure.com/courses/178112/assignments/4874980'

yellowdig: 
  post-01: 'Wednesday, January 10th'
  post-02: 'Wednesday, January 17th' 
  post-03: 'Wednesday, January 24th' 
  post-04: 'Wednesday, January 31st' 
  post-05: 'Wednesday, February 7th' 
  post-06: 'Wednesday, February 14th' 
  post-07: 'Wednesday, February 21st' 
  

labs:
  lab-01:  'Wednesday, January 17th' 
  lab-02:  'Wednesday, January 24th'
  lab-03:  'Wednesday, January 31st'
  lab-04:  'Wednesday, February 7th'
  lab-05:  'Wednesday, February 14th'
  lab-06:  'Wednesday, February 21st'
  
  
projects: 
  r-package:  'Monday, February 5th'
  report-template:  'Tuesday, February 27th'
  data-wrangling:  'Ongoing'
  
  
---

<!--- 
Submit Button - <a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>
-->






<div class = "uk-container uk-container-small">
  
<br><br>
<br><br>

**COURSE CONTENT:**

-----------------------

* TOC
{:toc}

-----------------------

<br>





# Course Overview

## Topics We Will Cover

<hr> 

<a class="uk-button uk-button-default" href="../lectures/week-00/">OVERVIEW</a>

<hr>
  
## Due Dates 

For easy reference, you have the following due dates this term: 

**Labs:** 

* {{page.labs.lab-01}} 
* {{page.labs.lab-02}} 
* {{page.labs.lab-03}} 
* {{page.labs.lab-04}} 
* {{page.labs.lab-05}} 
* {{page.labs.lab-06}} 

**Post Practice Problems on YellowDig:**
 
* {{page.yellowdig.post-01}} 
* {{page.yellowdig.post-02}} 
* {{page.yellowdig.post-03}} 
* {{page.yellowdig.post-04}} 
* {{page.yellowdig.post-05}} 
* {{page.yellowdig.post-06}} 
* {{page.yellowdig.post-07}} 


**Projects:**

* **R Package**: {{page.projects.r-package}}
* **Data Wrangling Exercise**: {{page.projects.data-wrangling}}  
* **Customized Report Template**: {{page.projects.report-template}} 



## Practice Problem Warmup

<hr>

<a class="uk-button uk-button-default" href="../practice/week-01/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-01}}** 
  
<hr>

Non-obvious bugs can EASILY work there way into your code. Once you identify the problem always seems obvious in retrospect. But it is often unclear why code is not working as expected. 

These practice problems are largely an opportunity to review content from CPP 526 and develop a sensitivity for the importance of writing **robust and maintainable code** and testing for unexpected behaviors. 

Many of these questions are similar to riddles or brain teasers that help sharpen your critical thinking skills when working with code. Work through them on your own, then discuss your ideas on YellowDig with classmates. 

For the topics this week, you will find that reviewing the lecture notes on one-dimensional data types useful: [VECTORS IN R](http://ds4ps.org/dp4ss-textbook/ch-050-vectors.html).

*Each question has it's own pin. Share your solutions by adding comments to the pins.*

<br>
<br>
<br>



  
  
  
  
  
  
  

<!--- 
#########################################
#########################################
##########
##########         WEEK 01
##########
#########################################
#########################################
-->

  
  
# Week 1 - Control Structures  

## Unit Overview 

  
**Description**

This section introduces [control structures](https://intellipaat.com/blog/tutorial/r-programming/decision-making-and-loops/) that will allow you to incorporate decision-making into computer code. It enables things like *if-then* logic to determine what code should be used based upon whether specified conditions are met. 


**Learning Objectives**

Once you have completed this unit you will be able to: 

* divide or "factor" your code into distinct tasks 
* use functions as steps in problem-solving 
* review compound statements 
* implement if-else statements 
* identify "edge cases" and their impact on code 

**Lecture Notes**

<a class="uk-button uk-button-default" href="../lectures/week-01-function-review/">Functions and Workflow</a>

<a class="uk-button uk-button-default" href="../lectures/week-01/">Control Structures</a>




<br>
<br>


## Lab-01: Control Structures 

<hr>
  
<a class="uk-button uk-button-default" href="../labs/lab-01-instructions.html">LAB-01 Instructions</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

**Due {{page.labs.lab-01}}**

<hr>

This lab is based upon the famous [Monty Hall Problem](http://www.montyhallproblem.com/). 

There was famously much debate about the correct solution when the problem was initially introduced. It is now a popular example used to teach conditional probability in statistics.  
  
**Using Computing Logic to Build the Game**

The Monty Hall Problem is a great example of a mathematical problem that might be hard to solve using proofs, but it is fairly easy to solve using simulation. 

Since it is a game with simple and explicit rules we can build our own virtual version. Then we can compare how outcomes differ when we deploy the two different strategies for selecting doors. 

In Lab 01 we will use functions and control structures to build a virtual version of the game. 

```r
### STEP 01 OF GAME 
# 1: create a vector of 3 doors: 2 goats and 1 car
# 2: randomize the position of the car for a new game
# 3: return the new game setup (vector of prizes)

create_game <- function( )
{
    prizes <- c("goat","goat","car")
    a.game <- sample( x=prizes, size=3, replace=F )
    return( a.game )
} 
```
  
In Lab 02 we will use simulation to play the game thousands of times so that we can get stable estimates of the payoff of each strategy. 


<iframe width="560" height="315" src="https://www.youtube.com/embed/9vRUxbzJZ9Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<hr><br>



## Practice Problems

<hr> 
  
<a class="uk-button uk-button-default" href="../practice/week-01/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-02}}**

<hr>
<br>








<!--- 
#########################################
#########################################
##########
##########         WEEK 02
##########
#########################################
#########################################
-->


# Week 2 - Simulations 




## Unit Overview 


**Description**

This section introduces loops. We will use them to create simulations. 

**Learning Objectives**

Once you have completed this section you will be able to 
* use a loop responsibly in your code 
* select appropriate iterators 
* be mindful of the collector vector needed for the loop 

---------

> "I was working on my master’s degree before I realized … that code was intuitive to me, but math notation was not." ~ [JD Long](https://twitter.com/CMastication/status/1437025651903582220)

![](../lectures/figures/math-v-code-v2.png)

----------

<br>

**Lecture Notes:** 

<a class="uk-button uk-button-default" href="../lectures/week-02/">LECTURE NOTES</a> 

<a class="uk-button uk-button-default" href="../lectures/p-02-loops.html">Building Simulations in R: Mastering Loops</a>

<a class="uk-button uk-button-default" href="../lectures/Animations.html">Creating Animations with Loops</a>

**Example:** 

Buzzfeed published a recent story with a dynamic visualization of the change in health care costs over time. 

It uses loops to create effective data visualization:

[Why Americans Are So Damn Unhealthy, In 4 Shocking Charts](https://www.buzzfeednews.com/article/peteraldhous/american-health-care)   [*Buzzfeed Replication Files*](https://github.com/BuzzFeedNews/2017-05-us-health-care)

![](../assets/img/buzzfeed-gif.gif)

<br>
<br>
<br>
  





## Lab 02: Simulations 

<hr> 
  
<a class="uk-button uk-button-default" href="../labs/lab-02-instructions.html">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

**Due {{page.labs.lab-02}}**

<hr>
<br>





## Practice Problems

<hr> 
  
<a class="uk-button uk-button-default" href="../practice/week-02/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-03}}**
  
<hr>
<br>



  
  
  

<!--- 
#########################################
#########################################
##########
##########         R Package 
##########
#########################################
#########################################
-->


## PROJECT: Build Your Own R Package

<hr> 

<a class="uk-button uk-button-default" href="../labs/create-r-package.html">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT PACKAGE</a>

**Due {{page.projects.r-package}}**

*To receive credit for the assignment, submit the URL to your package on GitHub through Canvas.*

<hr> 
  

At some point you might develop a tool that you want to upload to the CRAN so it is widely available.

More likely, if you are working with a team of analysts within an organization you will begin building a library of functions that are specific to the project. 

Even if not sharing the package widely it is often a more efficient method for the team to maintain project code so that it can be easily updated and functions enhanced. Project updates are then easily shared simply by re-installing the package. 

This tutorial will teach you how to build and share a package in R. You will "package" your R code from Labs 01 and 02 into a new **montyhall package** to make it easier to run simulations to evaluate game strategies.

If you are not yet familiar with functions used to set and change working directories here are some notes on [FOLDER NAVIGATION](../lectures/navigation/).

It's also helpful to learn about [FUNCTION CONFLICTS](../lectures/function-conflicts/) when deciding to add dependencies via either **Imports** or **Depends** in the DESCRIPTION file of your new R package. 

**Grading:**

Your package will be installed and submitted to a series of testing scripts that ensure each function operates as expected. 

The documentation will also be inspected to ensure there are complete instructions and sample code available for each of the functions. 

You will receive a grade of zero if you package cannot be installed or run, and you will lose 5 points if documentation is unavailable. 


<br> 
<br> 
  



  
  
  
  


<!--- 
#########################################
#########################################
##########
##########         WEEK 03
##########
#########################################
#########################################
-->



# Week 3 - Regular Expressions 


## Unit Overview 

**Text as Data:**

This week comes with an up-front warning. You can get a PhD in Natural Language Processing, which is an entire field devote to computation analysis using text as data. We have two weeks to cover the topic! We obviously cannot go deep into this interesting field, but we can introduce some foundational tools and R functions for text processing. 
  
Let's get started by motivating the topic with a couple of cool examples. 

[Which Hip-Hop Artist Has the Largest Vocabulary?](https://pudding.cool/projects/vocabulary/index.html) 

[Counting Happiness](https://flowingdata.com/2021/07/29/counting-happiness/)  [[methods](https://megagon.ai/happydb-a-happiness-database-of-100000-happy-moments/)] [[data](https://github.com/megagonlabs/HappyDB)]

[Sentiment Analysis](https://www.kaggle.com/rtatman/tutorial-sentiment-analysis-in-r) 

[Who is the Anonymous Op-Ed Writer inside the Trump Administration?](http://varianceexplained.org/r/op-ed-text-analysis/)

These examples all demonstrate interesting uses of text as data. They are also examples of the types of insight that can come from analysis with big data - the patterns are hiding in plain sight but our brains cannot hold enough information at one time to see it.  Once we can find a system to extract hidden patterns from language we can go beyond seeking large public databases to generate insights, and we can start using all of Twitter, all published news stories, or all of the internet to identify trends and detect outliers. 

**Lecture Notes**

<a class="uk-button uk-button-default" href="../lectures/week-03/">LECTURE NOTES</a>


<br>
<br>


  
  
## Lab-03: Regular Expressions 

<hr> 

<a class="uk-button uk-button-default" href="../labs/lab-03-instructions.html">LAB-03 Instructions</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

**Due {{page.labs.lab-03}}**
  
<hr>
<br>






## Practice Problems

<hr> 
  
<a class="uk-button uk-button-default" href="../practice/week-03/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-04}}**
  
<hr>
<br>
  
  










<!--- 
#########################################
#########################################
##########
##########         WEEK 04
##########
#########################################
#########################################
-->




# Week 4 - Text Analysis 

## Unit Overview 

This week will use regular expressions you developed during the prior week and some additional text analysis tools from the package **quanteda** to practice working with text as data. 

**Required Reading**

Motivation for the topic this week comes from the Urban Institute's new [Racial Equity Analytics Lab](https://www.urban.org/racial-equity-analytics-lab). 

One of the challenges of bringing a data-driven approach to issues like racial equity is that tracking patterns and trends requires the ability to observe groups that might not be explicitly included in the data. 

One useful application of text analysis is using words to identify whether specific entities belong to a study group of interest. In this case, do foundations and nonprofits work with diverse communities? See: 

[Addressing Racial Funding Gaps in the Nonprofit Sector Requires New Data Approaches](https://www.urban.org/urban-wire/addressing-racial-funding-gaps-nonprofit-sector-requires-new-data-approaches)

**Quanteda**

There are several text analysis packages in R, but Quanteda is one of the most popular and robust.

Text analysis packages contain functions that assist in the manipulation of text as data in order to convert raw text files into structured databases, apply a variety of pre-processing steps that clean and standardize the data, and functions that assist in identifying patterns in text. 

Read the [Quanteda Quick-start Guide](https://quanteda.io/articles/quickstart.html) to familiarize your self with some basic components of text analysis. 

Focus on a few [KEY CONCEPTS](https://github.com/Watts-College/paf-514-template/blob/main/lectures/text-analysis.pdf): 

* Vocabulary: 
  - Document: a file consisting primarily of text 
  - Corpus: a collection of documents in a study 
  - Tokens: single words or phrases 
* Cleaning text: 
  - Removing punctuation and often numbers and symbols
  - Removing filler text called "stop words": the, and, where, etc 
* Pre-Processing Steps: 
  - Stemming words to remove variant components:  running, runner, runs -> run
  - Identify proper nouns 
  - Combine compound words into single words:  George Bush -> george_bush
  - Standardization of text using "dictionaries" 
* Analysis 
  - Tokenization of pre-processed documents  
  - Identification of patterns in use of words 


<br>
<br>
<br>







## Lab-04: Text Analysis

<hr> 

<a class="uk-button uk-button-default" href="../labs/lab-04-instructions.html">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

**Due {{page.labs.lab-04}}**
  
<hr>
<br>



## Practice Problems 

<hr> 

<a class="uk-button uk-button-default" href="../practice/week-04/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-05}}**
  
<hr>
<br>


## PROJECT: Start Data Wrangling Exercise

Get started on your data wrangling assignment. 

This assignment is designed to revisit some concepts from Data Science I and practice your data wrangling skills so that you can become facile with common dataset construction functions and descriptive statistics. 

* filtering by rows
  - select by position
  - select by condition
  - recycling rules 
* selecting by columns
  - select by name (base vs dplyr conventions)
  - select_all() functions
  - select by position
* joining datasets by shared IDs
  - left, right, middle, outer joins
  - compound IDs
  - cartesian product rules 
* dataset reshape
  - convert from wide to long format
  - convert from long to wide format
* data tidying
* renaming variables 
* variable transformations (one variable to one variable)
  - numeric to factor (e.g. age to age group)
  - factor to numeric (sample from category)
  - factor to factor (relevel)
  - character to factor (regex)
  - numeric to numeric (new feature)
  - new boolean (1/0 or T/F) variable (logical statements)
  - cumulative sum or proportion 
* feature engineering (multiple variables to one variable)
  - combine 5 scores (variables) into an index
  - conduct PCA to reduce data complexity
  - calculate distance of each house to nearest grocery store
  - complex logical statements with multiple conditions
  - conditional proportions (group_by)
* data standardization
* data validation
* data documentation
* data profiling
* summary tables
  - F1xF2: factor by factor (table or count functions, mosaic plots)
  - F1xN: factor by numeric (group_by + summarize, box and whisker plots)
  - F1xF2xF3: factor by factor by factor (table, mosaic plots)
  - F1xF2xN: factor by factor by numeric (group_by + summarize, ggplot+grid)

<hr>
<br>






<!--- 
#########################################
#########################################
##########
##########         WEEK 05
##########
#########################################
#########################################
-->


# Week 5 - GitHub Pages



## Unit Overview

A big part of every analysts job is trying to find ways to distill large volumes of data and information down to meaningful bites of knowledge, often for diverse stakeholder audiences that have varying degrees of technical expertise. For this reason, communication skills are extremely valuable for data scientists. You will constantly be challenged to find the interesting story that emerges from an overwhelming amount of data, and find creative ways to tell the story so that information becomes actionable. 

Although it might not sound as edgy as building a machine learning classifier, the ability to create customized reporting formats and automate various steps of analysis will both make you more efficient and also more effective at communication. 

This lab introduces you to one powerful tool for your toolkit - using GitHub pages to build a website quickly and inexpensively (for free, actually). Then use it to host various components of projects including public-facing reports and RMD documents after rendering. 

More generally, we will learn how to build templates that can be used in websites or to batch process R Markdown reports. 

Templates use the same basic tools for both HTML pages and R Markdown reports. Some basic familiarity with CSS, page containers, and responsive design can go a long way toward empowering you to automate organizational reporting processes. 

**Lecture Notes** 

<a class="uk-button uk-button-default" href="../lectures/week-05/">LECTURE NOTES</a>

<br>
<br>
<br>




## Lab 05: GitHub Pages 

<hr>

<a class="uk-button uk-button-default" href="../labs/lab-05/">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

Also share your page link on YellowDig: 

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Due {{page.labs.lab-05}}**

<hr>
<br>




  
## Practice Problems 

<a class="uk-button uk-button-default" href="../practice/week-05/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-06}}**
  
<hr>
<br>
















<!--- 
#########################################
#########################################
##########
##########         WEEK 06
##########
#########################################
#########################################
-->


#  Week 6 - Creating Report Templates



## Unit Overview

<hr> 

<a class="uk-button uk-button-default" href="../lectures/week-06/">LECTURE NOTES</a>

<hr>  
<br>


## Lab 06: Creating RMD Templates  

<hr>

**Due {{page.labs.lab-06}}**

<a class="uk-button uk-button-default" href="../labs/lab-06-instructions/">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT LAB</a>

<hr>
<br>



## Practice Problems 

<hr>

<a class="uk-button uk-button-default" href="../practice/week-06/">PRACTICE PROBLEMS</a>

<a class="uk-button uk-button-primary" href="{{page.yellowdig_url}}">YELLOWDIG</a>

**Post on {{page.yellowdig.post-07}}**
  
<hr>
<br>

## Data Wrangling Exercise

**Due {{page.projects.data-wrangling}}**

Coming soon....

<a class="uk-button uk-button-default" href="">Instructions</a>

---

<br>
<br>




<br>








<!--- 
#########################################
#########################################
##########
##########         WEEK 07
##########
#########################################
#########################################
-->



# Week 7 - FINAL PROJECTS 



## Project Lifecycle Lab

**Due {{page.projects.report-template}}**

This final project is worth 15 points, compared to 10 points for regular labs. It is not meant to be a big final project that you spend lots of time one, rather a nice well-scoped task (creating reports that break out salaries by job title and gender), but it requires data cleaning, agmentation, and wrangling in order to complete the task. It also requires the use of loops to replicate the steps across a bunch of units within an organization.

It is designed to be integrative where you can see various skills you have learned throughout the semester come together into the type of work-flow needed to structure larger tasks. I have provided code for the most time-intensive tasks (creating a crosswalk from raw job descriptions to five well-structured job categories and creating a customized graphing function tailored to this data). You will need to implement functions to accomplish some steps on your own, then gather all of the functions into a "utilities" script (utils.R). The RMD document loads the data and "sources" these functions to control the work flow and execute the steps at a high level. 

A key learning outcome is understanding how the basic building blocks of data programming and content packaging come together to create your deliverable. You will get more practice with these skills in CPP 528 when you do a deep dive into project management frameworks. 

-------------

<a class="uk-button uk-button-default" href="../labs/final-project-instructions.html">INSTRUCTIONS</a>

<a class="uk-button uk-button-primary" href="{{page.canvas.assignment_url}}">SUBMIT PROJECT</a>

---------------

<br>
<br> 






























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
  color: #995c00;
  font-weight:300;
  margin-top:40px !important;
  margin-bottom:20px;
  } 

h3{
  font-size:calc(1.4em + 0.25vw);
  font-weight:300;
  margin-top:20px !important;
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

