# Coca-Cola Stock Historical Analysis Using SQL
![Coca-Cola](https://upload.wikimedia.org/wikipedia/commons/c/ce/Coca-Cola_logo.svg)

## Project Overview

This project analyzes the historical stock performance of The Coca-Cola Company (KO) using SQL. The dataset spans from 1962 to 2025, providing a comprehensive view of one of the world's most iconic blue-chip stocks. Through 15 business intelligence queries, this analysis explores price volatility, trading volume patterns, yearly trends, and market performance metrics.

## Dataset Information

**Data Source:**
- **Yahoo Finance API** via yfinance Python library
- **Date Range:** 1962-01-02 to 2025 (63+ years of data)
- **Update Frequency:** Daily

**Company Background:**
- **Founded:** 1892
- **Headquarters:** Atlanta, Georgia
- **Industry:** Beverage Manufacturing
- **Market:** NYSE (Ticker: KO)
- **Portfolio:** 200+ brands including Coca-Cola, Sprite, Fanta, Dasani

**Key Columns:**
- Date, Open, High, Low, Close, Volume
- Ticker Symbol (KO)
- Company Name

## SQL Skills Demonstrated

This project showcases fundamental to intermediate SQL querying techniques:

- `SELECT`, `FROM`, `WHERE`
- Aggregate functions: `COUNT()`, `AVG()`, `MIN()`, `MAX()`, `SUM()`
- `GROUP BY` and `ORDER BY`
- `TOP` for limiting results
- `CASE` statements for conditional logic
- Date functions: `YEAR()`, `MONTH()`, `DATENAME()`, `DATEPART()`, `QUARTER()`
- Type conversions: `CAST()` for handling large integers
- Mathematical calculations and comparisons
- `UNION ALL` for combining query results

## Technical Implementation

### Database Setup
- **Platform:** Microsoft SQL Server Management Studio (SSMS)
- **Import Method:** Flat File Source (CSV import)
- **Data Cleaning:** VARCHAR to FLOAT/DECIMAL conversions, BIGINT casting for volume calculations

## 15 Business Questions Analyzed

### 1. What were the dates with the highest and lowest closing prices in the entire dataset?
```sql
SELECT TOP 1 [Date], [Close] AS Highest_Close
FROM Coca_Cola_historical_data
ORDER BY [Close] DESC

SELECT TOP 1 [Date], [Close] AS Lowest_Close
FROM Coca_Cola_historical_data
ORDER BY [Close] ASC
```

### 2. What is the average trading volume across all trading days?
```sql
SELECT AVG(CAST(Volume AS BIGINT)) AS AvgTradingVolume
FROM Coca_Cola_historical_data
```

### 3. Which dates had the largest difference between High and Low prices (daily range)?
```sql
SELECT TOP 10 [Date], [High], [Low],
    ([High] - [Low]) AS DailyRange
FROM Coca_Cola_historical_data
GROUP BY [Date], [High], [Low]
ORDER BY DailyRange DESC
```

### 4. What are the top 10 dates with the highest trading volume?
```sql
SELECT TOP 10 [Date], [Volume]
FROM Coca_Cola_historical_data
ORDER BY [Volume] DESC
```

### 5. What is the minimum and maximum closing price in the dataset?
```sql
SELECT
    MIN([Close]) AS MinClosingPrice,
    MAX([Close]) AS MaxClosingPrice
FROM Coca_Cola_historical_data
```

### 6. What was the average closing price for each year? Order by year.
```sql
SELECT YEAR([Date]) AS Year,
    AVG([Close]) AS YearlyAVG
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC
```

### 7. What was the total trading volume for each year?
```sql
SELECT YEAR([Date]) AS Year,
    SUM(CAST([Volume] AS BIGINT)) AS TotalVolume
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC
```

### 8. What was the highest closing price achieved in each year?
```sql
SELECT YEAR([Date]) AS Year,
    MAX([Close]) AS HighestClose
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date])
ORDER BY YEAR([Date]) DESC
```

### 9. Count how many trading days occurred in each decade (1960s, 1970s, etc.)
```sql
SELECT 
    (YEAR([Date]) / 10) * 10 AS Decade,
    COUNT(*) AS TradingDays
FROM Coca_Cola_historical_data
GROUP BY (YEAR([Date]) / 10) * 10
ORDER BY Decade
```

### 10. What is the average closing price for each month (January through December) across all years?
```sql
SELECT 
    DATENAME(MONTH, [Date]) AS Month,
    AVG([Close]) AS Monthly_ClosingAvg
FROM Coca_Cola_historical_data
GROUP BY DATENAME(MONTH, [Date]), MONTH([Date])
ORDER BY MONTH([Date])
```

### 11. Which months historically have the highest average trading volume?
```sql
SELECT TOP 3
    DATENAME(MONTH, [Date]) AS Month,
    AVG([Close]) AS Monthly_ClosingAvg
FROM Coca_Cola_historical_data
GROUP BY DATENAME(MONTH, [Date]), MONTH([Date])
ORDER BY AVG([Close]) DESC
```

### 12. What is the average closing price for each quarter (Q1, Q2, Q3, Q4)?
```sql
SELECT 
    YEAR([Date]) AS Year,
    'Q' + CAST(DATEPART(QUARTER, [Date]) AS VARCHAR(1)) AS Quarter,
    AVG([Close]) AS QuarterlyAVG
FROM Coca_Cola_historical_data
GROUP BY YEAR([Date]), DATEPART(QUARTER, [Date])
ORDER BY Year, Quarter
```

### 13. How many days had a closing price higher than the opening price by more than $0.50?
```sql
SELECT 
    COUNT(*) AS PriceAbove50Cents
FROM Coca_Cola_historical_data
WHERE ([Close] - [Open]) > 0.50
```

### 14. Count days where the difference between High and Low was less than $0.10.
```sql
SELECT 
    COUNT(*) AS Difference10Cents
FROM Coca_Cola_historical_data
WHERE ([High] - [Low]) < 0.10
```

### 15. What is the average volume for days when the closing price was above $40 vs below $40?
```sql
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
    END
```

## Key Insights

- Long-term analysis reveals Coca-Cola's stock stability as a blue-chip investment
- Volatility patterns demonstrate market response to economic events across decades
- Seasonal trading patterns emerge from monthly and quarterly analysis
- Volume trends correlate with significant price movements and market conditions
- Historical price ranges showcase the company's consistent growth trajectory

## Files Included

- `Coca_Cola_Business_Solutions.sql` - All 15 business solution queries
- `Coca_Cola_Business_Problems.sql` - All 15 business problem questions
- `Coca_Cola_historical_data.csv` - Original dataset (1962-2025)

## How to Use

1. **Import Data:** Use SSMS Import Wizard with Flat File Source
2. **Set Data Types:** Configure price columns as FLOAT, Volume as BIGINT
3. **Run Queries:** Execute queries from `Coca_Cola_Business_Solutions.sql`
4. **Analyze Results:** Review output for investment insights and trends

## Learning Outcomes

This project demonstrates:
- Practical SQL query construction for financial analysis
- Data cleaning and type conversion in SSMS
- Advanced date manipulation and extraction techniques
- Aggregate analysis across multiple time dimensions
- Conditional logic using CASE statements
- Handling large numeric values with proper casting

## Future Enhancements

- Add moving average calculations (50-day, 200-day)
- Implement stock split adjustments
- Calculate daily returns and volatility metrics
- Compare performance against S&P 500 index
- Add technical indicators (RSI, MACD, Bollinger Bands)
- Create views for common financial metrics
- Develop stored procedures for automated analysis

## Use Cases

- **Financial Analysis:** Study long-term stock performance and trends
- **Risk Assessment:** Analyze volatility and price ranges
- **Investment Research:** Evaluate historical returns and patterns
- **Market Timing:** Identify seasonal trends and optimal trading periods
- **Educational Projects:** Practice SQL with real-world financial data

## Author

Created as part of SQL learning and portfolio development

## Acknowledgments

- **Yahoo Finance** for providing comprehensive historical stock data
- **yfinance Python library** for data collection
- Data sourced and analyzed November 2025

## License

This project uses publicly available stock market data for educational purposes.

---

*Note: This is an educational project for demonstrating SQL analysis skills. Historical stock data should not be the sole basis for investment decisions. Past performance does not guarantee future results.*
