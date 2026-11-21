# Perfume shop: PostgreSQL backend sprint

A three-day SQL practice project for a small perfume shop. Day 1 is implemented and tested. Days 2 and 3 are pending.

## Files

- `sql/01_schema.sql`: four tables and their column types.
- `sql/02_seed.sql`: 10 customers, 15 perfumes, 30 orders and 39 order items.
- `sql/03_queries.sql`: five paginated filtering queries.
- `notes/design_decisions.md`: table choices, deliberate messy rows and later work.

## Run from a new installation

Requires a running PostgreSQL server and `psql` on PATH. PostgreSQL 19 was used for validation.

In Terminal, change into this repository folder. Use your PostgreSQL username in place of `mac` if different.

```sh
psql -U mac -d postgres -c 'CREATE DATABASE perfume_shop;'
psql -U mac -d perfume_shop -v ON_ERROR_STOP=1 -f sql/01_schema.sql
psql -U mac -d perfume_shop -v ON_ERROR_STOP=1 -f sql/02_seed.sql
psql -U mac -d perfume_shop -v ON_ERROR_STOP=1 -f sql/03_queries.sql
```

The schema and seed scripts are for a fresh database and should each run once. Each uses a transaction. Do not rerun the seed against a populated database: relationships assume the initial generated IDs.

**On the Mac where this project was prepared, the perfume_shop database has already been created and loaded.** Connect directly:

```sh
psql -U mac -d perfume_shop
```

Inside psql:

```text
\dt
\d customers
```

```sql
SELECT * FROM products ORDER BY product_id;
```

Exit with `\q`. SQL commands end with a semicolon; psql commands such as `\dt` do not need one. Run shell commands at the Terminal prompt, not at `perfume_shop=#`.

Local socket connections here use local authentication. Connecting with `-h localhost` uses TCP and requires the password configured for the role. Never commit database passwords.

## Table design

```text
customers -> orders -> order_items <- products
```

One order has multiple item rows. Items keep the quantity and price charged for each perfume. Product price changes therefore do not rewrite order history. Day 1 uses primary keys; foreign keys and additional integrity rules are added during Day 3.

## Day 1: setup and querying

The queries cover SELECT, ORDER BY, DISTINCT, WHERE, AND/OR, comparisons, LIMIT/OFFSET, IN, BETWEEN and LIKE/ILIKE. Each query includes a sample endpoint in a comment; no HTTP API is implemented.

The required messy data includes one missing email, one duplicated customer, and a return with quantity -1. These are deliberate exercise cases. Customers 9 and 10 and products 14 and 15 have no orders, giving later LEFT JOIN exercises meaningful results.

Dates are relative to the setup date. The recent-orders filter includes today and the preceding 29 calendar dates. Change OFFSET from 0 to 5 to request the second page when LIMIT is 5.

### Learning notes to complete after practice

- Explain in your own words why an order needs separate item rows.
- Try a different customer ID, search term and page offset.
- Describe what happened when you switched between the shell and psql.

These prompts are intentionally unfinished rather than inventing personal learning claims. The implementation was prepared with assistant help and follows the written brief; a full review of the course video is still pending.

## Day 2: pending

Revenue reports, aggregation, dates, safe NULL handling and a documented return policy.

## Day 3: pending

Data cleanup, stronger constraints, upsert, joins and a CSV export.

## GitHub submission

This is a local repository. A GitHub remote must still be created and the commits pushed before submitting the repository link.
