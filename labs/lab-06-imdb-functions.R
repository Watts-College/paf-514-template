# library( rvest )
# library( dplyr )
# library( pander )

# goonies <- "https://www.imdb.com/title/tt0089218/?ref_=fn_al_tt_1"
# 
# df <- 
#   get_actors( goonies ) %>% 
#   add_bios()



get_actors <- function( imdb.url ) {

  htm <- read_html( imdb.url )

  names <-  
    htm %>% 
    html_elements( "a.ipc-lockup-overlay" )  %>% 
    html_attr("aria-label")

  links <- 
    htm %>% 
    html_elements( "a.ipc-lockup-overlay" )  %>% 
    html_attr("href")

  is.name <- 
    grepl( "^/name/", links )

  links <- gsub( "\\?ref.*", "", links )
  links <- paste0( "https://www.imdb.com", links, "/bio" )

  df <- 
    data.frame( names, links ) %>% 
    dplyr::filter( is.name )

  img <- 
    htm %>% 
    html_elements( "img" )  %>% 
    html_attr("src")  

  alt <- 
    htm %>% 
    html_elements( "img" )  %>% 
    html_attr("alt") 

  df2 <- data.frame( alt, img )

  df3 <- merge( df, df2, by.x="names", by.y="alt" )

  return( df3 )
}

# film: Poor Things 
poor.things <- "https://www.imdb.com/title/tt14230458/?ref_=hm_fanfav_tt_t_1_pd_fp1_r"
df <- get_actors( poor.things )



get_bio <- function( bio.url ) {

  htm <- try( read_html( bio.url ) )

    if( inherits( htm, "try-error" ) )
    { return(NULL) }

  divs <- 
    htm %>%
    html_elements( "div" )  

  tag.id <- 
    htm %>%
    html_elements( "div" )  %>%
    html_attr("data-testid") 

  bio.full <- 
    divs[ which( tag.id == "sub-section-mini_bio" ) ] %>% 
    html_text2()

    # limit to 5 sentences 

    bio.list <- strsplit( bio, ". " )
    bio <- 

  return( bio )
}

# Mark Ruffalo
bio.url <- "https://www.imdb.com/name/nm0749263/bio/"
get_bio( bio.url )


make_short <- function( bio ) {
  bio.chunks <- strsplit( bio, "\\.{1,1}[ |\n]" ) %>% unlist()
  bio.chunks <- gsub( "\\\n", "", bio.chunks )
  bio.chunks <- gsub( "\\.$", "", bio.chunks )
  n          <- length( bio.chunks )
  max        <- ifelse( n < 6, n - 1, 5 )
  bio.5      <- bio.chunks[1:max]
  bio.short  <- paste0( bio.5, collapse=". " )
  bio.short  <- paste0( bio.short, "." )
  return( bio.short )
}

get_bio( bio.url ) %>% make_short()



add_bios <- function( df ) {
  df$bio       <- purrr::map_chr( df$link, get_bio )  
  df$bio.short <- purrr::map_chr( df$bio, make_short )
  return( df )
}

df2 <- add_bios( df )



##############################
##############################



