-- ============================================================
-- MSME E-Commerce Business Analytics - Core Analysis Script
-- Engine: SQLite / Standard ANSI SQL
-- Description: Contains business-driven analytical queries 
--              showcasing JOINs, WHERE, GROUP BY, HAVING, and ORDER BY.
-- ============================================================

-- ------------------------------------------------------------
-- 1. Revenue by Product Category
-- Business Question: Which product categories generate the 
-- highest total revenue from completed orders?
-- ------------------------------------------------------------
SELECT 
    p.category,
    SUM(o.quantity * p.unit_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;


-- ------------------------------------------------------------
-- 2. High-Value VIP Customers
-- Business Question: Which customers have spent a total of 
-- more than $300 on completed orders?
-- ------------------------------------------------------------
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    c.country,
    SUM(o.quantity * p.unit_price) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
HAVING SUM(o.quantity * p.unit_price) > 300
ORDER BY total_spend DESC;


-- ------------------------------------------------------------
-- 3. Product Inventory Health & Sales Performance
-- Business Question: What is the total quantity sold for each 
-- product, ensuring ALL products appear even if they have 0 sales?
-- ------------------------------------------------------------
SELECT 
    p.product_name,
    p.category,
    COALESCE(SUM(o.quantity), 0) AS total_units_sold
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id AND o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_units_sold DESC;


-- ------------------------------------------------------------
-- 4. Country-Level Market Penetration
-- Business Question: Which countries have more than 1 registered 
-- customer, and what is their average order quantity?
-- ------------------------------------------------------------
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(AVG(o.quantity), 2) AS avg_order_quantity
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country
HAVING COUNT(DISTINCT c.customer_id) > 1
ORDER BY total_customers DESC;


-- ------------------------------------------------------------
-- 5. Detailed Transaction Log for Completed Sales
-- Business Question: List all completed order transactions with 
-- customer full names, product names, and calculated row totals, 
-- sorted chronologically from newest to oldest.
-- ------------------------------------------------------------
SELECT 
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    o.quantity,
    (o.quantity * p.unit_price) AS order_total,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
ORDER BY o.order_date DESC;