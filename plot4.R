## plot4.R: Multiple line charts for readings over a period of 2 days
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


# Open PNG file/device as plot4.png
png("plot4.png", height = 480, width = 480)

#generate plots, assuming there are no changes needed in font base or size

#addset multi column/row plot area through mfrow
par(mfrow = c(2,2))

with(hpcDF, {
    
    # plot #1 - Global Active Power over the period of 2 days
    plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type="l", col = "black")
    
    # plot #2 - Voltage over the period of 2 days
    plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type="l", col = "black")
    
    # plot #3 - Sub meter readings over the period of 2 days
    
    # Sub_metering_1 line plot setting type "l" over the 2 days period. 
    plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="l", col = "black")
    
    #add 2 lines on the chart for each of the remaining 2 sub meter readings 
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    # draw legend for chart # 3, supress border as per the assignment requirement
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black", "red", "blue"), bty="n")
    
    # plot #4 - Global Reactive Power over the period of 2 days
    plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type="l", col = "black")
    
})

# Close png file(device)
dev.off()