df.demo <-
structure(list(name = c("Attila Dobai", "Charlie Hiscock", "Christopher Abbott", 
"Emma Hindle", "Emma Stone", "Hanna Schygulla", "Jack Barton", 
"Jerrod Carmichael", "Kathryn Hunter", "Mark Ruffalo", "Ramy Youssef", 
"Suzy Bemba", "Vicki Pepperdine", "Willem Dafoe"), link = c("https://www.imdb.com/name/nm8581180/bio", 
"https://www.imdb.com/name/nm4193460/bio", "https://www.imdb.com/name/nm3571592/bio", 
"https://www.imdb.com/name/nm10446192/bio", "https://www.imdb.com/name/nm1297015/bio", 
"https://www.imdb.com/name/nm0778016/bio", "https://www.imdb.com/name/nm10354428/bio", 
"https://www.imdb.com/name/nm4273797/bio", "https://www.imdb.com/name/nm0402898/bio", 
"https://www.imdb.com/name/nm0749263/bio", "https://www.imdb.com/name/nm3858973/bio", 
"https://www.imdb.com/name/nm11031494/bio", "https://www.imdb.com/name/nm0672621/bio", 
"https://www.imdb.com/name/nm0000353/bio"), img = c("https://m.media-amazon.com/images/M/MV5BZmQ3N2FkMDItN2Y4Ny00ZTJkLTk3NjQtNjFlMzlhMTMxMTVkXkEyXkFqcGdeQXVyMTcwODcxNjQw._V1_QL75_UX140_CR0,0,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BYjhhYjA0NzQtNzQwNC00NDM4LTkwZjQtNjU2ZDA0YTE1MGRkXkEyXkFqcGdeQXVyODI5OTI1NjU@._V1_QL75_UX140_CR0,0,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BMjI1NDYxODU5N15BMl5BanBnXkFtZTgwMDMwNTczNDM@._V1_QL75_UX140_CR0,12,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BNWQ2ZWFkOWQtYjI1NC00ZTAyLWI2NWItZmNlNDYxMmJhMGEwXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_QL75_UX140_CR0,12,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BMjI4NjM1NDkyN15BMl5BanBnXkFtZTgwODgyNTY1MjE@._V1_QL75_UX140_CR0,13,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BMjA0MzgzMzk5OF5BMl5BanBnXkFtZTcwNzI2MTUzOA@@._V1_QL75_UX140_CR0,19,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BNzg3ZjlmYjAtNjllNS00MzBmLTk4YzgtYTMxZmI3YWViNzI3XkEyXkFqcGdeQXVyMTI2Nzk2MjQ1._V1_QL75_UX140_CR0,0,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BNDAyYmI0MjYtOTA3ZC00ODRkLWJjZjktY2E3ZmVlOGNlOTkzXkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_QL75_UY140_CR55,0,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BNjcxMmZhMmEtMGRmYy00NjE4LWJhNWMtOTMyMDU4YTg5YmFiXkEyXkFqcGdeQXVyNjUxMjc1OTM@._V1_QL75_UY140_CR4,0,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BNWIzZTI1ODUtZTUzMC00NTdiLWFlOTYtZTg4MGZkYmU4YzNlXkEyXkFqcGdeQXVyNTExOTk5Nzg@._V1_QL75_UX140_CR0,12,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BMDlkODBiOTUtOGY5YS00ZGJmLWFhMWYtZTBlMTE4NmY1MmM2XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_CR749,24,1883,2824_QL75_UX140_CR0,12,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BZmQ3OWUwOTMtNDQ0OS00YzI2LWI3M2YtOTg1NWY5ZDE1Yjc1XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_QL75_UX140_CR0,10,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BZGQxNjk1OGQtMTMzMy00MTExLWJkMzYtZDkzZWMwNGZjOGZiXkEyXkFqcGdeQXVyMTAwMzUyMzUy._V1_QL75_UX140_CR0,6,140,140_.jpg", 
"https://m.media-amazon.com/images/M/MV5BOWU4MTI2OTctODQ1ZS00MGM1LWJkM2EtODE3MGNkNmIyZDEwXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_QL75_UX140_CR0,0,140,140_.jpg"
), bio = c("Attila Dobai is known for Poor Things (2023), Holnap tali! (2016) and Most vagy soha! (2024).", 
"Charlie J. Hiscock can be seen as \"Will\" on the Emmy award winning Apple+ series \"Ted Lasso,\" which was made history with its 20 Emmy nominations for a comedy series. Hiscock is also known for his work on the BAFTA winning and Emmy nominated series \"Secret Life of Boys.\" He began his career at the young age of 9 and made his professional debut on the British TV series \"Combat Kids.\" He then followed that up with the BBC TV movie adaptation of \"The Borrowers\" opposite Christopher Eccleston, Sharon Horgan and Stephen Fry. Hiscock then took a break to focus on school and then got back into the business in 2018 with \"Secret Life of Boys.\"\n- IMDb Mini Biography By: Mia Hansen", 
"Christopher Jacob Abbott is an American actor. Abbott made his feature film debut in Martha Marcy May Marlene (2011). Abbott's other notable films include Hello I Must Be Going (2012) and The Sleepwalker (2014). In 2015, Abbott starred as the titular character in the critically acclaimed film James White. In 2017, he starred opposite Joel Edgerton in the psychological horror film It Comes at Night. In 2018, he portrayed astronaut David Scott in the film First Man, and a reporter in Vox Lux. Abbott portrayed John Yossarian as the lead role in the 2019 miniseries Catch-22 based on the Joseph Heller novel of the same name, for which he was nominated for the Golden Globe Award for Best Actor - Miniseries or Television Film. In 2020, he co-starred in the films Black Bear, Possessor and The World to Come.\n- IMDb Mini Biography By: Bonitao", 
"Emma Hindle is known for Poor Things (2023), Grantchester (2014) and Outlander (2014).", 
"Emily Jean \"Emma\" Stone was born on November 6, 1988 in Scottsdale, Arizona to Krista Jean Stone (née Yeager), a homemaker & Jeffrey Charles \"Jeff\" Stone, a contracting company founder and CEO. She is of Swedish, German & British Isles descent. Stone began acting as a child as a member of the Valley Youth Theatre in Phoenix, Arizona, where she made her stage debut in a production of Kenneth Grahame's \"The Wind in the Willows\". She appeared in many more productions through her early teens until, at the age of fifteen, she decided that she wanted to make acting her career.\n\nThe official story is that she made a PowerPoint presentation, backed by Madonna's \"Hollywood\" and itself entitled \"Project Hollywood\", in an attempt to persuade her parents to allow her to drop out of school and move to Los Angeles. The pitch was successful and she and her mother moved to LA with her schooling completed at home while she spent her days auditioning.\n\nShe had her TV breakthrough when she won the part of Laurie Partridge in the VH1 talent/reality show In Search of the Partridge Family (2004) which led to a number of small TV roles in the following years. Her movie debut was as Jules in Superbad (2007) and, after a string of successful performances, her leading role as Olive in Easy A (2010) established her as a star.\n- IMDb Mini Biography By: IMDb Editors", 
"Lead icon of the influential New German Cinema of the 70's & 80's, Schygulla's natural blonde beauty and amazing versatility keep her among the world's top actresses. She won best actress at Cannes in 1983 for The Story of Piera (1983) (aka \"The Story of Piera\"), an Italian/German co-production. The Turkish/German co-production, The Edge of Heaven (2007) (aka \"The Edge of Heaven\"), won the 2007 Cannes award for best screenplay. The now silver-haired actress appears to have shunned plastic surgery.\n\nOne of many protégés of Rainer Werner Fassbinder, who gave Schygulla especially tender treatment and nurturing, while he terrorized, manipulated, and slept with many of the other actors and filmmakers Fassbinder developed in his incestuous family-like theatrical and film troupes.\n\nOver 12 years, Hanna Schygulla appeared in 23 Fassbinder movies (including his first feature film), the most-acclaimed being The Marriage of Maria Braun (1979) (aka \"The Marriage of Maria Braun\") (for which she won the Silver Bear), Lili Marleen (1981) and Berlin Alexanderplatz (1980). After a disagreement with Fassbinder, she did not appear in his final 4 movies. Their mentor/muse relationship is often favorably compared with that of Josef von Sternberg and Marlene Dietrich. Schygulla met Fassbinder while she was studying romance languages and taking acting lessons in Munich, then became a member of his collective theatre troupe, \"Munich Action Theatre\", which eventually evolved into his film group.\n\nAfter Fassbinder's 1982 death, she appeared in a few commercial films, and when she does act now, concentrates on complex roles in films with unique, international social messages. Her better known non-Fassbinder movies include Kenneth Branagh's Dead Again (1991), Casanova (1987) (with Faye Dunaway), Andrzej Wajda's A Love in Germany (1983) (aka \"A Love in Germany\") and Margarethe von Trotta's Sheer Madness (1983) (aka \"Sheer Madness\"). She's renowned for portraying strong, sensual women, and her language ability enables her to appear in films produced by many countries. Her singing was featured in Lili Marleen (1981) and Sheer Madness (1983) (aka \"Sheer Madness\"). Since 1997, she has turned away from movie acting, primarily to chanson singing, recording CDs, appearing in the movie, Hanna Schygulla Sings (1999) and, in 2007, a one-woman autobiographical musical (including songs of Janis Joplin, Édith Piaf, Billie Holiday, Brecht). She was the lead and sang in a live Vanessa Beecroft conceptual art piece in a German castle, with Fassbinder's long-time associate, Irm Hermann, plus 23 other women. Schygulla has worked on producing films about Berlin's Holocaust memorial, and about her work with Fassbinder.\n\nMany of Fassbinder's film plots reflect his bizarre working relations with cast and crew, and he often reserved the most glamorous costumes and dramatic roles for Hanna Schygulla, intentionally pressuring his other talented actresses, such as his feisty ex-wife Ingrid Caven, and the abused Irm Hermann. The extremely tense relationships in the all-female The Bitter Tears of Petra von Kant (1972) (aka \"Bitter Tears of Petra Von Kant\") somewhat reflect real-life interactions of Hermann, Schygulla (both are in the movie), Fassbinder, and his mother.\n\nHann Schygulla's childhood family situation somewhat parallels her role, typifying Germany's moral dilemmas at the end of World War II, in The Marriage of Maria Braun (1979) (aka \"The Marriage of Maria Braun\"). Schygulla was born on Christmas Day 1943, in Kattowice, Upper Silesia (then a section of Poland annexed by the Third Reich). Her German father was an infantryman in Italy, who was in a POW camp until she was 5. After the war, the German population was expelled from the Kattowice area.\n- IMDb Mini Biography By: David Stevens", 
"Jack Barton is known for Poor Things (2023), Chronic (2022) and Rogue Heroes (2022).", 
"Jerrod Carmichael was born on April 6, 1987 in Winston-Salem, North Carolina, USA. He is a producer and writer, known for On the Count of Three (2021), 8 (2017) and The Carmichael Show (2015).", 
"Kathryn Hunter was born on April 9, 1957 in New York, USA. She is an actress, known for The Tragedy of Macbeth (2021), Poor Things (2023) and Harry Potter and the Order of the Phoenix (2007). She was previously married to Marcello Magni.", 
"Award-winning actor Mark Ruffalo was born on November 22, 1967, in Kenosha, Wisconsin, of humble means to father Frank Lawrence Ruffalo, a construction painter and Marie Rose (Hebert), a stylist and hairdresser; his father's ancestry is Italian and his mother is of half French-Canadian and half Italian descent. Mark moved with his family to Virginia Beach, Virginia, where he lived out most of his teenage years. Following high school, Mark moved with his family to San Diego and soon migrated north, eventually settling in Los Angeles.\n\nMark first took classes at the Stella Adler Conservatory and subsequently co-founded the Orpheus Theatre Company, an Equity-Waiver establishment, where he worked in nearly every capacity. From acting, writing, directing and producing to running the lights and building sets while building his resume.\n\nMoving into film and TV, Mark's inauspicious movie debut was the drifter role of Christian in the horror opus Mirror Mirror 2: Raven Dance (1994) and returned to the film series in the role of Joey with Mirror Mirror 3: The Voyeur (1995). He continued on through the 1990's rather indistinctly with more secondary roles in the horror film The Dentist (1996) starring madman Corbin Bernsen; an amusing perf in the obscure dramedy The Last Big Thing (1996); a third billed role in the Jerry Stiller/Anne Meara bickering senior comedy A Fish in the Bathtub (1998); and the war drama Ceremony... The Ritual of Love (1976) directed by Ang Lee.\n\nBartending for nearly nearly a decade to make ends meet and discouraged enough to give it up, a chance meeting and resulting collaboration with playwright/screenwriter Kenneth Lonergan approaching the millennium changed everything. Ruffalo won NY success in Lonergan's 1996 off-Broadway play \"This Is Our Youth,\" a story about troubled young adults. This led to his male lead in Lonergan's Oscar-winning film drama You Can Count on Me (2000), playing the ne'er-do-well brother of Laura Linney. The performance drew rave reviews and invited comparisons to an early Marlon Brando.\n\nRuffalo never looked back. Notable roles in The Last Castle (2001), XX/XY (2002), and Windtalkers (2002) followed, although in 2002 Ruffalo was diagnosed with an acoustic neuroma, a type of brain tumor. Though the tumor was benign, the resulting surgery led to a period of partial facial paralysis, from which he fully recovered. In 2003, Ruffalo scored leading roles alongside two popular female stars, playing a police detective opposite Meg Ryan in In the Cut (2003) and the love interest of Gwyneth Paltrow in the comedy View from the Top (2003).\n\nThough both films were high-profile box office disappointments, Ruffalo went on to four notable (if highly disparate) films in 2004 -- We Don't Live Here Anymore (2004), Eternal Sunshine of the Spotless Mind (2004), 13 Going on 30 (2004), and Collateral (2004) -- which solidified his ability to be both a popular leading man and an acclaimed ensemble player in either comedy or drama.\n\nAfter 2004, Ruffalo was consistently at work, with leads in popular Hollywood films and independent productions that continued to solidify him as one of film's most consistently strong actors: Just Like Heaven (2005), All the King's Men (2006), Zodiac (2007), Reservation Road (2007), and The Brothers Bloom (2008). He also made his Broadway debut as Moe Axelrod in the play \"Awake and Sing!\"\n\nIn 2010 Ruffalo achieved something of a breakthrough, by directing the indie film Sympathy for Delicious (2010), which won him the Special Jury Prize at the Sundance Film Festival, and co-starring as the sperm-donor father to lesbian couple Annette Bening and Julianne Moore in The Kids Are All Right (2010). His role in the idiosyncratic domestic comedy/drama earned him Academy Award, Independent Spirit Award, Screen Actors Guild, and BAFTA nominations for Best Supporting Actor. He went on to earn two more Best Supporting Actor nominations as an Olympic-winning wrestling champion in Foxcatcher (2014) and as a journalist working to uncover the Catholic Church sex abuse scandal in Spotlight (2015). In 2017, the actor returned to Broadway in Arthur Miller's \"The Price.\"\n\nHigh-profile roles in Martin Scorsese's Shutter Island (2010) and Longeran's long-delayed film Margaret (2011) followed before Ruffalo's appearance as Dr. Bruce Banner, aka The Hulk, in Joss Whedon's movie blockbuster The Avengers (2012). Garnering highly positive reviews for a role in which actors Eric Bana and Edward Norton could not find success in previous films made Ruffalo a box office action star in addition to a critically-acclaimed actor. He returned to the Banner/Hulk role frequently in such Marvel movies as Iron Man 3 (2013), Avengers: Age of Ultron (2015), Thor: Ragnarok (2017), Avengers: Infinity War (2018), Captain Marvel (2019) and Avengers: Endgame (2019),\n\nReunited with former co-star Gwyneth Paltrow in the sex-addiction comedy-drama Thanks for Sharing (2012), he went on to earn a Golden Globe nomination for playing a bipolar Dad in Infinitely Polar Bear (2014). Ruffalo also took on the lead in Ryan Murphy's adaptation of Larry Kramer's AIDS-drama play The Normal Heart (2014) and earned a SAG Award and Emmy Nomination. He later took home the Emmy playing twin brothers, one a paranoid schizophrenic, in I Know This Much Is True (2020).\n\nRuffalo has been married to actress Sunrise Coigney since 2000; the couple has three children, a son and two daughters.\n- IMDb Mini Biography By: Gary Brumburgh / gr-home@pacbell.net", 
"Ramy Youssef was born on March 26, 1991 in Queens, New York City, New York, USA. He is an actor and writer, known for Ramy (2019), Mr. Robot (2015) and Ramy Youssef: Feelings (2019).", 
"Suzy Bemba is known for Poor Things (2023), Kandisha (2020) and Homecoming (2023).", 
"Vicki Pepperdine was born on July 24, 1961 in Roehampton, London, England, UK. She is an actress and writer, known for Getting On (2009), Poor Things (2023) and Getting On (2013).", 
"Having made over one hundred films in his legendary career, Willem Dafoe is internationally respected for bringing versatility, boldness, and daring to some of the most iconic films of our time. His artistic curiosity in exploring the human condition leads him to projects all over the world, large and small, Hollywood films as well as Independent cinema.\n\nIn 1979, he was given a role in Michael's Cimino's Heaven's Gate, from which he was fired. Since then, he has collaborated with directors who represent a virtual encyclopedia of modern cinema: James Wan, Robert Eggers, Sean Baker, Kenneth Branagh, Kathryn Bigelow, Sam Raimi, Alan Parker, Walter Hill, Mary Harron, Wim Wenders, Anton Corbijn, Zhang Yimou, Wes Anderson, Martin Scorsese, David Lynch, Oliver Stone, William Friedkin, Werner Herzog, Lars Von Trier, Abel Ferrara, Spike Lee, David Cronenberg, Paul Schrader, Anthony Minghella, Theo Angelopoulos, Robert Rodriguez, Phillip Noyce, Hector Babenco, John Milius, Paul Weitz, The Spierig Brothers, Andrew Stanton, Josh Boone, Dee Rees and Julian Schnabel.\n\nDafoe has been recognized with four Academy Award nominations: Best Actor in a Supporting Role for Platoon, Best Actor in a Supporting Role for Shadow Of The Vampire, for which he also received Golden Globe and Screen Actors Guild nominations, Best Actor in a Supporting Role for The Florida Project, for which he also received Golden Globe and Screen Actors Guild nominations, and most recently, Best Leading Actor for At Eternity's Gate, for which he also received a Golden Globe nomination. Among his other nominations and awards, he has received two Los Angeles Film Critics Awards, a New York Film Critics Circle Award, a National Board of Review Award, two Independent Spirit Awards, Venice Film Festival Volpi Cup, as well as a Berlinale Honorary Golden Bear for Lifetime Achievement.\n\nWillem was born in Appleton, Wisconsin, to Muriel Isabel (Sprissler), a nurse, and William Alfred Dafoe, a surgeon. He is of mostly German, Irish, Scottish, and English descent. He and his wife, director Giada Colagrande, have made three films together: Padre, A Woman, and Before It Had A Name.\n\nHis natural adventurousness is evident in roles as diverse as Marcus, the elite assassin who is mentor to Keanu Reeves in the neo-noir John Wick; in his voice work as Gil the Moorish Idol in Finding Nemo and Ryuk the Death God in Death Note; as Paul Smecker, the obsessed FBI agent in the cult classic The Boondock Saints; and as real life hero Leonhard Seppala, who led the 1925 Alaskan dog sled diphtheria serum run in Ericson Core's Togo. That adventurous spirit continues with upcoming films including Wes Anderson's The French Dispatch, Abel Ferrara's Siberia, and Paul Schrader's The Card Counter.\n\nDafoe is one of the founding members of The Wooster Group, the New York based experimental theatre collective. He created and performed in all of the group's work from 1977 thru 2005, both in the U.S. and internationally. Since then, he worked with Richard Foreman in Idiot Savant at The Public Theatre (NYC), with Robert Wilson on two international productions: The Life & Death of Marina Abramovic and The Old Woman opposite Mikhail Baryshnikov and developed a new theatre piece, directed by Romeo Castellucci, based on Nathaniel Hawthorne's The Minister's Black Veil. He recently completed work on Marina Abramovic's opera 7 Deaths of Maria Callas.\n- IMDb Mini Biography By: Anonymous"
), bio.short = c("Attila Dobai is known for Poor Things (2023), Holnap tali! (2016) and Most vagy soha! (2024)..", 
"Charlie J. Hiscock can be seen as \"Will\" on the Emmy award winning Apple+ series \"Ted Lasso,\" which was made history with its 20 Emmy nominations for a comedy series. Hiscock is also known for his work on the BAFTA winning and Emmy nominated series \"Secret Life of Boys.\" He began his career at the young age of 9 and made his professional debut on the British TV series \"Combat Kids.\" He then followed that up with the BBC TV movie adaptation of \"The Borrowers\" opposite Christopher Eccleston, Sharon Horgan and Stephen Fry.", 
"Christopher Jacob Abbott is an American actor. Abbott made his feature film debut in Martha Marcy May Marlene (2011). Abbott's other notable films include Hello I Must Be Going (2012) and The Sleepwalker (2014). In 2015, Abbott starred as the titular character in the critically acclaimed film James White. In 2017, he starred opposite Joel Edgerton in the psychological horror film It Comes at Night.", 
"Emma Hindle is known for Poor Things (2023), Grantchester (2014) and Outlander (2014)..", 
"Emily Jean \"Emma\" Stone was born on November 6, 1988 in Scottsdale, Arizona to Krista Jean Stone (née Yeager), a homemaker & Jeffrey Charles \"Jeff\" Stone, a contracting company founder and CEO. She is of Swedish, German & British Isles descent. Stone began acting as a child as a member of the Valley Youth Theatre in Phoenix, Arizona, where she made her stage debut in a production of Kenneth Grahame's \"The Wind in the Willows\". She appeared in many more productions through her early teens until, at the age of fifteen, she decided that she wanted to make acting her career. The official story is that she made a PowerPoint presentation, backed by Madonna's \"Hollywood\" and itself entitled \"Project Hollywood\", in an attempt to persuade her parents to allow her to drop out of school and move to Los Angeles.", 
"Lead icon of the influential New German Cinema of the 70's & 80's, Schygulla's natural blonde beauty and amazing versatility keep her among the world's top actresses. She won best actress at Cannes in 1983 for The Story of Piera (1983) (aka \"The Story of Piera\"), an Italian/German co-production. The Turkish/German co-production, The Edge of Heaven (2007) (aka \"The Edge of Heaven\"), won the 2007 Cannes award for best screenplay. The now silver-haired actress appears to have shunned plastic surgery. One of many protégés of Rainer Werner Fassbinder, who gave Schygulla especially tender treatment and nurturing, while he terrorized, manipulated, and slept with many of the other actors and filmmakers Fassbinder developed in his incestuous family-like theatrical and film troupes.", 
"Jack Barton is known for Poor Things (2023), Chronic (2022) and Rogue Heroes (2022)..", 
"Jerrod Carmichael was born on April 6, 1987 in Winston-Salem, North Carolina, USA.", 
"Kathryn Hunter was born on April 9, 1957 in New York, USA. She is an actress, known for The Tragedy of Macbeth (2021), Poor Things (2023) and Harry Potter and the Order of the Phoenix (2007).", 
"Award-winning actor Mark Ruffalo was born on November 22, 1967, in Kenosha, Wisconsin, of humble means to father Frank Lawrence Ruffalo, a construction painter and Marie Rose (Hebert), a stylist and hairdresser; his father's ancestry is Italian and his mother is of half French-Canadian and half Italian descent. Mark moved with his family to Virginia Beach, Virginia, where he lived out most of his teenage years. Following high school, Mark moved with his family to San Diego and soon migrated north, eventually settling in Los Angeles. Mark first took classes at the Stella Adler Conservatory and subsequently co-founded the Orpheus Theatre Company, an Equity-Waiver establishment, where he worked in nearly every capacity. From acting, writing, directing and producing to running the lights and building sets while building his resume.", 
"Ramy Youssef was born on March 26, 1991 in Queens, New York City, New York, USA. He is an actor and writer, known for Ramy (2019), Mr.", 
"Suzy Bemba is known for Poor Things (2023), Kandisha (2020) and Homecoming (2023)..", 
"Vicki Pepperdine was born on July 24, 1961 in Roehampton, London, England, UK.", 
"Having made over one hundred films in his legendary career, Willem Dafoe is internationally respected for bringing versatility, boldness, and daring to some of the most iconic films of our time. His artistic curiosity in exploring the human condition leads him to projects all over the world, large and small, Hollywood films as well as Independent cinema. In 1979, he was given a role in Michael's Cimino's Heaven's Gate, from which he was fired. Since then, he has collaborated with directors who represent a virtual encyclopedia of modern cinema: James Wan, Robert Eggers, Sean Baker, Kenneth Branagh, Kathryn Bigelow, Sam Raimi, Alan Parker, Walter Hill, Mary Harron, Wim Wenders, Anton Corbijn, Zhang Yimou, Wes Anderson, Martin Scorsese, David Lynch, Oliver Stone, William Friedkin, Werner Herzog, Lars Von Trier, Abel Ferrara, Spike Lee, David Cronenberg, Paul Schrader, Anthony Minghella, Theo Angelopoulos, Robert Rodriguez, Phillip Noyce, Hector Babenco, John Milius, Paul Weitz, The Spierig Brothers, Andrew Stanton, Josh Boone, Dee Rees and Julian Schnabel. Dafoe has been recognized with four Academy Award nominations: Best Actor in a Supporting Role for Platoon, Best Actor in a Supporting Role for Shadow Of The Vampire, for which he also received Golden Globe and Screen Actors Guild nominations, Best Actor in a Supporting Role for The Florida Project, for which he also received Golden Globe and Screen Actors Guild nominations, and most recently, Best Leading Actor for At Eternity's Gate, for which he also received a Golden Globe nomination."
)), row.names = c(NA, -14L), class = "data.frame")


