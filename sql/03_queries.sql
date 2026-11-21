-- 1. Orders for customer 1
SELECT *
FROM orders
WHERE customer_id = 1
ORDER BY order_id DESC
LIMIT 5 OFFSET 0;

-- 2. Search for Sauvage
SELECT *
FROM products
WHERE name ILIKE '%sauvage%'
ORDER BY product_id
LIMIT 5 OFFSET 0;

-- 3. Orders placed in November 2026
SELECT *
FROM orders
WHERE order_date BETWEEN '2026-11-01' AND '2026-11-30'
ORDER BY order_id DESC
LIMIT 5 OFFSET 0;

-- 4. Lattafa or Armaf perfumes costing up to GHS 700
SELECT *
FROM products
WHERE brand IN ('Lattafa', 'Armaf') AND price <= 700
ORDER BY product_id
LIMIT 5 OFFSET 0;

-- 5. Different brands starting with C or L
SELECT DISTINCT brand
FROM products
WHERE brand LIKE 'C%' OR brand LIKE 'L%'
ORDER BY brand
LIMIT 5 OFFSET 0;
