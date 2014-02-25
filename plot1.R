################################################################################
# This code produces plot1.png for the Exploratory Analysis week 1 assignment.
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

#### 2. Create the histogram of plot1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#### 3. Save plot1
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()