############################  READ THE DATA AND FORMAT DATES  ##################################



### read in data

# first five rows only to get variable classes

tab5rows <- read.table("./household_power_consumption.txt",
                       header = TRUE,
                       sep = ";", 
                       nrows = 5)

classes <- sapply(tab5rows, class)
classes

# full file

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



##################################  PLOT 3  #########################################



### convert variables to numeric

power_work$Sub_metering_1 <- as.numeric(as.character(power_work$Sub_metering_1))

power_work$Sub_metering_2 <- as.numeric(as.character(power_work$Sub_metering_2))

power_work$Sub_metering_3 <- as.numeric(as.character(power_work$Sub_metering_3))



### plot and expot to png:  first plot Sub_metering_1,
    # then overlay with the other 2 and the legend

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
       lty = 1)

dev.copy(png, file = "plot3.png")

dev.off()

