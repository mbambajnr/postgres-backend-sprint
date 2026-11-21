# Perfume Shop Database

A PostgreSQL practice project for a small perfume shop. This is the Day 1 work.

## Files

- `sql/01_schema.sql` creates the four tables.
- `sql/02_seed.sql` adds 10 customers, 15 perfumes, 30 orders and 39 order items.
- `sql/03_queries.sql` contains five filtering queries.
- `notes/design_decisions.md` explains the sample data and table choices.

## Setup

Start PostgreSQL, then open Terminal in this repository folder. Connect using your PostgreSQL username (`mac` on my setup):

```sh
psql -U mac -d postgres
```

Inside PostgreSQL, create and connect to a new database:

```sql
CREATE DATABASE perfume_shop;
```

```text
\c perfume_shop
\i sql/01_schema.sql
\i sql/02_seed.sql
\i sql/03_queries.sql
```

Run the schema and seed files only once in an empty database. On this Mac, `perfume_shop` is already set up, so skip creation and loading. Connect with `psql -U mac -d perfume_shop` and run the queries.

## Tables

- `customers`: customer names, emails and cities.
- `products`: perfume names, brands, sizes, concentrations, prices and stock.
- `orders`: the customer, date and status of each order.
- `order_items`: the perfumes, quantities and prices in each order.

An order can contain several perfumes, so it needs separate order items. All prices are sample amounts in Ghana cedis (GHS).

## Day 1 queries

1. Orders for customer 1.
2. Perfumes with “Sauvage” in the name.
3. Orders from the last 30 days.
4. Lattafa or Armaf perfumes costing up to GHS 700.
5. A list of different brands starting with C or L.

Each query uses `LIMIT 5 OFFSET 0`. To see the second page, change it to `LIMIT 5 OFFSET 5`. Orders use dates relative to the day the seed file runs. The last-30-days query includes today and the previous 29 days.

## Day 1 notes

Separating orders from order items lets one order contain different perfumes. `WHERE` filters rows, and `ORDER BY` sorts the results. `LIKE` matches case, while `ILIKE` ignores case.

A setup challenge was mixing up Terminal commands and PostgreSQL commands. Another was setting the password: the password must be entered after running `\password mac`, rather than typed as SQL.

The missing email, duplicate customer and negative quantity are intentional, as required by the assignment. More constraints and data cleanup will be added on Day 3. Days 2 and 3 are not completed yet.

Prepared with AI assistance from the written assignment. The full video has not yet been reviewed.
