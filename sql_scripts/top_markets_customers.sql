/*
=========================================================
AtliQ Hardware - Top Markets & Customers Analysis
=========================================================

Objective:
Identify high-performing markets and customers using:
- Aggregations
- Window Functions
- Ranking logic
- Percentage contribution analysis

This demonstrates advanced SQL analytical capabilities.

=========================================================
*/


/*
---------------------------------------------------------
1. Top 5 Markets by Net Sales (FY 2021)
---------------------------------------------------------
*/

SELECT 
    market,
    ROUND(SUM(net_sales) / 1000000, 2) AS net_sales_million
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY market
ORDER BY net_sales_million DESC
LIMIT 5;


/*
---------------------------------------------------------
2. Customer-wise Net Sales Contribution %
---------------------------------------------------------

Calculates each customer's percentage contribution 
to total revenue in FY 2021.
*/

WITH customer_sales AS (
    SELECT 
        c.customer,
        ROUND(SUM(n.net_sales) / 1000000, 2) AS net_sales_million
    FROM net_sales n
    JOIN dim_customer c
        ON n.customer_code = c.customer_code
    WHERE n.fiscal_year = 2021
    GROUP BY c.customer
)

SELECT 
    customer,
    net_sales_million,
    ROUND(
        net_sales_million * 100 
        / SUM(net_sales_million) OVER (),
        2
    ) AS pct_contribution
FROM customer_sales
ORDER BY net_sales_million DESC;


/*
---------------------------------------------------------
3. Top 3 Products per Division by Quantity Sold
---------------------------------------------------------

Uses DENSE_RANK() to rank products within each division.
*/

WITH division_sales AS (
    SELECT
        p.division,
        p.product,
        SUM(s.sold_quantity) AS total_quantity
    FROM fact_sales_monthly s
    JOIN dim_product p
        ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY p.division, p.product
),
ranked_products AS (
    SELECT
        division,
        product,
        total_quantity,
        DENSE_RANK() OVER (
            PARTITION BY division 
            ORDER BY total_quantity DESC
        ) AS rank_in_division
    FROM division_sales
)

SELECT *
FROM ranked_products
WHERE rank_in_division <= 3
ORDER BY division, rank_in_division;


/*
=========================================================
Analytical Insights (Mention in README)
=========================================================

- Revenue concentration across top markets.
- Customer contribution follows Pareto principle.
- Product performance varies significantly by division.
- Window functions enable advanced ranking analysis.

=========================================================
End of Top Markets & Customers Analysis
=========================================================
*/