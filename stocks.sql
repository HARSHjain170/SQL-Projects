SELECT * FROM finalproject.stocks;
-- 1.	Categorize each stock’s PERatio as 'Low' (<15), 'Medium' (15–30), 'High' (>30)
select Ticker,PERatio,
CASE 
     WHEN PERatio < 15 THEN 'LOW'
     WHEN PERatio BETWEEN 15 AND 30 THEN 'MEDIUM'
     ELSE 'HIGH'
END AS Price_category
from stocks
order by PERatio desc;
-- 2.	Display 'Profitable' if EPS > 0, else 'Loss Making'.
select EPS,
CASE
   WHEN EPS > 0 THEN 'PROFITABLE'
   else 'LOSS MAKING'
end as EPS_DETAIL
 from stocks
 order by EPS DESC;
-- 3.	Add a column showing 'Overvalued' if ClosePrice > PERatio * EPS.
select ClosePrice,PERatio,EPS,
CASE 
    WHEN ClosePrice > PERatio * EPS then 'OVERVALUED'
    ELSE 'UNDERVALUED'
END AS OVERVALUED_UNDERVALUED
 from stocks
 order by OVERVALUED_UNDERVALUED desc;
 -- 4.	Categorize dividend yield: 'High Dividend', 'Moderate', 'Low'.
SELECT 
    Ticker,
    Sector,
    DividendYield,
    CASE
        WHEN DividendYield >= 3 THEN 'High Dividend'
        WHEN DividendYield BETWEEN 1 AND 2.99 THEN 'Moderate'
        ELSE 'Low'
    END AS Dividend_Category
FROM stocks
order by DividendYield desc;
-- 5.	Use CASE with aggregate — count how many stocks are “Overvalued” vs “Undervalued” in each sector.
SELECT 
    Sector,
    COUNT(CASE WHEN ClosePrice > (PERatio * EPS) THEN 1 END) AS Overvalued_Count,
    COUNT(CASE WHEN ClosePrice <= (PERatio * EPS) THEN 1 END) AS Undervalued_Count
FROM stocks
GROUP BY Sector
ORDER BY Sector;
-- 6.Highlight stocks that are within 10% of their 52-week high.

-- 7.Label sectors as 'Tech Driven' if Sector='Technology', else 'Other'.
select sector ,
CASE 
   when  sector = 'Technology' then 'Tech Driven'
   else 'other'
