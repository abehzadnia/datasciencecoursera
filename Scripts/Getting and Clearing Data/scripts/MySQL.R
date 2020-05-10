# Data and Cleaning data
# Week 1

# mySQL -----

install.packages("RMySQL")
library(RMySQL)
ucscDb <- dbConnect(MySQL(), user = "genome",# first we connect
                    host="genome-euro-mysql.soe.ucsc.edu")

result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb) 
  #this is MySQL command. Should always disconnect after retrieving data

result #all the databases available


# Will now select the database we want, here the gene hg19
hg19<-dbConnect(MySQL(), user = "genome",db = "hg19",
          host="genome-euro-mysql.soe.ucsc.edu")
allTables<-dbListTables(hg19)
length(allTables) # it contains 12444 tables
allTables[1:5]
dbListFields(hg19,"affyU133Plus2") # looking at particular table
dbGetQuery(hg19,"select count(*) from affyU133Plus2") #MySQL command for counting all records


affyData<-dbReadTable(hg19, "affyU133Plus2")
# as MySQL data could be too large to import into R, we may opt to import selected onlies
query <-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")#mysql cmd

affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
#here, the query has been sent to the server. we fetched the data, now query needs to be cleared
dim(affyMisSmall)



