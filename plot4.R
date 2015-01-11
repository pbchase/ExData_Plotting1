# plot4.R
# A script to generate the an array of plots based on data from
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

# add a numeric column of global active power to data frame for plot2
gap <- as.numeric(myData2$Global_active_power)
myData2["gap"] <- gap

# Change all sub metering columns to numeric for plot 3
myData2$Sub_metering_1 <- as.numeric(myData2$Sub_metering_1)
myData2$Sub_metering_2 <- as.numeric(myData2$Sub_metering_2)
myData2$Sub_metering_3 <- as.numeric(myData2$Sub_metering_3)

# Change voltage column to numeric for plot 4c
myData2$Voltage <- as.numeric(myData2$Voltage)

# Change Global_reactive_power to numeric for plot 4d
myData2$Global_reactive_power <- as.numeric(myData2$Global_reactive_power)

# set the plot parameters we need for plot
par(pch='.', lty=1)
par(mfcol=c(2,2))
par(mar = c(5,4,2,2))

# write plot for GAP
plot(myData2$Date, myData2$gap, ylab="Global Active Power", xlab="", main="", type='l')

# write plot sub metering
plot(myData2$Date, myData2$Sub_metering_1, ylab="Energy sub metering", xlab="", main="", type='n')
points(myData2$Date, myData2$Sub_metering_1, type='l', col="black")
points(myData2$Date, myData2$Sub_metering_2, type='l', col="red")
points(myData2$Date, myData2$Sub_metering_3, type='l', col="blue")

legendText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineCol <- c("black", "red", "blue")
legend(x="topright", legend=legendText, col=lineCol, lty=1, box.lwd=0,  box.lty=0 )

# write plot for Voltage
plot(myData2$Date, myData2$Voltage, ylab="Voltage", xlab="datetime", main="", type='l')

# write plot for Global_reactive_power
plot(myData2$Date, myData2$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", main="", type='l')


# write the plot to a file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# set the plot parameters we need for plot
par(pch='.', lty=1)
par(mfcol=c(2,2))
par(mar = c(5,4,2,2))

# write plot for GAP
plot(myData2$Date, myData2$gap, ylab="Global Active Power", xlab="", main="", type='l')

# write plot sub metering
plot(myData2$Date, myData2$Sub_metering_1, ylab="Energy sub metering", xlab="", main="", type='n')
points(myData2$Date, myData2$Sub_metering_1, type='l', col="black")
points(myData2$Date, myData2$Sub_metering_2, type='l', col="red")
points(myData2$Date, myData2$Sub_metering_3, type='l', col="blue")

legendText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineCol <- c("black", "red", "blue")
legend(x="topright", legend=legendText, col=lineCol, lty=1, box.lwd=0,  box.lty=0 )

# write plot for Voltage
plot(myData2$Date, myData2$Voltage, ylab="Voltage", xlab="datetime", main="", type='l')

# write plot for Global_reactive_power
plot(myData2$Date, myData2$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", main="", type='l')

dev.off()

