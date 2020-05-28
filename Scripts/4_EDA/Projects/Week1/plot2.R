# Week 1 Project

# Library
library(tidyverse)

# Loading data
getwd()
data<- read.delim("./Data/EDA/household_power_consumption.txt", sep= ";",
                  na.strings = "?")
head(data)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
df1<- data %>% dplyr::filter(Date >="2007-02-01" & Date <= "2007-02-02")

# Plot 2
# Global Active Power for the 2 days
df1$DateTime <- as.POSIXct(paste(df1$Date, df1$Time), format = "%Y-%m-%d %H:%M:%S")
png("./Scripts/4_EDA/Projects/Week1/plot2.png", width=480, height=480)
with(df1,plot(DateTime, Global_active_power, type="l", 
              xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
