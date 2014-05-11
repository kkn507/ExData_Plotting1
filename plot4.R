library(data.table)

inputFile <- "household_power_consumption.txt"

DT <- suppressWarnings(fread(inputFile,header=TRUE, sep=";",na.strings="?",showProgress=FALSE))
DT <- DT[grep("^[12]/2/2007",DT$Date)]
DT[,colnames(DT)[3:9]:=lapply(.SD,as.numeric),.SDcols=3:9]

Sys.setlocale("LC_TIME","English")

png(file="plot4.png",bg="transparent")

par(mfrow=c(2,2))
with(DT,
     plot(
       strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
       Global_active_power,
       type="l",
       col=rgb(0,0,0,0.7),
       xlab="",
       ylab="Global Active Power"
    )
)
with(DT,
     plot(
       strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
       Voltage,
       type="l",
       col=rgb(0,0,0,0.7),
       xlab="datetime",
       ylab="Voltage"
    )
)
with(DT,{
  plot(
    strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
    Sub_metering_1,
    type="l",
    col=rgb(0,0,0,0.7),
    xlab="",
    ylab="Energy sub metering"
  );
  lines(
    strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
    Sub_metering_2,
    type="l",
    col="red",
    xlab="",
    ylab="Energy sub metering"
  );
  lines(
    strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
    Sub_metering_3,
    type="l",
    col="blue",
    xlab="",
    ylab="Energy sub metering"
  );
  legend("topright",lwd=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

with(DT,
  plot(
    strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"),
    Global_reactive_power,
    type="l",
    col=rgb(0,0,0,0.7),
    xlab="datetime",
  )
)


dev.off()
