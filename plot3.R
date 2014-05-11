library(data.table)

inputFile <- "household_power_consumption.txt"

DT <- suppressWarnings(fread(inputFile,header=TRUE, sep=";",na.strings="?",showProgress=FALSE))
DT <- DT[grep("^[12]/2/2007",DT$Date)]
DT[,colnames(DT)[3:9]:=lapply(.SD,as.numeric),.SDcols=3:9]

Sys.setlocale("LC_TIME","English")

png(file="plot3.png",bg="transparent")

with(DT,{
     plot(
       strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
       Sub_metering_1,
       type="l",
       xlab="",
       ylab="Energy sub metering");
     lines(
       strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
       Sub_metering_2,
       type="l",
       col="red",
       xlab="",
       ylab="Energy sub metering");
     lines(
       strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
       Sub_metering_3,
       type="l",
       col="blue",
       xlab="",
       ylab="Energy sub metering")
     }
)

legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#dev.copy(png,file="plot3.png")
dev.off()
