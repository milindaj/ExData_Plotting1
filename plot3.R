## plot3.R: Line chart of three Energy sub metering readings over a period of 2 days
# I have used read.table() for reading data. See Notes.md file under this repo
# for an alternative and better option - fread()

# Read data, specify the format of each variable under colClasses, na.strings is coded as ?
hpcDF <- read.table("household_power_consumption.txt", sep=";", header = TRUE, 
               colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
               na.strings='?')

# Extract data for 2 dates: Feb 01 2007 and Feb 02 2007
hpcDF <- hpcDF[hpcDF$Date %in% c("1/2/2007","2/2/2007"), ]

# concatinate Date and Time strings under a new column DateTime
hpcDF$DateTime <- paste(hpcDF$Date, hpcDF$Time, sep = " ")

# Remove Date and Time columns as they are no longer needed. This may save memory as well
hpcDF$Date = NULL
hpcDF$Time = NULL

#convert DateTime from text to Date (POSIXlt class) using strptime
hpcDF$DateTime <- strptime(hpcDF$DateTime, format = "%d/%m/%Y %H:%M:%S")


# Open PNG file/device as plot3.png
png("plot3.png", height = 480, width = 480)

#generate plot, assuming there are no changes needed in font base or size

# Initialize plot, draw Sub_metering_1 line plot setting type "l" over the 2 days period. 
# Set ylab as per requirement and set xlab to "" as it is not needed
plot(hpcDF$DateTime, hpcDF$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="l", col = "black")

#add 2 lines on the chart for each of the remaining 2 sub meter readings 
lines(hpcDF$DateTime, hpcDF$Sub_metering_2, col = "red")
lines(hpcDF$DateTime, hpcDF$Sub_metering_3, col = "blue")

# Note - instead of using lines() we can also use par("new" = TRUE) option and go on drawing series of
# plots overlaying on top of each others. For the current scenario it would look like below

#plot first sub meter reading
# plot(hpcDF$DateTime, hpcDF$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="l", col = "black")

# par("new" = TRUE)

# plot second reading  
# plot(hpcDF$DateTime, hpcDF$Sub_metering_2, type="l", col = "red")

# par("new" = TRUE)

# plot third reading  
# plot(hpcDF$DateTime, hpcDF$Sub_metering_3, type="l", col = "blue")

# draw legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black", "red", "blue"))

# Close png file(device)
dev.off()