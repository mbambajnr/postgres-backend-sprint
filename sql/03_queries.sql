-- Day 1: five independent filtering queries resembling API requests.
-- Values below are examples. A real backend should bind request values as parameters.
-- Every query uses ORDER BY for stable pagination, plus LIMIT and OFFSET.
-- With LIMIT 5: OFFSET 0 = page 1, OFFSET 5 = page 2, OFFSET 10 = page 3.

-- 1. GET /customers/1/orders?limit=5&offset=0
-- Find every order for one customer, newest first.
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

-- 2. GET /products?search=sauvage&limit=5&offset=0
-- % matches any number of characters; ILIKE ignores letter case.
-- The ID breaks ties when the same name comes in different sizes.
SELECT product_id, name, brand, concentration, size_ml, price
FROM products
WHERE name ILIKE '%sauvage%'
ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

-- 3. GET /orders?period=last30days&limit=5&offset=0
-- BETWEEN includes both endpoints: today plus the previous 29 dates.
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date BETWEEN CURRENT_DATE - 29 AND CURRENT_DATE
ORDER BY order_date DESC, order_id DESC
LIMIT 5 OFFSET 0;

-- 4. GET /products?brands=Lattafa,Armaf&max_price=700&limit=5&offset=0
-- Both the brand filter and the price condition must be satisfied.
SELECT product_id, name, brand, size_ml, price, stock_quantity
FROM products
WHERE brand IN ('Lattafa', 'Armaf') AND price <= 700
ORDER BY price ASC, product_id ASC
LIMIT 5 OFFSET 0;

-- 5. GET /brands?prefixes=C,L&limit=5&offset=0
-- A brand-filter list: DISTINCT removes repeated brands across products.
-- LIKE is case-sensitive; either prefix may match because we use OR.
SELECT DISTINCT brand
FROM products
WHERE brand LIKE 'C%' OR brand LIKE 'L%'
ORDER BY brand ASC
LIMIT 5 OFFSET 0;
