/*
=========================================================
AtliQ Hardware - Net Sales Transformation Logic
=========================================================

Objective:
Transform Gross Sales into Net Sales by applying:

1. Pre-Invoice Discounts
2. Post-Invoice Deductions

Business Flow:
Gross Sales
→ Apply Pre-Invoice Discount
→ Calculate Net Invoice Sales
→ Apply Post-Invoice Deductions
→ Final Net Sales

This layered approach mimics real-world revenue reporting.

=========================================================
*/


/*
---------------------------------------------------------
Step 1: Create View - sales_preinv_discount
---------------------------------------------------------

Calculates:
- gross_price_total
- Applies pre-invoice discount percentage

*/

CREATE OR REPLACE VIEW sales_preinv_discount AS
SELECT 
    s.date,
    s.fiscal_year,
    s.customer_code,
    c.market,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM fact_sales_monthly s
JOIN dim_customer c
    ON s.customer_code = c.customer_code
JOIN dim_product p
    ON s.product_code = p.product_code
JOIN fact_gross_price g
    ON g.product_code = s.product_code
    AND g.fiscal_year = s.fiscal_year
JOIN fact_pre_invoice_deductions pre
    ON pre.customer_code = s.customer_code
    AND pre.fiscal_year = s.fiscal_year;


/*
---------------------------------------------------------
Step 2: Create View - sales_postinv_discount
---------------------------------------------------------

Calculates:
- Net Invoice Sales
- Post-Invoice Discount %

*/

CREATE OR REPLACE VIEW sales_postinv_discount AS
SELECT 
    s.date,
    s.fiscal_year,
    s.customer_code,
    s.market,
    s.product_code,
    s.product,
    s.variant,
    s.sold_quantity,
    s.gross_price_total,
    s.pre_invoice_discount_pct,
    
    -- Net Invoice Sales after Pre-Invoice Discount
    (s.gross_price_total 
        - (s.pre_invoice_discount_pct * s.gross_price_total)
    ) AS net_invoice_sales,

    -- Combined Post-Invoice Discount %
    (po.discounts_pct + po.other_deductions_pct) 
        AS post_invoice_discount_pct

FROM sales_preinv_discount s
JOIN fact_post_invoice_deductions po
    ON po.customer_code = s.customer_code
    AND po.product_code = s.product_code
    AND po.date = s.date;


/*
---------------------------------------------------------
Step 3: Create Final View - net_sales
---------------------------------------------------------

Final Revenue Calculation:
Net Sales = Net Invoice Sales × (1 - Post Invoice Discount %)

*/

CREATE OR REPLACE VIEW net_sales AS
SELECT 
    *,
    net_invoice_sales * (1 - post_invoice_discount_pct) 
        AS net_sales
FROM sales_postinv_discount;


/*
---------------------------------------------------------
Example: Net Sales Report (FY 2021)
---------------------------------------------------------
*/

SELECT 
    fiscal_year,
    ROUND(SUM(net_sales) / 1000000, 2) 
        AS total_net_sales_million
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY fiscal_year;


/*
=========================================================
Design Decisions
=========================================================

- Used views to separate transformation layers.
- Improves modularity and reusability.
- Simplifies reporting queries.
- Mimics real enterprise BI architecture.

=========================================================
End of Net Sales Transformation
=========================================================
*/