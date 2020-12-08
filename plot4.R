###This code produce the plot 4 from Course project 1 of Exploratory Data Analysis Course

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

##convert variables to numeric classes
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Voltage<-as.numeric(data$Voltage)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)


##open pgn file to save the plot
png(filename="plot4.png", height = 480, width = 480, units = "px")

#2 rows, 2 columns layout for plotting
par(mfrow = c(2,2))

##generate plot 4.1: time series of global active power
plot(data$Date.Time,data$Global_active_power, xlab = "", xaxt="n", type='l',
     ylab = "Global Active Power")

#create x-axis
x.axis.datetime<-seq.Date(as.Date(data$Date.Time[1]), as.Date(data$Date.Time[nrow(data)])+1, by ="days")
axis.POSIXct(side=1, at=x.axis.datetime, format="%a")

axis.POSIXct(side=1, at=x.axis.datetime, format="%a")


##generate plot 4.2: time series of voltage
plot(data$Date.Time, data$Voltage, xlab = "datetime", ylab = "Voltage", xaxt = "n", type = "l")
axis.POSIXct(side=1, at=x.axis.datetime, format="%a")


##generate plot 4.3: time series of energy sub metering
plot(data$Date.Time,data$Sub_metering_1, xlab = "", xaxt="n", type='l',
     ylab = "Energy sub metering")
lines(data$Date.Time, data$Sub_metering_2, col = 'red')
lines(data$Date.Time, data$Sub_metering_3, col = 'blue')
axis.POSIXct(side=1, at=x.axis.datetime, format="%a")

#add legend
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1)


##generate plot 4.4: time series of Global reactive power
plot(data$Date.Time, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
     xaxt = "n", type = "l")
axis.POSIXct(side=1, at=x.axis.datetime, format="%a")


dev.off()

