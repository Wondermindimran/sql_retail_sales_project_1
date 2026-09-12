-- SQL Retail Sales Analysis

-- Create Table
DROP TABLE IF EXISTS retail_sales_table;
CREATE TABLE retail_sales_table
			(
				transaction_id INT PRIMARY KEY,
				sales_date DATE,
				sales_time	TIME,
				customer_id	INT,
				gender VARCHAR (15),
				age	INT,
				category VARCHAR (15),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sales FLOAT
			);

-- DATA CLEANING
SELECT * FROM retail_sales_table
LIMIT 10


SELECT COUNT(*) 
FROM retail_sales_table

SELECT * FROM retail_sales_table
WHERE transaction_id IS NULL

SELECT * FROM retail_sales_table
WHERE sales_date IS NULL



SELECT * FROM retail_sales_table
WHERE
	transaction_id IS NULL
	OR
	sales_date IS NULL
	OR
	sales_time IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantity IS NULL
	OR 
	cogs IS NULL
	OR 
	total_sales IS NULL;


DELETE FROM retail_sales_table
WHERE
	transaction_id IS NULL
	OR
	sales_date IS NULL
	OR
	sales_time IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantity IS NULL
	OR 
	cogs IS NULL
	OR 
	total_sales IS NULL;

-- DATA EXPLORATION

-- How many sales do we have?

SELECT COUNT(*) AS total_sale FROM retail_sales_table

-- How many customers do we have?

SELECT COUNT(DISTINCT(customer_id)) AS total_customers FROM retail_sales_table

-- How many categories do we have?

SELECT DISTINCT(category) AS total_customers FROM retail_sales_table



-- Data Analysis & Business Key Problems & Answers

-- Q.1: Write an SQL query to retrieve all columns for sales made on "2022-11-05"

SELECT * FROM retail_sales_table
WHERE sales_date = '2022-11-05';


-- Q.2: Write a SQL query to retrieve all transactions where the category is "clothing" and quantity sold is more than 4 in the month of Nov-2022

SELECT 
	* 
FROM retail_sales_table
WHERE category = 'Clothing'
	AND 
	TO_CHAR(sales_date, 'YYYY-MM') = '2022-11'	
	AND quantity >= 4;


-- Q.3: Write SQL query to calculate the total sales for each category

SELECT 
	Category,
	SUM(total_sales) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales_table
GROUP BY 1;

-- Q.4 Write an SQL query to find the average age of customers who purchased items from the "Beauty" category

SELECT 
	ROUND(AVG(age),2) as Average_age
FROM retail_sales_table
WHERE Category = 'Beauty';


-- Q.5 Write an SQL query to find all transactions where the total_sale is greater than 1000

SELECT 
	*
FROM retail_sales_table
WHERE total_sales > 1000;	


-- Q.6 Write a SQL query to find the total number of transactions made by each gender in each category

SELECT 
	category,
	gender,
	COUNT(*) as total_transactions
FROM retail_sales_table
GROUP BY 
	category, 
	gender
ORDER BY category;


-- Q.7 Write an SQL query to calculate the average sale for each month. find out the best selling month in each year

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
--ORDER BY 1, 3 DESC;


-- Q.8: Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
	customer_id,
	SUM(total_sales) AS total_sales_per_customer
FROM retail_sales_table
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5



-- Q.9: Write a SQL Query to find the number of unique customers who purchased items from each category

SELECT
	category,
	COUNT(DISTINCT customer_id) AS count_of_unique_cust
	
FROM retail_sales_table
GROUP BY 1
ORDER BY 2 DESC


-- Q.10: Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon between 12 & 17 and Evening > 17)

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

-- END OF PROJECT