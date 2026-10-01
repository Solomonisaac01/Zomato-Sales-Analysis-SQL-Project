# 🍽️ Zomato Sales Analysis – SQL Project

## 📌 Project Overview

This project is a **Zomato Sales Analysis** project developed using **MySQL**.  
The goal is to analyze customer orders, restaurant performance, deliveries, rider performance, customer behavior, revenue trends, and order patterns using SQL.

The project uses a relational database containing five main tables:

- `customers`
- `restaurants`
- `orders`
- `riders`
- `deliveries`

The database and tables are created directly in SQL, followed by data exploration, data cleaning, relationship creation using foreign keys, and business-focused analysis.

The database is created as `zomato_sales_analysis`. The SQL source defines the five tables and their primary keys. 

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Analyze customer ordering behavior
- Identify popular dishes and ordering time slots
- Analyze customer spending and order value
- Identify high-value customers
- Analyze restaurant revenue
- Find orders without deliveries
- Compare restaurant performance by city
- Analyze customer activity and churn
- Measure cancellation rates
- Analyze rider delivery performance
- Calculate rider earnings
- Analyze rider ratings based on delivery time
- Identify restaurant growth trends
- Segment customers based on spending
- Analyze monthly sales trends
- Calculate Customer Lifetime Value (CLV)
- Identify seasonal demand patterns
- Compare city revenue across years

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **MySQL** | Database creation and SQL analysis |
| **SQL** | Data cleaning, transformation and analysis |
| **MySQL Workbench** | Query execution and database management |
| **CSV Data** | Source data imported into database tables |

---

## 🗄️ Database Schema

The project contains five related tables.

### 1. Customers

Stores customer registration information.

| Column | Description |
|---|---|
| `customer_id` | Unique customer ID |
| `customer_name` | Customer name |
| `reg_date` | Customer registration date |

### 2. Restaurants

Stores restaurant information.

| Column | Description |
|---|---|
| `restaurant_id` | Unique restaurant ID |
| `restaurant_name` | Restaurant name |
| `city` | Restaurant city |
| `opening_hours` | Restaurant opening hours |

### 3. Orders

Stores customer order information.

| Column | Description |
|---|---|
| `order_id` | Unique order ID |
| `customer_id` | Customer reference |
| `restaurant_id` | Restaurant reference |
| `order_item` | Ordered dish/item |
| `order_date` | Order date |
| `order_time` | Order time |
| `order_status` | Order status |
| `total_amount` | Total order amount |

### 4. Riders

Stores delivery rider information.

| Column | Description |
|---|---|
| `rider_id` | Unique rider ID |
| `rider_name` | Rider name |
| `sign_up` | Rider signup date |

### 5. Deliveries

Stores delivery information.

| Column | Description |
|---|---|
| `delivery_id` | Unique delivery ID |
| `order_id` | Order reference |
| `delivery_status` | Delivery status |
| `delivery_time` | Delivery completion time |
| `rider_id` | Rider reference |

---

## 🔗 Table Relationships

The project uses foreign keys to connect the tables:

```text
customers
    │
    │ customer_id
    ▼
orders
    │
    ├──────────────► restaurants
    │                 restaurant_id
    │
    ▼
deliveries
    │
    ▼
riders
    rider_id
```

### Relationships

```text
orders.customer_id
        ↓
customers.customer_id

orders.restaurant_id
        ↓
restaurants.restaurant_id

deliveries.order_id
        ↓
orders.order_id

deliveries.rider_id
        ↓
riders.rider_id
```

These relationships allow customer, restaurant, order, delivery, and rider information to be analyzed together.

---

## 🧹 Data Cleaning

Before analysis, the project checks for missing values in the major tables.

The cleaning process includes:

- Checking NULL customer records
- Checking NULL delivery records
- Checking NULL order records
- Checking NULL restaurant records
- Removing records containing required NULL values

This ensures that the analysis is performed using records with the required fields populated.

---

# 📊 Business Analysis & SQL Solutions

## 1. Top 5 Dishes Ordered by a Customer

**Business Question:**  
Find the top 5 most frequently ordered dishes by customer **Arjun Mehta** during the last one year.

**SQL concepts used:**

- `JOIN`
- `COUNT()`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- Date filtering

**Business Use:**  
Helps understand an individual customer's food preferences and ordering behavior.

---

## 2. Popular Order Time Slots

**Business Question:**  
Identify the time slots during which the highest number of orders are placed using two-hour intervals.

**SQL concepts used:**

- `EXTRACT(HOUR)`
- `CASE`
- `GROUP BY`
- `ORDER BY`

