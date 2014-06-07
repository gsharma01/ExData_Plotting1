#It assumes file at current directory

#file name
fileName <- "household_power_consumption.txt"

#Create Column names and their classes
colNames = c("date", "time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
colClasses = c("character", "character", rep("numeric",7) )

#read file
requiredData <- read.table(fileName, header=TRUE, sep=";", col.names=colNames, colClasses=colClasses, na.strings="?")

#convert to Date type, then filter
requiredData$date = as.Date(requiredData$date, format="%d/%m/%Y")
requiredData = requiredData[requiredData$date >= as.Date("2007-02-01") & requiredData$date<=as.Date("2007-02-02"),]


#plot and save graph
png(filename="plot3.png", width=480, height=480, units="px")
with(requiredData, {
    plot(subMetering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
    lines(x=subMetering2, col="red")
    lines(x=subMetering3, col="blue")
    })
axis(1, at=c(1, as.integer(nrow(requiredData)/2), nrow(requiredData)), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()