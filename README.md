# Perfume Shop Database

Day 1 of a PostgreSQL assignment: a small perfume shop database.

## Files

- `sql/01_schema.sql`: creates the four tables.
- `sql/02_seed.sql`: adds 10 customers, 15 perfumes, 30 orders and 39 order items.
- `sql/03_queries.sql`: five filtering queries with pagination.
- `notes/design_decisions.md`: explains the table choices and intentional data issues.

## Setup

Start PostgreSQL and open Terminal in this repository folder. Replace `mac` with your PostgreSQL username if needed.

```sh
psql -U mac -d postgres
```

Inside PostgreSQL, run:

```sql
CREATE DATABASE perfume_shop;
```

```text
\c perfume_shop
\i sql/01_schema.sql
\i sql/02_seed.sql
\i sql/03_queries.sql
```

The schema and seed files should each run once in a new, empty database. If a database called `perfume_shop` already contains an earlier version, use a different database name for a fresh setup.

## Tables

Customers place orders. Products are the perfumes for sale. Order items record which perfumes are in an order, how many were bought and the price charged. One order can have several items.

IDs are entered as whole numbers in the sample data. Primary keys and other constraints will be added on Day 3. Prices are sample amounts in Ghana cedis (GHS).

## Queries

The five queries find a customer's orders, search for a perfume, filter orders by date, filter products by brand and price, and list matching brands. These could support order history, product search and brand filters on a shop website.

`LIMIT 5` shows up to five rows. `OFFSET 0` starts at the first row. Change it to `OFFSET 5` for the next page.

The sample dates are fixed in September to November 2026. Query 3 uses November 2026 so its results do not depend on when the reviewer runs it.

## Day 1 notes

An order needs separate item rows because a customer can buy several perfumes at once. `WHERE` filters the rows, `ORDER BY` sorts them, and `DISTINCT` removes repeated values from the results. `LIKE` is case-sensitive; `ILIKE` ignores case.

One setup challenge was mixing up Terminal commands with SQL commands. Another was setting a password: it must be entered after running `\password mac`, rather than typed directly at the SQL prompt.

The seed file deliberately includes a missing email, a duplicate customer and a return with a negative quantity. These will be used in the later tasks. Days 2 and 3 are still pending.



## Plan for the next two days

These files will be added as the work is completed:

| Day | File | Work |
| --- | --- | --- |
| 2 | `sql/04_reports.sql` | Total revenue, monthly revenue, top 5 products, average order value and return percentage. Use GROUP BY, HAVING, aggregates, ROUND, COALESCE and NULLIF. Practise intervals, EXTRACT and AGE. |
| 2 | `notes/day2.md` | Learning notes and challenges. |
| 3 | `sql/05_integrity.sql` | Clean the duplicate and missing data, add constraints, and write a customer upsert. |
| 3 | `sql/06_joins.sql` | Full order details and customers or products with no orders. |
| 3 | `sql/07_export.sql` | Export an order report to CSV. |
| 3 | `exports/order_details.csv` | The exported report. |
| 3 | `notes/day3.md` | Learning notes and challenges. |

The design decisions file stays local and is excluded from Git. Before Day 2 reports are written, agree which order statuses count as revenue and how to calculate the share from returns.
