## plot2.R: Line chart of Global Active Power over a period of 2 days
# I have used read.table() for reading data. See notes.Rmd file under this repo
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


# Open PNG file/device as plot2.png
png("plot2.png", height = 480, width = 480)

#generate plot, assuming there are no changes needed in font base or size
# since this is a line plot set type to "l". Also, set xlab to "" as it is not needed
plot(hpcDF$DateTime, hpcDF$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Close png file(device)
dev.off()