# R Programming: Assignments

# Assignment 2 #####

# second programming assignment will require you to write an R function is able to cache potentially time-consuming computations. 


# first function, makeVector creates a special "vector", which is really a list containing a function to
# 
# set the value of the vector
# get the value of the vector
# set the value of the mean
# get the value of the mean

# example
#Setp1: intialise objects
makeVector <- function(x = numeric()) { # initialised x as an empty numeric vector
  m <- NULL #initialised within the arguemtn to be used in this environment
  
#Set2: define bheaviours or functions for objects
  # getts and setters
  set <- function(y) {
    x <<- y
    #<<- operator can be used to assign a value to an object in an environment that is different from the current environment.
    # this operator assigns the value on the right side to the object in the parent environment
    m <<- NULL # clears any value of m cached by prior executions
    
    # these two lines do exactly as what the above two lines did, introduce objects
  }
  
  get <- function() x # this defines the getter for the vector x
  # here as x is not defined within get() function, it will be retrieved from parent environment
  
  setmean <- function(mean) m <<- mean #since m is defined in parent environment we need <<-
  getmean <- function() m 
  
  #at this stage we have the getters and setters
  
#Step 3: creae new object by returning list()
  list(set = set,          # gives the name 'set' to the set() function defined above
       get = get,          # gives the name 'get' to the get() function defined above
       setmean = setmean,  # gives the name 'setmean' to the setmean() function defined above
       getmean = getmean)  # gives the name 'getmean' to the getmean() function defined above
}


x <-c(rnorm(10))
testVector<-makeVector(1:15)
testVector$set(rnorm(10))
testVector$get()[5]

# Without cachman function, makeVector is incomplete as the mean values are missing 



# Following function calculates the mean of the special "vector" created with the above function. However, it first checks to see if the mean has already been calculated. If so, it gets the mean from the cache and skips the computation. Otherwise, it calculates the mean of the data and sets the value of the mean in the cache via the setmean function.
cachemean <- function(x, ...) {
  m <- x$getmean() # retrieves the mean from the vector
  if(!is.null(m)) { #if its been calculated will return
    message("getting cached data")
    return(m)
  }
  data <- x$get() #for those not calculated will store the value
  m <- mean(data, ...)
  x$setmean(m) 
  m
}


aVector <- makeVector(1:10)
aVector$get()               # retrieve the value of x
aVector$getmean()           # retrieve the value of m, which should be NULL
aVector$set(10:50)          # reset value with a new vector
cachemean(aVector)          # notice mean calculated is mean of 30:50, not 1:10
aVector$getmean()[1]        # retrieve it directly, now that it has been cached










