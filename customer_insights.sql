DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name TEXT,
    region TEXT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount NUMERIC,
    order_date DATE
);


INSERT INTO customers (customer_id, name, region) VALUES
(1, 'Ali', 'Lahore'),
(2, 'Sara', 'Karachi'),
(3, 'Zain', 'Islamabad'),
(4, 'Fatima', 'Lahore'),
(5, 'Usman', 'Multan');

INSERT INTO orders (order_id, customer_id, amount, order_date) VALUES
(101, 1, 1200, '2024-05-01'),
(102, 2, 400, '2024-05-03'),
(103, 2, 600, '2024-05-04'),
(104, 1, 500, '2024-05-05'),
(105, 4, 300, '2024-05-07');


SELECT * FROM customers;
SELECT * FROM orders;


SELECT 
    customers.name,
    customers.region,
    orders.amount,
    orders.order_date
FROM 
    customers JOIN orders
    ON customers.customer_id = orders.customer_id;
	SELECT 
    customers.name, 
    COUNT(orders.order_id) AS total_orders
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
GROUP BY 
    customers.name
HAVING 
    COUNT(orders.order_id) > 1;
	SELECT 
    customers.region, 
    SUM(orders.amount) AS total_sales
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
GROUP BY 
    customers.region;
	SELECT 
    customers.name, 
    customers.region
FROM 
    customers
LEFT JOIN 
    orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.order_id IS NULL;
	SELECT 
    customers.name, 
    SUM(orders.amount) AS total_spent
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
GROUP BY 
    customers.name
ORDER BY 
    total_spent DESC
LIMIT 3;
SELECT 
    order_date, 
    SUM(amount) AS daily_sales
FROM 
    orders
GROUP BY 
    order_date
ORDER BY 
    order_date;