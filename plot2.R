require(dplyr)
require(lubridate)
#reading data file
hpcDF<- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

#filtering on dates
hpcFilteredDF <- filter(hpcDF, as.Date(Date,"%d/%m/%Y") ==as.Date("1/2/2007","%d/%m/%Y") | 
                          as.Date(Date,"%d/%m/%Y") ==as.Date("2/2/2007","%d/%m/%Y"))

# adding another colume as date time object
hpcFWithDateDF <- mutate(hpcFilteredDF, datetime = parse_date_time(paste(Date,Time),
                                                           "%d/%m/%Y %H:%M:%S"))
#plotting the line
par(mfrow = c(1, 1))
with(hpcFWithDateDF,plot(datetime,
                         as.numeric(levels(Global_active_power))[Global_active_power],
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type="l")
     )

#copying the plot in the file
dev.copy(png,file="plot2.png")
dev.off()
