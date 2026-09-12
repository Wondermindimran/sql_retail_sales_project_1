# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
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

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write an SQL query to retrieve all columns for sales made on "2022-11-05"**:
```sql
SELECT * FROM retail_sales_table
WHERE sales_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is "clothing" and quantity sold is more than 4 in the month of Nov-2022
**:
```sql
SELECT 
	* 
FROM retail_sales_table
WHERE category = 'Clothing'
	AND 
	TO_CHAR(sales_date, 'YYYY-MM') = '2022-11'	
	AND quantity >= 4;
```

3. **Write SQL query to calculate the total sales for each category.**:
```sql
SELECT 
	Category,
	SUM(total_sales) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales_table
GROUP BY 1;
```

4. **Write an SQL query to find the average age of customers who purchased items from the "Beauty" category**:
```sql
SELECT 
	ROUND(AVG(age),2) as Average_age
FROM retail_sales_table
WHERE Category = 'Beauty';

```

5. **Write an SQL query to find all transactions where the total_sale is greater than 1000**:
```sql
SELECT 
	*
FROM retail_sales_table
WHERE total_sales > 1000;	
```

6. **Write a SQL query to find the total number of transactions made by each gender in each category**:
```sql
SELECT 
	category,
	gender,
	COUNT(*) as total_transactions
FROM retail_sales_table
GROUP BY 
	category, 
	gender
ORDER BY category;
```

7. **Write an SQL query to calculate the average sale for each month. Find out the best-selling month in each year.**:
```sql
SELECT 
		year,
		month,
		avg_sales
FROM
(
	SELECT
		EXTRACT(YEAR FROM sales_date) as year,
		EXTRACT(MONTH FROM sales_date) as month,
		AVG(total_sales) as avg_sales,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sales_date) ORDER BY AVG(total_sales) DESC) AS Rank
	FROM retail_sales_table
	GROUP BY 1, 2 
) AS t1
WHERE Rank = 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
	customer_id,
	SUM(total_sales) AS total_sales_per_customer
FROM retail_sales_table
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL Query to find the number of unique customers who purchased items from each category**:
```sql
SELECT
	category,
	COUNT(DISTINCT customer_id) AS count_of_unique_cust
	
FROM retail_sales_table
GROUP BY 1
ORDER BY 2 DESC
```

10. **Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon between 12 & 17 and Evening > 17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM sales_time) < 12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales_table
)

SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
```

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

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Muhammad Imran

This project is part of my portfolio and showcases the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

Thank you, and I look forward to connecting with you!
