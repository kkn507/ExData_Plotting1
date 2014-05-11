library(data.table)

inputFile <- "household_power_consumption.txt"

DT <- suppressWarnings(fread(inputFile,header=TRUE, sep=";",na.strings="?"))
DT <- DT[grep("^[12]/2/2007",DT$Date)]
DT[,colnames(DT)[3:9]:=lapply(.SD,as.numeric),.SDcols=3:9]

png(file="plot1.png")

with(DT,hist(Global_active_power,
             xlab="Global Active Power (kilowatts)",
             col="orange",
             main="Global Active Power"
       )
)

dev.off()
