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
par(mfrow = c(2, 2))
par(mar=c(4,4,1,1))
with(hpcFWithDateDF,plot(datetime,
                         as.numeric(levels(Global_active_power))[Global_active_power],
                         ylab="Global Active Power",
                         xlab="",
                         type="l")
)

with(hpcFWithDateDF,plot(datetime,
                         as.numeric(levels(Voltage))[Voltage],
                         ylab="Voltage",
                         xlab="datetime",
                         type="l")
)

with(hpcFWithDateDF,{plot(datetime,
                          as.numeric(levels(Sub_metering_1))[Sub_metering_1],
                          ylab="Energy sub metering",
                          xlab="",
                          type="l")
                     #plotting for Sub_metering_3
                     lines(datetime,as.numeric(levels(Sub_metering_2))[Sub_metering_2],col="red")
                     #plotting for Sub_metering_3
                     lines(datetime,Sub_metering_3,col="blue")
                     #annotating with legends
                     recordGraphics(legend("topright",
                                           legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                                           lty=1,
                                           col=c("black","red","blue"),
                                           cex=0.5,bty="n"
                     ),list(), getNamespace("graphics"))                      
                }
            )

with(hpcFWithDateDF,plot(datetime,
                         as.numeric(levels(Global_reactive_power))[Global_reactive_power],
                         ylab="Global_reactive_power",
                         xlab="datetime",
                         type="l")
)

#copying the plot in the file
dev.copy(png,file="plot4.png")
dev.off()

