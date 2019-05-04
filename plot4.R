# Plot 4 - Quad Plot

#Strings as factors = false so that you dont have to use as.character() on the parameter to plot before you do as.numeric()
# dec ="." so decimal numbers (such as sub_metering_# come through as characters)
#header=true so you dont have to use names(table) <- c('col1','col2','col3') for a column name list
table <- read.table("./data/household_power_consumption.txt", header=TRUE, stringsAsFactors=FALSE, sep=";", dec=".")

#date_range <- subset(table, table$Date == "1/2/2007" | table$Date == "2/2/2007")
date_range <- table[table$Date %in% c("1/2/2007","2/2/2007") ,]

#combine date with time in a new datetime column
date_range$datetime <- strptime(paste(date_range$Date, date_range$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

with(date_range,{
  plot(date_range$datetime,as.numeric(date_range$Global_active_power),type="l",  xlab="",ylab="Global Active Power")  
  plot(date_range$datetime,as.numeric(date_range$Voltage), type="l",xlab="datetime",ylab="Voltage")
  plot(date_range$datetime,date_range$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(date_range,lines(datetime,as.numeric(Sub_metering_1)))
  with(date_range,lines(datetime,as.numeric(Sub_metering_2),col="red"))
  with(date_range,lines(datetime,as.numeric(Sub_metering_3),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(date_range$datetime,as.numeric(date_range$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()