# ### John Hopkins Data Science Course ###


# Loop Functions #####

# loop functions other than for and while loops
 

# * lapply to loop over a list  ####

x<- list(a=1:5, b=rnorm(10))
lapply(x,mean) #returns list

x<-1:4
lapply(x,runif) #coerces object into list as output

x<-1:4
lapply(x,runif, min=0,max=10) #can specify FUN args



# * sapply ####
# same as lapply but simplified result

x<- list(a=1:5, b=rnorm(10))
sapply(x,mean) #returns matrix

x<-1:4
sapply(x,runif) #if unable due to dim will be a list


# * apply ####

str(apply)
# x = array
# MARGINE = integer vector that should be retained
# FUN

x <- matrix(rnorm(200), 20,10)
x # matrix of 20x10 
apply(x,1,mean) #across the rows
apply(x,2,mean) #across the columns
#rowSums = apply(x,1,sum)
#colMeans = apply(x,2,mean)

apply(x,1,quantile, probs = c(.25,0.75))


# array
a<- array(rnorm(2*2*10),c(2,2,10))
a
apply(a,c(1,2), mean)


# * mapply: Multivariate version of lapply ####

# Apply lapply over a series of arguments (e.g. mult elemnts of a list)
# number of FUN should be at least as many as number of lists


list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1)

#e.g
noise<-function(n,mean,sd){
  rnorm(n,mean,sd)
}
noise(5,1,2)
noise(1:5,1:5,2) # doesn't work for vector
mapply(noise,1:5,1:5,2) #vectorises a function

# * tapply: Apply a function over subsets of a vector ####

x<-c(rnorm(10), runif(10), rnorm(10,1))
f<-gl(3,10)
tapply(x,f,range)
# tapply splits the vector and applies the function and then brings it back


# *  split is also useful, particularly in conjunction with lapply #####
#split is good to use in conjucture with other loop functions
str(split)
# Takes vector x and splits based on groups/factors f
split(x,f)
lapply(split(x,f), mean)
tapply(x,f,mean)
head(airquality)
lapply(split(airquality$Ozone, airquality$Month), 
       function(x){colMeans(x, ra.rm = TRUE)})



# Week 3 Quiz 
library(datasets)
data(iris)
?iris
attach(iris)
sapply(split(Sepal.Length, Species), mean)
colMeans(iris[1:4])
apply(iris[,1:4],2, mean)
detach(iris)

data(mtcars)

# calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?

head(mtcars)
a<-tapply(mtcars$mpg, mtcars$cyl, mean)
abs(a[1] - a[3])

debug(ls)
ls(a)
