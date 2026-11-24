# Perfume Shop Database

A three-day PostgreSQL practice project for a small perfume shop. All three days are implemented and tested.

## Files

| File | Purpose |
| --- | --- |
| `sql/01_schema.sql` | Create four simple tables. |
| `sql/02_seed.sql` | Add 10 customers, 15 perfumes, 30 orders and 39 order items. |
| `sql/03_queries.sql` | Five filtering queries with pagination. |
| `sql/04_reports.sql` | Reports, functions and dates. |
| `sql/05_integrity.sql` | Remove the duplicate, add constraints and run an upsert. |
| `sql/06_joins.sql` | Order details, order totals and customers or products without orders. |
| `sql/07_export.sql` | Export order details to CSV. |
| `exports/order_details.csv` | The exported results. |

## Setup

Start PostgreSQL and open Terminal in this repository folder. Use your PostgreSQL username in place of `mac` if different.

```sh
psql -U mac -d postgres
```

Inside PostgreSQL, create a new database:

```sql
CREATE DATABASE perfume_shop_sprint;
```

Then run:

```text
\c perfume_shop_sprint
\set ON_ERROR_STOP on
\i sql/01_schema.sql
\i sql/02_seed.sql
\i sql/03_queries.sql
\i sql/04_reports.sql
\i sql/05_integrity.sql
\i sql/06_joins.sql
\i sql/07_export.sql
```

Use a new, empty database for setup. Run files 01, 02 and 05 only once. If the database name is already in use, choose a new name. The other files can be run again. `ON_ERROR_STOP` stops the script if a command fails.

Run the export from the repository folder so the `exports/` path is correct. It replaces the existing sample CSV. `\copy` stays on one line because it is a psql command. SQL statements end with a semicolon; psql commands such as `\i` do not need one. Exit with `\q`.

## Table design

Customers place orders. Products are the perfumes for sale. Order items store which perfumes are in each order, the quantity and the price charged. One order can contain several perfumes.

Each perfume size is a separate product. Prices are sample amounts in Ghana cedis (GHS). `NUMERIC(10, 2)` allows two decimal places. An item keeps its sale price so changing a product price does not change an old order.

The IDs are entered manually in the seed data. Day 3 adds primary keys and foreign keys. For a new customer upsert, use an unused customer ID; email is the conflict target. `EXCLUDED` refers to the values proposed by the INSERT.

## Day 1

The seed includes one missing email, one duplicate customer and a return with quantity -1. These are intentional exercise cases.

The five queries practise SELECT, ORDER BY, DISTINCT, WHERE, AND/OR, comparisons, IN, BETWEEN and LIKE/ILIKE. `LIMIT 5 OFFSET 0` gets the first page; `LIMIT 5 OFFSET 5` gets the second. Sample dates are fixed in September to November 2026.

The main idea is separating an order from its items. A setup challenge was distinguishing Terminal commands from SQL commands, including how to set a password using `\password mac`.

## Day 2

Reports count delivered sales and subtract returns. Pending, shipped and cancelled orders are excluded. Refunds are positive amounts for the return percentage: refunded value / gross sales * 100. Average order value uses delivered purchases before refunds, counting each order once.

With the sample data, gross sales are GHS 51,450.00, refunds are GHS 1,800.00, net revenue is GHS 49,650.00, average order value is GHS 2,338.64 and returns are 3.50% of gross sales.

GROUP BY collects rows for a calculation; HAVING filters the resulting groups. COALESCE supplies a missing value. NULLIF avoids division by zero. With no sales, the average and return percentage are NULL rather than a misleading zero.

A point to watch is counting orders rather than item rows when calculating average order value. Basic JOINs are needed to read an order's date and status alongside its items.

## Day 3

Customer 10 duplicates customer 1. Any orders for customer 10 are moved to customer 1 before the duplicate is deleted. There are 9 customers after cleanup. The missing email stays NULL: email is optional, but a supplied email must be unique. No replacement email is invented.

Primary keys prevent duplicate IDs. Foreign keys prevent orders and items from pointing to missing rows. Required fields use NOT NULL. Prices and bottle sizes must be positive; quantity cannot be zero. Negative quantities remain allowed for returns.

The cleanup and constraints run between BEGIN and COMMIT so they succeed together. The upsert demonstrates a conflict on Ama's existing email and returns customer 1 instead of inserting customer 11. Test data keeps the same customer details, so the update does not change them.

INNER JOIN builds order details. LEFT JOIN finds customers or products with no orders. The CSV has 39 item rows, including pending and cancelled orders: it is an order-detail export, not a revenue report. The return has a negative item total.

The cleanup needs to happen before UNIQUE(email) can be added. This is the main constraint-ordering issue in the Day 3 setup. The database does not yet check that a negative quantity belongs to a returned order or link a return to its original purchase; those rules would need further work.

 The design decisions file and separate Day 2 notes remain local and are not included in Git.
