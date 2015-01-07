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
