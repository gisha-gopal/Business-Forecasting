citi14to20 <- read.csv("C:/Users/gisha/Downloads/citi14to20.csv")
View(citi14to20)
citi15to20 <- read.csv("C:/Users/gisha/Downloads/citi15to20.csv")
View(citi15to20)
citi16to20 <- read.csv("C:/Users/gisha/Downloads/citi16to20.csv")
View(citi16to20)

class(citi14to20)
class(citi15to20)
class(citi16to20)

head(citi14to20)

citi14to20$Month <- as.Date(citi14to20$Month,"%d-%B-%Y")
citi15to20$Month <- as.Date(citi15to20$Month,"%d-%B-%Y")
citi16to20$Month <- as.Date(citi16to20$Month,"%d-%B-%Y")

citi14to20.ts <- ts(citi14to20$Trips, start = c(2014,1),end = c(2020,12),frequency = 12)
citi15to20.ts <- ts(citi15to20$Trips, start = c(2015,1),end = c(2020,12),frequency = 12)
citi16to20.ts <- ts(citi16to20$Trips, start = c(2016,1),end = c(2020,12),frequency = 12)

citi14to20.ts
citi15to20.ts
citi16to20.ts

summary(citi14to20.ts)
summary(citi15to20.ts)
summary(citi16to20.ts)

boxplot(citi14to20.ts)
boxplot(citi15to20.ts)
boxplot(citi16to20.ts)

str(citi16to20.month)

ggplot(citi16to20.month,aes(x=Month,y=Trips))+geom_boxplot()+scale_x_discrete(limits = month.abb)
ggplot(citi15to20.month,aes(x=Month,y=Trips))+geom_boxplot()+scale_x_discrete(limits = month.abb)
ggplot(citi16to20.month,aes(x=Month,y=Trips))+geom_boxplot()+scale_x_discrete(limits = month.abb)

citi14to20.fit <- stl(citi14to20.ts, s.window = "periodic")
citi15to20.fit <- stl(citi15to20.ts, s.window = "periodic")
citi16to20.fit <- stl(citi16to20.ts, s.window = "periodic")

plot(citi14to20.fit)
plot(citi15to20.fit)
plot(citi16to20.fit)

citi14to20.dcmp <- decompose(citi14to20.ts)
citi15to20.dcmp <- decompose(citi15to20.ts)
citi16to20.dcmp <- decompose(citi16to20.ts)

plot(citi14to20.dcmp)
plot(citi15to20.dcmp)
plot(citi16to20.dcmp)

library(forecast)

citi14to20.seas_adj <- seasadj(citi14to20.fit)
citi15to20.seas_adj <- seasadj(citi15to20.fit)
citi16to20.seas_adj <- seasadj(citi16to20.fit)

plot(citi14to20.seas_adj)
plot(citi15to20.seas_adj)
plot(citi16to20.seas_adj)

plot(citi14to20.ts)
lines(citi14to20.seas_adj,col="Red")
plot(citi15to20.ts)
lines(citi15to20.seas_adj,col="Red")
plot(citi16to20.ts)
lines(citi16to20.seas_adj,col="Red")

citi14to20.acf <- acf(citi14to20.ts, type = "correlation")
citi15to20.acf <- acf(citi15to20.ts, type = "correlation")
citi16to20.acf <- acf(citi16to20.ts, type = "correlation")

citi14to20.meanf <- meanf(citi14to20.ts, h=12)
citi15to20.meanf <- meanf(citi15to20.ts, h=12)
citi16to20.meanf <- meanf(citi16to20.ts, h=12)

plot(citi14to20.meanf)
plot(citi15to20.meanf)
plot(citi16to20.meanf)

citi14to20.acc.meanf <- accuracy(citi14to20.meanf)
citi15to20.acc.meanf <- accuracy(citi15to20.meanf)
citi16to20.acc.meanf <- accuracy(citi16to20.meanf)

citi14to20.acc.meanf
citi15to20.acc.meanf
citi16to20.acc.meanf

citi14to20.naive <- naive(citi14to20.ts, h=12)
citi15to20.naive <- naive(citi15to20.ts, h=12)
citi16to20.naive <- naive(citi16to20.ts, h=12)

plot(citi14to20.naive)
plot(citi15to20.naive)
plot(citi16to20.naive)

plot(citi14to20.naive$residuals)
ggplot(citi14to20.ts,aes(x=citi14to20.naive$fitted,y=citi14to20.naive$residuals))+geom_point()
acf(citi14to20.naive$residuals)

citi14to20.acc.naive <- accuracy(citi14to20.naive)
citi15to20.acc.naive <- accuracy(citi15to20.naive)
citi16to20.acc.naive <- accuracy(citi16to20.naive)

citi14to20.acc.naive
citi15to20.acc.naive
citi16to20.acc.naive

citi14to20.snaive <- snaive(citi14to20.ts, h=12)
citi15to20.snaive <- snaive(citi15to20.ts, h=12)
citi16to20.snaive <- snaive(citi16to20.ts, h=12)

