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

The analysis shows that **multiple products have the same total number of orders (300 orders each)**.
This indicates that **all listed products were ordered in every transaction**, resulting in identical order counts across products.
### What this means : 
* There is **no single dominant best-selling product** based on order count alone.
* Product sales are **evenly distributed** across the catalog.
* This behavior suggests that:
  - Orders may include **multiple products per order**, or The dataset was generated using **uniform/randomized logic** for product assignment.
### Business Insight
- Since demand appears evenly distributed, decision-makers should:
  * Analyze **revenue contribution** instead of order count.
  * Consider metrics such as **total sales value** or **profit per product**.
- Further analysis could reveal differences when incorporating:
  * Product price.
  * Product category.
  * Customer purchasing behavior.


## Highest spending customers
![Highest spending customers](https://github.com/chourouk-sun/E-Commerce-SQL-Analysis/blob/9eba300ffa50c26062116e1a7fd4ca5a5c9790eb/images/image2.png)

### Highest Spending Customer :
The analysis identifies **Customer_45** as the **highest spending customer**, with a total expenditure of **6,810.35**.
### Top 10 Customers by Total Spend :
* The top 10 customers spent between **4,175.37** and **6,810.35**.
* Spending is **unevenly distributed**, with a small group of customers contributing a significant share of total revenue.
* This reflects a **Pareto-style pattern**, where a minority of customers generate a large portion of sales.
### Business Insights :
* High-value customers such as **Customer_45** are ideal targets for:
  * Loyalty programs
  * Personalized promotions
  * Retention strategies
* Customer segmentation based on spending can help:
  * Improve customer lifetime value (CLV)
  * Optimize marketing budgets by focusing on top contributors



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


































