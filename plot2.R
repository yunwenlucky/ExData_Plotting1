## DOWNLOAD AND IMPORT DATA FROM THE WEBSITE
library(dplyr)
temp <- tempfile() # give a temporary name for the file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url,temp)
dat <- read.table(unz(temp, "household_power_consumption.txt"),
                  sep = ";", header = TRUE, stringsAsFactors = FALSE)
unlink(temp)

## DATA MANAGEMENT
colnames(dat) <- tolower(names(dat))
dat <- tbl_df(dat)
dat2 <- filter(dat, date == "2/2/2007" | date == "1/2/2007")
dat2$date_time <- strptime(paste(dat2$date, dat2$time), "%d/%m/%Y %H:%M:%S")
dat2$date <- as.Date(dat2$date, "%d/%m/%Y")
dat2[,3:9] <- lapply(dat2[,3:9],as.numeric)
dat2 <- rename(dat2, kitchen = sub_metering_1,
               laundry = sub_metering_2, 
               utility = sub_metering_3)

plot(c(0,10),c(0,1200))

## PLOT 2
png("plot2.png", width=400, height=400)
plot(dat2$date_time, dat2$global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()