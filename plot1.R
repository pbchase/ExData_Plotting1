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
data$Date <- strptime(data$Date, format="%d/%m/%Y")

# Subset the data to the two dates of interest
myData <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02", drop=TRUE)

hist(as.numeric(myData$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
