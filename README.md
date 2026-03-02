# 📊 AtliQ Hardware – Finance Analytics System (SQL)

## 📌 Project Overview

Designed and implemented an end-to-end finance analytics reporting system using SQL to transform raw transactional sales data (~1.4M+ records) into structured, business-ready insights.

The project focuses on revenue transformation, discount impact analysis, market performance tracking, revenue concentration evaluation, and large-scale query performance optimization.

This simulates an enterprise-style finance reporting workflow built on a fact-dimension data model.

---

# 🎯 Business Objectives

- Convert **Gross Sales → Net Sales** after multiple discount layers  
- Identify top-performing markets and customers  
- Measure revenue concentration and dependency risk  
- Improve reporting query performance on large datasets  

---

# 🏗 Data Architecture

The project follows a structured analytical model aligned with enterprise reporting systems:

- Fact table: `fact_sales_monthly`
- Dimension tables: customer, product, date
- Layered SQL views for revenue transformation
- Indexed fiscal reporting attributes for performance scalability

The schema supports financial reporting, ranking analysis, and KPI monitoring.

---

# 🔍 Core Analytics Implementation

## 1️⃣ Net Sales Transformation

Implemented layered revenue calculation:

Gross Sales  
→ Pre-Invoice Discount  
→ Post-Invoice Discount  
→ Final Net Sales  

This logic was built using structured SQL views to ensure reusability and reporting clarity.

---

## 2️⃣ Market & Customer Performance Analysis

- Ranked markets based on total revenue  
- Calculated customer contribution percentage  
- Applied window functions (`DENSE_RANK`, `OVER`) for ranking and revenue distribution  
- Identified high-performing and underperforming segments  

---

## 3️⃣ Revenue Concentration Analysis

- Measured revenue share of top customers  
- Identified dependency risk across customer segments  
- Evaluated revenue skewness for strategic awareness  

---

# ⚡ Performance Optimization Case Study

## 🔎 Initial Performance Issue

The original execution plan revealed:

- Function-based filtering:
  ```sql
  WHERE get_fiscal_year(date) = 2021
Full table scans on ~1.4M+ records

Multiple nested loop joins

Execution time: ~7–8 seconds

This approach prevented proper index utilization and reduced scalability.

🛠 Optimization Strategy
Step 1: Removed Function-Based Filtering

Added a dedicated fiscal_year column to the fact table.

Replaced:

WHERE get_fiscal_year(date) = 2021

With:

WHERE fiscal_year = 2021
Step 2: Implemented Indexing

Created an index on the fiscal_year column to enable direct filtering.

Step 3: Reduced Unnecessary Date Table Join

Since fiscal_year was now stored in the fact table, redundant joins to the date dimension were eliminated for reporting queries.

📊 Performance Results
Stage	Execution Time
Before Optimization	~7–8 seconds
After Join Improvement	~3 seconds
After Indexed Fiscal Year	~1.9 seconds

✅ ~75% reduction in execution time
✅ Improved scalability for reporting queries
✅ Enabled efficient filtering on large datasets

📌 Key Technical Insight

Avoid using functions in WHERE clauses on large indexed datasets.

Function-based filtering prevents index usage and forces full table scans.

Designing fact tables with precomputed reporting attributes (e.g., fiscal_year) significantly improves performance in analytics systems.

💼 Business Impact & Decision Support

This analytics system enables:

Identification of high-revenue but low-margin markets

Evaluation of discount impact on overall profitability

Detection of revenue concentration risk among top customers

Structured financial performance monitoring for leadership

Faster reporting cycles due to improved query efficiency

The system mirrors real-world enterprise finance analytics workflows.

🛠 Skills Demonstrated

Advanced SQL Joins

Window Functions (DENSE_RANK, OVER)

CTEs & Layered Views

Query Optimization & Execution Plan Analysis

Indexing Strategy

Fact-Dimension Data Modeling

Revenue & Profitability Analytics

🧰 Tools Used

MySQL
EXPLAIN ANALYZE
SQL Views & Indexing
Microsoft Excel (validation & cross-checking)


---

# 🔥 Why This Is Strong

This README now shows:

- Technical depth  
- Performance engineering  
- Business reasoning  
- Architectural understanding  
- Interview-ready clarity  

It reads like someone who understands analytics systems — not just someone who wrote queries.

---

You are now portfolio-competitive.

Next smart move:

Do you want to make your BI project README equally strong so both look enterprise-level?
