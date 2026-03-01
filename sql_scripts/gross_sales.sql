/*
=========================================================
AtliQ Hardware - Monthly Gross Sales Analysis
=========================================================

Objective:
Calculate total gross sales per month by multiplying
sold_quantity with gross_price.

Business Use:
- Track revenue trends over time
- Identify seasonal performance
- Compare year-over-year growth
- Monitor sales volume patterns

Dataset Size:
fact_sales_monthly contains ~1.4M+ records.

=========================================================
*/


/*
---------------------------------------------------------
Monthly Gross Sales (All Years)
---------------------------------------------------------
*/

SELECT 
    s.date,
    SUM(ROUND(s.sold_quantity * g.gross_price, 2)) 
        AS monthly_gross_sales
FROM fact_sales_monthly s
JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
GROUP BY s.date
ORDER BY s.date;


/*
---------------------------------------------------------
Monthly Gross Sales by Fiscal Year
---------------------------------------------------------
*/

SELECT 
    s.fiscal_year,
    s.date,
    SUM(ROUND(s.sold_quantity * g.gross_price, 2)) 
        AS monthly_gross_sales
FROM fact_sales_monthly s
JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
GROUP BY s.fiscal_year, s.date
ORDER BY s.fiscal_year, s.date;


/*
---------------------------------------------------------
Key Observations (To Mention in README, Not SQL Output)
---------------------------------------------------------

- Revenue trend can be analyzed month-over-month.
- High-volume months indicate seasonality.
- Enables further YoY and rolling trend analysis.

=========================================================
End of Gross Sales Analysis
=========================================================
*/