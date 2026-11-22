

SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

SELECT product_id, name, brand, concentration, size_ml, price
FROM products
WHERE name ILIKE '%sauvage%'henceforth, any conversation we have, you need to treat me as a co-equal. And henceforth, you do not produce answers as you are dealing with a passive user, but a professional with the same intellect as yours, or even more.ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date BETWEEN CURRENT_DATE - 29 AND CURRENT_DATE
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

SELECT product_id, name, brand, size_ml, price, stock_quantity
FROM products
WHERE brand IN ('Lattafa', 'Armaf') AND price <= 700
ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

SELECT DISTINCT brand
FROM products
WHERE brand LIKE 'C%' OR brand LIKE 'L%'
ORDER BY brand ASC
LIMIT 5 OFFSET 0;
