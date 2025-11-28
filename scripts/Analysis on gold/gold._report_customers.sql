------------------------------------------
--reporting
------------------------------------------
----base query

create view gold.report_customers as
with base_query as(
select
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name,' ',c.last_name) as customer_name,
datediff(year,c.birthdate,getdate()) age
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
where order_date is not null),

customer_aggregation as(
----customer aggregation
select
customer_key,
customer_number,
customer_name,
age,
count(distinct order_number) as total_orders,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(distinct product_key) as total_products,
max(order_date) as last_order_date,
datediff(month,min(order_date),max(order_date)) as life_span
from base_query
group by customer_key,
      customer_number,
       age,
       customer_name
)

---final result

select
customer_key,
customer_number,
customer_name,
age,
case when age < 20 then 'under 20'
     when age between 20 and 29 then '20-29'
     when age between 30 and 39 then '30-39'
     when age between 40 and 49 then '40-49'
     else '50 and above'
end 'age_group',
case when life_span >= 12 and total_sales > 5000 then 'VIP'
     when life_span >= 12 and total_sales <= 5000 then 'regular' 
     else 'New'
end as customer_segment,
datediff(month,last_order_date,getdate()) as recency,
total_orders,
total_sales,
total_quantity,
total_products,
last_order_date,
life_span,
case when total_orders = 0 then 0
     else total_sales/total_orders
end as avg_order_value,

case when life_span = 0 then total_sales
     else total_sales / life_span
end as avg_monthly_spend
from customer_aggregation
