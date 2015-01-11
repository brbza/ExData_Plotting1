# Author: Carlos Barboza
# Date: 2015-01-10
# Coursera Exploratory Data Analysis Course, JHS
#
# This scripts creates a line graph of the energy sub metering samples from the 1st and 2nd day of 
# February 2007. 
# 
# It looks for the filtered set of measurements (filtered_power_consumption.csv) on the working directory.
# If the file is not found, it calls the filterByDays function to create this data set from the original one.
# After that it creates a png file with the appropriate size and labels on the working directory.
#
# In order to work properly, the script must be on the same directory as the filter_by_days.R and 
# household_power_consumption.txt files.

# source script to filter the data on the required days
source("filter_by_days.R", local=TRUE)

# if file with filtered data already exists, load it, otherwise filter the original data.
if(!file.exists("filtered_power_consumption.csv")) {
  filteredData <- filterByDays("household_power_consumption.txt", c("1/2/2007","2/2/2007"))
  write.table(filteredData,"filtered_power_consumption.csv", sep= ",", row.names=FALSE)  
} else {
  filteredData <- read.table("filtered_power_consumption.csv", sep=",", stringsAsFactors=FALSE, header=TRUE)
}

# open png graphic device to store the graph
png("plot3.png", width=480, height=480,units="px")

# creates two vectors with x and y data to be plotted
x <- strptime(filteredData$Time, "%Y-%m-%d %H:%M:%S")
y1 <- filteredData$Sub_metering_1
y2 <- filteredData$Sub_metering_2
y3 <- filteredData$Sub_metering_3

# plot data assigning y label
plot(x, y1, type="n", ylab = "Energy sub metering", xlab = "")
lines(x, y1)
lines(x, y2, col="red")
lines(x, y3, col="blue")

# adds legend to the graph 
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = names(filteredData)[7:9])

# closes the device
dev.off()