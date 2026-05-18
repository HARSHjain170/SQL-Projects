use hospital;
select * from hospital.hos;
-- Increase all paid_amount by 5% for “Insurance” payments
update hos set paid_amount = paid_amount + (paid_amount * 5 /100) where payment_method ='Insurance';
-- Correct any visit records where age < 1 → set to NULL
update hos set age = null where age > 1;
-- Delete records from hos where billing_amount = 0;
 -- delete from hos where billing_amount = 0; 
-- Delete visits by patients marked as “invalid” (manually set one)
update hos set visit_type = 'invalid' where patient_id = "PAT1008";
delete from hos where visit_type = 'invalid';

-- Total revenue, paid revenue, outstanding revenue
select 
round(sum(billing_amount),2) as Total_revenue ,
round(sum(paid_amount),2) as paid_revenue , 
round(sum(billing_amount - paid_amount),2) as outstanding_revenue 
from hos;
-- 	Revenue by doctor
select distinct doctor_id, doctor_name ,
round(sum(billing_amount),2) as paid_revenue_doctor 
from hos group by doctor_id,doctor_name 
order by paid_revenue_doctor desc;
-- 	Revenue by department
select department,
round(sum(billing_amount),2) as revenue_department 
from hos group by department;
-- 	Top 10 patients by spending
select patient_id,patient_name,round(sum(billing_amount),2)as total_spend
 FROM hos 
 group by patient_id,patient_name 
 order by total_spend desc limit 10;
 -- Monthly revenue trend
 select date_format(visit_date,"%Y-%M") as month_name,
 round(sum(billing_amount),2)as monthy_revenue 
 from hos group by month_name ORDER BY month_name;
 -- Average billing per visit type (OPD/IPD/Emergency)
 select visit_type,round(avg(billing_amount),2)as avg_billing 
 from hos group by visit_type;
 -- Count of visits requiring follow-up
 select count(*) as follow_up_visits from hos where follow_up_flag = 1;
 -- List all visits with patient name + doctor name + department
 select  v.visit_date,p.patient_name,d.department,d.doctor_name 
 from hos v join hos p 
 on v.patient_id = p.patient_id 
 join hos d 
 on v.doctor_id = d.doctor_id 
 order by v.visit_date;
-- 	Get all procedures performed along with billing amounts
select p.procedure_description, v.billing_amount from hos p join hos v on p.visit_id = v.visit_id;
-- 	Patients whose visit count is above average visit count
SELECT 
    patient_id,
    patient_name,
    COUNT(visit_id) AS visit_count
FROM hos
GROUP BY patient_id, patient_name
HAVING COUNT(visit_id) > (
    SELECT AVG(visit_count) 
    FROM (
        SELECT COUNT(visit_id) AS visit_count
        FROM hos
        GROUP BY patient_id
    ) AS avgs
);

-- 	Visits where billing is above patient’s own average billing
select h.visit_id,h.patient_id,h.patient_name,
h.billing_amount  
from hos h 
 where h.billing_amount >
 (select avg(h1.billing_amount) from hos h1 where h.patient_id= h1.patient_id);
 
 -- Doctors with revenue higher than average doctor revenue
select doctor_id,doctor_name,sum(billing_amount) as total_revenue from hos 
group by doctor_id,doctor_name having sum(billing_amount) > 
(select avg(doctor_revenue)from
(select sum(billing_amount)as doctor_revenue 
from hos group by doctor_id) t
);
-- Running total of daily revenue
select visit_date,sum(billing_amount) as daily_revenue, 
SUM(SUM(billing_amount)) over (order by visit_date) as running_total_revenue
from hos  group by visit_date;

-- Ranking doctors based on total revenue
select
    doctor_id,
    doctor_name,
    SUM(billing_amount) AS total_revenue,
    rank() over (order by SUM(billing_amount) desc) as revenue_rank
from hos
group by doctor_id, doctor_name
order by total_revenue desc;
-- 	Lag/Lead analysis of daily revenue for trend detection
WITH daily_rev AS (
    SELECT 
        visit_date,
        SUM(billing_amount) AS daily_revenue
    FROM 	hos
    GROUP BY visit_date
)
SELECT
    visit_date,
    daily_revenue,
    LAG(daily_revenue, 1) OVER (ORDER BY visit_date) AS prev_day_revenue,
    LEAD(daily_revenue, 1) OVER (ORDER BY visit_date) AS next_day_revenue,
    daily_revenue - LAG(daily_revenue, 1) OVER (ORDER BY visit_date) AS change_from_prev
FROM daily_rev
ORDER BY visit_date;
SELECT
    visit_date,
    daily_revenue,
    prev_day_revenue,

    CASE
        WHEN prev_day_revenue IS NULL THEN 'N/A'
        WHEN daily_revenue > prev_day_revenue THEN 'UP'
        WHEN daily_revenue < prev_day_revenue THEN 'DOWN'
        ELSE 'SAME'
    END AS revenue_trend
FROM (
    SELECT
        visit_date,
        SUM(billing_amount) AS daily_revenue,
        LAG(SUM(billing_amount)) OVER (ORDER BY visit_date) AS prev_day_revenue
    FROM hos
    GROUP BY visit_date
) t
ORDER BY visit_date;

-- 	Monthly_Billing_Summary view
create view Monthly_Billing_Summary as
select
    DATE_FORMAT(visit_date, '%Y-%m')as month,        
    COUNT(*) as total_visits,
    SUM(billing_amount) as total_revenue,
    SUM(paid_amount) as paid_revenue,
    SUM(billing_amount - paid_amount) as outstanding_revenue
from hos
group by date_format(visit_date, '%Y-%m')
order by  month;

select * from Monthly_Billing_Summary;
-- Doctor_Performance view (total visits, revenue, avg billing)
create or replace view doctor_per as 
select doctor_name,
    count(*) as total_visits,
    sum(billing_amount) as total_revenue,
    round(AVG(billing_amount), 2) as avg_billing
from hos
group  by doctor_name;

select * from doctor_per;

--  High_Value_Patients view (billing > ₹X threshold)
create or replace view High_Value_Patients as
select
    patient_id,
    patient_name,
    sum(billing_amount) as total_billing,
    count(*) as total_visits,
    round(avg(billing_amount), 2) as avg_billing
from hos
group by patient_id, patient_name;
select *
from High_Value_Patients
where total_billing > 5000;

