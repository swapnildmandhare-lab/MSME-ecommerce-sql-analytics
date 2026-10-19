-- ============================================================
-- E-Commerce Business Analytics - Database Schema Setup
-- Engine: SQLite / Standard ANSI SQL
-- Description: Creates customers, products, and orders tables 
--              and populates them with initial transaction data.
-- ============================================================

-- Drop existing tables to allow clean re-runs
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 1. Create Customers Table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone_number TEXT,
    country TEXT NOT NULL,
    signup_date DATE NOT NULL
);

-- 2. Create Products Table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    unit_price REAL NOT NULL
);

-- 3. Create Orders Table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE NOT NULL,
    status TEXT CHECK(status IN ('Completed', 'Pending', 'Cancelled')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- DATA INSERTION
-- ============================================================

-- Insert Customers
INSERT INTO customers (first_name, last_name, email, phone_number, country, signup_date) VALUES
('Alice', 'Smith', 'alice@example.com', '555-0101', 'USA', '2025-01-10'),
('Bob', 'Jones', 'bob@example.com', '555-0102', 'Canada', '2025-01-15'),
('Charlie', 'Brown', 'charlie@example.com', '555-0103', 'USA', '2025-02-01'),
('Diana', 'Prince', 'diana@example.com', '555-0104', 'UK', '2025-02-12'),
('Evan', 'Wright', 'evan@example.com', '555-0105', 'USA', '2025-03-05'),
('Fiona', 'Gallagher', 'fiona@example.com', '555-0106', 'Canada', '2025-03-20'),
('George', 'Miller', 'george@example.com', '555-0107', 'Australia', '2025-04-01');

-- Insert Products
INSERT INTO products (product_name, category, unit_price) VALUES
('Laptop Pro 15', 'Electronics', 1200.00),
('Wireless Ergonomic Mouse', 'Accessories', 35.00),
('Mechanical RGB Keyboard', 'Accessories', 85.00),
('Espresso Coffee Maker', 'Home Appliances', 150.00),
('Electric Standing Desk', 'Furniture', 450.00),
('UltraFast USB-C Cable', 'Accessories', 15.00),
('Noise-Canceling Headphones', 'Electronics', 250.00),
('Smart Fitness Watch', 'Electronics', 180.00); -- Unsold product for testing LEFT JOINs

-- Insert Orders
INSERT INTO orders (customer_id, product_id, quantity, order_date, status) VALUES
(1, 1, 1, '2025-05-01', 'Completed'),
(1, 2, 2, '2025-05-02', 'Completed'),
(2, 3, 1, '2025-05-03', 'Completed'),
(3, 4, 1, '2025-05-04', 'Cancelled'),
(3, 5, 1, '2025-05-05', 'Completed'),
(4, 2, 5, '2025-05-06', 'Completed'),
(5, 6, 10, '2025-05-07', 'Completed'),
(1, 6, 3, '2025-05-08', 'Completed'),
(2, 1, 1, '2025-05-09', 'Cancelled'),
(4, 4, 2, '2025-05-10', 'Completed'),
(5, 2, 4, '2025-05-11', 'Completed'),
(6, 3, 2, '2025-05-12', 'Completed'),
(1, 7, 1, '2025-05-13', 'Completed'),
(3, 7, 1, '2025-05-14', 'Pending');




SELECT
    p.product_name,
    p.category,
    COALESCE(SUM(o.quantity), 0) AS total_units_sold
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id AND o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY totat_units_sold DESC;