-- Day 1: run this in a new, empty perfume_shop database.
-- All money amounts are Ghana cedis (GHS).
-- Primary keys identify rows. Foreign keys and stronger constraints come on Day 3.
-- BIGSERIAL gives each new row an ID automatically.
-- VARCHAR(n) stores text up to n characters; INTEGER and BIGINT store whole numbers.
-- NUMERIC(10, 2) stores prices with two decimal places. DATE stores a calendar date.
-- BEGIN and COMMIT keep this setup together: either all tables are created or none are.
BEGIN;

CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254),
    city VARCHAR(80),
    created_at DATE DEFAULT CURRENT_DATE
);

-- Each brand/name/size/concentration combination is a separate product.
CREATE TABLE products (
    product_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120),
    brand VARCHAR(80),
    concentration VARCHAR(30),
    size_ml INTEGER,
    price NUMERIC(10, 2),
    stock_quantity INTEGER
);

CREATE TABLE orders (
    order_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id BIGSERIAL PRIMARY KEY,
    order_id BIGINT,
    product_id BIGINT,
    quantity INTEGER,
    -- Save the price charged, so later product price changes do not change history.
    unit_price NUMERIC(10, 2)
);

COMMIT;
