SELECT * FROM products;

SELECT *
FROM products
WHERE price BETWEEN 18000000 AND 22000000;

SELECT *
FROM products
WHERE name LIKE '%iPhone%';

SELECT 
    category_id,
    AVG(price) AS average_price
FROM products
GROUP BY category_id;

SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

SELECT AVG(price)
FROM products;

SELECT *
FROM products p
WHERE price = (
    SELECT MIN(price)
    FROM products
    WHERE category_id = p.category_id
);

