# E-Commerce-SQL-Analysis (SQL Server)

##  Project Overview
This project demonstrates an **E-Commerce Sales Analysis** using **SQL Server (SSMS)**.
It simulates a real-world online store environment, including **customers, products, orders, and payments**, and answers key business questions.

## Objectives / Business Questions
The main business questions addressed in this project are:
1. **Top 10 Best-Selling Products** : Identify which products are most popular.
2. **Highest Spending Customers** : Find customers generating the most revenue.
3. **Monthly Revenue** : Analyze revenue trends over time.
4. **Average Order Value (AOV)** : Determine the average value per order.

## Tools
- SQL Server
- SSMS

## Skills Demonstrated
- SQL **Database Design**: tables, primary & foreign keys.
- **Data Generation & Mock Data Creation** using SQL functions.
- **Data Analysis**: Aggregations, JOINs, GROUP BY, TOP N.
- **Business Insights**: Best-selling products, top customers, revenue trends, AOV.
- **SSMS / SQL Server** workflow.
  
## Database Structure
### Tables:
| Table Name    |     Description                                                           |
| ------------- | --------------------------------------------------------------------- |
| **customers** | Stores customer details (ID, name, email, country, registration date) |
| **products**  | Product catalog (ID, name, category, price)                           |
| **orders**    | Orders placed by customers (ID, customer ID, date, total amount)      |
| **payments**  | Payments for orders (ID, order ID, payment method, date, amount)      |

### Features:
* **Primary Keys** for uniqueness.
* **Foreign Keys** to maintain relationships.
* Randomized **mock data** for realistic testing.
* Compatible with **SQL Server / SSMS**.

## Data Generation
* **50 customers**, **30 products**, **300 orders**, **300 payments**.
* Randomized data using SQL functions like `ROW_NUMBER()`, `NEWID()`, and `RAND()` to simulate realistic e-commerce data.
* Supports analysis without needing external datasets.

## Key Insights
- 20% of customers generate 60% of revenue
- Revenue peaks in Q4

## Insights / Key Findings
* Top-selling products generate most revenue from **Electronics category**.
* A small percentage of customers contribute disproportionately to total revenue (Pareto principle).
* Revenue peaks in certain months (simulate seasonal trends).
* Average Order Value (AOV) provides benchmark for pricing and promotions.

## Top 10 best-selling products
![Top 10 best-selling products](https://github.com/chourouk-sun/E-Commerce-SQL-Analysis/blob/9eba300ffa50c26062116e1a7fd4ca5a5c9790eb/images/Top%2010%20best-selling%20products%20.png)
--Top 10 best-selling products --
SELECT TOP 10
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN payments pay ON o.order_id = pay.order_id
JOIN products p ON p.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;


## Highest spending customers
![Highest spending customers](https://github.com/chourouk-sun/E-Commerce-SQL-Analysis/blob/9eba300ffa50c26062116e1a7fd4ca5a5c9790eb/images/image2.png)
-- Highest spending customers--
SELECT TOP 10
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC;

## Monthly revenue
![Monthly revenue](https://github.com/chourouk-sun/E-Commerce-SQL-Analysis/blob/9eba300ffa50c26062116e1a7fd4ca5a5c9790eb/images/image3.png)
-- Monthly revenue--
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

## Average Order Value 
![Average Order Value](https://github.com/chourouk-sun/E-Commerce-SQL-Analysis/blob/9eba300ffa50c26062116e1a7fd4ca5a5c9790eb/images/images4.png)
-- Average Order Value (AOV)--
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;


































