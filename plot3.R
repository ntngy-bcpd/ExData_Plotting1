## Exploratory Data Analaysis
## Project 1
## Plot 3

library(data.table)

## Assume this data file is in the working directory
fileName = "household_power_consumption.txt"

## Read the data file and get a subset between 1-Feb-2007 and 2-Feb-2007
originalDF <- fread(fileName, colClasses = "character", na.string = "?")
DF1 <- subset(originalDF, originalDF$Date=="1/2/2007")
DF2 <- subset(originalDF, originalDF$Date=="2/2/2007")
DF <- rbind(DF1, DF2)
DF <- DF[complete.cases(DF)]

## Convert Sub_meterings to numeric
sub1 <- as.numeric(DF$Sub_metering_1)
sub2 <- as.numeric(DF$Sub_metering_2)
sub3 <- as.numeric(DF$Sub_metering_3)

## Convert date and time to POSIXlt
dateTime <- strptime(paste(DF$Date, DF$Time), "%d/%m/%Y %H:%M:%S")
DF$DateTime <- as.data.frame.POSIXlt(dateTime)

## Plot Sub meterings by date time
plot(DF$DateTime, sub1, type = "l", col = "black",
     ylab = "Energy sub metering",
     xlab = "",
     ps = 10,
     cex.lab = 0.8,
     cex.axis = 0.8)
lines(DF$DateTime, sub2, type = "l", col = "red")
lines(DF$DateTime, sub3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       cex = 0.8)

## Save the plot to png
dev.copy(png, "plot3.png")
dev.off()