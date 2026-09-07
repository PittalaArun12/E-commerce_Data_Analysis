-- E-Commerce Data Analytics Internship Project
-- Table name: ecommerce_data
-- Dataset rows after cleaning: 51271
-- Note: sales is treated as the revenue measure because the dataset has a sales field.

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

-- Verify imported data
SELECT COUNT(*) AS total_rows FROM ecommerce_data;
SELECT * FROM ecommerce_data LIMIT 10;

-- 1. Top 10 profitable products
SELECT product_name, SUM(profit) AS total_profit
FROM ecommerce_data
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- 2. Top 10 customers by sales
SELECT customer_name, SUM(sales) AS total_sales
FROM ecommerce_data
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- 3. Region-wise total sales
SELECT region, SUM(sales) AS total_sales
FROM ecommerce_data
GROUP BY region
ORDER BY total_sales DESC;

-- 4. Category-wise average profit
SELECT category, AVG(profit) AS average_profit
FROM ecommerce_data
GROUP BY category
ORDER BY average_profit DESC;

-- 5. Highest discount category (defined using average discount)
SELECT category, AVG(discount) AS average_discount
FROM ecommerce_data
GROUP BY category
ORDER BY average_discount DESC
LIMIT 1;

-- 6. Orders with negative profit
SELECT order_id, customer_name, product_name, profit
FROM ecommerce_data
WHERE profit < 0
ORDER BY profit ASC;

-- Count of loss-making records
SELECT COUNT(*) AS loss_making_records
FROM ecommerce_data
WHERE profit < 0;

-- 7. Monthly sales trend
SELECT YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       SUM(sales) AS total_sales
FROM ecommerce_data
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 8. Market-wise revenue analysis
SELECT market, SUM(sales) AS total_revenue
FROM ecommerce_data
GROUP BY market
ORDER BY total_revenue DESC;

-- 9. Top-performing sub-categories
SELECT sub_category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM ecommerce_data
GROUP BY sub_category
ORDER BY total_profit DESC;

-- 10. Ship mode usage analysis
SELECT ship_mode, COUNT(*) AS usage_count
FROM ecommerce_data
GROUP BY ship_mode
ORDER BY usage_count DESC;

-- Useful validation queries
SELECT SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,
       AVG(discount) AS average_discount
FROM ecommerce_data;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_data;
