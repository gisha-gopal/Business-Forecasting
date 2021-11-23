##Analyzing the data

#View data set
citi
head(citi)

#Summary of data set
summary(citi)

#Converting the data set into time series data
citi_bike_ts <- ts(citi$Trips, start = c(2015,1),end = c(2020,12),frequency = 12)
plot(citi_bike_ts)

##Model Fitting

model_fit <- stl(citi_bike_ts, s.window=5)
plot(model_fit)

model_fit
class(model_fit)

#Testing forecasting for next 5 periods
test_forecast <- forecast(model_fit, h=5)
test_forecast
accuracy(test_forecast)

#Partial Autocorrelation and Cross-Correlation 
Acf(citi_bike_ts)

#Auto and Cross-Covariance and Correlation
acf(citi_bike_ts)

##Forecasting

#Calculating the mean forecast with a period of 5
forecast_mean <- meanf(citi_bike_ts,h = 5)
plot(forecast_mean)

#Naive Forecasting
naive_forecast <- naive(citi_bike_ts, h = 5)
naive_forecast
plot(naive_forecast)

#Seasonal Naive Forecasting
snaive_forecast <- snaive(citi_bike_ts, h = 5)
snaive_forecast
plot(snaive_forecast)

#Random Walk Function
rwf_forecast <- rwf(citi_bike_ts, h = 5)
rwf_forecast
plot(rwf_forecast)

#Simple Exponential Forecasting
se_forecast <- ses(citi_bike_ts, h = 5)
se_forecast
plot(se_forecast)

#attributes of naive_forecast
attributes(naive_forecast)

#Plotting these
plot(forecast_mean)
lines(naive_forecast$fitted,col="red")
attributes(naive_forecast)
lines(rwf_forecast$fitted,col="green")
lines(snaive_forecast$fitted,col="blue")
lines(se_forecast$fitted,col="purple")

#Drift with rwf
rwf_forecast <- rwf(citi_bike_ts,5, drift=TRUE)
lines(rwf_forecast$fitted,col="pink")

# moving averages
MA5_forecast <- ma(citi_bike_ts,order = 5)
plot(MA5_forecast)
MA10_forecast <- ma(citi_bike_ts,order = 10)
plot(MA10_forecast)
MA20_forecast <- ma(citi_bike_ts, order = 20)
plot(MA20_forecast)
MA50_forecast <- ma(citi_bike_ts,order = 50)
plot(MA50_forecast)

#Plotting moving averages
plot(citi_bike_ts)
lines(MA5_forecast,col="Pink")
lines(MA10_forecast,col="Yellow")
lines(MA20_forecast,col="green")
lines(MA50_forecast,col="blue")

#Holt Winter's Forecasting
holt_forecast <- HoltWinters(citi_bike_ts)
holt_forecast

#Level
forecast_level <- HoltWinters(citi_bike_ts, beta=FALSE,gamma=FALSE)
forecast_level
plot(forecast_level)

#Trend
forecast_trend <- HoltWinters(citi_bike_ts,gamma=FALSE)
forecast_trend
plot(forecast_trend)

#Season
forecast_season <- HoltWinters(citi_bike_ts)
forecast_season
plot(forecast_season)

#Plotting these
plot(citi_bike_ts)
plot(forecast_level, col="blue")
plot(forecast_trend, col="green")
plot(forecast_season, col="purple")

#Accuracy
forecast_one <- forecast(forecast_season, h=12)
plot(forecast_one)
accuracy(forecast_one)

#ETS
ets(citi_bike_ts)
ets_forecast <- ets(citi_bike_ts)
attributes(ets_forecast)
ets_forecast$residuals

##Decomposition

stl_decomp <- stl(citi_bike_ts, t.window=12, s.window ="periodic")
stl_decomp
plot(stl_decomp)
attributes(stl_decomp)

#seasonal adjustments
seasadj(stl_decomp)

#forecast
forecast_stl <- forecast(stl_decomp,h=12)
forecast_stl
plot(forecast_stl)