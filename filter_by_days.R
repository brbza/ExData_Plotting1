# Author: Carlos Barboza
# Date: 2015-01-10
# Coursera Exploratory Data Analysis Course, JHS
#
# This Function used to filter out the sample file just for the required days, 
# Has two parameters, first the file name and second a vector with dates represented as strings
# in the following format: d/m/y, where d ranges from 1 to 31, m ranges from 1 to 12 and y has 4 digits, ie: 2007
# the function returns a data frame with the measurements of the days selected in days.

filterByDays <- function(fileName, days) {
  # Open a connection to read the file
  con <- file(fileName, "r")
  # Read the first line, the header
  header <- readLines(con, n = 1, warn = FALSE)
  # Create a dataframe called data that will be the result, assigning the name of the columns and its types.
  data <- data.frame(Date=character(0), Time=character(0), Global_active_power=numeric(0), 
                     Global_reactive_power=numeric(0), Voltage=numeric(0), Global_intensity=numeric(0), 
                     Sub_metering_1=numeric(0), Sub_metering_2=numeric(0), Sub_metering_3=numeric(0))
  # Loop to read the file line by line, avoiding to load the entire file in memory.
  while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
    # Split values of a line into a vector
    values <- (strsplit(line, ";")[[1]])
    # Just append the record of the line to data if it correspond to a date specified in days
    if(values[1] %in% days) {
      # Missing data represented by "?" is automatically coerced to NA by the as.numeric function
      line_df <- data.frame(Date                  = as.Date(values[1], "%d/%m/%Y"), 
                            Time                  = strptime(paste(values[1],values[2],sep=" "), "%d/%m/%Y %H:%M:%S", tz=""), 
                            Global_active_power   = as.numeric(values[3]), 
                            Global_reactive_power = as.numeric(values[4]), 
                            Voltage               = as.numeric(values[5]), 
                            Global_intensity      = as.numeric(values[6]), 
                            Sub_metering_1        = as.numeric(values[7]), 
                            Sub_metering_2        = as.numeric(values[8]), 
                            Sub_metering_3        = as.numeric(values[9]))
      data <- rbind(data, line_df)
    }
  } 
  # close io connection
  close(con) 
  # Output data as result
  data
}