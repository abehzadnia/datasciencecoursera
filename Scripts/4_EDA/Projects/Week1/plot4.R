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
df1$DateTime <- as.POSIXct(paste(df1$Date, df1$Time), format = "%Y-%m-%d %H:%M:%S")


# Plot 4
# Global Active Power for the 2 days

png("./Scripts/4_EDA/Projects/Week1/plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#plot 4.1 
with(df1,plot(DateTime, Global_active_power, type="l", 
              xlab="", ylab="Global Active Power"))
#plot 4.2
with(df1,plot(DateTime, Voltage, type="l", 
              xlab="", ylab="Voltage"))
#Plot 4.3
with(df1,plot(DateTime, Sub_metering_1, type="l", 
              xlab="", ylab="Energy sub metering"))
with(df1,points(DateTime, Sub_metering_2, type = "l", col="red"))
with(df1,points(DateTime, Sub_metering_3, type = "l", col="blue"))
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1), bty="n", cex=.5)
# Plot 4.4
with(df1,plot(DateTime, Global_reactive_power, type="l", 
              xlab="datetime", ylab="Global Reactive Power"))

dev.off()
