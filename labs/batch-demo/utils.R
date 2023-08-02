get_first_name <- function( name )
{
  x <- strsplit( name, "," )
  fn <- sapply( x, function(x){return(x[2])} )
  fn <- trimws( fn )
  fn2 <- strsplit( fn, " " )
  fn2 <- sapply( fn2, function(x){return(x[1])} ) 
  fn2 <- trimws( fn2 )
  return( fn2 )
}

add_gender <- function( d )
{
  unique.first.names <- unique( d$first.name )
  gen <- gender( unique.first.names )
  gen <- dplyr::select( gen, name, gender )
  d <- merge( d, gen, by.x="first.name", by.y="name", all.x=TRUE )
  d$gender[ is.na(d$gender) ] <- "uncoded"
  d$gender <- factor( d$gender, levels=c("male","female","uncoded") )
  return(d)
}

add_titles <- function( d )
{
  title <- rep( "", nrow(d) )
  title[ grepl( "^Asst Professor$", d$Job.Description ) ]  <- "Assistant Professor"
  title[ grepl( "^Assoc Professor$", d$Job.Description ) ] <- "Associate Professor"
  
  title[ grepl( "^Professor$", d$Job.Description ) ]            <- "Full Professor"
  title[ grepl( "Regents Professor", d$Job.Description ) ]      <- "Full Professor"
  title[ grepl( "President's Professor", d$Job.Description ) ]  <- "Full Professor"
  
  title[ grepl( "^Postdoctoral Research Scholar$", d$Job.Description ) ]   <- "Researcher"
  title[ grepl( "Research Specialist", d$Job.Description ) ]               <- "Researcher"
  title[ grepl( "Research Analyst", d$Job.Description ) ]                  <- "Researcher"
  title[ grepl( "Postdoctoral Scholar", d$Job.Description ) ]              <- "Researcher"
  title[ grepl( "Research Scientist", d$Job.Description ) ]                <- "Researcher"
  title[ grepl( "Research Professional", d$Job.Description ) ]             <- "Researcher"
  title[ grepl( "Research Professor", d$Job.Description ) ]                <- "Researcher"
  
  title[ grepl( "^Instructor$", d$Job.Description ) ]           <- "Teaching Faculty"
  title[ grepl( "Clinical .+ Professor", d$Job.Description ) ]  <- "Teaching Faculty"
  title[ grepl( "Lecturer$", d$Job.Description ) ]              <- "Teaching Faculty"
  title[ grepl( "^Lecturer Sr$", d$Job.Description ) ]          <- "Teaching Faculty"
  title[ grepl( "^Principal Lecturer$", d$Job.Description ) ]   <- "Teaching Faculty"
  title[ grepl( "Professor of Practice", d$Job.Description ) ]  <- "Teaching Faculty"
  
  d$title <- factor( title, 
                     levels=c("Full Professor","Associate Professor",
                              "Assistant Professor","Teaching Faculty",
                              "Researcher" ) )
  return(d)
}



unstring_salary <- function(x)
{
  x <- gsub( "[$,]", "", x )
  x <- as.numeric( x )
  return(x)
}

make_salary_fte <- function(d)
{
  
  if( max(d$FTE) == 100 )
  {  salary <- d$salary / (d$FTE/100) }
  
  if( max(d$FTE) == 1 )
  { salary <- d$salary / d$FTE }
  
  d$salary <- salary
  
  return(d)
}


fix_salary <- function( d )
{
  d$salary <- unstring_salary( d$Salary )
  d <- make_salary_fte(d)
  return(d)
}


dollarize <- function(x)
{ paste0("$", format( round( x, 0 ), big.mark="," ) ) }



academic.units <- 
  c("CISA-Intrdisp Hum & Comm", "CISA-Science & Mathmatics", 
    "College of Health Solutions MS", "College of Health Solutions NT", 
    "College of Health Solutions SH", "College Of Law", "English", "Hugh Downs School Of Comm", 
    "Humanities Arts & Cultural", "Journalism & Mass Comm", "Ldrshp and Integrative Studies", 
    "Math & Natural Sciences Div", "MDT Music", "Physics Department", 
    "Psychology", "Sch Biological & Hlth Sys Engr", "Sch Compt Infor & Dec Sys Engr", 
    "Sch Elect Comptr & Energy Engr", "Sch Engr Matter Trnsprt Energy", 
    "Sch Future of Innov in Society", "Sch Sustain Engr & Built Envrn", 
    "School Of Art", "School of Criminology & Crim J", "School Of Earth & Space Explor", 
    "School of Geog Sci & Urban Pln", "School of Math & Stat Sciences", 
    "School of Molecular Sciences", "School of Politics & Global St", 
    "School Of Public Affairs", "School of Social Transform", "School Of Social Work", 
    "SHPRS History Faculty", "Social & Behavioral Sciences", "Sols Administration & Faculty", 
    "SOS Faculty & Researchers", "The Design School", "The Sanford School", 
    "WPC Accountancy", "WPC Economics", "WPC Information Systems", 
    "WPC Management", "WPC Supply Chain Management")





