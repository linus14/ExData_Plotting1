### Code uses the package 'lubridate'. Please install before running code
library(lubridate)


### Code block for reading the data

# Download and unzip file to local drive
fpath<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fpath, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

# Open connection to unzipped text file, extract names of the variables, and search for the dates of the 2-day period which will be analyzed and plotted
con <- file("household_power_consumption.txt")    
names1 <- readLines(con,1)
d1_start <- grep("^1/2/2007", readLines(con))
d2_start <- grep("^2/2/2007", readLines(con))
close(con)

# Read data from the 2-day period 1/2/2007 to 2/2/2007 and store in variable 'dt1'
dt1<-read.table("household_power_consumption.txt", sep=";", skip=d1_start[1]-1, na.strings="?", 
nrows= length(d1_start) + length(d2_start))

# Assign variable names (column names) 
names2 <- unlist(strsplit(names1, ";"))
colnames(dt1) <- names2

# Change to Date and Time class (POSIXct and POSIXt) using the package 'lubridate' and assign to new variable called newdates
dt1$Date <- as.Date(dt1$Date, "%d/%m/%Y")
dt1$newdates <- paste(dt1$Date,dt1$Time)
dt1$newdates <- ymd_hms(dt1$newdates)


### Code for creating PNG file and plotting 'Global Active Power'

png(filename="plot2.png", width=480, height=480)
plot(Global_active_power~newdates,dt1, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()