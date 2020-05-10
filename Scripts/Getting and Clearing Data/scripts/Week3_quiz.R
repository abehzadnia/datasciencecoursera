# Week 3 Quiz
library(dplyr)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile = "acs2.csv")

acs <- read.csv("./acs2.csv", header = T)
names(acs)
#AGS: agricultral product:
# 1 .None           2 .$    1 - $  999           3 .$ 1000 - $ 2499           4 .$ 2500 - $ 4999           5 .$ 5000 - $ 9999           6 .$10000+

#ACR        1          Lot size                       b .N/A (GQ/not a one-family house or mobile home)           1 .House on less than one acre           2 .House on one to less than ten acres            3 .House on ten or more acres

X<-acs %>% select(ACR, AGS) %>% mutate(agricultureLogical=(ACR == 3 & AGS == 6))
X[which(X$agricultureLogical == T),]
which(X$agricultureLogical) 
table(X$agricultureLogical)


## Question 2:
fileJPG <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileJPG, "./Data/pic.jpg")
x<-readJPEG("./Data/pic.jpg", native = TRUE)
quantile(x, probs = c(0.3, 0.8))




## Question 3:
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, destfile = "./Data/FGDP.csv")
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL2, destfile = "./Data/EDSTATS.csv")
gdp<- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip=4
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)

edstat<-read.csv("./Data/EDSTATS.csv",header = T )
head(gdp)
names(gdp)
names(edstat)
df<-merge(gdp,edstat, by= "CountryCode")
df
dim(df)
dim(gdp)

# Question 4
summary(df)
#average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
names(df)
df%>%select(Rank, Economy, Income.Group) %>% 
  group_by(Income.Group) %>% summarise(avg.rank = mean(Rank))
