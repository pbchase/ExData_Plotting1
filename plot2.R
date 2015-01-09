# plot1.R
# A script to generate the plot "Global Active Power" based on data from
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

# add a numeric column of global active power to data frame
gap <- as.numeric(myData2$Global_active_power)
myData2["gap"] <- gap

# set the plot parameters we need for plot 2
par(pch='.', lty=1)

# write the plot the screen
plot(myData2$Date, myData2$gap, ylab="Global Active Power (kilowatts)", xlab="", main="", type='l')

# write the plot to a file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(myData2$Date, myData2$gap, ylab="Global Active Power (kilowatts)", main="", type='l')
dev.off()
