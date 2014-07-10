# First course project for Exploratory Data Analysis offering on Coursera

# Task 2 - plot2.png

# Variable for store path to datafiles
dataDir <- "."

# Data filename
dataFile <- "household_power_consumption.txt"

# Plot filename
plotFile <- "plot2.png"

# Bounds for filtering
date_1 <- "1/2/2007"
date_2 <- "2/2/2007"

# Load, cast and subset data
loadData <- read.table(file = paste(dataDir, dataFile, sep = "/"), 
                       sep = ";", 
                       header = T)

loadData$Global_active_power <- as.double(as.character(loadData$Global_active_power))

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
           subsetData$Global_active_power, 
           type = "l", 
           xlab = "", 
           ylab = "Global Active Power (kilowatts)")
      )

dev.off()