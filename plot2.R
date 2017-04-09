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

png('plot2.png', width = 480, height = 480)
with(data, plot(Time, Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = ''))
dev.off()
