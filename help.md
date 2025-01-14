---
layout: discussions
---






## Discussion Board Etiquette

We are using GitHub Issues for discussion boards to practice posting questions in a style simiilar to popular data science forums like StackOverflow. 

Discussion boards are amazing resources because you can post complex questions and talented professionals from around the world will help solve your problems FOR FREE! 

There is some skill involved in asking questions so that they are clear, concise, and provide the information needed for someone to offer a solution. 

For example, StackOverflow has a succinct guide on [asking clear questions](https://stackoverflow.com/help/how-to-ask) and Jon Skeet has an excellent [blog post](https://codeblog.jonskeet.uk/2010/08/29/writing-the-perfect-question/) on the topic.


## Simple Rules for Clear Questions

#### (1) Don't Repeat Questions

Check the existing list of questions and topics to make sure your questions has not been asked already. Often times the answer already exists, you just need to read a couple of previous discussions.

#### (2) Include Your Code 

This question is difficult to answer because we don't know how the error was generated unless you share your code:

> I am trying to merge my data but I keep getting the error message, "x is not a factor".

You need to show the code that generated the error message. Try something like: 

--- 

> I am trying to merge my data, but I keep getting the error message, "cannot merge object type list". Here is my code:

```r
x <- data.frame( id=letters[1:10], v1=rnorm(10) )
y <- data.frame( id=letters[1:10], v2=rbinom(10) )
z <- list( x, y )
merge( y, z )
```

--- 

GitHub speaks Markdown, which allows you to include reproducible code.

<br>
<img src="https://raw.githubusercontent.com/hasi96/course_website/master/assets/img/github-issue.png" 
alt="Issues" width="800" />
<br>
<img src="https://raw.githubusercontent.com/hasi96/course_website/master/assets/img/github-issue-preview.png" 
alt="Issues" width="800" />
<br>
 

#### (3) Include Data

You can include data in your questions in a few ways that are [summarized here](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example). 

There are some functions that allow you generate random data that can be used to demonstrate the problem.

Many packages include built-in datasets that can be easily loaded with the data() function.

```r
data( USArrests )
> head( USArrests )
           Murder Assault UrbanPop Rape
Alabama      13.2     236       58 21.2
Alaska       10.0     263       48 44.5
Arizona       8.1     294       80 31.0
Arkansas      8.8     190       50 19.5
California    9.0     276       91 40.6
Colorado      7.9     204       78 38.7
```

If the data is important for your question, you can post a small sample of your data using the dput() function. For example, here is the dput() output from the US Arrests dataset that comes with R.

```r
> dput( head( USArrests ) )

structure(list(Murder = c(13.2, 10, 8.1, 8.8, 9, 7.9), Assault = c(236L, 
263L, 294L, 190L, 276L, 204L), UrbanPop = c(58L, 48L, 80L, 50L, 
91L, 78L), Rape = c(21.2, 44.5, 31, 19.5, 40.6, 38.7)), .Names = c("Murder", 
"Assault", "UrbanPop", "Rape"), row.names = c("Alabama", "Alaska", 
"Arizona", "Arkansas", "California", "Colorado"), class = "data.frame")
```
And here is what the output looks like after being pasted back into R:

```r
> structure(list(Murder = c(13.2, 10, 8.1, 8.8, 9, 7.9), Assault = c(236L, 
+ 263L, 294L, 190L, 276L, 204L), UrbanPop = c(58L, 48L, 80L, 50L, 
+ 91L, 78L), Rape = c(21.2, 44.5, 31, 19.5, 40.6, 38.7)), .Names = c("Murder", 
+ "Assault", "UrbanPop", "Rape"), row.names = c("Alabama", "Alaska", 
+ "Arizona", "Arkansas", "California", "Colorado"), class = "data.frame")

           Murder Assault UrbanPop Rape
Alabama      13.2     236       58 21.2
Alaska       10.0     263       48 44.5
Arizona       8.1     294       80 31.0
Arkansas      8.8     190       50 19.5
California    9.0     276       91 40.6
Colorado      7.9     204       78 38.7
```

Thus dput() makes it easy for people on the discussion board to re-create your original dataset.

## Style Guides

Computer languages have rules that are similar to grammar rules in natural languages. This is called "syntax". Unlike grammar, syntax is strictly enforced in most computer languages because improper syntax will result in code that does not run.

There is another idiosyncratic aspect of computer code called "style". Since computer code for the most part ignores spaces, you don't have punctuation, and you can nest functions, style describes how readable and clear your code is. You can write accurate and functional code that is really hard to interpret. With good style it will be easier to share and maintain.

There are two popular style guides for R:

* [The Google R Style Guide](https://google.github.io/styleguide/Rguide.xml)
* [The Tidyverse Style Guide](http://style.tidyverse.org/index.html)

Think of these suggestions as good habits that will make your life easier and will improve your ability to collaborate with others.

My one addition to the style guide was inspired by the German language, which includes this whopper:

> Donaudampfschifffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft

It means, "Association for Subordinate Officials of the Head Office Management of the Danube Steamboat Electrical Services". Although technically allowable, these compound German words are impossible to read and pronounce. 

Similarly, your code technically might be correct, but it is much easier to read if you treat each argument as a separate word and use spaces accordingly. Which is easier to understand?

```r
y<-cut(rank(x),breaks=seq(from=1,to=100,by=10),labels=paste("X",1:10,sep=""))
```
Or:

```r
y <- cut( rank( x ), breaks=seq( from=1, to=100, by=10 ), labels=paste( "X", 1:10, sep="" ) )
```





