# First course project for Exploratory Data Analysis offering on Coursera

# Task 4 - plot4.png

# Variable for store path to datafiles
dataDir <- "."

# Data filename
dataFile <- "household_power_consumption.txt"

# Plot filename
plotFile <- "plot4.png"

# Bounds for filtering
date_1 <- "1/2/2007"
date_2 <- "2/2/2007"

# Load, cast and subset data
loadData <- read.table(file = paste(dataDir, dataFile, sep = "/"), 
                       sep = ";", 
                       header = T)

loadData$Voltage <- as.double(as.character(loadData$Voltage))
loadData$Global_reactive_power <- as.double(as.character(loadData$Global_reactive_power))
loadData$Global_active_power <- as.double(as.character(loadData$Global_active_power))
loadData$Sub_metering_1 <- as.double(as.character(loadData$Sub_metering_1))
loadData$Sub_metering_2 <- as.double(as.character(loadData$Sub_metering_2))
loadData$Sub_metering_3 <- as.double(as.character(loadData$Sub_metering_3))

filterSet <- loadData$Date == date_1 | loadData$Date == date_2
subsetData <- loadData[filterSet, ]

# date and time
dt <- strptime(paste(subsetData$Date, subsetData$Time), 
               format = "%d/%m/%Y %T")

# Generate plot
png(file = paste(dataDir, plotFile, sep = "/"), 
    width = 480, 
    height = 480
)

par(mfrow = c(2, 2))

# left upper corner
with (subsetData, 
      plot(dt, 
           subsetData$Global_active_power, 
           type = "l", 
           xlab = "", 
           ylab = "Global Active Power")
     )

# right upper corner
with (subsetData, 
      plot(dt, 
           subsetData$Voltage, 
           type = "l", 
           xlab = "datetime", 
           ylab = "Voltage")
      )

# left bottom corner
with (subsetData, 
      plot(dt, 
           subsetData$Sub_metering_1, 
           type = "l", 
           xlab = "", 
           ylab = "Energy sub metering", 
           col = "Black")
      )

lines(dt, 
      subsetData$Sub_metering_2, 
      type = "l", 
      col = "Red"
)

lines(dt, 
      subsetData$Sub_metering_3, 
      type = "l", 
      col = "Blue"
)

legend(y = 0,
       bty = "n",
       "topright",
       cex = 0.75,
       y.intersp = 0.75, 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# right bottom corner
with (subsetData, 
      plot(dt, 
           subsetData$Global_reactive_power, 
           type = "l", 
           xlab = "datetime", 
           ylab = "Global_reactive_power", 
           ylim = c(0.0, 0.5))
      )

dev.off()