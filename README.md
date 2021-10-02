# Business-Forecasting

## What are we forecasting and why?

**What :** Our team is forecasting number of bike trips completed by a specific station location to aid the management with making decisions around demand for bikes in the upcoming year.

**Why :** Our team is forecasting the demand for citi bikes at “Central Park S & 6 Ave” bike station in the upcoming year. We want to look at the past data for use the number of trips completed from this location to understand how the demand has trended over time and how weather, lifestyle, leisure and other factors, play into the overall demand. This forecasting will equip the management and logistics team to be prepared with bike demand fluctuations and volatility.

We will focus on short term forecast. The term of our forecast will be limited to the upcoming 6-12 months.

We will carry out the following steps and validations to measure the accuracy of the forecast:
* Measure the forecast value and observed value to calculate the error.
* Compute percentage errors, root mean square errors and mean absolute error.
* Splitting dataset into training and testing. By training the test dataset, accuracy of the model's forecast can be measured.

The time components of our dataset is Years and Months. The dataset can be drilled down further into daily numbers if required.

## The data, where we got it, how we got it, is there a way anyone can do the same?
* Citi Bike is a privately owned public bicycle sharing system serving the New York City boroughs of the Bronx, Brooklyn, Manhattan, Queens, as well as Jersey City and Hoboken in New Jersey. It is named after its lead sponsor ‘Citigroup’.
* Citi Bike shares its system data to developers, engineers, statisticians, artists, academics, and other interested members of the public for analysis, development, visualization, forecasting and analytics.
* The source data resides in a s3 bucket on AWS at https://s3.amazonaws.com/tripdata/index.html.
* The data is split by location into 2 sets of zip files, NYC and Jersey City [JC]. NYC zip files will have trip data from all the stations serving in the 5 boroughs of NYC. JC zip files will have trip data collected from any NJ based stations (mostly in and around Jersey City neighborhoods).
* We are using NYC trip data for our forecasting. Furthermore, each zip file only has trip data of a month.

For our research and forecasting we did the following:
1. Downloaded all the zip files from 2015 until 2020 [72 files].
2. Grain of data in these files is Days, Hours and minutes.
3. Firstly, we extract and consolidate data for 5 years into an excel workbook.
4. Filter on ‘station id’ to focus and analyze only one specific Station (i.e. location) in the NYC market area.
5. Use Pivot table to covert trip duration into count of trips by day for station ‘2006’.
6. Alternatively, you can also use a python script to extract count of daily trips based on ‘station id’ and ‘start time’.
7. Aggregate count of trips from Day to Month roll up.
8. Final table has 72 data points each row corresponding to distinct 72 months starting from Jan 2015 and ending at Dec 2020.

### Links to our group members GitHub profiles.

* https://github.com/niket-dalal
* https://github.com/garimachouhan