**Business Use:**  
Helps identify peak ordering periods for restaurant and delivery operations.

---

## 3. Average Order Value

**Business Question:**  
Find the Average Order Value (AOV) for customers who have placed more than 750 orders.

**SQL concepts used:**

- `AVG()`
- `COUNT()`
- `HAVING`
- `JOIN`
- `GROUP BY`

**Business Use:**  
Helps understand the average spending per order among highly active customers.

---

## 4. High-Value Customers

**Business Question:**  
Identify customers who have spent more than 100K on food orders.

**SQL concepts used:**

- `SUM()`
- `HAVING`
- `JOIN`
- `GROUP BY`

**Business Use:**  
Helps identify customers contributing significant revenue.

---

## 5. Orders Without Delivery

**Business Question:**  
Find restaurants and cities with orders that were placed but do not have a delivery record.

**SQL concepts used:**

- `LEFT JOIN`
- `IS NULL`
- `GROUP BY`
- `COUNT()`

**Business Use:**  
Can help identify potential delivery gaps and operational issues.

---

## 6. Restaurant Revenue Ranking

**Business Question:**  
Rank restaurants by total revenue within each city for the last year.

**SQL concepts used:**

- `SUM()`
- `RANK()`
- `PARTITION BY`
- `JOIN`
- Date filtering

**Business Use:**  
Allows restaurant revenue performance to be compared within individual cities.

---

## 7. Most Popular Dish by City

**Business Question:**  
Identify the most frequently ordered dish in each city.

**SQL concepts used:**

- `COUNT()`
- `RANK()`
- `PARTITION BY`
- `JOIN`
- Subquery

**Business Use:**  
Helps identify city-level food preferences.

---

## 8. Customer Churn Analysis

**Business Question:**  
Find customers who placed orders in 2025 but did not place orders in 2024.

**SQL concepts used:**

- Subqueries
- `IN`
- `NOT IN`
- Year-based filtering

**Business Use:**  
Helps analyze changes in customer activity across years.

---

## 9. Restaurant Cancellation Rate

**Business Question:**  
Compare restaurant cancellation rates between 2024 and 2025.

**SQL concepts used:**

- CTEs
- `COUNT()`
- `CASE`
- `LEFT JOIN`
- Percentage calculations

**Business Use:**  
Helps compare order completion/cancellation patterns across years.

---

## 10. Rider Average Delivery Time

**Business Question:**  
Calculate the average delivery time for each rider.

**SQL concepts used:**

- `TIMEDIFF()`
- `TIME_TO_SEC()`
- `CASE`
- `AVG()`
- `JOIN`

**Business Use:**  
Helps analyze rider delivery performance.

---

## 11. Monthly Restaurant Growth

**Business Question:**  
Calculate monthly restaurant order growth based on delivered orders.

**SQL concepts used:**

- CTEs
- `LAG()`
- `YEAR()`
- `MONTH()`
- Percentage calculation

**Business Use:**  
Helps identify whether restaurant order volume is increasing or decreasing month over month.

---

## 12. Customer Segmentation

Customers are divided into:

- **Gold**
- **Silver**

The segmentation is based on the customer's total spending compared with the overall Average Order Value.

**SQL concepts used:**

- CTE
- `SUM()`
- `AVG()`
- `IF()`
- `GROUP BY`

**Business Use:**  
Helps categorize customers according to spending behavior.

---

## 13. Rider Monthly Earnings

**Business Question:**  
Calculate each rider's monthly earnings assuming riders receive **8% of the order amount** for delivered orders.

**SQL concepts used:**

- `SUM()`
- `ROUND()`
- `YEAR()`
- `MONTH()`
- Multiple `JOIN`s

**Business Use:**  
Provides a monthly view of rider earnings.

---

## 14. Rider Ratings Analysis

Rider ratings are calculated according to delivery time:

| Delivery Time | Rating |
|---|---|
| Less than 30 minutes | 5-star |
| 30–40 minutes | 4-star |
| More than 40 minutes | 3-star |

**SQL concepts used:**

- CTEs
- `CASE`
- `TIMEDIFF()`
- `TIME_TO_SEC()`
- Conditional logic
- `GROUP BY`

**Business Use:**  
Provides a way to categorize rider performance based on delivery time.

---

## 15. Peak Order Day by Restaurant

**Business Question:**  
Identify the day of the week with the highest number of orders for each restaurant.

**SQL concepts used:**

- `DAYNAME()`
- `COUNT()`
- `RANK()`
- `PARTITION BY`
- `JOIN`

