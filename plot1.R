
setwd()

### description of data

# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption 


### zip file with data for project

# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 



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



##################################  PLOT 1  #########################################



### convert global active power to numeric

power_work$gap <- as.numeric(as.character(power_work$Global_active_power))



### plot and export to png

png(file = "plot1.png", width = 480, height = 480)

hist(power_work$gap, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# dev.copy(png, width = 480, height = 480, file = "plot1.png")

dev.off()

