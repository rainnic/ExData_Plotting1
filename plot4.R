## Read and create a data frame from household_power_consumption.txt file
powerConsumption = read.table("household_power_consumption.txt", header=T, sep=";",
                              na.strings="?", stringsAsFactors=F)

## Change the format for the date
powerConsumption$Date <- as.Date(powerConsumption$Date,format="%d/%m/%Y")

## Subset data in 2007/02/01 and 2007/02/02
data = powerConsumption[powerConsumption$Date>='2007/02/01' 
                        & powerConsumption$Date <='2007/02/02',]

## Convert the Date and Time variables to Date/Time classes in R
data$Timestamp = format(as.POSIXct(paste(data$Date, data$Time)), "%d/%m/%Y %H:%M:%S")
data$Timestamp <- strptime(data$Timestamp,"%d/%m/%Y %H:%M:%S") 

## Construct plot 4
png(file="plot4.png", width = 480, height = 480)

## Set the layout in 2 rows and 2 columns
par(mfrow = c(2,2))

## First
plot(data$Timestamp, data$Global_active_power, type="l",
     xlab = "", ylab="Global Active Power")

## Second
plot(data$Timestamp, data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

## Third
plot(data$Timestamp, data$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
points(data$Timestamp, data$Sub_metering_2, type="l", col="red")
points(data$Timestamp, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=c(1,1,1), bty="n")

## Fourth
plot(data$Timestamp, data$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

## Save file
dev.off()