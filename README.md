# 🛒 E-Commerce Customer Lifetime Value & Revenue Analytics

A professional SQL analytics project designed to evaluate customer spending patterns, product category performance, and regional market penetration using a relational e-commerce database.

---

## 📌 Project Overview
In modern retail, data-driven decision-making is critical for targeted marketing and inventory management. This project builds a custom relational database from scratch and runs advanced analytical queries to solve key business challenges:
* **Which product categories generate the highest revenue?**
* **Who are our high-value VIP customers for exclusive loyalty campaigns?**
* **Which products are underperforming or sitting completely unsold in inventory?**
* **Where is our strongest regional market penetration?**

---

## 🏗️ Database Architecture & Schema
The database consists of three core relational tables designed in SQLite:

1. **`customers`**: Stores customer details (`customer_id`, `first_name`, `last_name`, `email`, `phone_number`, `country`, `signup_date`).
2. **`products`**: Stores inventory and catalog details (`product_id`, `product_name`, `category`, `unit_price`).
3. **`orders`**: Transactional fact table linking users and items (`order_id`, `customer_id`, `product_id`, `quantity`, `order_date`, `status`).

---

## 📊 Key Analytical Queries (`analysis.sql`)
The project script answers 5 core business questions using advanced SQL clauses (`JOIN`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`):

1. **Revenue by Category:** Aggregates total revenue per product category for completed orders.
2. **High-Value VIP Customers:** Identifies customers spending over $300 using multi-table joins and aggregate threshold filtering (`HAVING`).
3. **Inventory Audit:** Uses `LEFT JOIN` and `COALESCE` to track unit sales while ensuring 100% catalog visibility (including unsold products).
4. **Market Penetration:** Calculates average order quantity per country for regions with active customer growth.
5. **Detailed Transaction Logs:** Extracts chronological transaction timelines with row-level calculations.

---

## 🚀 How to Run This Project
You can run and test this project locally in under 2 minutes:

1. Download or clone this repository.
2. Open your preferred SQLite environment (such as [SQLite Online](https://sqliteonline.com/) or DB Browser for SQLite).
3. Execute the **`schema.sql`** script to create the tables and insert sample data.
4. Run individual queries from **`analysis.sql`** to explore the data insights.

---

## 📂 Repository Structure
```text
ecommerce-sql-analytics/
│
├── README.md              # Project documentation and business insights
├── schema.sql             # Database creation script and sample data
└── analysis.sql           # Core analytical business queries