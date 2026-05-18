select count(*) as total_rowsofcustomer from customer;
select count(*) as total_rowsofproduct from product;
select count(*) as total_rowstransaction from transactions;
-- select prod_cat,prod_subcat from product group by prod_cat having prod_subcat = "DIY";
select count(Gender) as counting_females from customer where Gender = "f"; 
select count(Gender) as counting_males from customer where Gender = "m";
select count(city_code)as maximum_cities  ,customer_Id   from customer group by customer_Id ;
select count(prod_cat) as books_category, prod_subcat from product where prod_cat ='Books' group by prod_cat ;
select round(sum(total_amt),2) as total_amount ,prod_subcat  from transactions join product  where prod_cat in ('Electronics','Books') group by total_amt,prod_subcat;
select round(sum(total_amt),2) as tota_revenue,Qty,Store_type from transactions join product where prod_cat in ('Electronics','Clothing') and Store_type = 'Flagship store' group by total_amt,Qty,Store_type;
-- select round(sum(total_amt),2)
select max(Rate) as maximumreturn ,prod_cat from transactions join product where Rate like '-%' group by Rate ,prod_cat order by Rate asc;
select Store_type ,count(prod_cat)as maximum_product,max(Rate) as maximum_rates from  transactions join product group by Store_type ,Rate,prod_cat order by maximum_product;