-- create database 

create database zomato_sales_analysis;
use zomato_sales_analysis;


-- drop table if exist

drop table if exists customers;
drop table if exists deliveries;
drop table if exists orders;
drop table if exists restaurants;
drop table if exists riders;


-- creating tables

create table customers(
	customer_id int primary key,
    customer_name varchar(100),
    reg_date date
);

create table restaurants (
	restaurant_id int primary key,
    restaurant_name varchar(100),
    city varchar(100),
    opening_hours varchar(100)
);

create table orders (
	order_id int primary key,
    customer_id int,
    restaurant_id int,
    order_item varchar(100),
    order_date date,
    order_time time,
    order_status varchar(100),
    total_amount float
);

create table riders (
	rider_id int primary key,
    rider_name varchar(100),
    sign_up date
);

create table deliveries (
	delivery_id int primary key,
    order_id int,
    delivery_status varchar(100),
    delivery_time time,
    rider_id int
);


-- adding foreign key

alter table orders
add constraint fk_customers
foreign key (customer_id)
references customers(customer_id);

alter table orders
add constraint fk_restaurants
foreign key (restaurant_id)
references restaurants(restaurant_id);

alter table deliveries
add constraint fk_oders
foreign key (order_id)
references orders(order_id);

alter table deliveries
add constraint fk_riders
foreign key (rider_id)
references riders(rider_id);


-- import datasets by table data import wizard
-- explore data
select * from customers;
select * from restaurants;
select * from orders;
select * from riders;
select * from deliveries;


-- Data Cleaning
SELECT * FROM customers
WHERE 
    customer_id is null or
    customer_name is null or
    reg_date is null;

DELETE FROM customers
WHERE 
    customer_id is null or
    customer_name is null or
    reg_date is null;
    

SELECT * FROM deliveries
WHERE 
    delivery_id is null or
order_id is null or
delivery_status is null or
delivery_time is null or
rider_id is null;

DELETE FROM deliveries
WHERE 
     delivery_id is null or
order_id is null or
delivery_status is null or
delivery_time is null or
rider_id is null;
    
    
SELECT * FROM orders
WHERE 
    order_id is null or
customer_id is null or
restaurant_id is null or
order_item is null or
order_date is null or
order_time is null or
order_status is null or 
total_amount is null;

DELETE FROM orders
WHERE 
    order_id is null or
customer_id is null or
restaurant_id is null or
order_item is null or
order_date is null or
order_time is null or
order_status is null or 
total_amount is null;
    
    
SELECT * FROM restaurants
WHERE 
    restaurant_id is null or
restaurant_name is null or 
city is null or
opening_hours is null;

DELETE FROM restaurants
WHERE 
   restaurant_id is null or
restaurant_name is null or 
city is null or
opening_hours is null;
    
    
SELECT * FROM roders
WHERE 
    rider_id is null or
rider_name is null or 
sign_up is null;

DELETE FROM roders
WHERE 
      rider_id is null or
rider_name is null or 
sign_up is null;


-- Analysis

-- Write a query to find the top 5 most frequently ordered dishes by customer called "Arjun Mehta" in the last 1 year.

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

-- Popular Time Slots
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

-- Order Value Analysis
-- Question: Find the average order value per customer who has placed more than 750 orders.
-- Return customer_name, and aov(average order value)

select c.customer_name,avg(o.total_amount) as aov
from orders o 
join customers c
on o.customer_id=c.customer_id
group by c.customer_id
having(count(order_id))>750;

-- High-Value Customers
-- Question: List the customers who have spent more than 100K in total on food orders.
-- return customer_name, and customer_id!

select c.customer_id,c.customer_name
from orders o 
join customers c
on o.customer_id=c.customer_id
group by c.customer_id
having sum(o.total_amount)>100000
order by 1;

-- Orders Without Delivery
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

-- Restaurant Revenue Ranking: 
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

-- Most Popular Dish by City: 
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

-- Customer Churn: 
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

-- Cancellation Rate Comparison: 
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

-- Rider Average Delivery Time: 
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

-- Monthly Restaurant Growth Ratio: 
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

-- Customer Segmentation: 
-- Segment customers into 'Gold' or 'Silver' groups based on their total spending compared to the average order value (AOV).  If a customer's total spending exceeds 
-- the AOV, label them as 'Gold'; otherwise, label them as 'Silver'. Write an SQL query to determine each segment's  total number of orders and total revenue

with cte as (select customer_id,count(order_id)as total_orders,sum(total_amount) as total_revenue,if(sum(total_amount)>(select avg(total_amount) from orders),"Gold","Silver") as Segment
from orders
group by 1)

select c.segment,sum(c.total_orders) as total_orders,sum(c.total_revenue) as total_revenue
from cte c
group by 1;

-- Rider Monthly Earnings: 
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

-- Rider Ratings Analysis: 
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

-- Order Frequency by Day: 
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

-- Customer Lifetime Value (CLV): 
-- Calculate the total revenue generated by each customer over all their orders.

SELECT 
	o.customer_id,
	c.customer_name,
	SUM(o.total_amount) as CLV
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
GROUP BY 1, 2;

-- Monthly Sales Trends: 
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

-- Rider Efficiency: 
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

-- Order Item Popularity: 
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

-- Rank each city based on the total revenue for last year 2024

select r.city,sum(total_amount) as total_revenue,RANK() OVER(ORDER BY SUM(total_amount) DESC) as city_rank
from restaurants r 
join orders o 
on r.restaurant_id=o.restaurant_id
where year(order_date)='2024'
group by 1;

-- Rank each city based on the total revenue for this year 2025

select r.city,sum(total_amount) as total_revenue,RANK() OVER(ORDER BY SUM(total_amount) DESC) as city_rank
from restaurants r 
join orders o 
on r.restaurant_id=o.restaurant_id
where year(order_date)='2025'
group by 1;

-- how many customers registered in each year

select year(reg_date),count(customer_id) as cnt
from customers
group by 1;

-- For each customer, how many orders did they place in the year they registered?

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

-- How many orders were delivered by each rider in the same year they signed up?

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

-- Write a query to find the top 3 most frequently ordered dishes by each customer in the last 1 year.

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


-- End of Project --