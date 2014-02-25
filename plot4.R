################################################################################
# This code produces plot4.png for the Exploratory Analysis week 1 assignment.
# NOTE: It nedds the package "data.table" to select and load only some data from the 
# whole dataset.

#### 0. Set up the environment
library("data.table")
file_name <- "household_power_consumption.txt"
dirpath <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(dirpath)

#### 1. Import the data: select only two days in February "01/02/2007" and "02/02/2007"
library("data.table")
date <- fread(file_name, select = "Date", showProgress = FALSE)
nameColumn <- fread(file_name, nrows = 1, showProgress = FALSE)
index <- c(grep("^1/2/2007",date$Date), grep("^2/2/2007",date$Date))
data <- read.csv(file_name, header=TRUE, sep=';', na.strings="?", 
                 nrows=length(index) , skip = index[[1]]-1,
                 check.names=FALSE, stringsAsFactors=FALSE, comment.char="",
                 quote='\"')
colnames(data) <- colnames(nameColumn)

#### 2. Convert the Date and Time variables to Date/Time classes called period
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
period <- as.POSIXct(paste(as.Date(data$Date, format = "%d/%m/%Y"), data$Time))

#### 3. Create the plot4 composed by the 4 sub-plots, Global_active_power ~ period,
#           Voltage ~ period, Energy sub metering ~ period, Global_reactive_power~period.
#### 3.1 we need to change the margins to fit the plot label
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0.5,0.5,0.5,0.5))
#### 3.2 do the plots
with(data, {
  plot(Global_active_power~period, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~period, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~period, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~period,col='Red')
  lines(Sub_metering_3~period,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~period, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#### 4. Save plot4
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()