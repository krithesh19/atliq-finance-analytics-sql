# AtliQ Hardware – Finance Analytics Case Study (SQL)

## Project Overview

This project simulates a finance analytics reporting system for a consumer electronics company.

The objective was to transform transactional sales data into structured business insights by:

- Converting Gross Sales into Net Sales  
- Analyzing discount impact on revenue  
- Identifying top-performing markets and customers  
- Measuring revenue concentration  
- Optimizing query performance on large datasets (~1.4M records)

The project demonstrates end-to-end analytical thinking — from data modeling to performance tuning.

---

## Business Context

The company required:

- Clear visibility into actual revenue after multiple discount layers  
- Market-level performance tracking  
- Identification of high-value customers  
- Efficient query performance for reporting  

The solution was designed using a star schema structure and layered SQL transformations to create reusable reporting logic.

---

## Data Model Architecture

The database follows a star schema design.

### Fact Tables
- `fact_sales_monthly`  
- `fact_gross_price`  
- `fact_pre_invoice_deductions`  
- `fact_post_invoice_deductions`  

### Dimension Tables
- `dim_customer`  
- `dim_product`  

A view-based transformation layer was implemented to simplify reporting queries and improve modularity.

---

## Key Analytics Implemented

### 1. Monthly Gross Sales Analysis
Aggregated revenue using quantity × gross price to identify revenue trends across fiscal years.

### 2. Net Sales Transformation
Built a multi-step revenue calculation pipeline:

Gross Sales  
→ Apply Pre-Invoice Discount  
→ Calculate Net Invoice Sales  
→ Apply Post-Invoice Discount  
→ Final Net Sales  

Implemented using reusable SQL views for clarity and maintainability.

### 3. Top Markets and Customers
- Ranked top-performing markets by net sales  
- Calculated customer-level revenue contribution percentages  
- Used window functions (`DENSE_RANK`, `OVER`) for analytical ranking  

### 4. Revenue Concentration Analysis
Measured percentage contribution of each customer to total revenue and identified high-revenue concentration patterns.

---

## Performance Optimization

### Problem Identified
Using a fiscal year function in the `WHERE` clause caused full table scans across approximately 1.4 million records.

### Optimization Strategies
1. Introduced a date dimension table to avoid function-based filtering.  
2. Added a `fiscal_year` column directly to the fact table.  

### Final Implementation
An indexed `fiscal_year` column was used to enable direct filtering and improve execution time.

### Key Learning
Avoid functions in filtering conditions on large datasets. Prefer indexed columns for scalable reporting.

---

## Skills Demonstrated

- Advanced SQL joins  
- Window functions (`RANK`, `DENSE_RANK`, `OVER`)  
- CTEs and views  
- Business KPI modeling  
- Query optimization  
- Indexing strategy  
- Star schema understanding  

---

## Tools Used

- MySQL  
- EXPLAIN ANALYZE  
- Excel (for date dimension creation)  

---

## Outcome

This project demonstrates the ability to:

- Translate business requirements into SQL solutions  
- Design scalable analytical queries  
- Optimize performance on large datasets  
- Generate actionable business insights  
