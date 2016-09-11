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

#Save plot as plot1.png.
png(file="plot1.png",width = 480, height = 480)

#Produce histogram and modify appropriately.
hist(electric$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")

dev.off()