###This code produce the plot 1 from Course project 1 of Exploratory Data Analysis Course

##save the "household_power_consumption.txt" file in your current working directory

##load packages
require(sqldf)

##read the data
data<-read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";",
                  nrows = 2075259,
                 "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

##convert the Date and Time variables to Date/Time classes 
data$Date.Time <- paste(data$Date, data$Time)
data$Date.Time<-strptime(data$Date.Time, format="%d/%m/%Y %H:%M:%S")

##convert Global_active_power variable to numeric classes
data$Global_active_power<-as.numeric(data$Global_active_power)

##open pgn file to save the plot
png(filename="plot1.png", height = 480, width = 480, units = "px")

##generate plot 1: histogram of global active power
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")

dev.off()
