# AtliQ Hardware – Finance Analytics (SQL)

## Overview

Built a finance analytics reporting system using SQL to transform raw sales data into business-ready insights.

The project focuses on revenue calculation, discount impact analysis, market performance tracking, and query optimization on ~1.4M records.

---

## Business Objective

- Convert Gross Sales into Net Sales after multiple discount layers  
- Identify top-performing markets and customers  
- Measure revenue concentration  
- Improve query performance for large reporting datasets  

---

## Core Analytics

**Net Sales Transformation**  
Gross Sales → Pre-Invoice Discount → Post-Invoice Discount → Final Net Sales  
(Implemented using layered SQL views)

**Top Markets & Customers**  
- Ranked markets by revenue  
- Calculated customer contribution %  
- Used window functions (`DENSE_RANK`, `OVER`)

**Revenue Concentration Analysis**  
Identified high-value customers contributing major share of revenue.

---

## Performance Optimization

- Identified full table scan due to function-based filtering  
- Added indexed `fiscal_year` column to fact table  
- Reduced execution time by enabling direct filtering  

Key Learning: Avoid functions in WHERE clauses on large datasets.

---

## Skills Demonstrated

- Advanced SQL joins  
- Window functions  
- CTEs & Views  
- Query optimization  
- Indexing strategy  
- Star schema understanding  

---

## Tools

MySQL | EXPLAIN ANALYZE | Excel
