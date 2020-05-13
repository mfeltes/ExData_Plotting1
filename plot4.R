# load important packages
library(dplyr)
library(lubridate)

# read the data
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataURL, "./data"); rm(dataURL)
unzip("./data")
all.data <- read.table("./household_power_consumption.txt", head = TRUE, sep = ";") %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(time = dmy_hms(paste(Date, Time))) %>%
    select(time, Global_active_power:Sub_metering_3)

header <- names(all.data) %>%
    tolower() %>%
    gsub(pattern = "_", replacement = "")
colnames(all.data) <- header; rm(header)

# open png
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# set up plot
par(mfcol = c(2, 2))

# upper left, plot 2
plot(x = all.data$time,
     y = as.numeric(as.vector(all.data$globalactivepower)),
     xlab = "", 
     ylab = "Global Acitve Power",
     type = "l")

# lower left, plot 3
plot(all.data$time,
     as.numeric(as.vector(all.data$submetering1)),
     xlab = "", 
     ylab = "Energy sub metering",
     type = "l")

    points(all.data$time,
           as.numeric(as.vector(all.data$submetering2)),
           col = "red",
           type = "l")
    
    points(all.data$time,
           as.numeric(as.vector(all.data$submetering3)),
           col = "blue",
           type = "l")
    
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"), 
           lwd = 2)

# upper right, plot 4A
plot(all.data$time,
     as.numeric(as.vector(all.data$voltage)),
     xlab = "datetime", 
     ylab = "Voltage",
     type = "l")

# lower right, plot 4B
plot(all.data$time,
     as.numeric(as.vector(all.data$globalreactivepower)),
     xlab = "datetime", 
     ylab = "Gobal_reactive_power",
     type = "l")

# exit png
dev.off()