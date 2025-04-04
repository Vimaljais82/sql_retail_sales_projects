# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `projects1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE Projects1;

CREATE TABLE reatils_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;


Select* from reatils_sales
where transactions_id is null or
sale_date is null or 
sale_time is null or
customer_id is null or 
gender is null or  age is null or 
category is null or
quantiy is null;


DELETE FROM reatils_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```	Select* from reatils_sales where sale_date = '2022-11-05'
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```
with find_Nov as(
Select*, extract(Month from sale_date) as find_111
from reatils_sales where category = 'Clothing' and quantiy >=4)
select* from find_Nov
where find_111 = 11;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select category, sum(total_sale) as categoryaa_wise_sales
from reatils_sales
group by category
order by category 
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
	ROUND(avg(age),2) as avg_age,category
from reatils_sales
where category = 'Beauty'
group by  category
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
Select* 
	from  reatils_sales 
where total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select count(transactions_id),gender,category
	from reatils_sales
	group by  gender,category
order by 2 desc
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql

Select*
from reatils_sales
Select avg(total_sale),
extract(year from sale_date) as month_T,
extract(month from sale_date) year_T
from reatils_sales
group by year_T, month_T
order by 1 desc
limit 3```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
Select customer_id,sum(total_sale) 
	from reatils_sales
	group by customer_id 
	order by 2 desc
	limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
     select count(distinct customer_id),category
	 from  reatils_sales
	 group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
	group by Work_shift;```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

