
### John Hopkins Data Science Course ###


# Library
install.packages("swirl", dependencies = T)
library(swirl)

getwd()



#### Weak 1 ####
# Excercises 
data <- read.csv("./Data/hw1_data.csv")
head(data)
data[152:153,]
dim(data)
data[47,]
summary(data$Ozone)
data.subset <- data[data$Month == 5,]
summary(data.subset$Ozone)

# Swirl

#### W2: Structure and Function ####

# ** If condition ####
if(<condition>) {
  ## do something
} else {
  ## do something else
}
if(<condition1>) {
  ## do something
} else if(<condition2>) {
  ## do something different
} else {
  ## do something different
}

if(x > 3) {
  y <- 10
} else {
  y <- 0
}


## ** For loops #####
# For loops goes over a set of numbers
x <- c("a", "b", "c", "d")
for(i in 1:4) {
  print(x[i])
}
for(i in seq_along(x)) {
  print(x[i])
}
for(letter in x) {
  print(letter)
}
for(i in 1:4) print(x[i])


x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}

### ** while loop #####
# While loops are infinite loops
# Ensure the loop will finish else it can go on forever

z <- 5
while(z >= 0 && z <=10){
  print(z)
  coin <- rbinom(1,1,0.5)
  if(coin ==1){
    z <- z+1
  } else {
    z <- z-1
  }
  
}


### ** Repeat #####
# Repeat initiates an infinite loop; these are not commonly used in statistical applications
# The only way to exit a repeat loop is to call break.
# For example, when wanting two values to converge 

x0 <- 1
tol <- 1e-8
repeat {
  x1 <- computeEstimate()
  if(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}


# Better to use for functions

for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next
  }
  ## Do something here
}















  