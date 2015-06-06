require(dplyr)

#reading data file
hpcDF<- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

#filtering on dates
hpcFilteredDF <- filter(hpcDF, as.Date(Date,"%d/%m/%Y") ==as.Date("1/2/2007","%d/%m/%Y") | 
                          as.Date(Date,"%d/%m/%Y") ==as.Date("2/2/2007","%d/%m/%Y"))

#ploting histogram
par(mfrow = c(1, 1))
hist(as.numeric(levels(hpcFilteredDF$Global_active_power))[hpcFilteredDF$Global_active_power], 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power",
     col = "red")

#copying plot to png file
dev.copy(png,file="plot1.png")
dev.off()
