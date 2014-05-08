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

## Construct plot 2
png(file="plot2.png", width = 480, height = 480)

plot(data$Timestamp, data$Global_active_power, type="l", xlab = "",
     ylab="Global Active Power (kilowatts)")

## Save file
dev.off()