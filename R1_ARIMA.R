#Import dataset from environment
library(readxl)
> citybike_all <- read_excel("C:/Users/gisha/Downloads/citybike all.xlsx")
> View(citybike_all)

#Identify if imported dataset is recognized
> class(citybike_all)
[1] "tbl_df"     "tbl"        "data.frame"

#Convert to time series if not recognized as a time series
> ?ts 
> citi.ts <- ts(citybike_all$Trips, start = min(citybike_all$Year), end = max(citybike_all$Year), frequency = 12)
> citi.ts
       Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
2015   511   267   801  3162  7426  5336  7519  8204  7792  6815  4954  4304
2016  1870  1916  4842  5950  7434  8110  8473  9443 10512  9234  4449  3122
2017  2948  3287  2978  9194  8255  8403  9513  9318  9274  8612  4014  2938
2018  2386  2800  3753  6538  9634 10626  9495  9154  9166  8087  3627  3791
2019  2917  2661  4031  7083  8182  9390  8720  9593  9790  7178  3435  2607
2020  3421                                                                  
> class(citi.ts)
[1] "ts"

> library(forecast)
Registered S3 method overwritten by 'quantmod':
  method            from
  as.zoo.data.frame zoo 
> library(tseries)

    ‘tseries’ version: 0.10-48

    ‘tseries’ is a package for time series analysis and computational finance.

    See ‘library(help="tseries")’ for details.

#plot the time series to understand the data better
> plot(citi.ts)

#auto correlation - If the plot crosses the blue line, it means there is high correlation. If the lines go above the blue line, it means that the data is not stationary.
> acf(citi.ts)

#partial auto correlation
> pacf(citi.ts)

#Dickey-Fuller test to check if stationary
> adf.test(citi.ts)

	Augmented Dickey-Fuller Test

data:  citi.ts
Dickey-Fuller = -6.0947, Lag order = 3, p-value = 0.01
alternative hypothesis: stationary

Warning message:
In adf.test(citi.ts) : p-value smaller than printed p-value

#If not stationary, use arima to make stationary
> ?auto.arima
> citi.test.arima <- auto.arima(citi.ts,ic="aic",trace = TRUE)

 ARIMA(2,1,2)(1,1,1)[12]                    : 829.3094
 ARIMA(0,1,0)(0,1,0)[12]                    : 852.5742
 ARIMA(1,1,0)(1,1,0)[12]                    : 835.7228
 ARIMA(0,1,1)(0,1,1)[12]                    : 822.4792
 ARIMA(0,1,1)(0,1,0)[12]                    : 828.5426
 ARIMA(0,1,1)(1,1,1)[12]                    : 824.4732
 ARIMA(0,1,1)(1,1,0)[12]                    : 824.5269
 ARIMA(0,1,0)(0,1,1)[12]                    : Inf
 ARIMA(1,1,1)(0,1,1)[12]                    : 824.4789
 ARIMA(0,1,2)(0,1,1)[12]                    : 824.4788
 ARIMA(1,1,0)(0,1,1)[12]                    : Inf
 ARIMA(1,1,2)(0,1,1)[12]                    : Inf

 Best model: ARIMA(0,1,1)(0,1,1)[12]   

#ARIMA(p,d,q)

#before forecasting, confirm if stationary
> acf(ts(citi.test.arima$residuals))
> pacf(ts(citi.test.arima$residuals))

#forecast data
> citiforecast=forecast(citi.ts,level=c(95),h=3*12)
> citiforecast
         Point Forecast      Lo 95     Hi 95
Feb 2020       2558.526  555.21551  4561.836
Mar 2020       3762.475 1739.58071  5785.370
Apr 2020       7031.812 4989.49555  9074.128
May 2020       8235.028 6173.44956 10296.607
Jun 2020       9028.272 6947.58685 11108.956
Jul 2020       8972.169 6872.53109 11071.807
Aug 2020       9261.429 7142.98783 11379.870
Sep 2020       9363.315 7226.21782 11500.412
Oct 2020       8292.691 6137.08187 10448.301
Nov 2020       4321.051 2147.07050  6495.031
Dec 2020       3552.213 1360.00029  5744.425
Jan 2021       2491.866  281.55733  4702.175
Feb 2021       2603.615  375.31644  4831.913
Mar 2021       3805.258 1559.12813  6051.388
Apr 2021       7072.407 4808.57299  9336.241
May 2021       8273.547 5992.13549 10554.959
Jun 2021       9064.821 6765.95494 11363.686
Jul 2021       9006.849 6690.65049 11323.047
Aug 2021       9294.335 6960.92339 11627.747
Sep 2021       9394.539 7044.03035 11745.047
Oct 2021       8322.318 5954.82834 10689.808
Nov 2021       4349.162 1964.80426  6733.520
Dec 2021       3578.887 1177.77127  5980.002
Jan 2022       2517.176   99.41221  4934.940
Feb 2022       2627.630  193.30097  5061.959
Mar 2022       3828.045 1377.28089  6278.810
Apr 2022       7094.029 4626.93199  9561.125
May 2022       8294.063 5810.73616 10777.390
Jun 2022       9084.287 6584.83028 11583.745
Jul 2022       9025.320 6509.83121 11540.809
Aug 2022       9311.862 6780.43803 11843.286
Sep 2022       9411.169 6863.90540 11958.432
Oct 2022       8338.098 5775.08836 10901.107
Nov 2022       4364.135 1785.47199  6942.798
Dec 2022       3593.094  998.86774  6187.320
Jan 2023       2530.657  -79.04318  5140.356
> plot(citiforecast)

#validate using box test
> ?Box.test
> Box.test(citiforecast,lag=5,type = "Ljung-Box")

	Box-Ljung test

data:  citiforecast
X-squared = 23.782, df = 5, p-value = 0.0002391

> Box.test(citiforecast,lag=15,type = "Ljung-Box")

	Box-Ljung test

data:  citiforecast
X-squared = Inf, df = 15, p-value < 2.2e-16

> Box.test(citiforecast,lag=5,type = "Box-Pierce")

	Box-Pierce test

data:  citiforecast
X-squared = 13.207, df = 5, p-value = 0.02151

# If p < 0.05, it means data has auto correlation issue

#Correcting issue
> boxplot(citybike_all$Trips)
> citi.arima.forecast=forecast(citi.test.arima,level=c(95),h=3*12)
> plot(citi.arima.forecast)
> Box.test(citi.arima.forecast$residuals,lag=5,type = "Ljung-Box")

	Box-Ljung test

data:  citi.arima.forecast$residuals
X-squared = 5.3408, df = 5, p-value = 0.3757

> Box.test(citi.arima.forecast$residuals,lag=15,type = "Ljung-Box")

	Box-Ljung test

data:  citi.arima.forecast$residuals
X-squared = 16.47, df = 15, p-value = 0.3515

> Box.test(citi.arima.forecast$residuals,lag=20,type = "Ljung-Box")

	Box-Ljung test

data:  citi.arima.forecast$residuals
X-squared = 24.459, df = 20, p-value = 0.2229

> Box.test(citi.arima.forecast$residuals,lag=30,type = "Ljung-Box")

	Box-Ljung test

data:  citi.arima.forecast$residuals
X-squared = 32.624, df = 30, p-value = 0.3391

> Box.test(citi.arima.forecast$residuals,lag=5,type = "Box-Pierce")

	Box-Pierce test

data:  citi.arima.forecast$residuals
X-squared = 4.8287, df = 5, p-value = 0.4371

#p value is not less than 0.05, hence no auto correlation issue.
