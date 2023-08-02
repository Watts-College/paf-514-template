---
layout: lab
title: GitHub Pages   
image: model.svg
image-width: 150px
---

<div class = "uk-container uk-container-small">

-----------------------

* TOC
{:toc}

-----------------------

<br>
  
## Required Reading

Skim the following chapters, reading to get a general sense of **concepts, vocabulary, and the basics** of each component. *You can skip sections that explain the code in detail.* 
  
I am more concerned that you understand how these basic pieces fit together, and when you hear terms like "responsive" you conceptually know what people are talking about. At a minimum you should understand the bulleted vocabulary under each section:

[Basic Webpage Architecture](https://www.internetingishard.com/html-and-css/basic-web-pages/)

* tags (headings, formatting, lists)
* page elements (head, body) 
* structure versus presentation 
* line breaks 
  
[Style Sheets: CSS](https://www.internetingishard.com/html-and-css/hello-css/)

* style tags 
* properties 
* values 
* units of measure (pixels **px** versus relative scaling **EM**) 
* principle of cascading style and style hierarchy 
  
[Responsive Design](https://www.internetingishard.com/html-and-css/responsive-design/)

* screen size (desktop vs mobile vs tablet) 
* containers 

[Bootstrap (wikipedia entry)](https://en.wikipedia.org/wiki/Bootstrap_(front-end_framework))

* pre-existing CSS libraries (similar to R packages) 
  
Helpful overview of how website architectures. Focus on the big picture of what each component does, specifically the concept of **separation of content and style**. Websites leverage **templates** and **style sheets** to create page layouts, containers for data, and consistent look and feel of material. In subsequent weeks we will show you how you can integrate these principles into RMD docs to create report templates and automate reporting. Don't worry about the specifics of HTML code. 
  
[Introduction to Web Programming](https://www.internetingishard.com/html-and-css/)
  
  
## GitHub Pages Set-Up

This week's lab will ask you to configure a GitHub page within a repository on your account. GitHub pages are an amazing resource because (1) they allow you to create an unlimited number of websites related to your projects FOR FREE, and (2) they can be created and maintained using Markdown, which simplifies a lot of the complexity of websites. You will learn to link HTML files generated from R Studio so that you can start sharing analytical projects with external audiences. 

The set-up of a simple GitHub page is fairly straight-forward and can be completed in a few basic steps:

![](https://github.com/DS4PS/cpp-527-spr-2020/blob/master/lectures/images/github-pages-setup.gif?raw=true)

This will give you a barebones website with a landing page you can write using Markdown, and a few templates that you can select from. 

You have access to myriad advanced features on the platform. GitHub pages leverage several powerful web frameworks like Jekyll, Bootstrap, Liquid, and Javascript to make customization of static pages both easy and powerful. We will spend some time talking about how the pieces of a website fit together so that you have a rudimentary knowledge of the platform:

[Barebones Jekyll Example](http://ds4ps.org/barebones-jekyll/index)

More importantly, GitHub pages can help demonstrate the concept of page templates. We can design the layout of a graphic, table, or section of text on a page then dynamically populate it with data. GitHub pages allow you to do with with basic HTML and Liquid tags:

[Table Template Example](http://ds4ps.org/barebones-jekyll/page2)

And the **pagedown** package in R allows you to develop a variety of templates using similar principles:

[Pagedown Overview](https://slides.yihui.org/2019-rstudio-conf-pagedown.html#1)

Similar to other work we have done in R, we will start by using some working examples then reverse engineer them so you can see how the pieces fit together. You are not expected to master any of these topics in the short time-frame of the semester. The proper benchmark of knowledge is can you take an existing open source project and adapt it as necessary. 

  
  
## Custom Page Templates 

For the project component of the course we will use a CV template to learn how the **pagedown** package in R can be used to create highly-customized report templates:

[Auto-Generated Resume](http://nickstrayer.me/cv/)

We will also practice automation by the separation of the design elements of reporting from the data contained in the reports. In this example for a CV, Nick Strayer's positions are stored in a CSV file on GitHub:

[Positions CSV](https://github.com/nstrayer/cv/blob/switch_to_googlesheets/csvs/positions.csv)

And they are added to the document templates using some custom functions which filter positions and loop through the list to iteratively build the document. 

````
```{r}
print_section(position_data, 'education')
```
````

These are accomplished with text formatting functions that are a little more advanced than where you are at now. But if you are curious, they are basically just taking lists of text, putting it into tables, and formatting the tables. The formatting functions are [HERE](https://github.com/nstrayer/cv/blob/switch_to_googlesheets/parsing_functions.R). 

  
  
## Cascading Style Sheets 

You will not be required to learn web programming languages like HTML and Javascript (though they are super useful if you invest the time). You do, however, need to become familiar with very basic CSS as it is impossible to do customization without it. CSS started as a somewhat modest project but has evolved into a powerful language. R Markdown documents support CSS, which makes them fully customizable. It will also become more important so you begin to develop dashboards or custom interactive Shiny apps, since CSS is the primary means of controlling layouts and other style elements. 

These two pages on the example GitHub site have the same content, but CSS elements are used to change the page layout and style on the second. Click on the "see page layout" button to see the CSS elements. 

[Basic Page](http://ds4ps.org/barebones-jekyll/index)

[Style Added with CSS](http://ds4ps.org/barebones-jekyll/page1) 

  
  


  
<br>
<hr>
<br>
<br>

</div>
