# Sales and Customer Business Intelligence Project

End-to-end sales and customer analysis project using Power BI, Power Query, DAX, SQL Server, and dimensional data modeling.

The project transforms monthly transaction files into a structured analytical model and uses SQL and Power BI to analyze sales performance, profitability, customer behavior, payment methods, shipping methods, and order cancellation.

## Project at a Glance

- Period: September 2023 to September 2024
- Orders: 20,000
- Customers: 12,136
- Products: 13
- Payment methods: 5
- Shipping methods: 5
- Main tools: Power BI, Power Query, DAX, SQL Server, SSMS
- Main outputs: SQL database, data validation, business analysis, Power BI dashboard, customer cohort analysis

## Business Problem

The project focuses on understanding how different products, customers, payment methods, and shipping methods contribute to overall business performance.

The main questions are:

1. Which product categories generate the most revenue and profit?
2. Which product categories provide the strongest profit margins?
3. Which customers contribute the most revenue?
4. How do payment and shipping methods differ in profitability and cancellation rate?
5. Are there specific shipping and payment combinations associated with higher cancellation risk?
6. How does business performance change over time?

## Power BI Dashboard

The Power BI report contains five main pages designed to support different levels of business analysis, from high-level performance monitoring to detailed transaction investigation.

### Executive Overview

![Executive Overview](images/overview.jpg)

The Executive Overview provides a high-level summary of overall business performance.

It focuses on key indicators such as:

- Revenue
- Profit
- Profit margin
- Total orders
- Total customers
- Cancellation rate
- Monthly sales trends
- Product performance

This page is designed to help users quickly understand the overall performance of the business before exploring more detailed analysis.

### Product Performance

![Product Performance](images/product.jpg)

The Product Performance page compares product categories based on sales and profitability.

The main metrics include:

- Revenue
- Profit
- Profit margin
- Units sold
- Average rating
- Cancellation rate

This page helps identify which product categories contribute the most revenue and which categories provide stronger profitability.

### Customer Analytics

![Customer Analytics](images/customer.jpg)

The Customer Analytics page focuses on purchasing behavior and customer value.

The analysis includes:

- Customer revenue
- Number of orders
- Purchase frequency
- Customer characteristics
- New and returning customers
- Customer retention
- Cohort retention analysis

This page helps identify valuable customers and examine how customer behavior develops over time.

### Shipping and Payment Analysis

![Shipping and Payment Analysis](images/shipping&payment.jpg)

The Shipping and Payment Analysis page focuses on operational performance and cancellation risk.

The analysis includes:

- Shipping method performance
- Payment method performance
- Revenue and profit
- Profit margin
- Order volume
- Cancellation rate
- Shipping and payment risk heatmap
- Shipping performance quadrant
- Profit per order by shipping and payment combination

This page helps identify shipping and payment combinations that may require further operational investigation.

### Detail View

![Detail View](images/Detail.jpg)

The Detail View provides transaction-level information for deeper investigation.

It allows users to review individual order records after identifying a pattern or unusual result from the main analytical pages.

This page supports drill-down analysis and helps connect high-level dashboard findings with the underlying transaction data.

## Key Business Findings

### 1. Smartphone is the main revenue driver

Smartphone products generated approximately 21.52 million in revenue, representing about one-third of total project revenue.

Business implication:

Because Smartphone contributes a large share of total revenue, changes in this category can have a meaningful effect on overall business performance. Its performance should therefore be monitored closely together with profitability and cancellation metrics.

### 2. Smartwatch combines strong revenue with a high profit margin

Smartwatch generated approximately 14.04 million in revenue and achieved a profit margin of approximately 91.49 percent.

Business implication:

The result shows that product performance should not be evaluated using revenue alone. A category with lower revenue than the top-selling category may still provide strong profitability.

### 3. Product category does not appear to explain cancellation by itself

Cancellation rates across product categories were generally concentrated around 32 to 33 percent.

No product category showed a substantially different cancellation rate from the others.

Business implication:

Further cancellation analysis should focus on operational factors such as payment methods, shipping methods, and their combinations rather than assuming that one product category is responsible for the problem.

### 4. Shipping methods differ more in profitability than in cancellation rate

Cancellation rates across shipping methods were relatively close.

For example:

- Express shipping: approximately 33.84 percent
- Standard shipping: approximately 32.18 percent

Differences in profitability between shipping methods were more noticeable than differences in cancellation rate.

Business implication:

Shipping performance should be evaluated using both profitability and cancellation metrics rather than cancellation rate alone.

### 5. Some shipping and payment combinations show higher cancellation rates

The combined analysis of shipping and payment methods revealed more variation than analyzing either dimension independently.

Examples include:

- Express with PayPal: approximately 35.75 percent cancellation rate
- Overnight with PayPal: approximately 35.13 percent cancellation rate

Business implication:

These combinations can be prioritized for further investigation into payment processing, delivery expectations, customer behavior, or order fulfillment.

The available data shows an association but does not establish that the shipping or payment method directly causes cancellation.

### 6. Revenue is distributed across a broad customer base

The highest-revenue customer generated approximately 34.56 thousand in revenue from 7 orders.

Compared with total project revenue of approximately 63.60 million, the largest individual customer represents only a small share of total revenue.

Business implication:

The business is not heavily dependent on one high-value customer. Customer segmentation, retention, and repeat purchasing behavior may therefore be more useful areas for further analysis than focusing only on a small group of top customers.

## Data Source

The project uses monthly electronic sales transaction files together with supporting customer, product, payment, and shipping data.

The transaction data contains fields such as:

- Order ID
- Customer ID
- Product ID
- Purchase date
- Order status
- Payment ID
- Shipping ID
- Loyalty status
- Rating
- Quantity
- Unit cost

