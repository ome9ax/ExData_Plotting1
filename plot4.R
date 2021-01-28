# Get dataset
file_name <- 'household_power_consumption'
zip_file <- paste0(file_name, '.zip')
if(!file.exists(zip_file))
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', zip_file)

# Read the data file and filter the dates
data <- subset(read.table(unz(zip_file, paste0(file_name, '.txt')), sep = ';', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, na.strings = c('?', 'NA', '')), Date %in% c('1/2/2007', '2/2/2007'))
data$Time <- strptime(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S') # convert into datetime
data$Date <- as.Date(data$Date, format = '%d/%m/%Y') # convert into date
data[, 3:9] <- apply(data[, 3:9], 2, function(x) as.numeric(x)) # convert into numeric

old.par <- par() # mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1), oma = c(0, 0, 0, 0)
png('plot4.png', width = 480, height = 480, units = 'px')
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

with(data, {
    plot(Time, Global_active_power, type = 'l', ylab = 'Global Active Power', xlab = '')

    plot(Time, Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab = '')
    lines(Time, Sub_metering_2, col = 'red')
    lines(Time, Sub_metering_3, col = 'blue')
    legend('topright', lwd = 2.5, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), bty = 'n')

    plot(Time, Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')

    plot(Time, Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')
})

dev.off()
par(old.par)

# remove zip file
if(file.exists(zip_file))
    file.remove(zip_file)
