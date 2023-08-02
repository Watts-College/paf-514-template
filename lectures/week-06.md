---
layout: lab
title: Report Templates  
image: model.svg
image-width: 150px
---

<div class = "uk-container uk-container-small">

-----------------------

* TOC
{:toc}

-----------------------

<br>
  
  
## What is a Template?

Solid data programming skills are needed to generate robust results. Accuracy is necessary but not sufficient to achieve impact with your work. You also need to be effective at communicating your results in a clear and concise manner.
   
Templates are ways to separate **content** (or data) from **design** (page layout, fonts, styles, spacing). 
  
You have already encountered a couple of template examples including: 

* Jekyll templates like the [table example using liquid tags and YAML headers](http://ds4ps.org/barebones-jekyll/page2)  
* An HTML page template like the [syllabus page for this course](https://raw.githubusercontent.com/Watts-College/cpp-527-fall-2021/main/_layouts/index.html)  
  
This week you will learn how to build templates for R Markdown documents so that you can automate reporting systems (for example, create the same report each week with new data) or batch process a large number of reports using different slices of the data for each (for example, produce a separate crime report for each city in a US database). 

[Your Resume as an HTML Page](http://nickstrayer.me/cv/)  

<br>
<br>
  
  
  
### Template Functions 

Template functions are helper functions that merge content from a data frame or file with an HTML template to control how the content is presented in the report. 
  
Templates are often used when we need to summarize lots of pieces of information using consistent styling.  

```r
### CONTENT 
name <- "RUBY TUESDAY"
title <- "TOP DOG" 


### TEMPLATE FUNCTION - combine content with style 
add_tags <- function( name, title )
{

  cat( paste0( '<tag> ', name, ' </tag>' ) )
  cat( '\n' )  # line break 
  cat( paste0( '<div class="title"> ', title, ' </div>' ) )
  cat( '\n' )  # line break

}

# test it:
add_tags( name, title )   
```
            
HTML output that is added to your RMD doc while knitting: 
            
````
<tag> RUBY TUESDAY </tag>
<div class="title"> TOP DOG </div>
````

This HTML code is now readable by the browser and the user will experience organized and nicely-formatted content. 

<br>
<br>

  
### Adding Icons to Templates
  
Font Awesome is a free library of icons that can be added to RMD documents and dashboards in R. 
  
Icons need to be downloaded from FontAwesome through their API, and they are added to HTML as SVG object tags (SVG stands for scalable vector graphics - the numeric coordinates included in the svg file are the drawing instructions for the icon). 

See the tutorial below to get a sense of the challenges of converting an SVG object to regular text that can be integrated with other HTML tags. Be sure you are combining tags using **paste()**, exporting them from chunks as literal and not printed text using **cat()**, and including the **results="asis"** chunk argument. 

--------
  
<a class="uk-button uk-button-default" href="../../labs/font-awesome-rmd-integration-test.html">Add Icons to Templates</a>

--------
  
```r
# install.packages("fontawesome")
  
# - get icon svg object from font awesome 
# - implicitly recast as text when added to HTML tags 
# - cat() to export, need to include {r, results="asis"}

fa <- fontawesome::fa( name="github" )
x <-  paste0( '<a href="www.google.com">\n', fa, '\n</a>' )
cat( x )
```

HTML output that is added to your RMD doc during knitting: 

````
<a href="google.com">
<svg aria-hidden="true" role="img" viewBox="0 0 496 512" style="height:1em;width:0.97em;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:currentColor;overflow:visible;position:relative;"><path d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"/></svg>
</a>
````  

<br>
<br>

### Required Reading

--------
  
<a class="uk-button uk-button-default" href="../report-automation.html">Building RMD Templates</a>

--------

<br>
<br>


### Background Reading

[Parameterized Reports in R Markdown](https://rmarkdown.rstudio.com/developer_parameterized_reports.html%23parameter_types%2F)  

[GitHub Pages Jekyll Tools Library](https://github.com/cagrimmett/jekyll-tools)

*If you want to take your skills to the next level consider how report templates can be used to implement experiments with the presentation of information such as [A/B Testing for your resume](https://davidlindelof.com/a-b-testing-my-resume/). These sorts of skills are in high-demand as they are useful for refining content for large-scale marketing campaigns, outreach material, or user experience on a website.* 
  
<br>
<hr>
<br>  
  
  



  

  
<br>
<hr>
<br>
<br>

</div>
