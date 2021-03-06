# Author: Carlos Barboza
# Date: 2015-01-10
# Coursera Exploratory Data Analysis Course, JHS
#
# This scripts creates an histogram of the Global Active Power samples from the 1st and 2nd day of 
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
png("plot1.png", width=480, height=480,units="px")
# creates the histogram on the graphic device
hist(filteredData$Global_active_power, col= "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
# closes the graphic device
dev.off()