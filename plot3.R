
# Plot the Sub metering 1,2 and 3 for the 2-day period 2007-02-01 through 2007-02-02
#

install.packages('data.table', repos = 'http://cran.r-project.org') ## Use data.table for high-performance
library(data.table)

household.data <- suppressWarnings(fread("household_power_consumption.txt", 
                                         header = TRUE, sep = ";",  na.strings=c("?"),
                                         stringsAsFactors = FALSE, verbose = FALSE))

## Once imported, extact the required fields and store in a data.frame

household.df <- as.data.frame(subset(household.data, Date == "1/2/2007" | Date == "2/2/2007", 
                            c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)),
                            stringAsFactor = FALSE)

## create a new column, combining the Date and Time and convert it
household.df$DateTime <- strptime( paste(household.df$Date, household.df$Time), format = "%d/%m/%Y %H:%M:%S")

household.df$Sub_metering_1 <- as.numeric(household.df$Sub_metering_1)
household.df$Sub_metering_2 <- as.numeric(household.df$Sub_metering_2)
household.df$Sub_metering_3 <- as.numeric(household.df$Sub_metering_3)


png(filename = "plot3.png", width = 480, height = 480, units = "px")  ## Open PNG device

plot(household.df$DateTime,
     household.df$Sub_metering_1,
     ylab = "Energy sub metering",
     xlab = "",
     type = "l",
     col = "black")

lines(household.df$DateTime,
     household.df$Sub_metering_2,
     ylab = "",
     xlab = "",
     type = "l",
     col = "red")

lines(household.df$DateTime,
     household.df$Sub_metering_3,
     ylab = "",
     xlab = "",
     type = "l",
     col = "blue")

legend("topright", 
       lty = c(1,1,1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

dev.off() ## close the PNG file device
