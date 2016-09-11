#Check if data exists; download if not.
filename <- ".electric_data.zip"

if (!file.exists(filename)) {
  fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,filename)
}

#Load data into R and modify to prepare for analysis and plotting.
electric <- read.table(unz(filename,"household_power_consumption.txt"),header = TRUE, sep=";")
electric$Time <- paste(electric$Date,electric$Time,sep=" ")
electric$Date <- as.Date(electric$Date,format = "%d/%m/%Y")
electric$Time <- strptime(electric$Time,format = "%d/%m/%Y %H:%M:%S")
electric <- subset(electric,Date == "2007-02-01" | Date == "2007-02-02")
electric$Global_active_power <- as.numeric(as.character(electric$Global_active_power))
electric$Sub_metering_1 <- as.numeric(as.character(electric$Sub_metering_1))
electric$Sub_metering_2 <- as.numeric(as.character(electric$Sub_metering_2))
electric$Sub_metering_3 <- as.numeric(as.character(electric$Sub_metering_3))
electric$Voltage <- as.numeric(as.character(electric$Voltage))
electric$Global_reactive_power <- as.numeric(as.character(electric$Global_reactive_power))

#Save plot as plot4.png.
png(file="plot4.png",width = 480, height = 480)

#Create 2 x 2 panel space for plots.
par(mfcol=c(2,2))

#Produce first plot.
plot(electric$Time,electric$Global_active_power,"l",ylab="Global Active Power (kilowatts)",xlab = "")

#Produce second plot.
plot(electric$Time,electric$Sub_metering_1,"l",ylab="Energy sub metering",xlab = "",col="black")
lines(electric$Time,electric$Sub_metering_2,col="red")
lines(electric$Time,electric$Sub_metering_3,col="blue")

#Add a legend to mirror example.
legend("topright",lty=1, col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Produce third plot.
plot(electric$Time,electric$Voltage,"l",ylab="Voltage",xlab = "datetime")

#Produce fourth plot.
plot(electric$Time,electric$Global_reactive_power,"l",ylab="Global_reactive_power",xlab = "datetime")

dev.off()