**Business Use:**  
Helps restaurants understand their busiest days.

---

## 16. Customer Lifetime Value

**Business Question:**  
Calculate the total revenue generated by each customer over all their orders.

**SQL concepts used:**

- `SUM()`
- `JOIN`
- `GROUP BY`

**Business Use:**  
Provides a simple Customer Lifetime Value (CLV) measure based on total historical order value.

---

## 17. Monthly Sales Trends

**Business Question:**  
Compare each month's sales with the previous month.

The result classifies the trend as:

- `↑ Growth`
- `↓ Decline`
- `No Change`

**SQL concepts used:**

- CTE
- `LAG()`
- `IFNULL()`
- `CASE`
- Monthly aggregation

**Business Use:**  
Helps identify changes in monthly sales performance.

---

## 18. Rider Efficiency

**Business Question:**  
Evaluate rider efficiency using average delivery time and identify the minimum and maximum average delivery times.

**SQL concepts used:**

- CTE
- `AVG()`
- `MIN()`
- `MAX()`
- `TIMEDIFF()`

**Business Use:**  
Helps examine variation in rider delivery performance.

---

## 19. Order Item Popularity by Season

**Business Question:**  
Track the popularity of order items across seasons and identify demand patterns.

The project categorizes months into:

- Spring
- Summer
- Winter

**SQL concepts used:**

- `EXTRACT(MONTH)`
- `CASE`
- `COUNT()`
- Subqueries
- `GROUP BY`

**Business Use:**  
Helps identify seasonal food-ordering patterns.

---

## 20. City Revenue Ranking – 2024

**Business Question:**  
Rank cities based on total revenue generated during 2024.

**SQL concepts used:**

- `SUM()`
- `RANK()`
- `JOIN`
- Year filtering

---

## 21. City Revenue Ranking – 2025

**Business Question:**  
Rank cities based on total revenue generated during 2025.

This allows the 2025 city revenue results to be analyzed separately from 2024.

**SQL concepts used:**

- `SUM()`
- `RANK()`
- `JOIN`
- Year filtering

---

## 22. Customer Registration by Year

**Business Question:**  
Find the number of customers who registered in each year.

**SQL concepts used:**

- `YEAR()`
- `COUNT()`
- `GROUP BY`

**Business Use:**  
Helps understand customer registration trends.

---

## 23. Orders in Customer Registration Year

**Business Question:**  
For each customer, find the number of orders and total spending during the year they registered.

**SQL concepts used:**

- `LEFT JOIN`
- `YEAR()`
- `COUNT()`
- `SUM()`
- `COALESCE()`

**Business Use:**  
Helps analyze customer activity during their registration year.

---

## 24. Rider Orders in Signup Year

**Business Question:**  
Find the number of delivered orders handled by each rider during the same year they signed up.

**SQL concepts used:**

- `LEFT JOIN`
- `YEAR()`
- `COUNT()`
- Multiple table relationships

**Business Use:**  
Helps examine rider activity during their initial signup year.

---

## 25. Top 3 Dishes by Customer

**Business Question:**  
Find the top 3 most frequently ordered dishes for each customer during the last year.

**SQL concepts used:**

- CTE
- `DENSE_RANK()`
- `COUNT()`
- `GROUP BY`
- Date filtering

**Business Use:**  
Helps understand individual customer preferences and repeat-order behavior.

---

# 🧠 SQL Concepts Demonstrated

This project demonstrates practical SQL skills including:

```text
CREATE DATABASE
CREATE TABLE
DROP TABLE
PRIMARY KEY
FOREIGN KEY
ALTER TABLE
SELECT
WHERE
IS NULL
DELETE
JOIN
LEFT JOIN
GROUP BY
HAVING
ORDER BY
LIMIT
COUNT()
COUNT(DISTINCT)
SUM()
AVG()
MIN()
MAX()
ROUND()
CASE
IF()
COALESCE()
IFNULL()
CTE
Subqueries
RANK()
DENSE_RANK()
LAG()
PARTITION BY
YEAR()
MONTH()
DAYNAME()
EXTRACT()
TIMEDIFF()
TIME_TO_SEC()
DATE_SUB()
```

---

# 📈 Key Analytical Areas

The project covers several important areas of business analytics:

### 👥 Customer Analytics
- Customer spending
- Customer segmentation
- Customer lifetime value
- Customer registration trends
- Customer ordering behavior
- Customer churn/activity

### 🍴 Restaurant Analytics
- Restaurant revenue
- Restaurant ranking
- Popular dishes
- Peak ordering days
- Monthly restaurant growth
- Restaurant cancellation rates

