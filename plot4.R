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


### Create 4-paneled PNG file
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(Global_active_power~newdates,dt1, type="l", ylab="Global Active Power", xlab="")		# Panel 1
plot(Voltage~newdates,dt1, type="l", ylab="Voltage", xlab="datetime")						# Panel 2				  

# Panel 3
plot(Sub_metering_1~newdates,dt1, type="l", ylab="Energy sub metering", xlab="")
lines(Sub_metering_2~newdates,dt1, col="red")
lines(Sub_metering_3~newdates,dt1, col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n", cex=0.95)

# Panel 4
plot(Global_reactive_power~newdates,dt1, type="l", xlab="datetime")
dev.off()