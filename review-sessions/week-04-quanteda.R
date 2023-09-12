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

# find frequently co-occuring words 
# (typically compound words)

ngram2 <- 
  tokens %>%
  tokens_ngrams( n=2 ) %>% 
  dfm()

ngram2 %>% textstat_frequency( n=10 )

# 3-GRAMS

ngram3 <-
  tokens %>%
  tokens_ngrams( n=5 ) %>% 
  dfm()

ngram3 %>% textstat_frequency( n=10 )

tokens %>% 
  dfm() %>% 
  topfeatures( )




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


