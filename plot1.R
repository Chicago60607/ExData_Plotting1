#Plot1.R

# check for data directory

if(!file.exists("data")) { 
  dir.create("data")
}

# Download the file 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 

fileURL <- 
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./data/household_power_consumption.zip")

# unzip it in the folder "data"
unzip("./data/household_power_consumption.zip", exdir="./data")
powerconsumptionfile <- "./data/household_power_consumption.txt"

#Data frame format
#pcfdataframe <- data.frame(
#  Date = date(), y = character())

# Read line by line to only load in a data frame dates 2007-02-01 and 2007-02-02
# Create the connection
con  <- file(powerconsumptionfile, open = "r")
# linecount to skip first line
linecount <- 0
reccount <- 0
while ( length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0 ){
  linecount <- linecount + 1
#skip first line (labels)  
  if(linecount==1) {
      #Initialize Vectors      
      pcfDateStr <- vector('character')
      pcfTimeStr <- vector('character')
      pcfglobal_active_power <- vector('numeric')
      pcfglobal_reactive_power <- vector('numeric')
      pcfvoltage <- vector('numeric')
      pcfglobal_intensity <- vector('numeric')
      pcfsub_metering_1 <- vector('numeric')
      pcfsub_metering_2 <- vector('numeric')
      pcfsub_metering_3 <- vector('numeric')
    }
  else {
    lineVector <- unlist(strsplit(oneLine,";"))
#Only for dates 2007-02-01 and 2007-02-02, but in file they are in DD/MM/YYYY format
    if( lineVector[1] == "1/2/2007" || lineVector[1] == "2/2/2007") {

      reccount = reccount + 1
      pcfDateStr[reccount] <- lineVector[1]
      pcfTimeStr[reccount] <- lineVector[2]
      pcfglobal_active_power[reccount] <- as.numeric(lineVector[3])
      pcfglobal_reactive_power[reccount] <- as.numeric(lineVector[4])
      pcfvoltage[reccount] <- as.numeric(lineVector[5])
      pcfglobal_intensity[reccount] <- as.numeric(lineVector[6])
      pcfsub_metering_1[reccount] <- as.numeric(lineVector[7])
      pcfsub_metering_2[reccount] <- as.numeric(lineVector[8])
      pcfsub_metering_3[reccount] <- as.numeric(lineVector[9])   
      
    }

  }

}
close(con)

#PLOT 1
png("plot1.png",width=480,height=480,units="px")
hist(pcfglobal_active_power,
     col='red',
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()