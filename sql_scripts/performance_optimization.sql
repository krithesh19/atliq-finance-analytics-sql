/*
=========================================================
AtliQ Hardware - Query Performance Optimization
=========================================================

Dataset Size:
fact_sales_monthly ≈ 1.4M+ records

Objective:
Improve performance of Net Sales reporting queries
by eliminating inefficient filtering logic.

=========================================================
*/


/*
---------------------------------------------------------
1. Original Query (Performance Bottleneck)
---------------------------------------------------------

Problem:
Using a function inside the WHERE clause:

WHERE get_fiscal_year(date) = 2021

This forces row-by-row evaluation and prevents 
effective index utilization, resulting in full table scans.
*/

-- Example (Slow Filtering Approach)

SELECT *
FROM fact_sales_monthly
WHERE get_fiscal_year(date) = 2021;



/*
---------------------------------------------------------
2. Optimization Strategy #1 - Date Dimension Table
---------------------------------------------------------

Approach:
Created dim_date table and joined using calendar_date
to avoid calling function in WHERE clause.

Benefit:
Reduces function computation.
Allows filtering using indexed column in dim_date.

Trade-off:
Introduces additional join.
*/

SELECT 
    s.date,
    s.customer_code,
    s.product_code,
    s.sold_quantity
FROM fact_sales_monthly s
JOIN dim_date d
    ON s.date = d.calendar_date
WHERE d.fiscal_year = 2021;



/*
---------------------------------------------------------
3. Final Optimization Strategy - Fiscal Year Column
---------------------------------------------------------

Approach:
Added fiscal_year column directly to fact_sales_monthly.

Reason:
- Storage is inexpensive.
- Eliminates function calls.
- Avoids extra joins.
- Enables direct filtering.
- Simplifies reporting queries.

This is the selected production-ready solution.
*/

-- Add fiscal_year column (already implemented)

-- CREATE INDEX for improved filtering performance

CREATE INDEX idx_fiscal_year 
ON fact_sales_monthly(fiscal_year);


-- Optimized Query

SELECT 
    date,
    customer_code,
    product_code,
    sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2021;



/*
=========================================================
Performance Insight
=========================================================

Before Optimization:
- Full table scan
- Higher execution time

After Optimization:
- Index-based filtering
- Reduced execution time
- Cleaner query structure

Key Learning:
Avoid functions in WHERE clauses on large datasets.
Prefer indexed columns for filtering.

=========================================================
End of Performance Optimization
=========================================================
*/