
# Plot the Global Active Power for the 2-day period 2007-02-01 through 2007-02-02
#

install.packages('data.table', repos = 'http://cran.r-project.org') ## Use data.table for high-performance
library(data.table)

household.data <- suppressWarnings(fread("household_power_consumption.txt", 
                                         header = TRUE, sep = ";",  na.strings=c("?"),
                                         stringsAsFactors = FALSE, verbose = FALSE))

## Once imported, extact the required fields and store in a data.frame

household.df <- as.data.frame(subset(household.data, Date == "1/2/2007" | Date == "2/2/2007", 
                            c(Date, Time, Global_active_power)), stringAsFactor = FALSE)

## create a new column, combining the Date and Time and convert it
household.df$DateTime <- strptime( paste(household.df$Date, household.df$Time), format = "%d/%m/%Y %H:%M:%S")

household.df$Global_active_power <- as.numeric(household.df$Global_active_power)

png(filename = "plot2.png", width = 480, height = 480, units = "px")  ## Open PNG device

plot(household.df$DateTime,
     household.df$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type = "l")


dev.off() ## close the PNG file device
