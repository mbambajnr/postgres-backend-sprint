CREATE TABLE customers (
    customer_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(150),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INTEGER,
    name VARCHAR(100),
    brand VARCHAR(100),
    size_ml INTEGER,
    price NUMERIC(10, 2)
);

CREATE TABLE orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price NUMERIC(10, 2)
);
