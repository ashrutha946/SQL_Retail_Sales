Create database Project2
Create TABLE Retail_Sales
            (
                 transactions_Id INT Primary Key,
				 Sale_Date DATE,
                 Sale_Time TIME,
                 Customer_ID INT,
                 Gender VARCHAR(15),
                 AGE INT,
                 Category VARCHAR(15),
                 Quantity INT,
                 Price_per_unit FLOAT,
                 COGS FLOAT,
                 Total_Sale FLOAT
				
			);
select * from retail_sales;

select 
    count(*)
from retail_sales;

select * from retail_sales
WHERE transactions_Id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
COGS IS NULL
OR
Total_sale IS NULL;

----- How many sales we have--------
select count(*) as total_sales from retail_sales;

------How many customers we have------------

select count(customer_ID) as total_customers from retail_sales;

----------How many Unique customers we have?-------------
select count(DISTINCT customer_Id) as unique_cus from retail_sales;

-----------How many Unique categories we have?-----------
select DISTINCT category from retail_sales;

-----DATA ANALYSIS & Key Problems & Answers-------------

select * from retail_sales where sale_date='2022-11-05';

2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select *
from retail_sales
where category = 'clothing'
AND
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND
quantity >=4;

3. ----------Write a SQL query to calculate the total sales (total_sale) for each category.:----------

select
    category,
	SUM(total_sale) AS Net_Sale,
    COUNT(*) AS Total_Orders
    FROM retail_sales
    GROUP BY category;
    
4.-----------Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:-----------

select 
ROUND(AVG(age), 2) AS Average_Age
FROM retail_sales
WHERE category = 'Beauty';

5. ------------Write a SQL query to find all transactions where the total_sale is greater than 1000------------

select * FROM retail_sales
WHERE total_sale > 1000

6. ----Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category-----

select category,
	   gender,
	   COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category,
         gender
ORDER BY category;

7. **Write a SQL query to find the top 5 customers based on the highest total sales **

use project2;

select * from retail_sales;

select customer_ID,
SUM(total_sale) AS Total_Sales
From retail_sales
GROUP BY customer_ID
ORDER BY total_sales DESC
LIMIT 5;

#########Write a SQL query to find the number of unique customers who purchased items from each category#######

select category, 
COUNT(DISTINCT customer_ID) as Unique_Customers
from retail_sales
GROUP BY category;

####Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)####

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
