create database sql_retail_project;
use sql_retail_project;

create table retail (
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age int,
category varchar(30),
quantiy int,
price_per_unit float,
cogs float,
total_sale float);

drop table retail;
select * from retail;
select count(*) from retail;
describe retail;

select * from retail where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

select * from retail;

-- Data Exploration 

   -- How many sales we have?
select count(total_sale) from retail; 

   -- how many unique customers we have?
select count( distinct customer_id)  from retail; 

-- how many category are there?
select distinct category  from retail; 

-- BUSINESS KEY PROBLEMS  
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select * from retail where sale_date = "2022-11-05";

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more then 10 month of November 2022.
SELECT * FROM retail
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, 'yyyy-mm') = '2022-11'
  AND quantiy >= 2;
  
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale)as net_Sale, 
count(*) as total_orders from retail  group by 1;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age), category from retail
where category = "beauty";

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail where total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, category, count(*) as total_transaction from retail group by gender, category order by 1;

-- 7. Write a SQL query to calculate the average sale for each month. Find the best-selling month in each year.
select
    year(sale_date) AS year,
    month(sale_date) AS month,
    AVG(total_sale) AS average_sale
from retail
group by year(sale_date), month(sale_date)
order by year, month;

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales.
select customer_id, sum(total_sale) as highest_sale 
from retail
group by customer_id
order by highest_sale  desc limit 5;  

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct customer_id) from retail 
group by category;

-- 10. Write a SQL query to create each shift and number of orders (Example: Morning ≤12, Afternoon Between 12 & 17, Evening >17).
select case 
when hour(sale_time) <=12 then 'morning'
when hour(sale_time) between 13 and 17 then 'afternoon'
else 'evening'
end as 'shift',
COUNT(*) AS total_orders
FROM retail
GROUP BY shift;

---- end of project ---
