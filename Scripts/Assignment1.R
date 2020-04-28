# R Programming: Assignments

# Assignment 1 #####

# * Part 1 ######
# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
#The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'.

getwd()

pollutantmean<-function(directory,pollutant,id=1:332){
  #create a list of files
  fileNames<-list.files(directory,full.names = TRUE)
  #Other method is to do a loop
  #for(i in min(id):max(id)){
  #  fileNames <- NA
  #  fileNames[i] <- paste(directory, formatC(i, width = 3, flag = "0"),".csv", sep ="")
  #}
 
   #create an empty data frame
  dat <- data.frame()
  
  #loop through the list of files until id is found
  for(i in id){
    #read in the file
    temp<- read.csv(fileNames[i],header=TRUE)
    #add files to the main data frame
    dat<-rbind(dat,temp)
  }
  #find the mean of the pollutant, make sure you remove NA values
  return(mean(dat[,pollutant],na.rm = TRUE))
  
}

pollutantmean("./Data/specdata/",pollutant = "nitrate")


# * Part 2 ######


# Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases



complete <- function(directory, id = 1:332){
  fileNames<-list.files(directory,full.names = TRUE)
  dat<-data.frame()
  for(i in id){
    temp<- read.csv(fileNames[i],header=TRUE)
    temp2<-data.frame(File = fileNames[i], Obs = sum(complete.cases(temp)))
    dat<-rbind(dat,temp2)
  }
  return(dat)
}

complete("./Data/specdata/",54)



# * Part 3 ######
# 
# Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.

corr <- function(directory, threshold = 0){
  fileNames<-list.files(directory,full.names = TRUE)
  #empty vector
  x <- numeric(0)
  
  for(i in 1:length(fileNames)){
    temp <- read.csv(fileNames[i])
    temp <- temp[complete.cases(temp)==T,]
    csum <-nrow(temp) #total observations of complete cases
    if(csum > threshold){ #if bigger than threshold defined
      # we are interested in correlation between pollutants
      x<-c(x,cor(temp$nitrate, temp$sulfate))
    }
  }
  return(x)
}

head(corr("./Data/specdata/",400))

RNGversion("3.5.1")  
set.seed(42)
cc <- complete("./Data/specdata/", 332:1)
use <- sample(332, 10)
print(cc[use, "Obs"])


cr <- corr("./Data/specdata/", 2000)                
cr <- sort(cr)   
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)


cr <- corr("./Data/specdata/", 2000)                
n <- length(cr)                
cr <- corr("./Data/specdata/", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))

