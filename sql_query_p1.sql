-- SQL Retail Sales Analysis - p1
CREATE DATABASE sql_project_p1;
-- create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
            transactions_id INT PRIMARY KEY,
            sale_date DATE,
            sale_time	TIME,
            customer_id	INT,
            gender	VARCHAR(15),
            age	INT (15),
            category VARCHAR(15),
            quantiy	INT,
            price_per_unit	FLOAT,
            cogs	FLOAT,
            total_sale FLOAT
            );
SELECT * FROM retail_sales
LIMIT 10;
SELECT *FROM retail_sales 
WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR 
customer_id IS NULL
OR 
gender IS NULL
OR
age IS NULL
OR 
category IS NULL 
OR 
quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;
-- Data Exploration
-- How many sales do we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customers do we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

SELECT DISTINCT category as total_sale FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
ALTER TABLE retail_sales
CHANGE COLUMN quantiy quantity INT;
-- Write an SQL Query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT category,
       SUM(quantity) AS total_quantity
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >=4
GROUP BY category;

-- Write a SQL query to calculae the total sales (total_sale) for each category.
SELECT category, 
       SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
ROUND (AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender,
COUNT(*) AS total_trans
FROM retail_sales
GROUP BY 
category,gender
ORDER BY 1;

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH monthly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
)
SELECT *
FROM (
    SELECT 
        year,
        month,
        avg_sale,
        RANK() OVER (
            PARTITION BY year 
            ORDER BY avg_sale DESC
        ) 
    FROM monthly_sales
) AS t1
;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total_sales
SELECT  customer_id,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9. Write a SQL query to find the number of unique customers who purchased items for each category
SELECT 
category, COUNT(customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, Evening>17
WITH hourly_sale
AS 
(
SELECT *,
CASE 
	WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS shift		
FROM retail_sales
)
SELECT 
shift, 
COUNT(*) AS total_orders
 FROM hourly_sale
 GROUP BY shift;
-- SELECT EXTRACT(HOUR FROM CURRENT_TIME)

-- End of project.







