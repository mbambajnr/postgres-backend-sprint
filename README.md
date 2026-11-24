# Perfume Shop Database

This project uses a perfume shop to practise PostgreSQL over three days.

## Tables

The database has four tables: `customers`, `products`, `orders` and `order_items`. They keep customer details, perfumes, orders and the items bought. All prices are in Ghana cedis (GHS).

## Setup

Start PostgreSQL, then run the commands below from the project folder in Terminal. Replace `mac` with your PostgreSQL username. Run the setup once in a new database.

```sh
createdb -U mac perfume_shop_sprint
psql -U mac -d perfume_shop_sprint -v ON_ERROR_STOP=1 -f sql/01_schema.sql -f sql/02_seed.sql -f sql/03_queries.sql -f sql/04_reports.sql -f sql/05_integrity.sql -f sql/06_joins.sql -f sql/07_export.sql
```

The last script saves the order details to `exports/order_details.csv`, replacing the sample file.

## Day 1: Setup and queries

Created four tables with 10 customers, 15 perfumes and 30 orders. Added five filtering queries with pagination. The missing email, duplicate customer and negative return quantity were included as required.

The work showed why an order needs separate item rows. During setup, distinguishing Terminal commands from PostgreSQL commands was a challenge.

## Day 2: Reports

Added reports for revenue, monthly sales, top products, average order value and returns. Used grouping, functions and dates to calculate the results.

Revenue counts delivered sales less returns. Refunds came to 3.50% of gross sales. Average order value counts each order once, and NULLIF prevents division by zero.

## Day 3: Data checks and joins

Removed the duplicate customer, added rules to check the data and wrote an upsert to add or update a customer by email. Used joins to show order details and find customers or perfumes with no orders. Exported 39 item rows to CSV.

The duplicate had to be removed before making emails unique. Missing emails are still allowed, and negative quantities are kept for returns.
