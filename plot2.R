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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# construct plot 2
par(mfcol = c(1, 1))
plot(x = all.data$time,
    y = as.numeric(as.vector(all.data$globalactivepower)),
    xlab = "", 
    ylab = "Global Acitve Power (kilowatts)",
    type = "l")

# exit png
dev.off()