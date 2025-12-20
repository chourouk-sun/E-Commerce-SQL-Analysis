IF DB_ID('EcommerceSales') IS NULL
BEGIN
    CREATE DATABASE EcommerceSales;
END
GO

USE EcommerceSales;
GO

IF OBJECT_ID('customers', 'U') IS NULL
BEGIN
    CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        full_name NVARCHAR(100),
        email NVARCHAR(100),
        country NVARCHAR(50),
        created_at DATE
    );
END

IF OBJECT_ID('products', 'U') IS NULL
BEGIN
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name NVARCHAR(100),
        category NVARCHAR(50),
        price DECIMAL(10,2)
    );
END

IF OBJECT_ID('orders', 'U') IS NULL
BEGIN
    CREATE TABLE orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        total_amount DECIMAL(10,2),
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );
END

IF OBJECT_ID('payments', 'U') IS NULL
BEGIN
    CREATE TABLE payments (
        payment_id INT PRIMARY KEY,
        order_id INT,
        payment_method NVARCHAR(50),
        payment_date DATE,
        amount DECIMAL(10,2),
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
    );
END
GO

DELETE FROM payments;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM customers;
GO

INSERT INTO customers (customer_id, full_name, email, country, created_at)
SELECT TOP 50
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    CONCAT('Customer_', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
    CONCAT('customer', ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), '@example.com'),
    CASE WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 2 = 0 THEN 'USA' ELSE 'UK' END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE())
FROM sys.objects o1
CROSS JOIN sys.objects o2;
GO

INSERT INTO products (product_id, product_name, category, price)
SELECT TOP 30
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    CONCAT('Product_', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))),
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 3 = 0 THEN 'Electronics'
        WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 3 = 1 THEN 'Clothing'
        ELSE 'Home'
    END,
    CAST(ROUND((RAND(CHECKSUM(NEWID())) * 500 + 10), 2) AS DECIMAL(10,2))
FROM sys.objects o1
CROSS JOIN sys.objects o2;
GO

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
SELECT TOP 300
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    (ABS(CHECKSUM(NEWID())) % 50) + 1,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE()),
    CAST(ROUND((RAND(CHECKSUM(NEWID())) * 1000 + 20), 2) AS DECIMAL(10,2))
FROM sys.objects o1
CROSS JOIN sys.objects o2;
GO

INSERT INTO payments (payment_id, order_id, payment_method, payment_date, amount)
SELECT TOP 300
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 3 = 0 THEN 'Credit Card'
        WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 3 = 1 THEN 'PayPal'
        ELSE 'Bank Transfer'
    END,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 5), o.order_date),
    o.total_amount
FROM orders o;
GO
--Top 10 best-selling products --
SELECT TOP 10
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN payments pay ON o.order_id = pay.order_id
JOIN products p ON p.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC;

-- Highest spending customers--
SELECT TOP 10
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC;

-- Monthly revenue--
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- Average Order Value (AOV)--
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;