### 🚴 Rider Analytics
- Average delivery time
- Rider efficiency
- Rider earnings
- Rider ratings
- Delivered orders

### 💰 Revenue Analytics
- Total revenue
- Average order value
- High-value customers
- Monthly sales trends
- City-level revenue
- Restaurant-level revenue

### ⏰ Time-Based Analytics
- Popular order time slots
- Monthly trends
- Yearly comparisons
- Registration-year analysis
- Seasonal demand

---

# 📚 Complete SQL Queries & Explanations

The following section contains the analysis queries from the uploaded `zomato_sales_analysis.sql` project, followed by an explanation of what each query does and why it is useful. The SQL below is reproduced from the project source rather than replaced with a different implementation.

## 1. Write a query to find the top 5 most frequently ordered dishes by customer called "Arjun Mehta" in the last 1 year.

**Explanation:** Joins customers with orders, filters for Arjun Mehta and the last one year, counts orders for each dish, and returns the five most frequently ordered dishes.

```sql
-- 1. Write a query to find the top 5 most frequently ordered dishes by customer called "Arjun Mehta" in the last 1 year.

SELECT 
    c.customer_name,
    o.order_item AS dishes,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE 
    c.customer_name = 'Arjun Mehta'
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    c.customer_name, o.order_item
ORDER BY 
    total_orders DESC
LIMIT 5;
-- Another Approach
WITH ranked AS (
  SELECT 
      c.customer_name,
      o.order_item AS dishes,
      COUNT(o.order_id) AS total_orders,
      DENSE_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS rnk
  FROM customers c
  JOIN orders o 
      ON c.customer_id = o.customer_id
  WHERE 
      c.customer_name = 'Arjun Mehta'
      AND o.order_date >= current_date() - INTERVAL 1 YEAR
  GROUP BY 
      c.customer_name, o.order_item
)
SELECT customer_name, dishes,total_orders
FROM ranked
WHERE rnk <= 5;
```

## 2. Popular Time Slots

**Explanation:** Groups orders into two-hour time windows and counts orders in each slot. This identifies the periods with the highest order activity.

```sql
-- 2. Popular Time Slots
-- Question: Identify the time slots during which the most orders are placed. based on 2-hour intervals.

SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 0 AND 1 THEN '00:00 - 02:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 2 AND 3 THEN '02:00 - 04:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 4 AND 5 THEN '04:00 - 06:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 6 AND 7 THEN '06:00 - 08:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 8 AND 9 THEN '08:00 - 10:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 10 AND 11 THEN '10:00 - 12:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 12 AND 13 THEN '12:00 - 14:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 14 AND 15 THEN '14:00 - 16:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 16 AND 17 THEN '16:00 - 18:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 18 AND 19 THEN '18:00 - 20:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 20 AND 21 THEN '20:00 - 22:00'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 22 AND 23 THEN '22:00 - 00:00'
    END AS time_slot,
    COUNT(order_id) AS order_count
FROM Orders
GROUP BY time_slot
ORDER BY order_count DESC;

-- Another Approach

select floor(EXTRACT(HOUR FROM order_time)/2)*2 as start_time,
floor(EXTRACT(HOUR FROM order_time)/2)*2+2 as end_time,
count(*) as cnt
from orders
group by 1,2
order by 3 desc;
```

## 3. Order Value Analysis

**Explanation:** Joins customers and orders, groups by customer, and calculates Average Order Value (AOV) only for customers with more than 750 orders.

```sql
-- 3. Order Value Analysis
-- Question: Find the average order value per customer who has placed more than 750 orders.
-- Return customer_name, and aov(average order value)

select c.customer_name,avg(o.total_amount) as aov
from orders o 
join customers c
on o.customer_id=c.customer_id
group by c.customer_id
having(count(order_id))>750;
```

## 4. High-Value Customers

**Explanation:** Aggregates customer orders and uses HAVING to return customers whose total spending exceeds 100,000.

```sql
-- 4. High-Value Customers
-- Question: List the customers who have spent more than 100K in total on food orders.
-- return customer_name, and customer_id!

select c.customer_id,c.customer_name
from orders o 
join customers c
on o.customer_id=c.customer_id
group by c.customer_id
having sum(o.total_amount)>100000
order by 1;
```

## 5. Orders Without Delivery

**Explanation:** Uses LEFT JOIN to identify orders that have no matching delivery record, then summarizes those undelivered orders by restaurant and city.

