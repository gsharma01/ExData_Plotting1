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
png(filename="plot2.png", width=480, height=480, units="px")
plot(requiredData$globalActivePower, type="l",xaxt="n",xlab="", ylab="Global Active Power (kilowatts)")
axis(1, at=c(1, as.integer(nrow(requiredData)/2), nrow(requiredData)), labels=c("Thu", "Fri", "Sat"))
dev.off()