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



##################################  PLOT 2  #########################################



### convert global active power to numeric

power_work$gap <- as.numeric(as.character(power_work$Global_active_power))



### plot and export to png

plot(power_work$date_time, power_work$gap, 
     type = "l", 
     xlab="",
     ylab = "Global Active Power (kilowatts)") 


dev.copy(png, file = "plot2.png")

dev.off()
