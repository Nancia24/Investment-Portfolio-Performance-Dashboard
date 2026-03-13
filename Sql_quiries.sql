SELECT * FROM market_data.long_market_data;

-- convert date type from text to date
SET SQL_SAFE_UPDATES = 0;
UPDATE market_data.long_market_data 
SET temp_date = STR_TO_DATE(price_date, '%Y-%m-%d');
SELECT * FROM market_data.long_market_data;

ALTER TABLE market_data.long_market_data DROP COLUMN price_date;
ALTER TABLE market_data.long_market_data RENAME COLUMN temp_date TO price_date;

SELECT * FROM market_data.long_market_data;

-- currency convegence
CREATE OR REPLACE VIEW vw_portfolio_master AS
SELECT 
    m.price_date,
    m.Asset,
    -- If the Stock Name is one of the US Tech giants, multiply by the FX rate
    CASE 
        WHEN m.Asset IN ('Apple', 'Microsoft', 'Nvidia') THEN m.Price * fx.Price
        ELSE m.Price 
    END AS Price_ZAR
FROM market_data.long_market_data m
JOIN market_data.long_market_data fx ON m.price_date = fx.price_date 
WHERE fx.Asset = 'USD_ZAR_Rate' 
  AND m.Asset != 'USD_ZAR_Rate';
  
 -- Performance Tracking (Growth %)
  CREATE OR REPLACE VIEW vw_daily_performance AS
SELECT 
    price_date,
    Asset,
    Price_ZAR,
    -- Get the previous day's price for THIS specific stock
    LAG(Price_ZAR) OVER (PARTITION BY Asset ORDER BY price_date) AS Prev_Price,
    -- Calculate the Daily Return Percentage
    ((Price_ZAR - LAG(Price_ZAR) OVER (PARTITION BY Asset ORDER BY price_date)) 
    / LAG(Price_ZAR) OVER (PARTITION BY Asset ORDER BY price_date)) * 100 AS Daily_Return_Pct
FROM vw_portfolio_master;

-- Rebased Growth
CREATE OR REPLACE VIEW vw_growth_comparison AS
SELECT 
    price_date,
    Asset,
    Price_ZAR,
    -- Identify the price on the very first day for each stock
    FIRST_VALUE(Price_ZAR) OVER (PARTITION BY Asset ORDER BY price_date) AS Initial_Price,
    -- Current Price divided by Start Price * 100
    (Price_ZAR / FIRST_VALUE(Price_ZAR) OVER (PARTITION BY Asset ORDER BY price_date)) * 100 AS Growth_Index
FROM vw_portfolio_master;

SELECT 
    Asset,
    COUNT(*) as Data_Points,
    MIN(Price_ZAR) as Lowest_Price,
    MAX(Price_ZAR) as Highest_Price,
    AVG(Price_ZAR) as Average_Price
FROM vw_portfolio_master
GROUP BY Asset;