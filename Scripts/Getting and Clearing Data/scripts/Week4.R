# Week 4: Cleaning Text data

getwd()
cameraData <- read.csv("./Data/cameras.csv")
names(cameraData)


# Casing ----
tolower(names(cameraData))
toupper(names(cameraData))


# Separating -----
splitNames = strsplit(names(cameraData),"\\.") #splitting by `.`
splitNames

# can couple this with a function to only find the first elements
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)


# Substiting -----

a <- c("a_x_x", "b_y")
sub("_","", a) # only first
gsub("_", "",a) # all

library(stringr)
substr("Jeffery Leek",1,7)
paste("A","B")
paste0("A","B")
str_trim("Jeff            ")

# Searching ----
grep("Alameda", cameraData$intersection) # all instances that the word appears
cameraData2 <- cameraData[!grep("Alameda", cameraData$intersection)]

grep("Alameda", cameraData$intersection, value = T) # return values


# Quiz Week 4 
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile  = "./Data/Week4ACS.csv")
acs_data<-read.csv("./Data/Week4ACS.csv")
names(acs_data)
strsplit(names(acs_data), "\\wgtp")[123]


# GDP summary
gdp_data<-read.csv("./Data/FGDP.csv", skip=5, header = FALSE, nrows = 190)
gdp_data<-gdp_data[c(1,2,4,5)]
names(gdp_data) <- c("CountryCode", "Rank", "Country", "GDP")
head(gdp_data)

x<- str_trim(gsub( ",", "", gdp_data$GDP))
summary(as.integer(x))

# Countries starting with United
grep("^United*", as.character(gdp_data$Country))


# Fiscal year in June 
ed_data<- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

head(ed_data)

df_fiscal <- merge(gdp_data, ed_data, by.x="CountryCode")

summary(as.factor(df_fiscal$`Special Notes`))

x<-df_fiscal[grepl(pattern = "Fiscal year end: June 30;",df_fiscal$`Special Notes`),]
dim(x)

# Stock Data
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
table(year(sampleTimes) == 2012) # 250
table(year(sampleTimes)==2012 & wday(sampleTimes, label = TRUE) == "Mon") #47

wday(sampleTimes, label=TRUE)

# How many values were collected in 2012? How many values were collected on Mondays in 2012?
  
  