```sql
-- 5. Orders Without Delivery
-- Question: Write a query to find orders that were placed but not delivered. 
-- Return each restuarant name, city and number of not delivered orders 

select r.restaurant_name,r.city,count(*) as cnt_not_delivered
from  orders o
left join
restaurants r
on r.restaurant_id=o.restaurant_id
left join deliveries d
on o.order_id=d.order_id
where d.delivery_id is null
group by r.restaurant_id
order by 3 desc;


select r.restaurant_name,r.city,count(*) as cnt_not_delivered
from  orders o
left join
restaurants r
on r.restaurant_id=o.restaurant_id
where order_id not in (select order_id from deliveries)
group by r.restaurant_id
order by 3 desc;
```

## 6. Restaurant Revenue Ranking:

**Explanation:** Calculates restaurant revenue for the last year and uses RANK with PARTITION BY city to rank restaurants within each city.

```sql
-- 6. Restaurant Revenue Ranking: 
-- Rank restaurants by their total revenue from the last year, including their name, 
-- total revenue, and rank within their city.

SELECT 
		r.city,
		r.restaurant_name,
		SUM(o.total_amount) as revenue,
		RANK() OVER(PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) as rnk
FROM orders as o
JOIN 
restaurants as r
ON r.restaurant_id = o.restaurant_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL 1 year
GROUP BY 1, 2;
```

## 7. Most Popular Dish by City:

**Explanation:** Counts orders for each dish in each city and uses RANK partitioned by city to identify the most frequently ordered dish per city.

```sql
-- 7. Most Popular Dish by City: 
-- Identify the most popular dish in each city based on the number of orders.

SELECT * 
FROM
(SELECT 
	r.city,
	o.order_item as dish,
	COUNT(order_id) as total_orders,
	RANK() OVER(PARTITION BY r.city ORDER BY COUNT(order_id) DESC) as rnk
FROM orders as o
JOIN 
restaurants as r
ON r.restaurant_id = o.restaurant_id
GROUP BY 1, 2
) as t1
WHERE rnk = 1;
```

## 8. Customer Churn:

**Explanation:** Finds customers who ordered in 2025 but did not order in 2024. This is useful for identifying changes in customer activity between the two years.

```sql
-- 8. Customer Churn: 
-- Find customers who haven’t placed an order in 2024 but did in 2025.

select customer_id,customer_name
from customers c
where customer_id in (
select customer_id 
from orders 
where year(order_date)='2025') and customer_id not in (
select customer_id 
from orders 
where year(order_date)='2024');

SELECT DISTINCT customer_id FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2025
AND customer_id NOT IN 
(SELECT DISTINCT customer_id FROM orders WHERE EXTRACT(YEAR FROM order_date) = 2024);
```

## 9. Cancellation Rate Comparison:

**Explanation:** Builds separate yearly order counts for each restaurant, then compares the number of orders without a delivery record to total orders to calculate cancellation rates.

```sql
-- 9. Cancellation Rate Comparison: 
-- Calculate and compare the order cancellation rate for each restaurant between the 
-- current year and the previous year.

with cte as (select o.restaurant_id,count(o.order_id) as total_orders,count(case when d.delivery_id is null then 1 end) as cancelled_orders_cnt
from orders o 
left join deliveries d 
on o.order_id=d.order_id
where year(o.order_date)=2024
group by o.restaurant_id),
cte1 as (select o.restaurant_id,count(o.order_id) as total_orders,count(case when d.delivery_id is null then 1 end) as cancelled_orders_cnt
from orders o 
left join deliveries d 
on o.order_id=d.order_id
where year(o.order_date)=2025
group by o.restaurant_id)

select cte.restaurant_id,(cte.cancelled_orders_cnt/cte.total_orders)*100 as last_year_can_rate,(cte1.cancelled_orders_cnt/cte1.total_orders)*100 as cur_year_can_rate
from cte join cte1 
on cte.restaurant_id=cte1.restaurant_id;
```

## 10. Rider Average Delivery Time:

**Explanation:** Joins orders and deliveries, calculates delivery duration while handling deliveries that cross midnight, and averages the delivery time for each rider.

```sql
-- 10. Rider Average Delivery Time: 
-- Determine each rider's average delivery time.

select d.rider_id,avg(case
        WHEN delivery_time >= order_time 
            THEN ROUND(TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) / 60, 2)
        ELSE ROUND((TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) + 24*3600) / 60, 2)
    END) AS diff_mins,avg(case
        WHEN delivery_time >= order_time 
            THEN ROUND(TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) / 3600, 2)
        ELSE ROUND((TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) + 24*3600) / 3600, 2)
    END) AS diff_hrs
from orders o
join
deliveries d 
on o.order_id=d.order_id
where d.delivery_status='delivered'
group by 1;
```

