library(data.table)

inputFile <- "household_power_consumption.txt"

DT <- suppressWarnings(fread(inputFile,header=TRUE, sep=";",na.strings="?",showProgress=FALSE))
DT <- DT[grep("^[12]/2/2007",DT$Date)]
DT[,colnames(DT)[3:9]:=lapply(.SD,as.numeric),.SDcols=3:9]

Sys.setlocale("LC_TIME","English")

png(file="plot2.png",bg="transparent")

with(DT,
     plot(
        strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
        Global_active_power,
        type="l",
        col=rgb(0,0,0,0.7),
        xlab="",
        ylab="Global Active Power (kilowatts)"))


dev.off()
