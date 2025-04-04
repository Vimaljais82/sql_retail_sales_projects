select* from reatils_sales
limit 10;

Select
	count(*)
from reatils_sales
	limit 10;

-- to  find the null values 

Select*
from reatils_sales
where transactions_id is null;

Select*
from reatils_sales
where sale_date is null;

Select* from reatils_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null 
or 
gender is null
or 
age is null
or 
category is null 
or
quantiy is null
;

-- How to delete null values in from the tables

delete from reatils_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null 
or 
gender is null
or 
age is null
or 
category is null 
or
quantiy is null

--data expolartions

--to find the total number of 
-- here we deleted null value from the databases
Select count(*) from reatils_sales;
---How many sales we do have
Select count(*) as Total_sales from reatils_sales;
--How many customer we do have
Select count (*) as total_cx from reatils_sales ;
--How Unique cx we do have
Select count(distinct customer_id) from reatils_sales ;

-- Data Analysis and Business key problems and Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- ans 
	Select* from reatils_sales where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions
-- where the category is 'Clothing' and the quantity
-- sold is more than 10 in the month of Nov-2022

with find_Nov as(
Select*, extract(Month from sale_date) as find_111
from reatils_sales where category = 'Clothing' and quantiy >=4)
select* from find_Nov
where find_111 = 11;
-- to_char functions

with find_moths as 
(
Select*,extract(Month from sale_date) as find_Nov 
from
reatils_sales)
--- TO_CHAR(sale_date,'YYYY-MM') = '2022-11')
Select* from find_moths
where find_Nov = 11;
-- how to extarct data from date columns

Select TO_CHAR(Sale_date,'YYYY-MM') = '2022-11'
from reatils_sales
--Q2 Answers 

Select*
from reatils_sales where category = 'Clothing' and quantiy >=4 and TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
---- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select category, sum(total_sale) as categoryaa_wise_sales
from reatils_sales
group by category
order by category 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
	ROUND(avg(age),2) as avg_age,category
from reatils_sales
where category = 'Beauty'
group by  category

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select* 
	from  reatils_sales 
where total_sale > 1000

---- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transactions_id),gender,category
	from reatils_sales
	group by  gender,category
order by 2 desc
-- Q.7 Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year

Select*
from reatils_sales


Select avg(total_sale),
extract(year from sale_date) as month_T,
extract(month from sale_date) year_T
from reatils_sales
group by year_T, month_T
order by 1 desc
limit 3
-----

with best_sales as(
Select avg(total_sale),
extract(year from sale_date) as month_T,
extract(month from sale_date) year_T,
rank() over(partition by extract(year from sale_date) order by avg(total_sale)desc) as yeas 
from reatils_sales
group by year_T, month_T
)
select* from 
best_sales
where yeas = 1

--

Select*
from 
(
Select avg(total_sale),
extract(year from sale_date) as month_T,
extract(month from sale_date) year_T,
rank() over(partition by extract(year from sale_date) order by avg(total_sale)desc) as yeas 
from reatils_sales
group by year_T, month_T
) as t1
where yeas = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
	Select customer_id,sum(total_sale) 
	from reatils_sales
	group by customer_id 
	order by 2 desc
	limit 5;

	-- usning the rank functions
	Select customer_id,sum(total_sale),
	rank ()
	over(order by sum(total_sale) desc)
	from reatils_sales
	group by customer_id
	limit 5

  --Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
	
     select count(distinct customer_id),category
	 from  reatils_sales
	 group by category

	-- Q.10 Write a SQL query to create each shift and number of orders
	---(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

    with hourlay_shifts as(
	Select *,
	case
	when extract(hour from sale_time)<=12 then 'Morning '
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
	end as Work_shift
	from reatils_sales)
	select count(Work_shift),Work_shift
	from hourlay_shifts
	group by Work_shift;