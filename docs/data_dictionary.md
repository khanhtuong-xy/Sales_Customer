# Data Dictionary
# Data Dictionary

This document describes the main tables and fields used in the Sales & Customer BI project.

## fact_order

| Column | Description |
|---|---|
| order_id | Unique identifier for each order |
| purchase_date | Date when the order was placed |
| customer_id | Customer identifier linked to dim_customer |
| product_id | Product identifier linked to dim_product |
| payment_id | Payment method identifier linked to dim_payment |
| shipping_id | Shipping method identifier linked to dim_shipping |
| loyalty | Indicates customer loyalty status |
| Status | Order status such as completed or cancelled |
| orders_type | Order type |
| rating | Customer rating associated with the order |
| quantity | Number of units purchased |
| unit_cost | Cost per unit |

## dim_customer

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| age | Customer age |
| gender | Customer gender |

## dim_product

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| sku | Stock keeping unit |
| product_type | Product category |
| unit_price | Selling price per unit |

## dim_payment

| Column | Description |
|---|---|
| payment_id | Unique payment identifier |
| payment_method | Payment method used by the customer |
| payment_type | Payment classification |

## dim_shipping

| Column | Description |
|---|---|
| shipping_id | Unique shipping identifier |
| shipping_type | Shipping method |
| shipping_category | Shipping category |
| shipping_cost_level | Relative shipping cost classification |