df2[ c("name", "bio.short", "link" ) ] %>% pander::pander( split.tables=Inf )



# df2[ c("name", "bio.short", "link" ) ] %>% pander::pander( split.tables=Inf )
# 
# ------------------------------------------------------------------------------------------------
#         name                    bio.short                                link                   
# -------------------- -------------------------------- ------------------------------------------
#     Attila Dobai      Attila Dobai is known for Poor   https://www.imdb.com/name/nm8581180/bio  
#                        Things (2023), Holnap tali!                                              
#                         (2016) and Most vagy soha!                                              
#                                  (2024)..                                                       
# 
#   Charlie Hiscock     Charlie J. Hiscock can be seen   https://www.imdb.com/name/nm4193460/bio  
#                        as "Will" on the Emmy award                                              
#                         winning Apple+ series "Ted                                              
#                       Lasso," which was made history                                            
#                        with its 20 Emmy nominations                                             
#                        for a comedy series. Hiscock                                             
#                       is also known for his work on                                             
#                         the BAFTA winning and Emmy                                              
#                       nominated series "Secret Life                                             
#                       of Boys." He began his career                                             
#                       at the young age of 9 and made                                            
#                       his professional debut on the                                             
#                         British TV series "Combat                                               
#                        Kids." He then followed that                                             
#                          up with the BBC TV movie                                               
#                       adaptation of "The Borrowers"                                             
#                            opposite Christopher                                                 
#                        Eccleston, Sharon Horgan and                                             
#                                Stephen Fry.                                                     
# 
#  Christopher Abbott   Christopher Jacob Abbott is an   https://www.imdb.com/name/nm3571592/bio  
#                        American actor. Abbott made                                              
#                         his feature film debut in                                               
#                          Martha Marcy May Marlene                                               
#                       (2011). Abbott's other notable                                            
#                       films include Hello I Must Be                                             
#                            Going (2012) and The                                                 
#                        Sleepwalker (2014). In 2015,                                             
#                       Abbott starred as the titular                                             
#                        character in the critically                                              
#                       acclaimed film James White. In                                            
#                       2017, he starred opposite Joel                                            
#                       Edgerton in the psychological                                             
#                       horror film It Comes at Night.                                            
# 
#     Emma Hindle       Emma Hindle is known for Poor    https://www.imdb.com/name/nm10446192/bio 
#                        Things (2023), Grantchester                                              
#                       (2014) and Outlander (2014)..                                             
# 
#      Emma Stone        Emily Jean "Emma" Stone was     https://www.imdb.com/name/nm1297015/bio  
#                        born on November 6, 1988 in                                              
#                       Scottsdale, Arizona to Krista                                             
#                         Jean Stone (née Yeager), a                                              
#                        homemaker & Jeffrey Charles                                              
#                        "Jeff" Stone, a contracting                                              
#                        company founder and CEO. She                                             
#                          is of Swedish, German &                                                
#                        British Isles descent. Stone                                             
#                        began acting as a child as a                                             
#                         member of the Valley Youth                                              
#                        Theatre in Phoenix, Arizona,                                             
#                       where she made her stage debut                                            
#                         in a production of Kenneth                                              
#                         Grahame's "The Wind in the                                              
#                       Willows". She appeared in many                                            
#                        more productions through her                                             
#                       early teens until, at the age                                             
#                        of fifteen, she decided that                                             
#                       she wanted to make acting her                                             
#                       career. The official story is                                             
#                         that she made a PowerPoint                                              
#                          presentation, backed by                                                
#                         Madonna's "Hollywood" and                                               
#                          itself entitled "Project                                               
#                        Hollywood", in an attempt to                                             
#                       persuade her parents to allow                                             
#                       her to drop out of school and                                             
#                            move to Los Angeles.                                                 
# 
#   Hanna Schygulla      Lead icon of the influential    https://www.imdb.com/name/nm0778016/bio  
#                       New German Cinema of the 70's                                             
#                        & 80's, Schygulla's natural                                              
#                         blonde beauty and amazing                                               
#                       versatility keep her among the                                            
#                       world's top actresses. She won                                            
#                       best actress at Cannes in 1983                                            
#                       for The Story of Piera (1983)                                             
#                       (aka "The Story of Piera"), an                                            
#                       Italian/German co-production.                                             
#                             The Turkish/German                                                  
#                         co-production, The Edge of                                              
#                        Heaven (2007) (aka "The Edge                                             
#                         of Heaven"), won the 2007                                               
#                           Cannes award for best                                                 
#                            screenplay. The now                                                  
#                       silver-haired actress appears                                             
#                          to have shunned plastic                                                
#                       surgery. One of many protégés                                             
#                        of Rainer Werner Fassbinder,                                             
#                       who gave Schygulla especially                                             
#                            tender treatment and                                                 
#                            nurturing, while he                                                  
#                        terrorized, manipulated, and                                             
#                        slept with many of the other                                             
#                           actors and filmmakers                                                 
#                        Fassbinder developed in his                                              
#                           incestuous family-like                                                
#                        theatrical and film troupes.                                             
# 
#     Jack Barton       Jack Barton is known for Poor    https://www.imdb.com/name/nm10354428/bio 
#                       Things (2023), Chronic (2022)                                             
#                         and Rogue Heroes (2022)..                                               
# 
#  Jerrod Carmichael    Jerrod Carmichael was born on    https://www.imdb.com/name/nm4273797/bio  
#                              April 6, 1987 in                                                   
#                       Winston-Salem, North Carolina,                                            
#                                    USA.                                                         
# 
#    Kathryn Hunter       Kathryn Hunter was born on     https://www.imdb.com/name/nm0402898/bio  
#                         April 9, 1957 in New York,                                              
#                       USA. She is an actress, known                                             
#                         for The Tragedy of Macbeth                                              
#                       (2021), Poor Things (2023) and                                            
#                       Harry Potter and the Order of                                             
#                            the Phoenix (2007).                                                  
# 
#     Mark Ruffalo         Award-winning actor Mark      https://www.imdb.com/name/nm0749263/bio  
#                        Ruffalo was born on November                                             
#                           22, 1967, in Kenosha,                                                 
#                       Wisconsin, of humble means to                                             
#                       father Frank Lawrence Ruffalo,                                            
#                         a construction painter and                                              
#                       Marie Rose (Hebert), a stylist                                            
#                       and hairdresser; his father's                                             
#                        ancestry is Italian and his                                              
#                             mother is of half                                                   
#                          French-Canadian and half                                               
#                        Italian descent. Mark moved                                              
#                        with his family to Virginia                                              
#                         Beach, Virginia, where he                                               
#                       lived out most of his teenage                                             
#                       years. Following high school,                                             
#                       Mark moved with his family to                                             
#                        San Diego and soon migrated                                              
#                       north, eventually settling in                                             
#                        Los Angeles. Mark first took                                             
#                        classes at the Stella Adler                                              
#                       Conservatory and subsequently                                             
#                       co-founded the Orpheus Theatre                                            
#                         Company, an Equity-Waiver                                               
#                       establishment, where he worked                                            
#                       in nearly every capacity. From                                            
#                       acting, writing, directing and                                            
#                          producing to running the                                               
#                       lights and building sets while                                            
#                            building his resume.                                                 
# 
#     Ramy Youssef      Ramy Youssef was born on March   https://www.imdb.com/name/nm3858973/bio  
#                        26, 1991 in Queens, New York                                             
#                       City, New York, USA. He is an                                             
#                        actor and writer, known for                                              
#                              Ramy (2019), Mr.                                                   
# 
#      Suzy Bemba        Suzy Bemba is known for Poor    https://www.imdb.com/name/nm11031494/bio 
#                       Things (2023), Kandisha (2020)                                            
#                          and Homecoming (2023)..                                                
# 
#   Vicki Pepperdine     Vicki Pepperdine was born on    https://www.imdb.com/name/nm0672621/bio  
#                        July 24, 1961 in Roehampton,                                             
#                            London, England, UK.                                                 
# 
#     Willem Dafoe       Having made over one hundred    https://www.imdb.com/name/nm0000353/bio  
#                       films in his legendary career,                                            
#                              Willem Dafoe is                                                    
#                       internationally respected for                                             
#                           bringing versatility,                                                 
#                        boldness, and daring to some                                             
#                        of the most iconic films of                                              
#                           our time. His artistic                                                
#                         curiosity in exploring the                                              
#                        human condition leads him to                                             
#                        projects all over the world,                                             
#                         large and small, Hollywood                                              
#                        films as well as Independent                                             
#                       cinema. In 1979, he was given                                             
#                        a role in Michael's Cimino's                                             
#                        Heaven's Gate, from which he                                             
#                       was fired. Since then, he has                                             
#                        collaborated with directors                                              
#                          who represent a virtual                                                
#                       encyclopedia of modern cinema:                                            
#                       James Wan, Robert Eggers, Sean                                            
#                          Baker, Kenneth Branagh,                                                
#                        Kathryn Bigelow, Sam Raimi,                                              
#                       Alan Parker, Walter Hill, Mary                                            
#                         Harron, Wim Wenders, Anton                                              
#                         Corbijn, Zhang Yimou, Wes                                               
#                         Anderson, Martin Scorsese,                                              
#                         David Lynch, Oliver Stone,                                              
#                          William Friedkin, Werner                                               
#                        Herzog, Lars Von Trier, Abel                                             
#                         Ferrara, Spike Lee, David                                               
#                         Cronenberg, Paul Schrader,                                              
#                          Anthony Minghella, Theo                                                
#                            Angelopoulos, Robert                                                 
#                         Rodriguez, Phillip Noyce,                                               
#                        Hector Babenco, John Milius,                                             
#                          Paul Weitz, The Spierig                                                
#                       Brothers, Andrew Stanton, Josh                                            
#                         Boone, Dee Rees and Julian                                              
#                          Schnabel. Dafoe has been                                               
#                        recognized with four Academy                                             
#                       Award nominations: Best Actor                                             
#                          in a Supporting Role for                                               
#                          Platoon, Best Actor in a                                               
#                       Supporting Role for Shadow Of                                             
#                       The Vampire, for which he also                                            
#                         received Golden Globe and                                               
#                            Screen Actors Guild                                                  
#                        nominations, Best Actor in a                                             
#                          Supporting Role for The                                                
#                       Florida Project, for which he                                             
#                       also received Golden Globe and                                            
#                            Screen Actors Guild                                                  
#                           nominations, and most                                                 
#                        recently, Best Leading Actor                                             
#                        for At Eternity's Gate, for                                              
#                          which he also received a                                               
#                          Golden Globe nomination.                                               
# ------------------------------------------------------------------------------------------------
# 
# 
# 
# df2[ c("name", "bio.short", "link" ) ] %>% knitr::kable()
# 
# 
# |name               |bio.short                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |link                                     |
# |:------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------|
# |Attila Dobai       |Attila Dobai is known for Poor Things (2023), Holnap tali! (2016) and Most vagy soha! (2024)..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |https://www.imdb.com/name/nm8581180/bio  |
# |Charlie Hiscock    |Charlie J. Hiscock can be seen as "Will" on the Emmy award winning Apple+ series "Ted Lasso," which was made history with its 20 Emmy nominations for a comedy series. Hiscock is also known for his work on the BAFTA winning and Emmy nominated series "Secret Life of Boys." He began his career at the young age of 9 and made his professional debut on the British TV series "Combat Kids." He then followed that up with the BBC TV movie adaptation of "The Borrowers" opposite Christopher Eccleston, Sharon Horgan and Stephen Fry.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |https://www.imdb.com/name/nm4193460/bio  |
# |Christopher Abbott |Christopher Jacob Abbott is an American actor. Abbott made his feature film debut in Martha Marcy May Marlene (2011). Abbott's other notable films include Hello I Must Be Going (2012) and The Sleepwalker (2014). In 2015, Abbott starred as the titular character in the critically acclaimed film James White. In 2017, he starred opposite Joel Edgerton in the psychological horror film It Comes at Night.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |https://www.imdb.com/name/nm3571592/bio  |
# |Emma Hindle        |Emma Hindle is known for Poor Things (2023), Grantchester (2014) and Outlander (2014)..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |https://www.imdb.com/name/nm10446192/bio |
# |Emma Stone         |Emily Jean "Emma" Stone was born on November 6, 1988 in Scottsdale, Arizona to Krista Jean Stone (née Yeager), a homemaker & Jeffrey Charles "Jeff" Stone, a contracting company founder and CEO. She is of Swedish, German & British Isles descent. Stone began acting as a child as a member of the Valley Youth Theatre in Phoenix, Arizona, where she made her stage debut in a production of Kenneth Grahame's "The Wind in the Willows". She appeared in many more productions through her early teens until, at the age of fifteen, she decided that she wanted to make acting her career. The official story is that she made a PowerPoint presentation, backed by Madonna's "Hollywood" and itself entitled "Project Hollywood", in an attempt to persuade her parents to allow her to drop out of school and move to Los Angeles.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |https://www.imdb.com/name/nm1297015/bio  |
# |Hanna Schygulla    |Lead icon of the influential New German Cinema of the 70's & 80's, Schygulla's natural blonde beauty and amazing versatility keep her among the world's top actresses. She won best actress at Cannes in 1983 for The Story of Piera (1983) (aka "The Story of Piera"), an Italian/German co-production. The Turkish/German co-production, The Edge of Heaven (2007) (aka "The Edge of Heaven"), won the 2007 Cannes award for best screenplay. The now silver-haired actress appears to have shunned plastic surgery. One of many protégés of Rainer Werner Fassbinder, who gave Schygulla especially tender treatment and nurturing, while he terrorized, manipulated, and slept with many of the other actors and filmmakers Fassbinder developed in his incestuous family-like theatrical and film troupes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |https://www.imdb.com/name/nm0778016/bio  |
# |Jack Barton        |Jack Barton is known for Poor Things (2023), Chronic (2022) and Rogue Heroes (2022)..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |https://www.imdb.com/name/nm10354428/bio |
# |Jerrod Carmichael  |Jerrod Carmichael was born on April 6, 1987 in Winston-Salem, North Carolina, USA.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |https://www.imdb.com/name/nm4273797/bio  |
# |Kathryn Hunter     |Kathryn Hunter was born on April 9, 1957 in New York, USA. She is an actress, known for The Tragedy of Macbeth (2021), Poor Things (2023) and Harry Potter and the Order of the Phoenix (2007).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |https://www.imdb.com/name/nm0402898/bio  |
# |Mark Ruffalo       |Award-winning actor Mark Ruffalo was born on November 22, 1967, in Kenosha, Wisconsin, of humble means to father Frank Lawrence Ruffalo, a construction painter and Marie Rose (Hebert), a stylist and hairdresser; his father's ancestry is Italian and his mother is of half French-Canadian and half Italian descent. Mark moved with his family to Virginia Beach, Virginia, where he lived out most of his teenage years. Following high school, Mark moved with his family to San Diego and soon migrated north, eventually settling in Los Angeles. Mark first took classes at the Stella Adler Conservatory and subsequently co-founded the Orpheus Theatre Company, an Equity-Waiver establishment, where he worked in nearly every capacity. From acting, writing, directing and producing to running the lights and building sets while building his resume.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |https://www.imdb.com/name/nm0749263/bio  |
# |Ramy Youssef       |Ramy Youssef was born on March 26, 1991 in Queens, New York City, New York, USA. He is an actor and writer, known for Ramy (2019), Mr.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |https://www.imdb.com/name/nm3858973/bio  |
# |Suzy Bemba         |Suzy Bemba is known for Poor Things (2023), Kandisha (2020) and Homecoming (2023)..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |https://www.imdb.com/name/nm11031494/bio |
# |Vicki Pepperdine   |Vicki Pepperdine was born on July 24, 1961 in Roehampton, London, England, UK.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |https://www.imdb.com/name/nm0672621/bio  |
# |Willem Dafoe       |Having made over one hundred films in his legendary career, Willem Dafoe is internationally respected for bringing versatility, boldness, and daring to some of the most iconic films of our time. His artistic curiosity in exploring the human condition leads him to projects all over the world, large and small, Hollywood films as well as Independent cinema. In 1979, he was given a role in Michael's Cimino's Heaven's Gate, from which he was fired. Since then, he has collaborated with directors who represent a virtual encyclopedia of modern cinema: James Wan, Robert Eggers, Sean Baker, Kenneth Branagh, Kathryn Bigelow, Sam Raimi, Alan Parker, Walter Hill, Mary Harron, Wim Wenders, Anton Corbijn, Zhang Yimou, Wes Anderson, Martin Scorsese, David Lynch, Oliver Stone, William Friedkin, Werner Herzog, Lars Von Trier, Abel Ferrara, Spike Lee, David Cronenberg, Paul Schrader, Anthony Minghella, Theo Angelopoulos, Robert Rodriguez, Phillip Noyce, Hector Babenco, John Milius, Paul Weitz, The Spierig Brothers, Andrew Stanton, Josh Boone, Dee Rees and Julian Schnabel. Dafoe has been recognized with four Academy Award nominations: Best Actor in a Supporting Role for Platoon, Best Actor in a Supporting Role for Shadow Of The Vampire, for which he also received Golden Globe and Screen Actors Guild nominations, Best Actor in a Supporting Role for The Florida Project, for which he also received Golden Globe and Screen Actors Guild nominations, and most recently, Best Leading Actor for At Eternity's Gate, for which he also received a Golden Globe nomination. |https://www.imdb.com/name/nm0000353/bio  |
# 






