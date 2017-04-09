# Get dataset
file_name <- 'household_power_consumption'
zip_file <- paste0(file_name, '.zip')
if(!file.exists(zip_file))
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', zip_file)

# Read the data file and filter the dates
data <- subset(read.table(unz(zip_file, paste0(file_name, '.txt')), sep = ';', header = TRUE, stringsAsFactors = FALSE, strip.white = TRUE, na.strings = '?'), Date %in% c('1/2/2007', '2/2/2007'))
data$Time <- strptime(paste0(data$Date, data$Time), format = '%d/%m/%Y%H:%M:%S') # convert into datetime
data$Date <- as.Date(data$Date, format = '%d/%m/%Y') # convert into date
data[, 3:9] <- apply(data[, 3:9], 2, function(x) as.numeric(x)) # convert into numeric

png('plot3.png', width = 480, height = 480)
with(data, plot(Time, Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab = ''))
with(data, points(Time, Sub_metering_2, type = 'l', col = 'red'))
with(data, points(Time, Sub_metering_3, type = 'l', col = 'blue'))
legend('topright', lwd = rep(2.5, 3), col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()
