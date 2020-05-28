# EDA Graphs and Plotting
################################ ###
getwd()
pollution<-read.csv("./Data/EDA/avgpm25.csv", colClasses = c("numeric","character", "factor", "numeric", "numeric"))
head(pollution)

# One dimanestional summaries ----
# ############################### #
summary()
hist() #with abline and rug()
barplot()
boxplot()

# Two dimentional summaries -----
# ############################### #
#boxplot
boxplot(pm25~region, data = pollution, color = "red")

#histogram
par(mfrow=c(2,1),mar=c(4,4,2,1))
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")

#scatterplots
# most easiest and obvious
par(mfrow=c(1,1),mar=c(4,4,2,1))
with(pollution, plot(latitude, pm25))
abline(h=12,lwd=2,lty=2) # add horizontal line at pm25 for national standard

with(pollution, plot(latitude, pm25, col=region))
abline(h=12,lwd=2, lty=2)

# multiple scatterplots 
par(mfrow=c(1,2),mar=c(4,4,2,1))
with(subset(pollution,region=="west"), plot(latitude, pm25,main="West"))
with(subset(pollution,region=="east"), plot(latitude,pm25,main="East"))


# Plotting systems-----
# ############################### #

# Latttice System (lattice)
library(lattice)
state<-data.frame(state.x77, region=state.region)
xyplot(Life.Exp~Income | region, data=state, layout = c(4,1)) 
#single function call

# ggplot2 System
library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)



# * Base Plot -----
library(datasets)
hist(airquality$Ozone)
with(airquality,plot(Wind, Ozone))
airquality2 <- transform(airquality, Month=factor(Month))
boxplot(Ozone~Month, airquality2, xlab = "Month", ylab = "Ozone ppb")

# par function specifies global graphics parameters
par()
# lags - orientation of axi
# bg - background color
# mar - margin size
# oma - outer margine size
# mfrow and mfcol - matrix of row/column


with(airquality,plot(Wind, Ozone, main = "Main title", pch = 20))
# subsetting data and annotating the base plot
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col="red"))
legend("topright", pch=20, col=c("blue","red"), legend = c("May","Not May"))
model<-lm(Ozone ~ Wind, airquality)
abline(model,lwd=2)


# plotting multiples
par(mfrow=c(1,3), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(airquality,{
  plot(Wind,Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and temperature")
  mtext("Ozone and Weather in New York City", outer = T)
})
par(mfrow=c(1,1), mar=c(4,4,4,4),oma=c(0,0,0,0))

# * Base Plot e.g.-----



