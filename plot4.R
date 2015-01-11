## Exploratory Data Analaysis
## Project 1
## Plot 4

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
power <- as.numeric(DF$Global_active_power)
sub1 <- as.numeric(DF$Sub_metering_1)
sub2 <- as.numeric(DF$Sub_metering_2)
sub3 <- as.numeric(DF$Sub_metering_3)
voltage <- as.numeric(DF$Voltage)
reactive <- as.numeric(DF$Global_reactive_power)

## Convert date and time to POSIXlt
dateTime <- strptime(paste(DF$Date, DF$Time), "%d/%m/%Y %H:%M:%S")
DF$DateTime <- as.data.frame.POSIXlt(dateTime)

## Set plot matrix
par(mfrow = c(2,2), mar=c(4,4,2,2))


## Plot Globa active power by date time
plot(DF$DateTime, power, type = "l", col = "black",
     ylab = "Global Active Power",
     xlab = "",
     ps = 12,
     cex.lab = 0.75,
     cex.axis = 0.75)

## Plot voltage
plot(DF$DateTime, voltage, type = "l", col = "black",
     ylab = "Voltage",
     xlab = "datetime",
     ps = 12,
     cex.lab = 0.75,
     cex.axis = 0.75)

## Plot Sub meterings by date time
plot(DF$DateTime, sub1, type = "l", col = "black",
     ylab = "Energy sub metering",
     xlab = "",
     ps = 12,
     cex.lab = 0.75,
     cex.axis = 0.75)
lines(DF$DateTime, sub2, type = "l", col = "red")
lines(DF$DateTime, sub3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       cex = 0.7,
       bty = "n")

## Plot Global reactive power
plot(DF$DateTime, reactive, type = "l", col = "black",
     ylab = "Global_reactive_power",
     xlab = "datetime",
     ps = 12,
     cex.lab = 0.75,
     cex.axis = 0.75)

## Save the plot to png
dev.copy(png, "plot4.png")
dev.off()