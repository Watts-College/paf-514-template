## GENERATE DATA
## regression slope = 2

x <- 1:100
y <- 2*x + rnorm(100,0,75)
d <- data.frame( x, y )

plot( x, y, pch=19, main="Population Data" )
summary( lm( y ~ x ) )



##  HELPER FUNCTIONS 
##  FOR THE SIMULATIONS
##
##  argument n determines sample size



# returns a single value b1

get_sample_slope <- function( d, n=10, include.plot=TRUE )
{
  # random sample of 10 rows
  d.sample <- d[ sample( 1:nrow(d), size=n ) , ]

  # regression model: Y = b0 + b1(X)
  m <- lm( y ~ x, data=d.sample )

  if( include.plot )
  {
    plot( d, pch=19, bty="n", cex=1, 
          col=gray( 0.5, 0.5 ) )
    points( d.sample, pch=19, col="darkred" )
    abline( m, col="darkred", lwd=2 )
  }

  # extract slope b1 from the model
  b1 <- (coef( m ))[2]

  return( b1 )
}


# get_sample_slope( d, n=10 )
# 2.743883





# returns a data frame row
# with slope, conf int, and sign test

test_for_null_slope <- function( d, n=10, include.plot=TRUE )
{
  # random sample of 10 rows
  d.sample <- d[ sample( 1:nrow(d), size=n ) , ]

  # regression model: Y = b0 + b1(X)
  m <- lm( y ~ x, data=d.sample )

  if( include.plot )
  {
    plot( d, pch=19, bty="n", cex=1, 
          col=gray( 0.5, 0.5 ) )
    points( d.sample, pch=19, col="darkred" )
    abline( m, col="darkred", lwd=2 )
  }

  # is the slope significant? 
  b1 <- (coef( m ))[2]
  ci <- confint( m )
  ci.b1.lower <- ci[2,1]
  ci.b1.upper <- ci[2,2]

  null.slope <- ci.b1.lower < 0 & ci.b1.upper > 0

  df <- data.frame( b1, ci.b1.lower, ci.b1.upper, null.slope )

  return( df )
}

 
# test_for_null_slope( d, n=10 )

#         b1 ci.b1.lower ci.b1.upper null.slope
#   2.379374    1.660848      3.0979      FALSE

# null slope is TRUE if CI contains zero





plot_ci <- function( df, true.slope=2, n=10 )
{
  
  min.x <- min( results$ci.b1.lower )
  max.x <- max( results$ci.b1.upper )
  range.x <- mean( results$ci.b1.upper - results$ci.b1.lower )
  adj.x <- 0.5 * range.x
  
  ci.color <- ifelse( results$null.slope, "darkred", "gray70" )
  
  plot( results$b1, 1:nrow(results), 
        xlim=c( min.x - adj.x, max.x + adj.x ),
        bty="n", pch=19, col=ci.color, yaxt="n",
        xlab="Slope B1: From Y = b0 + b1(X)", ylab="" )

  abline( v=0 )
  
  abline( v=true.slope, col="gray80", lty=2 )

  segments( x0=results$ci.b1.lower,
            x1=results$ci.b1.upper,
            y0=1:nrow(results),
            col=ci.color, lwd=0.7 )

  type.ii.rate <- mean( results$null.slope )

  text( (min.x-adj.x), nrow(results),
        paste0( "\n\n\n\n\n\n\nSample Size \n   = ", n, 
                "\n\nType II \nError Rate \n  = ", type.ii.rate ),
        col="darkred", cex=1.3, pos=4 )
  
  return( NULL )
}




#################################
#################################
###
###   SIMULATIONS WITH LOOPS
###
#################################
#################################


# bootstrap simulation
# to examine Type II Errors
# as a function of sample size



# # collector vector 
# slopes <- NULL
# 
# for( i in 1:1000 )
# {
#   
#   b1 <- get_sample_slope( d, n=10 )
#   slopes[ i ] <- b1 
#   
# }
# 
# summary( slopes )
# hist( slopes, breaks=25, col="gray20", border="white" )
# 
# 
# 
# 
# 
# 
# 
# # results data frame
# results <- NULL
# 
# for( i in 1:50 )
# {
#   
#   null.slope.test <- test_for_null_slope( d, n=10 )
#   
#   # add new row to results data frame
#   results <- rbind( results, null.slope.test )
#   
# }
# 
# head( results )
# 
# 
# 
# 
# 
# 
# 
# # results list
# results <- NULL
# 
# for( i in 1:50 )
# {
#   null.slope.test <- test_for_null_slope( d, n=10 )
#   
#   results[[ i ]] <- null.slope.test
#   
#   ## the list version 
#   ## runs faster but it 
#   ## needs to be converted 
#   ## to a data frame afterwards
#   
# }
# 
# head( results )
# 
# ## convert list to df
# 
# results <- dplyr::bind_rows( results )
# head( results )
# 
# 
# 
# 
# 
# 
# min.x <- min( results$ci.b1.lower )
# max.x <- max( results$ci.b1.upper )
# range.x <- mean( results$ci.b1.upper - results$ci.b1.lower )
# adj.x <- 0.5 * range.x
# 
# ci.color <- ifelse( results$null.slope, "darkred", "gray70" )
# 
# plot( results$b1, 1:nrow(results), 
#       xlim=c( min.x - adj.x, max.x + adj.x ),
#       bty="n", pch=19, col=ci.color, yaxt="n",
#       xlab="Slope of B1", ylab="" )
# 
# abline( v=0 )
# 
# segments( x0=results$ci.b1.lower,
#           x1=results$ci.b1.upper,
#           y0=1:nrow(results),
#           col=ci.color, lwd=0.7 )
# 
# type.ii.rate <- mean( results$null.slope )
# 
# text( (min.x-adj.x), nrow(results),
#       paste0( "\n\nType II \nError Rate \n = ", type.ii.rate ),
#       col="darkred", cex=1.3, pos=4 )

