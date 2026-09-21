CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255)
);

DESC customers;

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

DESC orders;

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

DESC order_details;

INSERT INTO customers (name, email)
VALUES
('Nguyen Van An', 'an@gmail.com'),
('Tran Thi Binh', 'binh@gmail.com');

SELECT * FROM customers;

INSERT INTO orders (customer_id, order_date)
VALUES (1, '2026-09-21');
SELECT * FROM orders;

INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 19000000),
(1, 2, 1, 25000000);

SELECT * FROM order_details;

SELECT customers.id, customers.name, customers.email
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT customers.id, customers.name, customers.email
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
WHERE orders.id IS NULL;

SELECT 
    customers.id,
    customers.name,
    COALESCE(SUM(order_details.quantity * order_details.price), 0) AS total_revenue
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
LEFT JOIN order_details
    ON orders.id = order_details.order_id
GROUP BY customers.id, customers.name;

WITH customer_category AS (
    SELECT
        categories.id AS category_id,
        categories.name AS category_name,
        customers.id AS customer_id,
        customers.name AS customer_name,
        SUM(order_details.quantity) AS total_quantity
    FROM categories
    JOIN products
        ON categories.id = products.category_id
    JOIN order_details
        ON products.id = order_details.product_id
    JOIN orders
        ON order_details.order_id = orders.id
    JOIN customers
        ON orders.customer_id = customers.id
    GROUP BY
        categories.id,
        categories.name,
        customers.id,
        customers.name
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY category_id
            ORDER BY total_quantity DESC
        ) AS ranking
    FROM customer_category
)
SELECT
    category_name,
    customer_name,
    total_quantity
FROM ranked
WHERE ranking = 1;