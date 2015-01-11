# preparing dataset
if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="pwr.zip", method="curl")
  unzip("pwr.zip")
}

pw.t <- read.table("household_power_consumption.txt", header=T, sep=";", quote="", na.strings="?", stringsAsFactors=F, nrow=200)
col.n <- sapply(pw.t, class)
pw <- read.table("household_power_consumption.txt", header=T, sep=";", quote="", na.strings="?", stringsAsFactors=F, colClasses=col.n)
pw.sub <- pw[(pw$Date=="1/2/2007" | pw$Date=="2/2/2007"),]

# create variable "ttime" incorporating Date + Time and add to data.frame as new column
ttime <- strptime(paste(pw.sub$Date, pw.sub$Time, sep=" "), format="%d/%m/%Y %T")
pw.sub$TTime <- ttime

# begin plotting - plot4
png(file="./plots/plot4.png", width=480, height=480, units="px")
par(mfcol=c(2,2))
#1
plot(x=pw.sub$TTime, y=pw.sub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
#2
plot(x=pw.sub$TTime, y=pw.sub$Sub_metering_1, type="l", col="black", ylab="Energy Sub-metering", xlab="")
lines(x=pw.sub$TTime, y=pw.sub$Sub_metering_2, col="red")
lines(x=pw.sub$TTime, y=pw.sub$Sub_metering_3, col="blue")
legend("topright", lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"), bty="n")
#3
plot(x=pw.sub$TTime, y=pw.sub$Voltage, type="l", ylab="Voltage", xlab="datetime")
#4
plot(x=pw.sub$TTime, y=pw.sub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
