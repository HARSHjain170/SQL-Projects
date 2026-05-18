SELECT * FROM customer_clean_data;
select count(*) from customer_clean_data;
-- total revenue by male and female 
select gender,sum(purchase_amount) as revenue_m_f from customer_clean_data group by gender;	 
-- which customer used discount and still spent more than average purchase amount 
select customer_id,purchase_amount from customer_clean_data where discount_applied ='YES'  and
purchase_amount >(select avg(purchase_amount) from customer_clean_data);
-- which are top 5 products with the highest average review rating 
select item_purchased,round(avg(review_rating),2) as avg_rating from
customer_clean_data group by item_purchased order by avg_rating desc limit 5;
-- compare the average purchase Amounts between Standard and Express shipping 
select shipping_type ,round(avg(purchase_amount),2) as avg_puchased_amt
from customer_clean_data where shipping_type in( 'Express','Standard')  group by shipping_type;    
-- which customer spent more subscriber or nonsubscriber ?compare average spent between both 
select subscription_status,
count(customer_id) AS total_customer,
round(avg(purchase_amount),2) as avg_spent,
round(sum(purchase_amount),2) as total_revenue  
from customer_clean_data group by subscription_status;
-- which 5 products  have the highest percentage of purchases with discount applied ?
SELECT item_purchased,
       ROUND(
            100 * AVG(discount_applied = "YES"), 
       2) AS discount_rate
FROM customer_clean_data
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;
-- segmment customer  into new ,returning , loyal based  on their total number of previous purchases and  show the count each segment 
with customer_type as (
select 	customer_id,previous_purchases ,
case
     when previous_purchases = 1 then 'NEW'
     when previous_purchases between 2 and 10 then 'Returning'
     else 'LOYAL' 
    end as  Customer_segment 
from customer_clean_data
)
select Customer_segment ,count(*) as "Number of Customer " from customer_type group by Customer_segment;
-- what are the top 3 products in each category 
with item_counts as (
select category,item_purchased,count(customer_id) as total_order,
row_number() over (partition by category order by count(customer_id) desc) as item_rank 
from customer_clean_data
group by category,item_purchased
)
select * from item_counts where item_rank <= 3;
-- Are customers who are repeat buyers (more than 5 purchases) also likely to subscibe ?
select subscription_status,count(customer_id) as repeat_buyer 
from customer_clean_data where previous_purchases > 5 group by subscription_status;
-- what is the revenuee contribution of each age group 
select age_group,sum(purchase_amount) as total_revenue  from customer_clean_data group by age_group order by total_revenue desc;