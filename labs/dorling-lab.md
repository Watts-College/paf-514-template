---
layout: lab
title: Scaling Analysis
image: microscope.png
image-width: 150px
---

<div class = "uk-container uk-container-small">



-----------------------

* TOC
{:toc}

-----------------------

<br>
  
  
## Scaling Your Analysis w Functions and Loops

### Building Community Map Files 
  
If you recall from CPP 526 we discussed the example where Ben Balter, [GitHub’s official government evangelist](https://readwrite.com/2014/08/14/github-government-ben-balter-open-source/), created a project to make Washington DC open GIS files more accessible and useful by converting them all to a format more amenable to open-source projects (geoJSON files).

Ben wrote a script that downloaded all of Washington DC’s open data files, converted them to better formats, then uploaded them to GitHub so others have access:

[https://github.com/benbalter/dc-maps](https://github.com/benbalter/dc-maps)

The geoJSON files can also be read into R directly from GitHub, making it easy to incorporate the spatial maps and data into a wide variety of projects:

```r
library( geojsonio )
library( sp )
github <- "https://raw.githubusercontent.com/benbalter/dc-maps/master/maps/2006-traffic-volume.geojson"
traffic <- geojson_read( x=github, what="sp" )
plot( traffic, col="steelblue" )
```

### Dorling Lab from CPP 529 
  
Recall the lab where you created one Dorling cartogram for your neighborhood clustering project:

![](file:///C:/Users/jdlecy/Dropbox/00%20-%20PEDA/00%20-%20GITHUB/COURSE-CPP-529-PRACTICUM/cpp-529-master/LABS/lab-03-tutorial_files/figure-html/unnamed-chunk-21-1.png)



```r
library( geojsonio )   # read shapefiles
library( sp )          # work with shapefiles
library( sf )          # work with shapefiles - simple features format
library( tmap )        # theme maps
library( dplyr )       # data wrangling
library( pander )      # nice tables 


crosswalk <- "https://raw.githubusercontent.com/DS4PS/cpp-529-master/master/data/cbsatocountycrosswalk.csv"
crosswalk <- read.csv( crosswalk, stringsAsFactors=F, colClasses="character" )

# search for citie names by strings, use the ^ anchor for "begins with" 
grep( "^MIN", crosswalk$msaname, value=TRUE ) 

# select all FIPS for Minneapolis
these.minneapolis <- crosswalk$msaname == "MINNEAPOLIS-ST. PAUL, MN-WI"
these.fips <- crosswalk$fipscounty[ these.minneapolis ]
these.fips <- na.omit( these.fips )

state.fips <- substr( these.fips, 1, 2 )
county.fips <- substr( these.fips, 3, 5 )

dat <- data.frame( name="MINNEAPOLIS-ST. PAUL, MN-WI",
                   state.fips, county.fips, fips=these.fips )               
dat
```

|name                        |state.fips |county.fips |fips  |
|:---------------------------|:----------|:-----------|:-----|
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |003         |27003 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |019         |27019 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |025         |27025 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |037         |27037 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |053         |27053 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |059         |27059 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |123         |27123 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |139         |27139 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |141         |27141 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |163         |27163 |
|MINNEAPOLIS-ST. PAUL, MN-WI |27         |171         |27171 |
|MINNEAPOLIS-ST. PAUL, MN-WI |55         |093         |55093 |
|MINNEAPOLIS-ST. PAUL, MN-WI |55         |109         |55109 |


Now download shapefiles with Census data:

```r
library( tidycensus )

# census_api_key("YOUR KEY GOES HERE")
# key <- "abc123"
# census_api_key( key )


# Minneapolis metro area spans two states - 
# Minnesota = 27
# Wisconsin = 55

msp.pop1 <-
get_acs( geography = "tract", variables = "B01003_001",
         state = "27", county = county.fips[state.fips=="27"], geometry = TRUE ) %>% 
         select( GEOID, estimate ) %>%
         rename( POP=estimate )

msp.pop2 <-
get_acs( geography = "tract", variables = "B01003_001",
         state = "55", county = county.fips[state.fips=="55"], geometry = TRUE ) %>% 
         select( GEOID, estimate ) %>%
         rename( POP=estimate )

msp.pop <- rbind( msp.pop1, msp.pop2 )

plot( msp.pop )
```

![](file:///C:/Users/jdlecy/Dropbox/00%20-%20PEDA/00%20-%20GITHUB/COURSE-CPP-529-PRACTICUM/cpp-529-master/LABS/lab-04-instructions_files/figure-html/unnamed-chunk-9-1.png)

Convert to a Dorling cartogram: 

```r
# convert sf map object to an sp version
msp.sp <- as_Spatial( msp )
class( msp.sp )

# project map and remove empty tracts
msp.sp <- spTransform( msp.sp, CRS("+init=epsg:3395"))
msp.sp <- msp.sp[ msp.sp$POP != 0 & (! is.na( msp.sp$POP )) , ]

# convert census tract polygons to dorling cartogram
# no idea why k=0.03 works, but it does - default is k=5
msp.sp$pop.w <- msp.sp$POP / 9000 # max(msp.sp$POP)   # standardizes it to max of 1.5
msp_dorling <- cartogram_dorling( x=msp.sp, weight="pop.w", k=0.05 )
plot( msp_dorling )
```

![](file:///C:/Users/jdlecy/Dropbox/00%20-%20PEDA/00%20-%20GITHUB/COURSE-CPP-529-PRACTICUM/cpp-529-master/LABS/lab-04-instructions_files/figure-html/unnamed-chunk-9-2.png)

## Instructions:

1. Create an R script that will convert all US Metro Area shapefiles into Dorling cartograms, one new shapefile for each metro area.  
2. Save each Dorling cartogram as a geoJSON file. 
3. Create a dorling-msa-geojson GitHub repository. 
4. Upload the files and add instructions to the README for people to use them as alternatives to regular Census tract maps to improve the visualization of demographic data in urban environments. 

For example, once you have finished it will be possible to do the following: 

```r
# dorling cartogram of Phoenix Census Tracts
github.url <- "https://raw.githubusercontent.com/DS4PS/cpp-529-master/master/data/phx_dorling.geojson"
phx <- geojson_read( x=github.url,  what="sp" )
plot( phx )
```

Start with pseudo-code and write down the steps. I would recommend writing a couple of functions: 

* Select and parse state and county FIPS codes based upon a city name, return a data frame. 
* Using the MSA data frame you just created, download the census data and shapefile. 
* Convert a current MSA object to a Dorling cartogram object. 

Test your code with a single city until it is functional:

```r
these.minneapolis <- crosswalk$msaname == "MINNEAPOLIS-ST. PAUL, MN-WI"
```

At that point you can scale your steps by generalizing the city name. 

```r
city.names <- unique( crosswalk$cbsaname )

for( i in city.names )
{
  # your code here 
}
```

<br>
<br>
  
  
  
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