end as updated_sector
from stocks
group by Sector;
-- 8. Find sectors having average PERatio > 25.
select Sector,avg(PERatio) as avg_PERatio from stocks  group by Sector  having avg_PERatio > 25  order by Sector;
-- 9.List sectors with total MarketCap > 1 trillion.
select Sector,sum(MarketCap) as total_marketcap from stocks group by Sector having total_marketcap > 1000000000000  order by total_marketcap desc;
-- 10. Find sectors where average EPS > 10.
select Sector,round(avg(EPS),2) as eps_avg from stocks group by Sector having eps_avg > 10 order by eps_avg desc;
-- 11.Count how many companies per sector have DividendYield > 2, but show only those sectors where count > 5.
select Sector,count(*) as highest_dividendyeild from stocks where DividendYield > 2 group by Sector having count(*) > 5 order by highest_dividendyeild desc;
-- 12.Show sectors whose average ClosePrice exceeds 200, using HAVING
select Sector,avg(ClosePrice) as avg_closestprice from stocks group by Sector having avg_closestprice >= 200 order by avg_closestprice desc;
-- 13.Group stocks by Sector and find average VolumeTraded, order by highest volume.
select Sector,Ticker,round(avg(VolumeTraded),2)as avg_volume from stocks group by Ticker,Sector order by avg_volume desc;
-- 14.Group by Sector and count number of tickers, order by count descending.
select Sector,count(Ticker) as counted_stocks from stocks group by Sector order by counted_stocks desc;
-- 15.Find top 3 sectors by average MarketCap.
select Sector,round(avg(MarketCap),2) as top_avgsector from stocks group by Sector order by top_avgsector desc limit 3;
-- 16.Group by date and calculate daily average ClosePrice, order by Date.
select Date,round(avg(ClosePrice),2) as daily_closeprice from stocks group by Date order by Date desc;
-- 17.	List each sector’s total MarketCap ordered alphabetically.
select Sector, sum(MarketCap) as total_marketcap from stocks group by Sector order by Sector;
-- 18.	Extract month and year from the Date column and calculate average ClosePrice per month.
select 
	   extract(YEAR from str_to_date(Date,'%m/%d/%Y'))as year,
       extract(MONTH from str_to_date(Date,'%m/%d/%Y'))as month,
       round(avg(closeprice),2) as avg_closeprice
 from stocks
 group by year,month
 order by year,month;
 -- 19 find the number of in june 2025
 select count(*) as tradinddaysinjune2025 from stocks where month(str_to_date(Date,'%m/%d/%Y')) = 6 and Year(str_to_date(Date,'%m/%d/%Y')) = 2025;
 -- 20 show weekday name for each date and count per week day 
 select
 dayofweek(str_to_date(Date,'%m/%d/%Y')) as weekdays, 
 count(*) as num_records 
 from stocks
 group by weekdays 
 order by weekdays;
 -- 21 calculate averege price difference between per week 
 select
 yearweek(str_to_date(Date,'%m/%d/%Y')) as weekdays, 
 round(avg(ClosePrice),2) as avg_price 
 from stocks
 group by weekdays 
 order by weekdays;
 -- 23 find most recent  trading date 
 select date from stocks  order by Date desc limit 1;
 -- 24 Use CONCAT() to combine Ticker and Sector.
 select concat(Ticker,'- ',Sector) as combingthesector_sector from stocks;
 -- 25 Use LENGTH() to find the number of characters in ticker names.
 select Ticker,length(Ticker)as length_ticker from stocks;
 -- 26 Use UPPER() to convert all sectors to uppercase.
 select Sector,upper(Sector)as sector_in_uppercase from stocks;
 --  27 Use ABS() to calculate absolute daily price change.
 select Ticker,Date,abs(ClosePrice-OpenPrice) as daily_pricechange  from stocks;
 -- 28 Use COALESCE() to replace missing DividendYield with 0.
 select Ticker,coalesce(DividendYield,0) as null_value from stocks;
 -- 30 Use AVG(), MAX(), and MIN() within subqueries.
 select Ticker,Sector,ClosePrice,OpenPrice,DividendYield,
 (select avg(ClosePrice))as average_closeprice,
 (select min(OpenPrice))as min_openprice,
 (select max(DividendYield))as max_dividendyeild
 from stocks group by Ticker,Sector,ClosePrice,OpenPrice,DividendYield order by DividendYield desc;
 -- 31 Use ROW_NUMBER() to rank companies by MarketCap within each sector.
 select Sector,ticker,MarketCap,row_number()over(partition by Sector order by MarketCap desc) as rank_in_sector from stocks;
 -- 32 Use RANK() to find top 3 companies per sector by PERatio. 
 select * from (select Sector,Ticker,PERatio,RANK()over(partition by Sector order by PERatio desc ) as top_3company from stocks) as ranked where top_3company <= 3;
 -- 33 Use LAG() to compute day-over-day price change for each stock.
 select Ticker,date, ClosePrice,
 LAG(ClosePrice) OVER (PARTITION BY Ticker ORDER BY Date) AS Prev_ClosePrice,
 ClosePrice - lag(ClosePrice)over(partition by Ticker order by Date) as day_over_day 
 from stocks;
 -- 35  Use LEAD() to preview the next day’s ClosePrice.
 select Ticker,Date,ClosePrice,lead(ClosePrice) over(partition by Ticker order by Date) as next_dayclosingprice from stocks;
 -- 36 Use NTILE(4) to divide companies into quartiles based on MarketCap.
 select Ticker,Sector,MarketCap,NTILE(4)over(order by MarketCap desc)as quartiles_marketcaps from stocks;
 -- 37 Use SUM(VolumeTraded) OVER (PARTITION BY Sector) to show cumulative volume.
 select Sector,VolumeTraded,SUM(VolumeTraded) Over(PARTITION BY Sector order by VolumeTraded) as cumulative_volume  from stocks; 
-- 38 Use AVG(ClosePrice) OVER (PARTITION BY Sector) to find rolling average per sector. 
select Ticker,Sector,ClosePrice,avg(ClosePrice) over(partition by Sector order by ClosePrice desc) as rolling_avg_sec from stocks;
-- 39 Use a window function to calculate running total of volume for each ticker ordered by date.
select Ticker,Date,VolumeTraded,SUM(VolumeTraded) Over(PARTITION BY Ticker order by Date) as running_total_volume from stocks;
-- 40 Find the average ClosePrice per Sector.
 select Sector,round(avg(ClosePrice),2)as avg_cp_p_sector  from stocks group by Sector order by avg_cp_p_sector desc;
 -- 41 Calculate the total VolumeTraded for each sector.
 select Sector,round(avg(ClosePrice),2) as total_vol_t_p_sec from stocks group by Sector order by total_vol_t_p_sec;
 -- 42 Find the maximum MarketCap and minimum PERatio across all companies.
 select Ticker,max(MarketCap)as maximum_marketcap,min(PERatio) as minimum_peratio from stocks group by Ticker;