## 11. Monthly Restaurant Growth Ratio:

**Explanation:** Aggregates delivered orders by restaurant and month, uses LAG to retrieve the previous month's order count, and calculates month-over-month growth.

```sql
-- 11. Monthly Restaurant Growth Ratio: 
-- Calculate each restaurant's growth ratio based on the total number of delivered orders since its joining

WITH monthly_orders AS (
    SELECT 
        o.restaurant_id,
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        COUNT(o.order_id) AS cnt
    FROM orders o
    LEFT JOIN deliveries d 
        ON o.order_id = d.order_id
    WHERE d.delivery_status = 'Delivered'
    GROUP BY o.restaurant_id, YEAR(o.order_date), MONTH(o.order_date)
),pre_cnt as (
SELECT 
    restaurant_id,
    order_year,
    order_month,
    cnt,
    LAG(cnt, 1) OVER(
        PARTITION BY restaurant_id 
        ORDER BY order_year, order_month
    ) AS prev_month_cnt
FROM monthly_orders
ORDER BY restaurant_id, order_year, order_month)

select restaurant_id,
    order_year,
    order_month,
    prev_month_cnt,cnt,round((cnt - prev_month_cnt)/ NULLIF(prev_month_cnt, 0)*100,2) as growth_precent
    from pre_cnt
    ORDER BY restaurant_id, order_year, order_month;


select o.restaurant_id,date_format(order_date,'%Y-%m') as y_m,count(o.order_id) as cnt
from orders o 
left join deliveries d 
on o.order_id=d.order_id
where d.delivery_status='Delivered'
group by 1,2
order by 1,2;
```

## 12. Customer Segmentation:

**Explanation:** Calculates total orders and revenue per customer and labels each customer Gold when total spending is above the overall average order value; otherwise the customer is Silver.

```sql
-- 12. Customer Segmentation: 
-- Segment customers into 'Gold' or 'Silver' groups based on their total spending compared to the average order value (AOV).  If a customer's total spending exceeds 
-- the AOV, label them as 'Gold'; otherwise, label them as 'Silver'. Write an SQL query to determine each segment's  total number of orders and total revenue

with cte as (select customer_id,count(order_id)as total_orders,sum(total_amount) as total_revenue,if(sum(total_amount)>(select avg(total_amount) from orders),"Gold","Silver") as Segment
from orders
group by 1)

select c.segment,sum(c.total_orders) as total_orders,sum(c.total_revenue) as total_revenue
from cte c
group by 1;
```

## 13. Rider Monthly Earnings:

**Explanation:** Joins orders, deliveries, and riders and calculates monthly rider earnings as 8% of the total amount for delivered orders.

```sql
-- 13. Rider Monthly Earnings: 
-- Calculate each rider's total monthly earnings, assuming they earn 8% of the order amount.

select r.rider_id,YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,round(sum(total_amount*8/100)) as total_earnings
from orders o 
join deliveries d 
on o.order_id=d.order_id
join riders r
on r.rider_id=d.rider_id
where d.delivery_status='Delivered'
group by 1,2,3
order by 1,2,3;
```

## 14. Rider Ratings Analysis:

**Explanation:** Calculates delivery duration and assigns a rating category using CASE: below 30 minutes is 5-star, 30–40 minutes is 4-star, and above 40 minutes is 3-star. It then counts ratings per rider.

```sql
-- 14. Rider Ratings Analysis: 
-- Find the number of 5-star, 4-star, and 3-star ratings each rider has.
-- riders receive this rating based on delivery time.
-- If orders are delivered less than 30 minutes of order received time the rider get 5 star rating,
-- if they deliver 30 and 40 minute they get 4 star rating 
-- if they deliver after 40 minute they get 3 star rating.

with delivery_time as (select o.order_id,o.order_time,
			d.delivery_time,d.rider_id,TIMEDIFF(delivery_time, order_time) as diffcase,case
        WHEN delivery_time >= order_time 
            THEN ROUND(TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) / 60, 2)
        ELSE ROUND((TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) + 24*3600) / 60, 2)
    END AS diff_mins
from orders o
join
deliveries d 
on o.order_id=d.order_id
where d.delivery_status='delivered'),ratings as (
select rider_id,diff_mins,case when diff_mins<30 then "5-star" 
when diff_mins between 30 and 40 then "4-star"
else"3-star" end as rating from delivery_time)

select rider_id,rating,count(*) as cnt
from ratings
GROUP BY 1, 2
ORDER BY 1, 3 DESC;
```

