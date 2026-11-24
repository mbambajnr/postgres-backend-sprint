BEGIN;

-- Keep customer 1 and move any orders before removing the duplicate.
UPDATE orders SET customer_id = 1 WHERE customer_id = 10;
DELETE FROM customers WHERE customer_id = 10;

ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE customers ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE customers ALTER COLUMN last_name SET NOT NULL;
ALTER TABLE customers ALTER COLUMN city SET NOT NULL;
ALTER TABLE customers ADD UNIQUE (email);

ALTER TABLE products ADD PRIMARY KEY (product_id);
ALTER TABLE products ALTER COLUMN name SET NOT NULL;
ALTER TABLE products ALTER COLUMN brand SET NOT NULL;
ALTER TABLE products ALTER COLUMN size_ml SET NOT NULL;
ALTER TABLE products ALTER COLUMN price SET NOT NULL;
ALTER TABLE products ADD CHECK (size_ml > 0);
ALTER TABLE products ADD CHECK (price > 0);

ALTER TABLE orders ADD PRIMARY KEY (order_id);
ALTER TABLE orders ALTER COLUMN customer_id SET NOT NULL;
ALTER TABLE orders ALTER COLUMN order_date SET NOT NULL;
ALTER TABLE orders ALTER COLUMN status SET NOT NULL;
ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);
ALTER TABLE orders ADD CHECK (status IN ('pending', 'shipped', 'delivered', 'cancelled', 'returned'));

ALTER TABLE order_items ADD PRIMARY KEY (order_item_id);
ALTER TABLE order_items ALTER COLUMN order_id SET NOT NULL;
ALTER TABLE order_items ALTER COLUMN product_id SET NOT NULL;
ALTER TABLE order_items ALTER COLUMN quantity SET NOT NULL;
ALTER TABLE order_items ALTER COLUMN unit_price SET NOT NULL;
ALTER TABLE order_items ADD FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products (product_id);
ALTER TABLE order_items ADD CHECK (quantity <> 0);
ALTER TABLE order_items ADD CHECK (unit_price > 0);

-- Insert a customer, or update their details if the email already exists.
INSERT INTO customers (customer_id, first_name, last_name, email, city)
VALUES (11, 'Ama', 'Mensah', 'ama.mensah@example.com', 'Accra')
ON CONFLICT (email) DO UPDATE
SET first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    city = EXCLUDED.city
RETURNING customer_id, first_name, last_name, email, city;

COMMIT;
