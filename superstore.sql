select * from newsuperstore.superstore;
select region, sum(sales) as total_sales , sum(profit) as total_profit from superstore group by region order by total_profit desc;
select region, round(sum(profit)/sum(sales)*100,2) as profit_margin from superstore group by Region order by profit_margin desc;
select State, sum(sales) as highest_sales,sum(profit) as highest_profit, round(sum(profit)/sum(sales)*100,2) from superstore group by State order by highest_profit desc limit 10;
select city , round(sum(sales),2) as high_sale,round(sum(profit),2) as high_profit , round(sum(profit)/sum(sales)*100,2) from superstore group by city order by high_profit desc  limit 10;
select State ,round(sum(sales),2) as low_sale,round(sum(profit),2)as low_profit  from superstore group by State order by low_profit limit 10;
select Discount , round(avg(sales),2)as avg_sales  from superstore group by Discount order by Discount desc;
-- select Category,SubCategory,sum(discount) as total_discount from superstore group by Category,SubCategory order by total_discount desc;
select category,Region,State ,round(sum(sales),2) as total_sales,round(sum(profit),2) as total_profit , round(sum(sales)/sum(profit)*100,2) as percentage from superstore where category in('Technology','Furniture') group by Category,Region,State order by total_profit desc ;
