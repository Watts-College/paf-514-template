library( dplyr )
library( pander )
library( quanteda )


# library( quanteda.textmodels )
# library( quanteda.textstats )
# library( quanteda.textplots )

URL <- "https://github.com/DS4PS/cpp-527-spr-2020/blob/master/labs/data/IRS-1023-EZ-MISSIONS.rds?raw=true"
dat <- readRDS(gzcon(url( URL )))
head( dat[ c("orgname","codedef01","mission") ] ) %>% pander()




# convert missions to all lower-case 

dat$mission <- 
  dat$mission %>%
  tolower()



# use a sample for demo purposes

dat.sample <- 
  dat %>% 
  sample_n( 1000 )

corp <- 
  dat.sample %>% 
  corpus( text_field="mission" )

(corp)[1:10,] %>% 
  summary %>% 
  knitr::kable(align="c")




##########
##########  PRE-PROCESSING STEPS
##########

# remove mission statements that 
# are less than 3 sentences long

corp <-
  corp %>% 
  corpus_trim( 
    what="sentences", 
    min_ntoken=3 )

# remove punctuation 

tokens <- 
  corp %>%
  tokens( 
    what="word", 
    remove_punct=TRUE )

tokens %>% head()



# remove filler words like 
# the, and, a, to

tokens <-
  tokens %>% 
  tokens_remove( 
    c( stopwords("english"), "nbsp" ), 
    padding=F )


##########
##########  DICTIONARIES
##########


my_dictionary <- 
  dictionary( list( 

    five01_c_3    = c("501 c 3","section 501 c 3") ,
    united_states = c("united states"),
    high_school   = c("high school"),
    non_profit    = c("non-profit", "non profit", "nonprofit"),
    stem          = c("science technology engineering math", 
                      "science technology engineering mathematics" ),
    los_angeles   = c("los angeles"),
    ny_state      = c("new york state"),
    ny            = c("new york")

))

# apply the dictionary to the text 

tokens <- 
  tokens %>%
  tokens_compound( pattern=my_dictionary )

tokens %>% head



##########
##########  N-GRAMS 
##########

library( quanteda.textstats )

# find frequently co-occuring words 
# (typically compound words)

ngram2 <- 
  tokens %>%
  tokens_ngrams( n=2 ) %>% 
  dfm()

ngram2 %>% textstat_frequency( n=10 )  # requires quanteda.textstats library

# 3-GRAMS

ngram3 <-
  tokens %>%
  tokens_ngrams( n=3 ) %>% 
  dfm()

ngram3 %>% textstat_frequency( n=10 )

tokens %>% 
  dfm() %>% 
  topfeatures( )



#####   MEANINGFUL 2-GRAMS: ADD TO DICTIONARY
                      feature frequency rank docfreq group
8                jesus_christ        15    7      15   all
23             youth_football         9   23       6   all
26            school_district         8   26       8   all
28                 low_income         8   26       8   all
29           higher_education         8   26       8   all
30              special_needs         8   26       7   all
31      community_development         8   26       8   all
39                foster_care         7   36       6   all
42              mental_health         7   36       6   all

#####   NOISY 2-GRAMS: IGNORE
                      feature frequency rank docfreq group
1             mission_provide        26    1      26   all
3       organized_exclusively        19    3      19   all   # organized exclusively for charitable purposes: 4-gram
4      exclusively_charitable        19    3      19   all   # organized exclusively for charitable purposes: 4-gram
5                quality_life        18    5      18   all
32            mission_educate         8   26       8   all
40         organization_shall         7   36       7   all
9       corporation_organized        14    9      14   all





##########
##########  STEMMING 
##########


# old version: 
# deprecated stem=T argument

# tokens %>% 
#   dfm( stem=T ) %>% 
#   topfeatures()

tokens %>% 
  dfm() %>% 
  topfeatures()

# new version: stem=T

tokens %>%
  dfm() %>% 
  dfm_wordstem() %>% 
  topfeatures()


