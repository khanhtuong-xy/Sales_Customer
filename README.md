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

## Dashboard Overview

![Executive Overview](images/overview.jpg)

The Executive Overview provides a high-level view of revenue, profit, profit margin, order volume, customer volume, cancellation rate, product performance, and monthly trends.

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
