# Week 3: Getting and Clearing Data

set.seed(12435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10), "var3"=sample(11:15))
x
x<-x[sample(1:5),];x$var2[c(1,3)] = NA
x

## Subsetting ----
x[,1] #col
x[,"var1"]
x[1:2,"var2"]

#using logical statements
x[(x$var1 <=3 & x$var3>11),]
x[(x$var1 <=3 | x$var3>11),]
#Which
x[which(x$var2>0),]
# Sorting
sort(x$var2)
sort(x$var2, decreasing = T)
sort(x$var2, na.last = T)

#Order
x
x[order(x$var1),] #ordering dataframe based on a col


# * plyrs package ------
library(plyr)
arrange(x,var1)
arrange(x,desc(var1))

# Adding rows and columns -----
x$var4 <- rnorm(5)
x
#can do the same with cbind command
y <-cbind(x, rnorm(5))
y
z <- rbind(y,c(1:5))
z

#Summarizing data -----

fileURL<-"https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, "./Data/restaurants.csv", method="curl")
restData<-read.csv("./Data/restaurants.csv")
head(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict, probs = c(.5,.75))
table(restData$zipCode, useNA = "ifany") #by default NA is hidden
table(restData$zipCode, restData$councilDistrict)#2x2 tables

#check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)

#taking sum
colSums(is.na(restData))

#values with specific characteristics
table(restData$zipCode %in% c("21212", "21213"))
# can also subset
restData[restData$zipCode %in% c("21212", "21213"),]

# Cross tabs -----
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)
xtabs(Freq ~ Gender+Admit, data=df) # data ~ variables


warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks~., data=warpbreaks)
xt
ftable(xt)## summarise using flat tables based on cross tabs
print(object.size(xt), units = "Mb")


# Creating new variables -----
# common variables:
# missing indicators, cutting up quantitative varibles, transofrmations

# * sequence ----
s1<-seq(1,10,by=2);s1
s2<-seq(1,10,length=7);s2
x<<-c(1,3,8,25,100);s3<-seq_along(x);s3


# subsetting based on:
# binary variables
restData$zipWrong <- ifelse(restData$zipCode<0,T,F);table(restData$zipCode<0,restData$zipWrong)

# cutting up
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups,restData$zipCode)

# Hmisc package
library(Hmisc)
restData$zipGroups2 <- cut2(restData$zipCode, g=4)
restData2<-mutate(restData, zipGroups=cut2(zupCode,g4))

# Common transforms ----
abs(x)
sqrt()#square root
ceiling() #ceiling 3.7 = 4
floor() #floor of 3.7 is 3
round(x,digits = n)
signif(x,digits=n)
cos()
sin()
log()
log2();log10()
exp()

## Reshaping data -----
library(reshape2)
head(mtcars)
# * melt ---- 
mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),
                 measure.vars = c("mpg","hp"))
carMelt
# * dcast ----
cylData <- dcast(carMelt, cyl ~ variable) #seeing cyl 
cylData # for 4 cyl we have 11 measure of mpg and hp 
# can also specify the fucntion 
cylData <-dcast(carMelt, cyl~variable, mean);cylData

# averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)
# summing over 
spIns<-split(InsectSprays$count, InsectSprays$spray);spIns
spCount<-lapply(spIns, sum);unlist(spCount)
# or
spCount<-sapply(spIns, sum);spCount

# * ddply ----
library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
# anotherway:
spraySums<-ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums) #same length as original data using ave function


# dplyr package ------
#dplyr verbs:
library(dplyr)
chicago <- readRDS('./Data/chicago.rds')
str(chicago)
names(chicago)
# * select ----
# returns a subset of colimns of a df
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))

# * filter ----
# exact a subset of colimns of a df based on logical condition
chic.f <- filter(chicago, pm25tmean2 >30)
head(chic.f)

# * arrange ----
# reorder row of a df
arrange(chicago, date)


# * rename ----
# rename variables in a df
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoints = dptp)
head(chicago)

# * mutate -----
# add new variable/transform existing variables
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25,na.rm=T))
head(chicago)

chicago<-mutate(chicago, year=as.POSIXlt(date)$year + 1900)

# * summarise ----
# generate summary statistics
years <-group_by(chicago, year)
summarise(years, pm25=mean(pm25, na.rm=TRUE),o2=max(o3tmean2), no2=median(no2tmean2))

# Merging ---- 


 












