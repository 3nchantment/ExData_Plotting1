# Plot 2 - # Plot 2 - Global Active Power vs Time

#Strings as factors = false so that you dont have to use as.character() on the parameter to plot before you do as.numeric()
# dec ="." so decimal numbers (such as sub_metering_# come through as characters)
#header=true so you dont have to use names(table) <- c('col1','col2','col3') for a column name list
table <- read.table("./data/household_power_consumption.txt", header=TRUE, stringsAsFactors=FALSE, sep=";",dec=".")

#date_range <- subset(table, table$Date == "1/2/2007" | table$Date == "2/2/2007")
date_range <- table[table$Date %in% c("1/2/2007","2/2/2007") ,]

#combine date with time in a new datetime column
date_range$datetime <- strptime(paste(date_range$Date, date_range$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot2.png", width=480, height=480)

# You must do as.numeric first because global active power is still a string even though it's not a factor
plot(date_range$datetime, as.numeric(date_range$Global_active_power),type="l",xlab="",ylab="Global Active Power (kilowatts)")
title(main="Global Active Power vs DateTime")
dev.off()