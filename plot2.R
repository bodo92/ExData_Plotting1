## Store the current path to restore to at the end
dev.off()
dev.off()
path <- getwd()

## store the url of the dataset in a variable "fileurl"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download and unzip the dataset file if the file does not already exist on the computer
if(!file.exists("~/Electric Power Consumption.zip")){
    download.file(fileurl, destfile = "Electric Power Consumption.zip")
}

## Unzip the downloaded zip file
if(!file.exists("~/Electric Power Consumption")){
unzip("Electric Power Consumption.zip", exdir = "Electric Power Consumption")
}

## Set the working directory to folder containing the unzipped file(s)
setwd("./Electric Power Consumption/")

t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
t <- t[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
t <- t[ ,!(names(t) %in% c("Date","Time"))]
  
## Add DateTime column
t <- cbind(dateTime, t)
  
## Format dateTime Column
t$dateTime <- as.POSIXct(dateTime)

## Create Plot 2
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
dev.off()
dev.off()
