DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name TEXT,
    region TEXT,
    age INT,
    gender TEXT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount NUMERIC,
    order_date DATE
);

INSERT INTO customers (customer_id, name, region, age, gender) VALUES
(1, 'Ali', 'Lahore', 28, 'Male'),
(2, 'Sara', 'Karachi', 34, 'Female'),
(3, 'Zain', 'Islamabad', 30, NULL),
(4, 'Fatima', 'Lahore', 26, 'Female'),
(5, 'Usman', 'Multan', 40, NULL);

INSERT INTO orders (order_id, customer_id, amount, order_date) VALUES
(101, 1, 1200, '2024-05-01'),
(102, 2, 400, '2024-05-03'),
(103, 2, 600, '2024-05-04'),
(104, 1, 500, '2024-05-05'),
(105, 4, 300, '2024-05-07'),
(106, 3, 800, '2024-05-08'),
(107, 5, 1000, '2024-05-10'),
(108, 5, 200, '2024-05-12'),
(109, 3, 900, '2024-05-13');  

SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders,
SUM(o.amount) AS total_amount
FROM customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
SELECT *
FROM (
    SELECT 
        c.customer_id,
        c.name,
        o.order_date,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS row_num
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
) sub
WHERE row_num = 1;
SELECT 
    c.name,
    o.order_date,
    o.amount,
    SUM(o.amount) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS running_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
SELECT 
    c.name,
    SUM(o.amount) AS total_spent,
    CASE 
        WHEN SUM(o.amount) >= 1500 THEN 'High Value'
        WHEN SUM(o.amount) >= 800 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_type
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
SELECT 
    name,
    COALESCE(gender, 'Not Provided') AS gender_status
FROM customers;
SELECT 
    c.name,
    SUM(o.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.amount) DESC) AS spend_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
