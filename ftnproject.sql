-- Display the first 10 rows of transactions with columns:
select * from transaction limit 10;
-- List all distinct Regions and number of unique States in each region.
select distinct (Region) , count(State)as unique_states  from transaction group by Region;
-- Find all orders where:Discount > 0.10	Quantity ≥ 5	Category = 'Furniture'
select * from transaction where Discount >0.10 and Quantity > 5 and Category = 'Furniture';
-- Show all orders from March 2024, displaying: OrderID, Region, OrderDate, Sales, and a 
-- new column Weekday showing the day name of OrderDate.
select OrderID,Region,Sales,OrderDate as weekday from transaction where OrderDate between'2024-03-01'and '2024-03-31';
-- For each Region, show: Total Sales Total Profit Average Discount Only include regions where Total Sales > 400000. Sort by Total Sales DESC.
select distinct (Region),round(sum(Sales),2) as total_sales, round(sum(Profit),2) as total_profit,round(avg(Discount),3) as avg_discount from transaction group by Region having total_sales > 40000 order by total_sales desc;
-- Show the Top 3 States (overall) by total profit.
select State,round(sum(Profit),2) as total_profit from transaction group by State  order by total_profit desc limit 3;
-- Join transactions and products to list: OrderID, ProductName, Category, UnitCost, UnitPrice, Sales.
-- Calculate and display a new column ExpectedProfit = Sales - (Quantity * UnitCost).
select t.OrderID,t.ProductName,t.Category,p.UnitCost,t.UnitPrice,t.Sales,
round((t.Sales-(t.Quantity*p.UnitCost)),2) as ExpectedProfit 
from transaction t join product p on t.ProductID =p.ProductID;
-- Join transactions and targets on Region + Month
-- (to compare actual vs target).
-- Show:
-- Region
-- 	Month (derived from OrderDate as FORMAT(OrderDate, 'Mon-YYYY'))
-- SUM(Sales) as ActualSales	
-- 	Corresponding SalesTarget
-- 	Difference (ActualSales - SalesTarget)
select  from transaction t join region r on t.Region = r.Region;

-- Find products whose total sales are above the average sales of all products.
select distinct ProductID,ProductName,round(sum(Sales),2) as total_sales from transaction group by ProductID,ProductName having total_sales >(select avg(Sales) from transaction )order by total_sales;
-- Find customers who have placed more than 5 orders in total.
select distinct(count(Customer)) as counted_customer from transaction where Customer >= 5;
-- Using a window function, rank each Product within its Category by total profit (highest first). 
Select ProductID,Category,Profit,rank() over ( partition by Category order by Profit DESC ) AS rankincategory from transaction;