plot(citi14to20.snaive)
plot(citi15to20.snaive)
plot(citi16to20.snaive)

citi14to20.acc.snaive <- accuracy(citi14to20.snaive)
citi15to20.acc.snaive <- accuracy(citi15to20.snaive)
citi16to20.acc.snaive <- accuracy(citi16to20.snaive)

citi14to20.acc.snaive
citi15to20.acc.snaive
citi16to20.acc.snaive

citi14to20.rwf <- rwf(citi14to20.ts,h=12)
citi15to20.rwf <- rwf(citi15to20.ts,h=12)
citi16to20.rwf <- rwf(citi16to20.ts,h=12)

plot(citi14to20.rwf)
plot(citi15to20.rwf)
plot(citi16to20.rwf)

gghistogram(citi14to20.rwf$residuals)
gghistogram(citi15to20.rwf$residuals)
gghistogram(citi16to20.rwf$residuals)

citi14to20.acc.rwf <- accuracy(citi14to20.rwf)
citi15to20.acc.rwf <- accuracy(citi15to20.rwf)
citi16to20.acc.rwf <- accuracy(citi16to20.rwf)

citi14to20.acc.rwf
citi15to20.acc.rwf
citi16to20.acc.rwf

forecast(citi14to20.rwf)

citi14to20.ma3 <- ma(citi14to20.ts,order = 3)
citi14to20.ma6 <- ma(citi14to20.ts,order = 6)
citi14to20.ma12 <- ma(citi14to20.ts,order = 12)

citi15to20.ma3 <- ma(citi15to20.ts,order = 3)
citi15to20.ma6 <- ma(citi15to20.ts,order = 6)
citi15to20.ma12 <- ma(citi15to20.ts,order = 12)

citi16to20.ma3 <- ma(citi16to20.ts,order = 3)
citi16to20.ma6 <- ma(citi16to20.ts,order = 6)
citi16to20.ma12 <- ma(citi16to20.ts,order = 12)

plot(citi14to20.ts)
lines(citi14to20.ma3,col="red")
lines(citi14to20.ma6,col="blue")
lines(citi14to20.ma12,col="gold")

plot(citi15to20.ts)
lines(citi15to20.ma3,col="red")
lines(citi15to20.ma6,col="blue")
lines(citi15to20.ma12,col="green")

plot(citi16to20.ts)
lines(citi16to20.ma3,col="red")
lines(citi16to20.ma6,col="blue")
lines(citi16to20.ma12,col="green")

forecast(citi14to20.ma3)

plot(forecast(citi14to20.ma3, h=12))
plot(forecast(citi14to20.ma3))

citi14to20.acc.ma3 <- accuracy(forecast(citi14to20.ma3,h=12))
citi15to20.acc.ma3 <- accuracy(forecast(citi15to20.ma3,h=12))
citi16to20.acc.ma3 <- accuracy(forecast(citi16to20.ma3,h=12))

citi14to20.acc.ma6 <- accuracy(forecast(citi14to20.ma6,h=12))
citi15to20.acc.ma6 <- accuracy(forecast(citi15to20.ma6,h=12))
citi16to20.acc.ma6 <- accuracy(forecast(citi16to20.ma6,h=12))

citi14to20.acc.ma12 <- accuracy(forecast(citi14to20.ma12,h=12))
citi15to20.acc.ma12 <- accuracy(forecast(citi15to20.ma12,h=12))
citi16to20.acc.ma12 <- accuracy(forecast(citi16to20.ma12,h=12))

citi14to20.acc.ma3
citi14to20.acc.ma6
citi14to20.acc.ma12

citi15to20.acc.ma3
citi15to20.acc.ma6
citi15to20.acc.ma12

citi16to20.acc.ma3
citi16to20.acc.ma6
citi16to20.acc.ma12

citi14to20.ets <- ets(citi14to20.ts)
citi15to20.ets <- ets(citi15to20.ts)
citi16to20.ets <- ets(citi16to20.ts)

plot(citi14to20.ets)
plot(citi15to20.ets)
plot(citi16to20.ets)

citi14to20.acc.ets <- accuracy(citi14to20.ets)
citi15to20.acc.ets <- accuracy(citi15to20.ets)
citi16to20.acc.ets <- accuracy(citi16to20.ets)

citi14to20.acc.ets
citi15to20.acc.ets
citi16to20.acc.ets

citi14to20.hw <- HoltWinters(citi14to20.ts)
citi15to20.hw <- HoltWinters(citi15to20.ts)
citi16to20.hw <- HoltWinters(citi16to20.ts)

plot(citi14to20.hw)
plot(citi15to20.hw)
plot(citi16to20.hw)

citi14to20.acc.hw <- accuracy(forecast(citi14to20.hw,h=12))
citi15to20.acc.hw <- accuracy(forecast(citi15to20.hw,h=12))
citi16to20.acc.hw <- accuracy(forecast(citi16to20.hw,h=12))

citi14to20.acc.hw
citi15to20.acc.hw
citi16to20.acc.hw
                           
                          