## 15. Order Frequency by Day:

**Explanation:** Counts orders by restaurant and day of week and uses RANK to identify the peak order day for each restaurant.

```sql
-- 15. Order Frequency by Day: 
-- Analyze order frequency per day of the week and identify the peak day for each restaurant.

SELECT restaurant_name,day,total_orders FROM
(   SELECT 
		r.restaurant_name,
		DAYNAME(o.order_date) as day,
		COUNT(o.order_id) as total_orders,
		RANK() OVER(PARTITION BY r.restaurant_name ORDER BY COUNT(o.order_id)  DESC) as rnk
	FROM orders as o
	JOIN
	restaurants as r
	ON o.restaurant_id = r.restaurant_id
	GROUP BY 1, 2
	ORDER BY 1, 3 DESC
	) as t1
WHERE rnk = 1;
```

## 16. Customer Lifetime Value (CLV):

**Explanation:** Sums all order amounts for each customer to calculate a simple Customer Lifetime Value (CLV).

```sql
-- 16. Customer Lifetime Value (CLV): 
-- Calculate the total revenue generated by each customer over all their orders.

SELECT 
	o.customer_id,
	c.customer_name,
	SUM(o.total_amount) as CLV
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
GROUP BY 1, 2;
```

## 17. Monthly Sales Trends:

**Explanation:** Aggregates monthly sales, uses LAG to compare each month with the previous month, and labels the result as growth, decline, or no change.

```sql
-- 17. Monthly Sales Trends: 
-- Identify sales trends by comparing each month's total sales to the previous month.

with cte as (select year(order_date) as year,month(order_date) as month,sum(total_amount) as monthly_sales
from orders
group by 1,2
order by 1,2),
prev_month as (select *,
ifnull(lag(monthly_sales,1) over(order by year,month),0) as prev_month_sale
from cte)

select * , case when prev_month_sale<monthly_sales then '↑ Growth' when prev_month_sale>monthly_sales then '↓ Decline' else 'No Change' end as trend
from prev_month;
```

## 18. Rider Efficiency:

**Explanation:** Calculates each rider's average delivered-order time and returns the minimum and maximum average delivery times across riders.

```sql
-- 18. Rider Efficiency: 
-- Evaluate rider efficiency by determining average delivery times and identifying those with the lowest and highest averages.

with avg_del_time as (select d.rider_id,avg(case
        WHEN delivery_time >= order_time 
            THEN ROUND(TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) / 60, 2)
        ELSE ROUND((TIME_TO_SEC(TIMEDIFF(delivery_time, order_time)) + 24*3600) / 60, 2)
    END) AS diff_mins
from orders o
join
deliveries d 
on o.order_id=d.order_id
where d.delivery_status='delivered'
group by 1)

select min(diff_mins),max(diff_mins)
from avg_del_time;
```

## 19. Order Item Popularity:

**Explanation:** Extracts the month from each order date, assigns a season using CASE, and counts order items by season to study seasonal demand.

```sql
-- 19. Order Item Popularity: 
-- Track the popularity of specific order items over time and identify seasonal demand spikes.

SELECT 
	order_item,
	seasons,
	COUNT(order_id) as total_orders
FROM 
(
SELECT 
		*,
		EXTRACT(MONTH FROM order_date) as month,
		CASE 
			WHEN EXTRACT(MONTH FROM order_date) BETWEEN 4 AND 6 THEN 'Spring'
			WHEN EXTRACT(MONTH FROM order_date) > 6 AND 
			EXTRACT(MONTH FROM order_date) < 9 THEN 'Summer'
			ELSE 'Winter'
		END as seasons
	FROM orders
) as t1
GROUP BY 1, 2
ORDER BY 1,3 DESC;
```

## 20. Rank each city based on the total revenue for last year 2024

**Explanation:** Aggregates 2024 revenue by city and applies RANK to create a city revenue ranking for that year.

```sql
-- 20. Rank each city based on the total revenue for last year 2024

select r.city,sum(total_amount) as total_revenue,RANK() OVER(ORDER BY SUM(total_amount) DESC) as city_rank
from restaurants r 
join orders o 
on r.restaurant_id=o.restaurant_id
where year(order_date)='2024'
group by 1;
```

## 21. Rank each city based on the total revenue for this year 2025

**Explanation:** Aggregates 2025 revenue by city and applies RANK to create a city revenue ranking for that year.

