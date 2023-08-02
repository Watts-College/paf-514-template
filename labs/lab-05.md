---
layout: lab
title: GitHub Pages 
image: microscope.png
image-width: 150px
---

<div class = "uk-container uk-container-small">



-----------------------

* TOC
{:toc}

-----------------------

<br>

# Creating a GitHub Page

The animation in the Unit Overview above shows how simple it is to activate GitHub pages for any project repository so that you can turn markdown files into web-hosted HTML files and share tutorials or reports created from RMD files. 

If we want a website with a bit more functionality, however, we will need to start from an existing template and adapt it. 

For this lab you will copy and then adapt an existing GitHub pages websites. 


## Step 01

Start by forking or cloning the **beautiful-jekyll** website template (static version archived here):

[Beautiful Jekyll Website Template on GitHub](https://github.com/DS4PS/beautiful-jekyll)

You can see examples of the template in action in the [Featured Sites Gallery](https://beautifuljekyll.com/examples/). 

After forking the files you need to activate the GitHub pages option under Settings >> Pages (select the main branch and root folder). 
  
GitHub has changed some of the repository settings recently and is now using the term **Main** to refer to the default branch in a repository instead of **Master** (you will learn more about branches in CPP 528). Note that older repositories may have a Master branch still, and some of the documentation will use the term Master, so if you run across that term generally use "main" instead. 

**Forking vs Cloning:** 

Forking a project on GitHub creates a copy of the project on your account. You can update files without impacting the originals. Forking a project retains the link back to the original project so that you can add updates from the original version and if desired send pull requests back to the original with code updates that improve their project (this is how contributions to open-source projects are made).

When you **clone** a site, you copy all of the files to your account (similar to forking), but you sever ties between the two projects. This is done if you want to take the code as it exists and then modify it to create a new project that is distinct from the original. It means you can't incorporate updates from the original project and you can't send suggested code updates back to the original project.

You fork a project when you want to continue to contribute back to the original or continue to incorporate updates made in the original project. You clone a repository if you want to take the code as it stands and adapt it as something new. You still need to attribute the original project after cloning, but there will be no formal link between the repositories on GitHub after cloning.
  
Forking is fine for this assignment, but in the future if you don't plan to contribute back to a project it is better to clone it. 

-----


## Step 02

After forking or cloning a site, follow the instructions in the README file to begin customizing your page (the README file should look this [THIS](https://github.com/DS4PS/beautiful-jekyll/blob/master/README.md)). 

In the **`_config.yml`** file in the default directory do the following: 

**Change the website name and description.**

```
# Name of website
title: My website

# Short description of your site
description: A virtual proof that I'm awesome
```

You can update social network IDs if you like, or replace Dean's info with empty quotes `""` so the social media icons are present but not active. 

**Change the color scheme for the website:**

```
# Personalize the colors in your website. Colour values can be any valid CSS colour

navbar-col: "#F5F5F5"
navbar-text-col: "#404040"
navbar-children-col: "#F5F5F5"
page-col: "#FFFFFF"
link-col: "#008AFF"
hover-col: "#0085A1"
footer-col: "#F5F5F5"
footer-text-col: "#777777"
footer-link-col: "#404040"
```

## Step 03

**Add Page and Update Navigation**

You have forked the master branch of the website, which does not include the "getting started" page on the live site menu:

Navigate to the [getting started content](https://github.com/daattali/beautiful-jekyll/blob/master/README.md) located in the README.md file in the BeautifulJekyll repo, and copy the file content (the raw markdown text) to a new file called **getstarted.md** in the main folder on your site. Be sure to copy text from the **raw** view of the page with the markdown code and not the formatted version that does not include markdown tags. 

Now update the navigation bar and add another option called "Getting Started" under "Resources". You will use the text "getstarted" for the URL, excluding the *.md* markdown extension. GitHub pages converts all markdown files to HTML files in the background, so you want to direct the user to the HTML version, which does not require an explicit extension to work in browsers:

```
# List of links in the navigation bar
navbar-links:
  About Me: "aboutme"
  Resources:
    - Beautiful Jekyll: "http://deanattali.com/beautiful-jekyll/"
    - Learn markdown: "http://www.markdowntutorial.com/"
    - Getting Started: "getstarted"                         # ADD THIS LINK
  Author's home: "http://deanattali.com"
```
 
The **index.html** file contains text from the landing page of the website. You will find some page title and descriptions in the YAML header of this file:

````
---
layout: page
title: My website
subtitle: This is where I will tell my friends way too much about me
use-site-title: true
---
````


## Step 04 

**Change the Text Style on the Getting Started Page**

Demonstrate that you are able to apply CSS styles to specific elements of a page. 

Create a new **div** section around section 1 **on the Getting Started page** in order to change the style of that section only. 

```
### Overview of steps required

There are only three simple steps, ....  

Here is a 40-second video ....

<img src="../img/install-steps.gif" style="width:100%;" alt="Installation steps" />


<div class="gs-section-01" markdown="1">


### 1. Fork the Beautiful Jekyll repository 

Fork the [repository](https://github.com/daattali/beautiful-jekyll) 
by clicking the Fork button on the top right corner in GitHub.


</div>
```

Note that in order to render markdown text between HTML `<div>` tags you need to do two things:

(1) Make sure your file is a markdown .md file type and not an HTML .html file.

Either will work with GitHub pages, but only the .md files are automatically converted from MD to HTML on the GitHub (kramdown) servers. If you add markdown elements to an HTML file type they will not be converted. 

(2) Add a markdown="1" attribute or double-squirrely brackets. 

By default any markdown that occurs between HTML div tags is not converted to HTML. To instruct the server-side parser to process the text as markdown you need to add the **markdown="1"** attribute to the div tag, or wrap the markdown text in double-squirrely brackets. The first option is much cleaner. 

**Option 1:**

```
<div class="gs-section-01" markdown="1">

### 1. Fork the Beautiful Jekyll repository 

Fork the [repository](https://github.com/daattali/beautiful-jekyll) 
by clicking the Fork button on the top right corner in GitHub.

</div>
```

**Option 2:**

````
<div class="gs-section-01"> 

{% raw %}
{{  

### 1. Fork the Beautiful Jekyll repository 

Fork the [repository](https://github.com/daattali/beautiful-jekyll) 
by clicking the Fork button on the top right corner in GitHub.

}} 
{% endraw %}

</div>

````

Follow the [Barebones Jekyll example](http://ds4ps.org/barebones-jekyll/page1) for customizing a page style by adding a CSS style sheet the bottom of the Getting Started page:

```
<style>

.gs-section-01 h3 { 
     color: red }

.gs-section-01 p {
     font-size: 30px;
}

</style>
```

Similarly, add new **div** sections around Step 02 and Step 03 on the page so that each step has different header styles and text. It doesn't have to look nice - just show you are able to selectively change the style on a page. 

  
  
## Step 05
  
**Create a Liquid Table** 

Using the [Barebones Jekyll Custom Table example](http://ds4ps.org/barebones-jekyll/page2) add a page with a custom table. 

Copy the [liquid-table.html](https://github.com/DS4PS/barebones-jekyll/blob/master/_layouts/liquid-table.html) template and add it as a new layout in your site's layout folder. You will need to change the parent page template on the *liquid-table.html* page to "default" or "page" in your new site (you don't have a *nice-text* layout that you can use as the parent page layout). 

```
---
layout: default
---
```

Create a new page in your main website folder called **table-demo.md** and copy the page content from the [Barebones Jekyll example](https://github.com/DS4PS/barebones-jekyll/edit/master/page2.md).

You will need to add the ryan-v-ryan.jpg image to your **img** folder for it to be accessible on your new site (you can right-click and save it, then drag it into the image folder on your GitHub site). 

You do not need to include the "See Page Layout" button. 


```
---
layout: liquid-table
title: 'amiright?'
reynolds:
  strengths:
  - good father
  - funny
  - dated alanis morissette
  weaknesses: 
  - singing
  - green lantern movie
  - tennis backhand 
gosling:
  strengths: 
  - builds houses
  - is a real boy
  - never dated alanis morissette
  weaknesses: 
  - micky mouse club
  - cries a lot
  - not ryan reynolds
---

![](img/ryan-v-ryan.jpg)  

### Lorem Ipsum

Lorem ipsum dolor sit amet....
```

Add the page to your navigation bar: 

```
# List of links in the navigation bar
navbar-links:
  About Me: "aboutme"
  Resources:
    - Beautiful Jekyll: "http://deanattali.com/beautiful-jekyll/"
    - Learn markdown: "http://www.markdowntutorial.com/"
    - Getting Started: "getstarted"                         
  Table Demo: "table-demo"              # ADD THIS LINK
```

When these steps are done, submit a link to (1) your live site and (2) your GitHub repo where the website lives. 

  
  
  
  
  
  
  
  
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
