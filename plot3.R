# First course project for Exploratory Data Analysis offering on Coursera

# Task 3 - plot3.png

# Variable for store path to datafiles
dataDir <- "."

# Data filename
dataFile <- "household_power_consumption.txt"

# Plot filename
plotFile <- "plot3.png"

# Bounds for filtering
date_1 <- "1/2/2007"
date_2 <- "2/2/2007"

# Load, cast and subset data
loadData <- read.table(file = paste(dataDir, dataFile, sep = "/"), 
                       sep = ";", 
                       header = T)

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
      col = "Blue")

legend("topright", 
       cex = 0.8, 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.off()