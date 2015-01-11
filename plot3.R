# plot3.R
# A script to generate the plot "Energy Sub Metering" based on data from
# the UC Irvine Machine Learning Repository about household electricity consumption.

# Download data file
dataFile <- "exdata_data_household_power_consumption.zip"
if (!file.exists(dataFile)){
    print("Downloading data file")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dataFile, "curl")
} else {
    print("File already exists locally")
}

# Extract the contents of the zip file
unzip(dataFile)

# define column classes for the data to be read
colClasses <- c("character", "character", "character", "character", "character", "character", "character", "character", "numeric")

# load the data into a dataframe
dataFile <- c("household_power_consumption.txt")
data <- read.table(dataFile, header=TRUE, sep=";", colClasses=colClasses)

# convert the Date column to a POSIXlt date
data$Date <- strptime(paste(data$Date, data$Time, sep = ' '), format="%d/%m/%Y %H:%M:%S")

# Subset the data to the two dates of interest
myData2 <- subset(data, Date >= "2007-02-01 00:00:00" & Date <= "2007-02-02 23:59:59", drop=TRUE)

# Change all sub metering columns to numeric
myData2$Sub_metering_1 <- as.numeric(myData2$Sub_metering_1)
myData2$Sub_metering_2 <- as.numeric(myData2$Sub_metering_2)
myData2$Sub_metering_3 <- as.numeric(myData2$Sub_metering_3)

# set the plot parameters we need for plot 2
par(pch='.', lty=1)
par(ps=8)

# write the plot the screen
plot(myData2$Date, myData2$Sub_metering_1, ylab="Energy sub metering", xlab="", main="", type='n')
points(myData2$Date, myData2$Sub_metering_1, type='l', col="black")
points(myData2$Date, myData2$Sub_metering_2, type='l', col="red")
points(myData2$Date, myData2$Sub_metering_3, type='l', col="blue")

legendText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineCol <- c("black", "red", "blue")
legend(x="topright", legend=legendText, col=lineCol, lty=1)

# write the plot to a file
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(myData2$Date, myData2$Sub_metering_1, ylab="Energy sub metering", xlab="", main="", type='n')
points(myData2$Date, myData2$Sub_metering_1, type='l', col="black")
points(myData2$Date, myData2$Sub_metering_2, type='l', col="red")
points(myData2$Date, myData2$Sub_metering_3, type='l', col="blue")

legendText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineCol <- c("black", "red", "blue")
legend(x="topright", legend=legendText, col=lineCol, lty=1)
dev.off()
