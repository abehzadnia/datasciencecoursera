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

# Plot 1
# Global Active Power
summary(df1$Global_active_power)
png("./Scripts/4_EDA/Projects/Week1/plot1.png", width=480, height=480)
hist(df1$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
