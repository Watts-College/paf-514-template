---
layout: lab
title: Function Conflicts   
image: model.svg
image-width: 150px
---

<div class = "uk-container uk-container-small">

-----------------------

* TOC
{:toc}

-----------------------

<br>

## Package Load and Function Conflict 

When creating packages you should consider function conflicts (multiple packages with the same function name). The order in which packages are attached determines the default function called:

```r
library(lubridate)    |  library(here)
library(here)         |  library(lubridate)
here() # here::here() |  here() # lubridate::here()
```

The most likely place you encounter these are filter() and select(). You may have loaded dplyr and expect that you are calling **dplyr filter()**, but you might be calling a different **filter()** instead. 

The solution is to reference functions in packages explicitly using `package::function()`. **This is the recommended best practice for all package development.**

The only problem with this approach is operators, the pipe operator being the most widely used. You cannot reference an operator in the same way: `dplyr::%>%`.

```r
# DOES NOT WORK
x <- 1:10

x dplyr::%>% sum()
Error: unexpected symbol in "x dplyr"

x dplyr::`%>%` sum()
Error: unexpected symbol in "x dplyr"
# ASSIGN OPERATOR TO YOUR ENVIRONMENT FIRST

`%>%` <- dplyr::`%>%`
x %>% sum()
[1] 55

# THIS ALSO WORKS
import::from("magrittr", "%>%")
```

You can add those workarounds to the top of your sourced file to use the pipe operator. It's also the reason the base R pipe operator `|>` was introduced.

## Conflicts through Dependencies

Conflicts can arise in weird ways. If you know that packageA and packageB have a conflicted function, you might load packageA last so you can use that version. But if packageC is loaded next, and it depends on packageB, then the packageB function will now take precedents.

Similarly, people often load packages inside functions. Variables are protected by function scope, but the package namespace is not. You may call that function and inadvertently mask a function by changing the order of packages on your search path. You can see here the package remains attached after the function call:

```r
x <- 1:10
sum_x <- function(x)
{ 
  library( dplyr )
  sum(x)
}

x %>% sum()
Error in x %>% sum() : could not find function "%>%"

sum_x(x)
[1] 55

x %>% sum()  # dplyr now loaded b/c of a call to sum_x()
[1] 55
```

This is why you should never include package load statements inside functions that you write for packages. Just reference the function using `package::function` instead. If you are stuck, the `import::fom()` approach lets you load one function instead of a whole package, which will also minimize conflicts. 

## Adding Dependencies to Your Package 

When adding dependencies to your package (the list of other packages that must be installed for yours to work correctly), you have two options: **Imports** and **Depends**. When you add either arguments to the DESCRIPTION file created in your package directory it will direct R to check whether those packages are already installed when you install your new package, and if not it will install them as well. 

The main difference is how they are loaded. When *packageA* is listed in **Imports**, when you load your package it can use all of the functions inside of *packageA*. When listed in **Depends** packageA will be loaded when you load your package, but so will all of packageA's dependencies. That is more likely to cause function conflicts. 

There are some cases when loading all of your dependencies dependencies are necessary, but it is suggested to use **Imports** to minimize conflicts. 

```
# IN DESCRIPTION FILE
Depends:
    qtl 
Imports:
    jsonlite,
    utils (>= 1.30-4)
Suggests:
    knitr,
    devtools
```

**Suggests** is also an option, but packages that are only suggested are not installed when your package is installed. Typically this means they might be use in vignettes or demos, but are not required for the package to function properly (no pun intended). 

<br>
<br>
<hr>
<br>
<br>

</div>
