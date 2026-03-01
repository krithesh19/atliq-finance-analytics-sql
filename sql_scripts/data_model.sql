/*
=========================================================
AtliQ Hardware - Finance Analytics Data Model
=========================================================

Schema Type: Star Schema

Fact Tables:
- fact_sales_monthly
- fact_gross_price
- fact_pre_invoice_deductions
- fact_post_invoice_deductions

Dimension Tables:
- dim_customer
- dim_product

Objective:
This data model supports revenue analysis, discount impact 
calculation, customer contribution analysis, and market-level
performance reporting.

=========================================================
*/


/*
---------------------------------------------------------
Fiscal Year Logic
---------------------------------------------------------

The company follows a fiscal year starting in September.

Fiscal Year Calculation Logic:
FY = YEAR(DATE_ADD(calendar_date, INTERVAL 4 MONTH))

Instead of calculating fiscal year dynamically in queries
(using a function in WHERE clause), a fiscal_year column 
was added to fact_sales_monthly for performance optimization.
*/


/*
---------------------------------------------------------
Key Table Relationships
---------------------------------------------------------

fact_sales_monthly
    - date
    - product_code
    - customer_code
    - sold_quantity
    - fiscal_year

dim_product
    - product_code
    - product
    - variant
    - division

dim_customer
    - customer_code
    - customer
    - market
    - region

fact_gross_price
    - product_code
    - fiscal_year
    - gross_price

fact_pre_invoice_deductions
    - customer_code
    - fiscal_year
    - pre_invoice_discount_pct

fact_post_invoice_deductions
    - customer_code
    - product_code
    - date
    - discounts_pct
    - other_deductions_pct
*/


/*
---------------------------------------------------------
View Layer Design
---------------------------------------------------------

To create a reusable reporting layer, the following views
were implemented:

1. sales_preinv_discount
   - Calculates gross_price_total
   - Applies pre-invoice discount

2. sales_postinv_discount
   - Applies post-invoice deductions
   - Calculates net_invoice_sales

3. net_sales
   - Final revenue after all discounts

This layered approach improves:
- Query reusability
- Modularity
- Readability
- Reporting simplicity
*/


/*
---------------------------------------------------------
Indexing Strategy
---------------------------------------------------------

To improve filtering performance on large datasets
(~1.4 million rows), the following index was created:

*/

CREATE INDEX idx_fiscal_year 
ON fact_sales_monthly(fiscal_year);


/*
---------------------------------------------------------
Design Decisions
---------------------------------------------------------

1. Added fiscal_year column to fact table to avoid
   function calls in WHERE clause.

2. Used star schema to simplify analytical joins.

3. Created views to abstract transformation logic
   and simplify reporting queries.

=========================================================
End of Data Model Definition
=========================================================
*/