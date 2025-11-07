--Coca Cola Stock Business Solutions

--1.What were the dates with the highest and lowest closing prices in the entire dataset?
SELECT TOP 1 [Date], [Close] AS Highest_Close
FROM Coca_Cola_historical_data
ORDER BY [Close] DESC
SELECT TOP 1 [Date], [Close] AS Lowest_Close
FROM Coca_Cola_historical_data
ORDER BY [Close] ASC

--2.What is the average trading volume across all trading days?
SELECT AVG(CAST(Volume AS BIGINT)) AS AvgTradingVolume
FROM Coca_Cola_historical_data

--3.Which dates had the largest difference between High and Low prices (daily range)?
SELECT TOP 10 [Date], [High], [Low],
([High] - [Low]) AS DailyRange
FROM Coca_Cola_historical_data
GROUP BY [Date], [High], [Low]
ORDER BY DailyRange DESC

--4.What are the top 10 dates with the highest trading volume?
SELECT TOP 10 [Date],[Volume]
FROM Coca_Cola_historical_data
ORDER BY [Volume] DESC

--5.What is the minimum and maximum closing price in the dataset?
SELECT
MIN([Close]) AS MinClosingPrice,
MAX([Close]) AS MaxClosingPrice
FROM Coca_Cola_historical_data

--6.What was the average closing price for each year? Order by year.
SELECT YEAR([Date]),
AVG([Close]) AS YearlyAVG
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC

--7.What was the total trading volume for each year?
SELECT YEAR([Date]),
SUM(CAST([Volume] AS BIGINT)) AS TotalVolume
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC

--8.What was the highest closing price achieved in each year?
SELECT YEAR([Date]),
MAX([Close]) AS HighestClose
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC

--9.Count how many trading days occurred in each decade (1960s, 1970s, etc.)
SELECT 
    (YEAR([Date]) / 10) * 10 AS Decade,
    COUNT(*) AS TradingDays
FROM Coca_Cola_historical_data
GROUP BY (YEAR([Date]) / 10) * 10
ORDER BY Decade;

--10.What is the average closing price for each month (January through December) across all years?
SELECT 
    DATENAME(MONTH, [Date]) AS Month,
    AVG([Close]) AS Monthly_ClosingAvg
FROM Coca_Cola_historical_data
GROUP BY DATENAME(MONTH, [Date]), MONTH([Date])
ORDER BY MONTH([Date]);

--11.Which months historically have the highest average trading volume?
SELECT TOP 3
    DATENAME(MONTH, [Date]) AS Month,
    AVG([Close]) AS Monthly_ClosingAvg
FROM Coca_Cola_historical_data
GROUP BY DATENAME(MONTH, [Date]), MONTH([Date])
ORDER BY  AVG([Close]) DESC

--12.What is the average closing price for each quarter (Q1, Q2, Q3, Q4)?
SELECT 
    YEAR([Date]) AS Year,
    'Q' + CAST(DATEPART(QUARTER, [Date]) AS VARCHAR(1)) AS Quarter,
    AVG([Close]) AS QuarterlyAVG
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date]), DATEPART(QUARTER, [Date])
ORDER BY Year, Quarter;

--13.How many days had a closing price higher than the opening price by more than $0.50?
SELECT 
    COUNT(*) AS PriceAbove50Cents
FROM Coca_Cola_historical_data
WHERE ([Close] - [Open]) > 0.50;

--14.Count days where the difference between High and Low was less than $0.10.
SELECT 
    COUNT(*) AS Difference10Cents
FROM Coca_Cola_historical_data
WHERE ([Close] - [Open]) > 0.50;

--15. What is the average volume for days when the closing price was above $40 vs below $40?
SELECT 
    CASE 
        WHEN [Close] > 40 THEN 'Above $40'
        ELSE 'Below $40'
    END AS PriceCategory,
    AVG(CAST([Volume] AS BIGINT)) AS AvgVolume
FROM Coca_Cola_historical_data
GROUP BY 
    CASE 
        WHEN [Close] > 40 THEN 'Above $40'
        ELSE 'Below $40'
    END;