The original external publisher or source of the dataset is not documented in this repository.

The data covers September 2023 to September 2024.

## Metric Definitions

The main business metrics were calculated using the following logic.

### Revenue

```text
Revenue = Quantity * Unit Price
```
### Total Cost
```text
Total Cost = Quantity * Unit Cost
```
### Profit
```text
Profit = Quantity * (Unit Price - Unit Cost)
```
### Profit Margin
```text
Profit Margin = Profit / Revenue
```
### Cancellation Rate
```text
Cancellation Rate = Cancelled Orders / Total Orders
```
## Project Workflow

The project contains two analytical workflows built from the same source data.

```text
Monthly Transaction Files
        |
        |-------------------------------|
        |                               |
        v                               v
Power Query                    SQL Staging Tables
        |                               |
        v                               v
Data Cleaning                  Data Validation
and Transformation                      |
        |                               v
        v                      Fact and Dimension Model
Power BI Data Model                     |
        |                               v
        v                      SQL Business Analysis
DAX Measures                    and Advanced SQL
        |
        v
Power BI Dashboard
        |
        v
Business Insights
```
Power Query was used to combine and clean the monthly transaction files before analysis.
The main preparation steps included:
- Combining monthly files
- Checking missing values
- Checking duplicate records
- Standardizing column names and data types
- Standardizing order status values
- Handling missing customer information
- Preparing fact and dimension tables
The final analytical model consists of one fact table and four main dimension tables:
- fact_order
- dim_customer
- dim_product
- dim_payment
- dim_shipping
Detailed field descriptions are available in the [Data Dictionary](docs/data_dictionary.md).
## Data Validation
SQL was used to validate data quality before performing business analysis.
The validation process included:
- Row count checks
- Missing value checks
- Duplicate ID checks
- Missing key field checks
- Customer ID matching
- Product ID matching
- Payment ID matching
- Shipping ID matching
- Referential integrity checks
The final model contains:
- 20,000 orders
- 12,136 customers
- 13 products
- 5 payment methods
- 5 shipping methods
No unmatched customer, product, payment, or shipping keys were identified in the validated dataset.
## SQL Analysis
SQL was used to analyze the main areas of business performance.
The analysis covers:
- Product performance
- Customer performance
- Shipping performance
- Payment performance
- Shipping and payment cancellation risk
- Monthly revenue and profit trends
Advanced SQL techniques used in the project include:
- Multi-table JOINs
- Aggregations
- CASE WHEN
- Common Table Expressions
- RANK
- LAG
- Window functions
- Date functions
- NULLIF
Advanced Analysis
Product revenue was ranked using a Common Table Expression and the RANK window function.
The product revenue ranking was:
1. Smartphone
2. Smartwatch
3. Laptop
4. Tablet
5. Headphones
Monthly revenue growth was analyzed using the LAG window function to compare each month with the previous month.
Customer revenue and profit were also aggregated and ranked to identify high-value customers.
### SQL Files
[01_database_schema.sql](SQL/01_database_schema.sql)

Creates the fact and dimension tables, defines primary and foreign keys, and loads data from staging tables.

[02_data_validation.sql](SQL/02_data_validation.sql)

Contains data quality checks for missing values, duplicates, row counts, key matching, and referential integrity.

[03_business_analysis.sql](SQL/03_business_analysis.sql)

Contains the main product, customer, shipping, payment, cancellation risk, and monthly performance analysis.

[04_advanced_analysis.sql](SQL/04_advanced_analysis.sql)

Contains advanced analysis using CTEs, RANK, LAG, and window functions.

## Analytical Limitations
### Partial Months

The first and last months in the dataset are incomplete.

The dataset begins during September 2023 and ends during September 2024.

Month-over-month comparisons involving these periods should therefore be interpreted carefully because changes may partly reflect differences in the number of 
available transaction days.

Full-month periods should be prioritized when evaluating monthly trends.

### Revenue Definition

The current project calculates revenue and profit across all order records, including cancelled orders.

Cancellation is analyzed separately using cancellation rate.

For a production reporting environment, the definition of realized revenue should be confirmed with business stakeholders to determine whether cancelled orders 
should be excluded.

### Causality

The analysis identifies patterns and associations but does not establish causal relationships.

For example, a higher cancellation rate for a specific shipping and payment combination does not prove that either method directly causes cancellation.

Additional operational or customer data would be required to investigate the underlying causes.

###  Customer Data

Customer analysis is limited by the available customer attributes, mainly customer ID, age, and gender.

Additional information such as customer location, acquisition channel, customer segment, or marketing activity could support deeper customer analysis.

## Repository Structure

```text
Sales_Customer/
|
|-- README.md
|
|-- dashboard/
|   |-- Power BI dashboard file
|
|-- images/
|   |-- overview.jpg
|   |-- product.jpg
|   |-- customer.jpg
|   |-- shipping&payment.jpg
|   |-- Detail.jpg
|
|-- SQL/
|   |-- 01_database_schema.sql
|   |-- 02_data_validation.sql
|   |-- 03_business_analysis.sql
|   |-- 04_advanced_analysis.sql
|
|-- docs/
|   |-- data_dictionary.md
```
Recommended Review Order
1. Review the project overview and key business findings.
2. Review the Power BI dashboard screenshots.
3. Open the Power BI file for interactive analysis.
4. Review the SQL files for data modeling, validation, and analysis.
5. Review the data dictionary for detailed field definitions.
## Tools and Skills

Power BI, Power Query, DAX, SQL Server, SSMS, GitHub

Skills:
- Data cleaning and validation
- SQL analysis
- Dimensional modeling
- CTEs and window functions
- KPI development
- Customer and cohort analysis
- Power BI dashboard development
- Business insight communication
