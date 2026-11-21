CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254),
    city VARCHAR(80),
    created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(120),
    brand VARCHAR(80),
    concentration VARCHAR(30),
    size_ml INTEGER,
    price NUMERIC(10, 2),
    stock_quantity INTEGER
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price NUMERIC(10, 2)
);
