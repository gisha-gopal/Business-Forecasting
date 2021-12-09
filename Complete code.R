## CITI BIKE TRIPS
View(citi_bike)
class(citi_bike)
head(citi_bike)

citi_bike$Month <- as.Date(citi_bike$Month,"%d-%B-%Y")
citi_bike.ts <- ts(citi_bike$Trips, start = c(2016,1),end = c(2021,5),frequency = 12)
summary(citi_bike)

#STL
citi_bike.fit <- stl(citi_bike.ts, s.window = "periodic")
plot(citi_bike.fit)

#DECOMPOSITION
citi_bike.dcmp <- decompose(citi_bike.ts)
plot(citi_bike.dcmp)

#SEASONAL ADJUSTMENT
library(forecast)
citi_bike.seas_adj <- seasadj(citi_bike.fit)
plot(citi_bike.seas_adj)

#TIME SERIES PLOT
plot(citi_bike.ts)
lines(citi_bike.seas_adj,col="Red")

#acf
citi_bike.acf <- acf(citi_bike.ts, type = "correlation")

#MEAN FORECAST
citi_bike.meanf <- meanf(citi_bike.ts, h=7)
plot(citi_bike.mean.forecast)
plot(citi_bike.meanf$residuals)
hist(citi_bike.meanf$residuals,  xlab = "residuals", main = "Histogram of Mean forecasting Residuals")
Acf(citi_bike.meanf$residuals, main = "ACF OF Mean Forecasting")
citi_bike.acc.meanf <- accuracy(citi_bike.meanf)
citi_bike.mean.forecast <- forecast(citi_bike.meanf,h=7)

#NAIVE
citi_bike.naive <- naive(citi_bike.ts, h=7)
plot(citi_bike.naive.forecast)
plot(citi_bike.naive$residuals)
hist(citi_bike.naive$residuals,  xlab = "residuals", main = "Histogram of Naive forecasting Residuals")
Acf(citi_bike.naive$residuals, main = "ACF OF Naive Forecasting")
citi_bike.acc.naive <- accuracy(citi_bike.naive)
citi_bike.naive.forecast <- forecast(citi_bike.naive,h=7)

#SEASONAL NAIVE
citi_bike.snaive <- snaive(citi_bike.ts, h=7)
plot(citi_bike.snaive.forecast)
plot(citi_bike.snaive$residuals)
hist(citi_bike.snaive$residuals,  xlab = "residuals", main = "Histogram of snaive forecasting Residuals")
Acf(citi_bike.snaive$residuals, main = "ACF OF Seasonal Naive Forecasting")
citi_bike.acc.snaive <- accuracy(citi_bike.snaive)
citi_bike.snaive.forecast <- forecast(citi_bike.snaive,h=7)

#RANDOM WALK
citi_bike.rwf <- rwf(citi_bike.ts,h=7)
plot(citi_bike.rwf)
plot(citi_bike.rwf$residuals)
hist(citi_bike.rwf$residuals,  xlab = "residuals", main = "Histogram of rw forecasting Residuals")
Acf(citi_bike.rwf$residuals, main = "ACF OF Random walk Forecasting")
citi_bike.acc.rwf <- accuracy(citi_bike.rwf)
citi_bike.rwf.forecast <- forecast(citi_bike.rwf,h=7)

#MOVING AVERAGES
citi_bike.ma3 <- ma(citi_bike.ts,order = 3)
citi_bike.ma6 <- ma(citi_bike.ts,order = 6)
citi_bike.ma12 <- ma(citi_bike.ts,order = 12)
plot(citi_bike.ts, ylab = "citi bike trips")
lines(citi_bike.ma3,col="red")
lines(citi_bike.ma6,col="blue")
lines(citi_bike.ma12,col="green")

plot(citi_bike.ma3.forecast)
plot(citi_bike.ma6.forecast)
plot(citi_bike.ma12.forecast)

citi_bike.acc.ma3 <- accuracy(forecast(citi_bike.ma3,h=8))
citi_bike.acc.ma6 <- accuracy(forecast(citi_bike.ma6,h=10))
citi_bike.acc.ma12 <- accuracy(forecast(citi_bike.ma12,h=13))
citi_bike.ma3.forecast <- forecast(citi_bike.ma3, h=8)
citi_bike.ma6.forecast <- forecast(citi_bike.ma6, h=10)
citi_bike.ma12.forecast <- forecast(citi_bike.ma12, h=13)

Acf(citi_bike.ma3.forecast$residuals, main = "ACF OF MA3 Forecasting")
Acf(citi_bike.ma6.forecast$residuals, main = "ACF OF MA6 Forecasting")
Acf(citi_bike.ma12.forecast$residuals, main = "ACF OF MA12 Forecasting")

hist(citi_bike.ma3.forecast$residuals,  xlab = "residuals", main = "Histogram of MA3 Residuals")
hist(citi_bike.ma6.forecast$residuals,  xlab = "residuals", main = "Histogram of MA6 Residuals")
hist(citi_bike.ma12.forecast$residuals,  xlab = "residuals", main = "Histogram of MA12 Residuals")

#EXPONENTIAL SMOOTHING
citi_bike.ets <- ets(citi_bike.ts)
plot(citi_bike.ets.forecast)
plot(citi_bike.ets$residuals)
hist(citi_bike.ets$residuals,  xlab = "residuals", main = "Histogram of ETS forecasting Residuals")
Acf(citi_bike.ets$residuals, main = "ACF OF ETS Forecasting")
citi_bike.acc.ets <- accuracy(citi_bike.ets)
citi_bike.ets.forecast <- forecast(citi_bike.ets,h=7)

#HOLT WINTERS
citi_bike.hw <- HoltWinters(citi_bike.ts)
plot(citi_bike.hw.forecast)
plot(residuals(citi_bike.hw))
hist(residuals(citi_bike.hw),  xlab = "residuals", main = "Histogram of Holt Winters Residuals")
#plot(citi_bike.hw$residuals)
Acf(residuals(citi_bike.hw), main = "ACF OF Holt Winters Forecasting")
citi_bike.acc.hw <- accuracy(forecast(citi_bike.hw,h=7))
citi_bike.hw.forecast <- forecast(citi_bike.hw,h=7)

#ARIMA
citi_bike.arima <- auto.arima(citi_bike.ts,ic="aic",trace = TRUE)
plot(citi_bike.arima$residuals)
plot(citi_bike.arima.forecast)
hist(citi_bike.arima$residuals,  xlab = "residuals", main = "Histogram of arima forecasting Residuals")
Acf(ts(citi_bike.arima$residuals), main = "ACF of Arima")
citi_bike.acc.arima <- accuracy(forecast(citi_bike.arima,h=7))
citi_bike.arima.forecast <- forecast(citi_bike.arima,h=7)

