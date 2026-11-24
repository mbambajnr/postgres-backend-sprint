-- 1. Total revenue after returns
SELECT COALESCE(SUM(quantity * unit_price), 0) AS total_revenue
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE status IN ('delivered', 'returned');

-- 2. Revenue per month after returns
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(quantity * unit_price) AS revenue
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE status IN ('delivered', 'returned')
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY year, month;

-- 3. Top 5 products by revenue after returns
SELECT
    products.product_id,
    name,
    size_ml,
    SUM(quantity * unit_price) AS revenue
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE status IN ('delivered', 'returned')
GROUP BY products.product_id, name, size_ml
HAVING SUM(quantity * unit_price) > 0
ORDER BY revenue DESC, products.product_id
LIMIT 5;

-- 4. Average value of a delivered order, before returns
SELECT ROUND(
    SUM(quantity * unit_price) / NULLIF(COUNT(DISTINCT orders.order_id), 0),
    2
) AS average_order_value
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE status = 'delivered' AND quantity > 0;

-- 5. Refunds as a percentage of gross sales
SELECT ROUND(
    100.0 * COALESCE(SUM(
        CASE
            WHEN quantity < 0 THEN -(quantity * unit_price)
            ELSE 0
        END
    ), 0)
    / NULLIF(SUM(
        CASE
            WHEN quantity > 0 THEN quantity * unit_price
            ELSE 0
        END
    ), 0),
    2
) AS return_percentage
FROM order_items
JOIN orders ON order_items.order_id = orders.order_id
WHERE status IN ('delivered', 'returned');

-- 6. Product price summary
SELECT
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price,
    ROUND(AVG(price), 2) AS average_price
FROM products;

-- 7. Show a message when a customer's email is missing
SELECT customer_id, first_name, COALESCE(email, 'No email provided') AS email
FROM customers
ORDER BY customer_id;

-- 8. Dates and intervals
SELECT
    order_id,
    order_date,
    order_date + INTERVAL '7 days' AS seven_days_after_order,
    AGE(CURRENT_DATE, order_date) AS time_since_order
FROM orders
ORDER BY order_id
LIMIT 5;
