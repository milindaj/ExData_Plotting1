## plot1.R: Histogram of Global Active Power
# There are multiple ways to read the data into R and process it. One of the 
# fastest way is to use fread(). I have found fread() to be much much faster
# than read.table() or other similar methods. But currently there is an open
# issue related to fread() wherein na.strings() argument is not handled well. 
# Thus for this assignment I am using read.table() to read and process data
# You can refer to Notes.md file under this repo for some additional notes on
# my observations related to reading data. Although I have used read.table()
# i have left some code related to reading and processing data through fread()
# in the file but ofcourse this code is commented

# library data.table is needed for fread
#library(data.table)

# Read data, specify the format of each variable, na.strings is coded as ?
hpcDF <- read.table("household_power_consumption.txt", sep=";", header = TRUE, 
               colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
               na.strings='?')

# in case using fread() the below code should work
# hpcDT <- fread("household_power_consumption.txt", sep=";", header = TRUE, 
#               colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
#               na.strings='?')

# due to issue with na.strings handling the numeric columns are coerced to character
# while reading data from file sometime. Thus convert text data these to numeric as needed
# hpcDT$Global_active_power <- as.numeric(hpcDT$Global_active_power)


# Extract data for 2 dates: Feb 01 2007 and Feb 02 2007
hpcDF <- hpcDF[hpcDF$Date %in% c("1/2/2007","2/2/2007"), ]


# If using fread() the same operation works for for data.table returned from fread().
# But data.table is much faster than data.frame and thus usually preferred for 
# operations such as subsetting
# hpcDT <- hpcDT[hpcDT$Date %in% c("1/2/2007","2/2/2007")]

# fread reads the data into data.table
# optionally convert it to data.frame as plot functions expect data.frame
# for this plot data.table also work well so I am leaving it as it is
#hpcDF <- as.data.frame(hpcDT)


# Open PNG file/device as plot1.png, generate plot, assuming required color is "red"
png("plot1.png", height = 480, width = 480)
hist(hpcDF$Global_active_power, col ='red', xlab ='Global Active Power (kilowatts)', main = 'Global Active Power')

# Close png file(device)
dev.off()