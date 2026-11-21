-- 1. Orders for customer 1
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

-- 2. Search for Sauvage
SELECT product_id, name, brand, size_ml, price
FROM products
WHERE name ILIKE '%sauvage%'
ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

-- 3. Orders from the last 30 days
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date BETWEEN CURRENT_DATE - 29 AND CURRENT_DATE
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

-- 4. Lattafa and Armaf perfumes costing up to GHS 700
SELECT product_id, name, brand, price
FROM products
WHERE brand IN ('Lattafa', 'Armaf') AND price <= 700
ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

-- 5. Different brands starting with C or L
SELECT DISTINCT brand
FROM products
WHERE brand LIKE 'C%' OR brand LIKE 'L%'
ORDER BY brand ASC
LIMIT 5 OFFSET 0;