```sql
-- 21. Rank each city based on the total revenue for this year 2025

select r.city,sum(total_amount) as total_revenue,RANK() OVER(ORDER BY SUM(total_amount) DESC) as city_rank
from restaurants r 
join orders o 
on r.restaurant_id=o.restaurant_id
where year(order_date)='2025'
group by 1;
```

## 22. how many customers registered in each year

**Explanation:** Groups customers by registration year and counts registrations to show how customer acquisition changes over time.

```sql
-- 22. how many customers registered in each year

select year(reg_date),count(customer_id) as cnt
from customers
group by 1;
```

## 23. For each customer, how many orders did they place in the year they registered?

**Explanation:** Uses a LEFT JOIN with a year condition so each customer is matched only with orders from their registration year, then counts orders and sums spending.

```sql
-- 23. For each customer, how many orders did they place in the year they registered?

SELECT 
    c.customer_id,
    c.customer_name,
    YEAR(c.reg_date) AS registration_year,
    COUNT(o.order_id) AS orders_in_registration_year,
    COALESCE(SUM(o.total_amount), 0) AS total_spent_in_registration_year
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    AND YEAR(o.order_date) = YEAR(c.reg_date)
GROUP BY c.customer_id, c.customer_name, YEAR(c.reg_date)
ORDER BY c.customer_id;
```

## 24. How many orders were delivered by each rider in the same year they signed up?

**Explanation:** Joins riders to deliveries and orders, filters delivered orders to the rider's signup year, and counts those orders for each rider.

```sql
-- 24. How many orders were delivered by each rider in the same year they signed up?

SELECT 
    r.rider_id,
    r.rider_name,
    YEAR(r.sign_up) AS signup_year,
    COUNT(o.order_id) AS delivered_orders_in_signup_year
FROM riders r
LEFT JOIN deliveries d
    ON r.rider_id = d.rider_id
LEFT JOIN orders o
    ON d.order_id = o.order_id
    AND d.delivery_status = 'Delivered'
    AND YEAR(o.order_date) = YEAR(r.sign_up)
GROUP BY 
    r.rider_id, 
    r.rider_name, 
    YEAR(r.sign_up)
ORDER BY r.rider_id;
```

## 25. Write a query to find the top 3 most frequently ordered dishes by each customer in the last 1 year.

**Explanation:** Counts dishes ordered by each customer during the last year and uses DENSE_RANK to identify the top three ranked dishes.

```sql
-- 25. Write a query to find the top 3 most frequently ordered dishes by each customer in the last 1 year.

WITH ranked AS (
  SELECT 
      c.customer_name,
      o.order_item AS dishes,
      COUNT(o.order_id) AS total_orders,
      DENSE_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS rnk
  FROM customers c
  JOIN orders o 
      ON c.customer_id = o.customer_id
  WHERE 
	 o.order_date >= current_date() - INTERVAL 1 YEAR
  GROUP BY 1,2
  order by 1,3
)
SELECT customer_name, dishes,total_orders
FROM ranked
WHERE rnk <= 3;
```

---

# 💼 Skills Demonstrated

This project demonstrates my ability to:

- Design a relational database
- Create tables using SQL
- Define primary and foreign keys
- Clean data using SQL
- Combine multiple tables using joins
- Write complex analytical queries
- Use CTEs and subqueries
- Apply window functions
- Analyze customer behavior
- Analyze restaurant performance
- Analyze rider performance
- Perform time-based analysis
- Solve business problems using SQL

---

# 🔍 SQL Query Techniques Used

The complete analysis demonstrates practical use of:

- `JOIN` and `LEFT JOIN` for combining related tables
- `GROUP BY` and `HAVING` for aggregation and filtering aggregated results
- Aggregate functions such as `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`
- `CASE` for business rules and classifications
- CTEs using `WITH`
- Subqueries
- Window functions including `RANK`, `DENSE_RANK`, and `LAG`
- `PARTITION BY` for rankings within groups
- Date functions such as `YEAR`, `MONTH`, `DAYNAME`, `EXTRACT`, and `DATE_SUB`
- Time functions such as `TIMEDIFF` and `TIME_TO_SEC`
- `COALESCE` and `IFNULL` for handling missing values
- Conditional calculations and percentage calculations

---

# 🚀 Project Outcome

This project converts raw food-delivery data into meaningful business analysis using SQL.

It demonstrates practical experience in **database design, data cleaning, relational data analysis, aggregation, window functions, customer analytics, restaurant analytics, delivery analytics, and business problem solving**.

---

# 👨‍💻 Author

**Solomon Isaac**

Aspiring Data Analyst | SQL | Excel | Power BI | Python
