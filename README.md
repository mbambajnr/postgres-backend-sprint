# Perfume Shop Database

A three-day PostgreSQL assignment using a perfume shop.

## Tables

`customers` stores customer details, `products` stores perfumes, `orders` stores purchases, and `order_items` stores the perfumes and quantities in each order. Prices are in GHS.

## Setup

Start PostgreSQL and run these from the repository folder in Terminal. Replace `mac` with your PostgreSQL username. Use a new database and run setup only once.

```sh
createdb -U mac perfume_shop_sprint
psql -U mac -d perfume_shop_sprint -v ON_ERROR_STOP=1 -f sql/01_schema.sql -f sql/02_seed.sql -f sql/03_queries.sql -f sql/04_reports.sql -f sql/05_integrity.sql -f sql/06_joins.sql -f sql/07_export.sql
```

The last script saves the CSV to `exports/order_details.csv`, replacing the sample export.

## Day 1

Created four tables, added 10 customers, 15 products and 30 orders, and wrote five filtering queries with pagination. The missing email, duplicate customer and negative return quantity were intentional.

The main lesson was separating orders from their items. A setup challenge was knowing which commands belong in Terminal and which belong in PostgreSQL.

## Day 2

Added revenue reports, monthly totals, top products, average order value and return percentage. Practised grouping, functions and dates.

Revenue includes delivered sales minus returns. Refunds are 3.50% of gross sales. Average order value counts each delivered order once, rather than counting its items. NULLIF prevents division by zero.

## Day 3

Removed the duplicate customer, added constraints, wrote a customer upsert and used joins to show order details and customers or products without orders. Exported 39 item rows to CSV.

The duplicate had to be removed before adding the unique email rule. Missing email is still allowed, and negative quantities remain valid for returns.
