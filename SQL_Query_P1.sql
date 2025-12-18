-- SQL Retqil Sqles Qnqlysis - P1



--Create Table

CREATE TABLE retaile_sales

           (
                transactions_id INT PRIMARY KEY,
                sale_date  DATE ,
                sale_time  TIME ,
                customer_id INT,
                gender  VARCHAR(15),
                age  INT ,
                category	VARCHAR(15),
                quantity  INT,
				price_per_unit	FLOAT,
                cogs	FLOAT,
                total_sale FLOAT
           );

SELECT * FROM  retaile_sales; 


SELECT 
      COUNT(*)
FROM  retaile_sales;

--
SELECT * FROM  retaile_sales 
WHERE 
     transactions_id IS NULL
	 or 
	 sale_date IS NULL
     OR
	 sale_time IS NULL
     OR
	 customer_id IS NULL
     OR
	 gender  IS NULL
     OR
	 age  IS NULL
     OR
	 category	IS NULL
     OR
	 quantity  IS NULL
	 OR
	 price_per_unit	IS NULL
     OR
	 cogs	IS NULL
     OR
	 total_sale IS NULL;

--DATA CLEANING

DELETE FROM retaile_sales
WHERE 
     transactions_id IS NULL
	 or 
	 sale_date IS NULL
     OR
	 sale_time IS NULL
     OR
	 customer_id IS NULL
     OR
	 gender  IS NULL
     OR
	 age  IS NULL
     OR
	 category	IS NULL
     OR
	 quantity  IS NULL
	 OR
	 price_per_unit	IS NULL
     OR
	 cogs	IS NULL
     OR
	 total_sale IS NULL;
--DATA EXPLORATION 

--HOW MANY SALES WE HAVE 
 SELECT COUNT (*) AS total_sale FROM retaile_sales

--HOW MANY UNIQUE CUSTOMERS WE HAVE ?
SELECT COUNT (DISTINCT customer_id)AS UNIQUE_CUSTOMERS FROM retaile_sales

--TOTAL category AND NAMES

SELECT DISTINCT category FROM retaile_sales

--businesses  KEY PROBLEMES & ANSWERS

--1 retrive all columns for sales on '2022-11-05'
SELECT *
FROM retaile_sales
WHERE sale_date = '2022-11-05';

--transaction where category s 'clothing ' and the quqntity sold is more than 3 in the month of nov-2022
 
SELECT *
FROM retaile_sales
WHERE 
     category = 'Clothing'
     AND 
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantity > 3

--calculate the totale for each category 

SELECT 
      category,
	  SUM(total_sale) AS net_sale,
	  COUNT(*) AS totale_orders
FROM retaile_sales
GROUP BY 1

--average age from "Beauty" customers
SELECT
      ROUND(AVG(age),2) AS avg_age 
FROM retaile_sales
WHERE category = 'Beauty'

--find transactions wher total_sale > 1000
SELECT * FROM retaile_sales
WHERE total_sale >1000

--find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
      category,
	  gender,
	  COUNT(*) as total_trans
FROM retaile_sales
GROUP BY
        category,
	    gender
ORDER BY 1

--calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM
(
SELECT
      EXTRACT(YEAR FROM sale_date) AS year,
      EXTRACT(MONTH FROM sale_date) AS month,
	  AVG(total_sale) as avg_sale,
      RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) AS Rank
FROM retaile_sales
GROUP BY 1,2
)as T1
WHERE Rank = 1
--ORDER BY 1,2


--find the top 5 customers based on the highest total sales 

SELECT
      customer_id,
	  SUM(total_sale)
FROM retaile_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Find the number of unique customers who purchased items from each category


SELECT
      category,
	  COUNT(DISTINCT customer_id) AS unique_customers
FROM retaile_sales
GROUP BY category

--create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
      CASE
	      WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
		  WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
	  END AS shift
FROM retaile_sales
)
SELECT
      shift,
      COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

--END 





















