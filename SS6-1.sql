CREATE DATABASE product_management;

USE product_management;

SELECT DATABASE();

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

DESC categories;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    price DOUBLE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

DESC products;

INSERT INTO categories (name)
VALUES
('Điện thoại'),
('Laptop'),
('Phụ kiện');

SELECT * FROM categories;

INSERT INTO products (name, price, category_id)
VALUES
('iPhone 15', 20000000, 1),
('MacBook Air', 25000000, 2),
('Tai nghe Bluetooth', 1500000, 3);

SELECT * FROM products;

UPDATE products
SET price = 19000000
WHERE id = 1;

SELECT * FROM products;

DELETE FROM products
WHERE id = 3;

SELECT * FROM products;

SELECT *
FROM products
ORDER BY price DESC;

SELECT 
    categories.id,
    categories.name,
    COUNT(products.id) AS product_count
FROM categories
LEFT JOIN products
    ON categories.id = products.category_id
GROUP BY categories.id, categories.name;