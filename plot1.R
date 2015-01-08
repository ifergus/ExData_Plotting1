
# Plot Histogram of Global Active Power for the 2-day period 2007-02-01 through 2007-02-02
#

install.packages('data.table', repos = 'http://cran.r-project.org') ## Use data.table for high-performance
library(data.table)

household.data <- suppressWarnings(fread("household_power_consumption.txt",
                                         header = TRUE, sep = ";",  na.strings=c("?"),
                                         stringsAsFactors = FALSE, verbose = FALSE))

dt <- subset(household.data, Date == "1/2/2007" | Date == "2/2/2007")

dt$Global_active_power <- as.numeric(dt$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480, units ="px") ## Open PNG device

hist(dt$Global_active_power,
     col  = "red",  
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0,1200))

dev.off() ## close the PNG file device


