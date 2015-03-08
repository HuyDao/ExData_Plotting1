#Download zip file if text data does not exist on current folder
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
alldata <- read.table(file, header=T, sep=";", na.strings = "?")
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")
subdata <- subset(alldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
subdata$DateTime <- as.POSIXct(paste(subdata$Date, subdata$Time) ) 
subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage))
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))

plot1 <- function() {
  png(file="Plot1.png",width=480, height=480)
  hist(subdata$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.off()
}
plot1()
