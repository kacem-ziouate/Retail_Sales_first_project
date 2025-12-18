# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`

This project showcases practical SQL skills used by data analysts to work with retail sales data. It covers the complete process of building a database, exploring the data, cleaning inconsistencies, and extracting meaningful insights using SQL queries.

The goal of this project is to simulate real-world data analysis tasks by answering business-related questions through structured query language (SQL).

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Table Creation**: The project starts by creating A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql

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
```
<img width="1552" height="885" alt="Screenshot 2025-12-18 at 16 30 52" src="https://github.com/user-attachments/assets/8313aa5c-cc75-493c-bfee-20c0108d7e89" />

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT (DISTINCT customer_id)AS UNIQUE_CUSTOMERS FROM retaile_sales
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

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
<img width="1554" height="891" alt="Screenshot 2025-12-18 at 16 37 40" src="https://github.com/user-attachments/assets/50dbb813-786f-4c84-9f47-3ddbe53e10e2" />

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```
<img width="1551" height="884" alt="Screenshot 2025-12-18 at 16 38 12" src="https://github.com/user-attachments/assets/51774745-715d-4a21-80c8-b87211a1b7eb" />

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```
<img width="1552" height="883" alt="Screenshot 2025-12-18 at 16 39 49" src="https://github.com/user-attachments/assets/dbe979bf-512d-4087-bce9-2f302d784655" />

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```
<img width="648" height="374" alt="Screenshot 2025-12-18 at 16 41 04" src="https://github.com/user-attachments/assets/a0ef5fe0-6468-4752-bd84-ff42e12e4d53" />

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```
<img width="1551" height="685" alt="Screenshot 2025-12-18 at 16 42 26" src="https://github.com/user-attachments/assets/485ed66c-6770-4d84-a475-da7b5e87fb10" />


6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
```
<img width="1062" height="641" alt="Screenshot 2025-12-18 at 16 43 40" src="https://github.com/user-attachments/assets/9e23c9db-272a-4ad3-ad9b-0263934696a0" />

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```
<img width="1042" height="533" alt="Screenshot 2025-12-18 at 16 46 35" src="https://github.com/user-attachments/assets/ae1ccb77-49ef-41f2-948b-376fdfa03e9d" />

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```
<img width="1009" height="630" alt="Screenshot 2025-12-18 at 16 47 15" src="https://github.com/user-attachments/assets/77bb505a-2e58-4bdb-8df7-c4bd78c77ac0" />

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
      category,
	  COUNT(DISTINCT customer_id) AS unique_customers
FROM retaile_sales
GROUP BY category
```
<img width="1009" height="630" alt="Screenshot 2025-12-18 at 16 47 15" src="https://github.com/user-attachments/assets/e6df98be-28a9-403d-82f7-1b136587583d" />

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```
<img width="1554" height="883" alt="Screenshot 2025-12-18 at 16 49 09" src="https://github.com/user-attachments/assets/11d5d2c0-6460-4caa-9985-acc79c8bbd7f" />

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

## Author - KACEM ZIOUATE 

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 