-- 43 Count how many stocks have DividendYield > 2\
select count(*)as dividend_lessthan_2 from stocks where DividendYield > 2; 
-- 44 Display the sum of MarketCap grouped by Sector.
select Sector,sum(MarketCap) as total_mc_p_sec from stocks group by Sector;
-- 45 Show the sector with the highest average EPS.
select Sector,round(avg(EPS),2)as high_avg_sec from stocks group by Sector order by high_avg_sec desc limit 1;
-- 46 Find the total number of trading records per month.
select date_format(Date,'%Y/%m') as year_months, count(*) as total_trade from stocks group by year_months;
-- 47 Find the standard deviation of PERatio for each sector.    
select Sector,round(stddev(PERatio),2) as standard_deviation from stocks group by Sector;
-- 48 Use a CTE to calculate average ClosePrice per Sector, then list only those with an average greater than 200.
with avg_sec as (
     select Sector,round(avg(ClosePrice),2) as avg_cp from stocks group by Sector
)
select Sector,avg_cp from avg_sec where avg_cp > 200;
-- 49 Use a recursive CTE to generate a sequence of trading days between two given dates.
with recursive tradingday as (
     select Date('2025-06-01') as tradedate
     union all
     select Date_add(tradedate, interval 1 day) from tradingday where  tradedate < '2025-06-10'
)
select * from tradingday;
-- 50 Create a CTE to find top 5 stocks by MarketCap in each sector.
with top as (
	 select Sector,Ticker,MarketCap,rank() over (partition by Sector order by MarketCap desc) as rank_in_sector from stocks
)
select * from top where rank_in_sector <= 5;
-- 51 Use a CTE to calculate daily return = (ClosePrice - OpenPrice)/OpenPrice.
with daily as (
	 select Ticker,Date,ClosePrice,OpenPrice, (ClosePrice - OpenPrice)/OpenPrice as daily_returns from stocks
)
select * from daily;

-- 52 Create a CTE to find top 5 stocks by MarketCap in each sector.
with top5 as (
  select Sector,Ticker,MarketCap,rank() over(partition by Sector order by MarketCap desc) as top_5ranks 
  from stocks 
)
select * from top5 where top_5ranks <=5;
-- 53 Use a CTE to calculate daily return = (ClosePrice - OpenPrice)/OpenPrice.
with dr as (
    select Sector,Ticker,round((ClosePrice -OpenPrice)/OpenPrice,2) as daily_return  from stocks order by daily_return desc
)
select * from dr;
-- 54.	With a CTE, calculate the difference between ClosePrice and 52WeekHigh for each stock.
 with diff as (
  select Ticker,ClosePrice,52WeekHigh,round((52WeekHigh-ClosePrice),2)as difference from stocks
 )
 select * from diff;
 -- 55 Categorize each stock as 'High Growth', 'Stable', or 'Low Growth' based on its PERatio and EPS.
 SELECT 
    Ticker,
    Sector,
    PERatio,
    EPS,
    CASE
        WHEN PERatio >= 30 AND EPS >= 5 THEN 'High Growth'
        WHEN PERatio BETWEEN 10 AND 29 AND EPS BETWEEN 1 AND 4.99 THEN 'Stable'
        WHEN PERatio < 10 OR EPS < 1 THEN 'Low Growth'
        ELSE 'Stable'
    END AS GrowthCategory
FROM stocks;
 -- 56 Find the daily Open Price, Close Price, and Volume Traded for Amazon (AMZN) for the trading days between June 10th, 2025, and June 15th, 2025, inclusive.
 select OpenPrice,ClosePrice,VolumeTraded,Ticker,Date 
 from stocks 
 where Ticker ='AMZN' and str_to_date(Date,'%m/%d/%Y') between '2025-06-10' and '2025-06-15' 
 order by str_to_date(Date,'%m/%d/%Y');
