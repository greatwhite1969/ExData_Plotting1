############################  READ THE DATA AND FORMAT DATES  ##################################



### read in data

# first five rows only to get variable classes

tab5rows <- read.table("./household_power_consumption.txt",
                       header = TRUE,
                       sep = ";", 
                       nrows = 5)

classes <- sapply(tab5rows, class)
classes

power <- read.table("./household_power_consumption.txt",
                    comment.char = "",
                    header = TRUE,
                    sep = ";")

str(power)



### convert date and time from factors to strings then to R date & time class

date_char <- as.character(power$Date)

time_char <- as.character(power$Time)

data_time_char <- paste(date_char,time_char)

power$date_time <- strptime(data_time_char, "%d/%m/%Y %H:%M:%S")

power$date_new <- as.Date(date_char, "%d/%m/%Y")



###  subset for only 2007-02-01 and 2007-02-02

power_work <- power[(power$date_new == "2007-02-01"| power$date_new == "2007-02-02"),]



##################################  PLOT 4  #########################################



### convert variables to numeric

power_work$gap <- as.numeric(as.character(power_work$Global_active_power))

power_work$volt <- as.numeric(as.character(power_work$Voltage))

power_work$Sub_metering_1 <- as.numeric(as.character(power_work$Sub_metering_1))

power_work$Sub_metering_2 <- as.numeric(as.character(power_work$Sub_metering_2))

power_work$Sub_metering_3 <- as.numeric(as.character(power_work$Sub_metering_3))

power_work$grap <- as.numeric(as.character(power_work$Global_reactive_power))



### plot

# set matrix

par(mfrow = c(2, 2))

# four graphs

with(power_work, {
     plot(power_work$date_time, power_work$gap, 
          type = "l", 
          xlab="",
          ylab = "Global Active Power")
     plot(power_work$date_time, power_work$volt, 
          type = "l", 
          xlab="datetime",
          ylab = "Voltage")
     plot(power_work$date_time, power_work$Sub_metering_1, 
          type = "l", 
          xlab="",
          ylab = "Energy sub metering")      
     lines(power_work$date_time, power_work$Sub_metering_2, 
           type = "l", 
           col = "red")     
     lines(power_work$date_time, power_work$Sub_metering_3, 
           type = "l", 
           col = "blue")     
     legend("topright", 
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            col = c("black", "red", "blue"), 
            y.intersp = .25,
            x.intersp = .5,
            lty = 1,
            bty = "n",
            cex = .5)
     plot(power_work$date_time, power_work$grap, 
          type = "l", 
          xlab="datetime",
          yaxt = "n",
          ylab = "Global_reactive_power")
     axis(side = 2, 
          cex.axis = .85) 
})

dev.copy(png, file = "plot4.png")

dev.off()