add_position <- function( t, position, y, xmax, scale.f=8 )
{
  
  t.original <- t
  t <- filter( t.original, title==position )
  dot.size <- 2 + scale.f*sum(t$p)
  offset.n <- 1 + sum(t$p)*2
  
  male.median <- NA
  n.male <- NA
  t <- filter( t.original, title==position & gender == "male" )
  if( nrow(t) > 0 )
  { 
    male.median <- t$q50 
    n.male <- t$n
  }
  
  
  female.median <- NA
  n.female <- NA
  t <- filter( t.original, title==position & gender == "female" )
  if( nrow(t) > 0 )
  { 
    female.median <- t$q50 
    n.female <- t$n
  }
  
  
  # dumbell plots 
  segments( x0=female.median, x1=male.median, y0=y,
            col=gray(0.3,0.5), lwd=7 )
  points( male.median, y,
          col=adjustcolor( "darkblue", alpha.f = 0.5), 
          pch=19, cex=dot.size  )
  points( female.median, y,
          col=adjustcolor( "firebrick", alpha.f = 0.5), 
          pch=19, cex=dot.size  )
  
  pos.f <- 2
  pos.m <- 4
  if( ! ( is.na(female.median) | is.na(male.median) ) )
  {
    pos.f <- ifelse( female.median > male.median, 4, 2 )
    pos.m <- ifelse( female.median > male.median, 2, 4 )
  }
  
  # add salaries to right and left 
  text( female.median, y, paste0("$",round(female.median/1000,0),"k"),
        col=adjustcolor( "firebrick", alpha.f = 0.7), 
        cex=1.2, pos=pos.f, offset=offset.n )
  text( male.median, y, paste0("$",round(male.median/1000,0),"k"),
        col=adjustcolor( "darkblue", alpha.f = 0.7), 
        cex=1.2, pos=pos.m, offset=offset.n ) 
  
  # add faculty counts
  n.female <- ifelse( is.na(n.female), 0, n.female )
  n.female <- ifelse( nchar(n.female)==1, 
                      paste0( " ", n.female), n.female )
  n.male <- ifelse( is.na(n.male), 0, n.male )
  n.male <- ifelse( nchar(n.male)==1, 
                    paste0( " ", n.male), n.male )
  text( xmax-0.1*xmax, y+0.14, paste0( "f   = ", n.female),
        col="gray50", cex=1.1, pos=4  )
  text( xmax-0.1*xmax, y-0.14, paste0( "m = ", n.male),
        col="gray50", cex=1.1, pos=4  )
  
  
  axis( side=2, at=y, labels=position, 
        las=2, tick=F, cex.axis=1.5, col.axis="gray50" )
}


build_graph <- function( t.salary, unit )
{
  unique.titles <- unique( t.salary$title )
  ymax <- length(unique.titles)
  xmax <- round( max(t.salary$q50), -3 ) + 50000
  color.key.pos <- 40000 + ( xmax - 40000 ) / 2
  color.key.inc <- ( xmax - 40000 ) / 10
  
  t.mf <- filter( t.salary, gender %in% c("male","female") )
  N <- sum( t.mf$n )
  
  par( mar=c(6,15,4.1,0) )
  plot.new()
  plot.window( xlim=c(40000-10000,xmax), ylim=c(0,ymax+1) )
  
  abline( v=seq(40000,xmax-40000,20000), lwd=1.5, lty=2, col=gray(0.5,0.5) )
  axis( side=1, 
        at=seq(40000,xmax-40000,20000), 
        labels=paste0("$",seq(40,(xmax-40000)/1000,20),"k"),
        cex.axis=1.1, col.axis="gray40", tick=FALSE )
  
  y <- ymax
  
  if( "Full Professor" %in% unique.titles )
  {
    add_position( t.salary, position="Full Professor", y, xmax )
    y <- y-1
  }
  if( "Associate Professor" %in% unique.titles )
  {
    add_position( t.salary, position="Associate Professor", y, xmax )
    y <- y-1
  }
  if( "Assistant Professor" %in% unique.titles )
  {
    add_position( t.salary, position="Assistant Professor", y, xmax )
    y <- y-1
  }
  if( "Teaching Faculty" %in% unique.titles )
  {
    add_position( t.salary, position="Teaching Faculty", y, xmax )
    y <- y-1
  }
  if( "Researcher" %in% unique.titles )
  {
    add_position( t.salary, position="Researcher", y, xmax )
    y <- y-1
  }
  
  
  text( color.key.pos + 3*color.key.inc, 0, "MALE", 
        col=adjustcolor( "darkblue", alpha.f = 0.7), cex=1.2 )
  text( color.key.pos + 1.8*color.key.inc, 0, "FEMALE", 
        col="firebrick",  cex=1.2 )
  text( xmax - 0.1*xmax, 0, paste0("N = ",N), col="gray40",  cex=1.2, pos=4 )
  
  
  title( main="Median Salary by Rank and Gender", cex.main=1.5, col.main="gray30" )
  title( xlab=unit, col.lab="gray50", cex.lab=1.5, line=5 )
  title( xlab="dot size represents proportion of faculty at that rank",
         col.lab="gray50", cex.lab=0.9 )
  
  return(NULL)
}


