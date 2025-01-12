

#Reads in data from file then subsets data for specified dates
dt <- data.table::fread(input = "./household_power_consumption.txt",na.strings = "?" )

# Convert global activer power to numeric
dt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Concatinate date & time into 1 column so that date can be easily filtered
dt[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter dates for 2007-02-01 and 2007-02-02
dt <- dt[(dateTime >= "2007-02-01")&(dateTime < "2007-02-03")]


png("plot3.png", width = 480, height = 480)

## Plot3


x = dt[[7]] 
y = dt[[8]]
z = dt[[9]]
t = dt[[10]]

plot(t,x, xlab = "",ylab = "Energy-sub metering",type = "l")
lines(t,y, col = "red")
lines(t,z, col = "blue")
legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))

dev.off()

