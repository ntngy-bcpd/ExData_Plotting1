## Exploratory Data Analaysis
## Project 1
## Plot 1

library(data.table)

## Assume this data file is in the working directory
fileName = "household_power_consumption.txt"

## Read the data file and get a subset between 1-Feb-2007 and 2-Feb-2007
originalDF <- fread(fileName, colClasses = "character", na.string = "?")
DF1 <- subset(originalDF, originalDF$Date=="1/2/2007")
DF2 <- subset(originalDF, originalDF$Date=="2/2/2007")
DF <- rbind(DF1, DF2)
DF <- DF[complete.cases(DF)]

## Convert Global active power to numeric
power <- as.numeric(DF$Global_active_power)

## Convert date and time to POSIXlt
dateTime <- strptime(paste(DF$Date, DF$Time), "%d/%m/%Y %H:%M:%S")
DF$DateTime <- as.data.frame.POSIXlt(dateTime)

## Plot the historgram of Globa active power
hist(power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     ps = 10,
     cex.lab = 0.8,
     cex.axis = 0.8)

## Save the plot to png
dev.copy(png, "plot1.png")
dev.off()