###This code produce the plot 3 from Course project 1 of Exploratory Data Analysis Course

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

##convert sub_metering variables to numeric classes
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)

##open pgn file to save the plot
png(filename="plot3.png", height = 480, width = 480, units = "px")

##generate plot 3: time series of energy submetering
plot(data$Date.Time,data$Sub_metering_1, xlab = "", xaxt="n", type='l',
     ylab = "Energy sub metering")
lines(data$Date.Time, data$Sub_metering_2, col = 'red')
lines(data$Date.Time, data$Sub_metering_3, col = 'blue')

#create x-axis
x.axis.datetime<-seq.Date(as.Date(data$Date.Time[1]), as.Date(data$Date.Time[nrow(data)])+1, by ="days")
axis.POSIXct(side=1, at=x.axis.datetime, format="%a")

#add legend
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1)

dev.off()

