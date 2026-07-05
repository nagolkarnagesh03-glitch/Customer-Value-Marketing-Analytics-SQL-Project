# Customer Value & Marketing Analytics — SQL Project

## Overview
This project analyzes an insurance company's customer dataset using MySQL to uncover actionable insights around **customer lifetime value (CLV), marketing campaign effectiveness, risk/profitability, retention, and customer targeting**. The goal is to simulate a real-world analyst workflow: raw data → cleaning → business-focused SQL queries → insights → recommendations.

## Dataset
- **Source:** Marketing Customer Value Analysis dataset (insurance customer data)
- **Table:** `customers`
- **Rows:** ~9,100 customer records
- **Key columns:** `customer_id`, `state`, `clv`, `income`, `employment_status`, `monthly_premium_auto`, `total_claim_amount`, `policy_type`, `sales_channel`, `renew_offer_type`, `vehicle_class`, `open_complaints`, `months_since_last_claim`

## Tools Used
- **MySQL 8.0** — data cleaning, transformation, and analysis
- **SQL** — window functions, aggregations, CASE-based segmentation, date functions

## Project Workflow

### 1. Data Cleaning
- Renamed all columns from raw/inconsistent headers (e.g. `Customer Lifetime Value`, `Number of Open Complaints`) to clean `snake_case` names (`clv`, `open_complaints`) for easier querying
- Checked and handled NULL values across key columns
- Identified and removed duplicate customer records
- Converted `effective_to_date` (text, `M/D/YY` format) into a proper MySQL `DATE` column using `STR_TO_DATE`
- Validated categorical fields (`gender`, `education`, `vehicle_class`, etc.) for typos/inconsistent casing
- Checked numeric fields (`income`, `clv`, `total_claim_amount`) for negative or invalid values

### 2. Business Analysis (SQL Queries)
Organized into 5 analytical themes:

| # | Theme | Business Question |
|---|-------|-------------------|
| 1 | Customer Value & Segmentation | Who are the highest-value customers? How do CLV tiers compare? |
| 2 | Marketing Campaign Effectiveness | Which sales channel and renewal offer convert best? |
| 3 | Risk & Profitability | Which vehicle class/policy type is most profitable vs. risky? |
| 4 | Customer Behavior & Retention | Do complaints correlate with lower value? Who is at churn risk? |
| 5 | Demographics & Targeting | Which employment/state/education segments are most valuable? |

Full SQL code and findings are documented in `Customer_Value_Marketing_Insights_Report.docx`.

### 3. Key Insights
- A concentrated segment of customers drives disproportionate CLV — retention-worthy
- Sales channel performance varies significantly, informing where marketing budget should shift
- Certain vehicle classes/policy types show loss ratios that may erode profitability
- Customers with recent claims + multiple open complaints represent a clear, actionable churn-risk list

## Files in This Project
```
├── README.md                                       # Project documentation (this file)
├── customers_cleaning.sql                          # Data cleaning & transformation queries
├── customer_value_queries.sql                       # 11 business insight queries
└── Customer_Value_Marketing_Insights_Report.docx    # Findings + recommendations report
```

## How to Reproduce
1. Import the raw CSV into MySQL as table `customers`
2. Run the cleaning script to rename columns and fix data types
3. Run the analysis queries to generate segment-level and profitability insights
4. Review the report for business interpretation of each query's output

## Skills Demonstrated
`SQL` · `MySQL` · `Data Cleaning` · `Customer Segmentation (RFM/CLV)` · `Business Analytics` · `Marketing Analytics` · `Risk Analysis` · `Data-Driven Decision Making`
