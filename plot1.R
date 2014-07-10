# First course project for Exploratory Data Analysis offering on Coursera

# Task 1 - plot1.png

# Variable for store path to datafiles
dataDir <- "."

# Data filename
dataFile <- "household_power_consumption.txt"

# Plot filename
plotFile <- "plot1.png"

# Bounds for filtering
date_1 <- as.Date("1/2/2007", "%d/%m/%Y")
date_2 <- as.Date("2/2/2007", "%d/%m/%Y")

# Load, cast and subset data
loadData <- read.table(file = paste(dataDir, dataFile, sep = "/"), 
                       sep = ";", 
                       header = T)

loadData$Date <- as.Date(loadData$Date, "%d/%m/%Y")
loadData$Global_active_power <- as.double(as.character(loadData$Global_active_power))

filterSet <- loadData$Date == date_1 | loadData$Date == date_2
subsetData <- loadData[filterSet, ]

# Generate plot
png(file = paste(dataDir, plotFile, sep = "/"),
    width = 480, 
    height = 480
)
with (subsetData, 
      hist(Global_active_power, 
           main = "Global Active Power", 
           col = "Red", 
           xlab = "Global Active Power (kilowatts)")
      )

dev.off()