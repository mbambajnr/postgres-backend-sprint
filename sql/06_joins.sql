-- 1. Full order details, one row per perfume in an order
SELECT
    orders.order_id,
    order_date,
    status,
    first_name,
    last_name,
    name AS perfume,
    size_ml,
    quantity,
    unit_price,
    quantity * unit_price AS item_total
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_items ON orders.order_id = order_items.order_id
INNER JOIN products ON order_items.product_id = products.product_id
ORDER BY orders.order_id, order_item_id;

-- 2. Total value of each order
SELECT orders.order_id, SUM(quantity * unit_price) AS order_total
FROM orders
INNER JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY orders.order_id
ORDER BY orders.order_id;

-- 3. Customers with no orders
SELECT customers.customer_id, first_name, last_name
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL
ORDER BY customers.customer_id;

-- 4. Products with no orders
SELECT products.product_id, name, size_ml
FROM products
LEFT JOIN order_items ON products.product_id = order_items.product_id
WHERE order_items.order_item_id IS NULL
ORDER BY products.product_id;
