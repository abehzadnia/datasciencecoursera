## Week 2: writing functions


# Function syntax #####

# Function that adds two value
add2 <- function(x, y) {
  ## naming function and
  # introducing the two variables that are to be added - x and y
  x + y #actual function
}
add2(2, 4)


# Fuction that takes a vector of number and returns a subset
aboveX <- function(x, y) {
  use <- x > y
  x[use] #subsetting the vector
}
a <- c(1:10)
aboveX(a, 5)

aboveX(a) # returns an error
# we can also define a default value


aboveX <- function(x, y = 4) {
  use <- x > y
  x[use] #subsetting the vector
}
aboveX(a, 1)
aboveX(a)

# Writing a function that utlises loops

ColMean <-
  function(x, removeNA = T) {
    # This functions aims to cycle through all columns and cal mean
    nc <- ncol(x)  #storing number of columns
    means <- numeric(nc)
    #at this stage we want to introduce "mean", doesn't matter what it holds
    # the term numeric, creates an verctor with numeric data with length defined
    # this shouldnt be confused with as.numeric
    for (i in 1:nc) {
      means[i] <-
        mean(x[, i], na.rm = removeNA) # mean of each column, na.rm by default is TRUE
    }
    means
  }
summary(airquality) #first two columns have NAs hence, can't calculate.
# Adition of NA Remove argument deals with this problem
ColMean(airquality)




## LEXICAL SCOPING IN R ######
# In nutshell, where does R look for values of the objects

make.power <- function(n) {
  pow <- function(x) {
    x ^ n
  }
  pow
}

cube <- make.power(2)
square <- make.power(3)
cube(2) #now cube return the function, hence a function itself
square(10)
ls(environment(make.power))


### Maximizing a Normal Likelihood #####
# It is important to understand the lexical scoping in R as Optimization
# methods in R routinely would require passing a function whose argument is a vector (e.g. log-likeligood)

# making a negative log likelihood for a normal distribution
NegLogLik <-
  function(data, fixed = c(F, F)) {
    #Fixed retermins if we wanna fix some parameters
    params <- fixed
    function(p) {
      #takes argument p for parameters (the parameter we want to optimise)
      params[!fixed] <- p
      # this is for normal distribution N(mu, sigma)
      # params that we gonna optimise over:
      mu <- params[1]
      sigma <- params[2]
      a <- -0.5 * length(data) * log(2 * pi * sigma ^ 2)
      b <- -0.5 * sum((data - mu) ^ 2) / (sigma ^ 2)
      - (a + b)
    }
  }

set.seed(1)
normals <- rnorm(100, 1, 2)
nLL <- NegLogLik(normals)
nLL
