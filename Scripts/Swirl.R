# Coursera Swirl Codes

# List of all courses:
# http://swirlstats.com/scn/title.html

#Library
library(swirl)
swirl()

# R Programming #####

# * * 3. Sequence of Numbers #####
1:15
15:1
?`:`
seq(1,20)
seq(0,10, by = .5)
my_seq <- seq(5, 10, length=30)
length(my_seq)
1:length(my_seq) 
#another option:
seq(along.with = my_seq)
seq_along(my_seq)


# Creating vector n=40, values = 0 
rep(0, times= 40)
rep(c(0,1,2), times = 10)
rep(c(0,1,2), each = 10)

# * * 4. Vectors ####
num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect <1 # Vector of logics
my_char <- c("My", "name", "is")
paste(my_char, collapse = " ")
my_name <- c(my_char, "Ali") # used to colllapse the values
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ") #Joining characters
paste(c(1:3), c("X", "Y", "Z"), sep = "")
paste(LETTERS, 1:4, sep = "-") #repeated if unequal length


# * * 5. Missing Values ####
x <- c(44, NA, 5, NA)
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y, z), 100)
my_na <- is.na(my_data)
sum(my_na) # T = 1
# value -- NaN, which stands for 'not a number
Inf-Inf

# * * 6. Subsetting ####
x
x[1:10]
x[is.na(x)]  #vector of all NAs
x[!is.na(x)]
y <- x[!is.na(x)]
x[!is.na(x) & x > 0] #as NA is placeholder, NAs would have been retruend too
x[c(3,5,7)]
x[3000] #Caution: no error is produced
x[c(-2, -10)]
x[-c(2, 10)]
vect <- c(foo = 11, bar =2, norf = NA)
names(vect) #Names of vect
vect2 <-  c(11, 2, NA) #No names
names(vect2) <- c("foo", "bar", "norf")
identical(vect, vect2)
vect[c("foo", "bar")]

# * * 7. Matrices and Dataframe ####
my_vector <- 1:20
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4,5) # Transposing matrix
dim(my_vector)
attributes(my_vector)
class(my_vector)
my_matrix <- my_vector
my_matrix2 <- matrix(1:20,nrow = 4, ncol= 5)
my_matrix2 <- matrix(1:20, nrow=4, ncol=5,byrow = F)
identical(my_matrix, my_matrix2)
patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix) #combining char and num coerces char
#This is called implicit coercion
my_data<-data.frame(patients, my_matrix)
class(my_data)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <-cnames

# * * 8. Logic####
TRUE & c(TRUE, FALSE, FALSE)
TRUE && c(TRUE, FALSE, FALSE) #Evaluates first member only
TRUE | c(TRUE, FALSE, FALSE)
TRUE || c(TRUE, FALSE, FALSE)
5 > 8 || 6 != 8 && 4 > 3.9
isTRUE(6 > 4)
xor(5 == 6, !FALSE) #Exclusive OR
ints <- sample(10)
ints >5
which(ints >7) #return indices
any(ints < 0) #T if one or more logical vector is T
all(ints>0)

# * * 9. Functions ####
Sys.Date()
mean(c(2,4,5))
# refer to function folder


# * * 10. lapply and sapply  ###

head(flags)
cls_list <- lapply(flags, class)
class(cls_list)
as.character(cls_list)
cls_vect<-sapply(flags, class)
flag_colors<-flags[,11:17]
sapply(flag_colors, sum)
sapply(flag_colors, mean)
flag_shapes <- flags[, 19:23]
shape_mat<-sapply(flag_shapes, range)
unique_vals <- lapply(flags, unique)
sapply(unique_vals, length)
sapply(flags, unique) # fails to simplify due to different length
lapply(unique_vals, function(elem) elem[2]) 


# * * 11. vapply and tapply  ###
sapply(flags, class)
#vapply allows us to define the correct expect format of output
vapply(flags, class, character(1))


tapply(flags$population, flags$landmass, summary)

# * * 14. Date ###
t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M")
difftime(Sys.time(), t1, units = "days")