-- Calculate the average PERatio and average DividendYield for every unique Sector in the dataset. 
-- Order the sectors from the highest to the lowest average PERatio.
select Sector, round(avg(PERatio),2) as avg_peratio, round(avg(DividendYield),2)as avg_dividend from stocks group by Sector order by avg_peratio  desc ;
-- What was the highest HighPrice recorded across all stocks and dates in the dataset? 
-- Identify the corresponding Ticker, Date, and that HighPrice value.
select Date,Ticker,HighPrice from stocks  order by HighPrice desc limit 1;
-- Price and Volume Filtering:
-- Identify all stock-day records where the ClosePrice was between $\$100$ and $\$200$ (inclusive) 
-- AND the VolumeTraded exceeded $50,000,000$.
select Date,Sector,Ticker,ClosePrice,VolumeTraded from stocks where ClosePrice between 100 and 200 and VolumeTraded > 50000000;
-- For stocks in the Financials sector, calculate the Daily Trading Range (HighPrice - LowPrice).
-- List the Ticker, Date, and the calculated range for the top 5 days with the widest ranges.
select Date,Sector,Ticker,round((HighPrice-LowPrice),2) as Daily_trading_range  from stocks where Sector = 'Financials' order by Daily_trading_range desc limit 5;
-- Count the total number of trading records (rows) available for each unique Ticker.
-- List only those tickers that have more than 50 recorded days.
select Ticker,count(*) as total_records from stocks group by Ticker having total_records > 50 order by total_records desc ;
-- Find all instances (Ticker and Date) where the day's HighPrice was equal to or exceeded the stock's recorded 52WeekHigh,
-- indicating a potential new all-time high was set.
select Date,Ticker,HighPrice,52WeekHigh from stocks where HighPrice >= 52WeekHigh  order by HighPrice desc;
-- Retrieve all available data (all columns) for the following three specific tickers: 
-- Microsoft (MSFT), Nvidia (NVDA), and Tesla (TSLA).
 select * from stocks where Ticker in ('MSFT','NVDA','TSLA');
 -- Best Daily Gainers (Percentage):
-- Calculate the percentage price change from the OpenPrice to the ClosePrice for every record:
--  $\left(\frac{\text{ClosePrice} - \text{OpenPrice}}{\text{OpenPrice}}\right) \times 100$.
-- List the top 10 days with the largest positive percentage price increases
select Date,Ticker,OpenPrice,ClosePrice,
round(((ClosePrice - OpenPrice)/OpenPrice)*100,2) as dailypercentage 
from stocks 
order by dailypercentage desc limit 10;
-- Identify the record (Ticker, Date, and MarketCap) that represents the lowest MarketCap found within the Communication Services sector.
select Date,Ticker,Sector,MarketCap from stocks where Sector = 'Communication Services' order by MarketCap limit 1;
--  Classify all stocks based on their PERatio and DividendYield on the last available date in the dataset. 
-- Assign a 'Valuation_Tier' using a CASE statement as follows:'High Dividend Value': 
-- If PERatio is less than the overall average PERatio AND DividendYield is greater than $3.0\%$.'Growth Focus':
-- If PERatio is greater than $35$.
-- 'Standard Mix': All other stocks.
with latestdate  as (
 select max(str_to_date(Date,'%m/%d/%Y'))as max_date from stocks
),
averageperatio as (
select avg(t1.peratio) as avg_pe from stocks t1 join latestdate ld on str_to_date(t1.Date,'%m/%d/%Y') = ld.max_date
)
select t.Date,t.Ticker,t.PERatio,t.DividendYield, 
case  
when t.PERatio <(select avg_pe from averageperatio) and t.DividendYield > 3 then 'high dividend Value'
when t.PERatio > 35 then 'growth Focus'
else 'Standard Mix'
end as Valuation_tier
from stocks t
where str_to_date(t.Date,'%m/%d/%Y') = (select max_date from latestdate)
order by t.Ticker;
--  For every stock-day record, 
-- calculate the difference between its ClosePrice and the average ClosePrice of its entire Sector on that same date. 
-- List all records where the stock's closing price was more than $10\%$ higher than its sector's average closing price for that day.
 select Sector,Date,ClosePrice from stocks where ClosePrice >(select avg(ClosePrice) as avg_cp from stocks) ;
 -- Calculating the Volatility 
select Sector,Ticker,round(((HighPrice - LowPrice) / LowPrice) * 100,2) as Volatilaity_count from stocks order by Volatilaity_count desc;
-- Consecutive Day Gains....
SELECT *
FROM (SELECT Ticker,Date,ClosePrice,OpenPrice,
        LAG(ClosePrice) OVER (PARTITION BY Ticker ORDER BY Date) AS PrevClose,
        LAG(OpenPrice) OVER (PARTITION BY Ticker ORDER BY Date) AS PrevOpen
    FROM stocks
) AS t
WHERE t.ClosePrice > t.OpenPrice AND t.PrevClose > t.PrevOpen;

 --  select * from stocks;
