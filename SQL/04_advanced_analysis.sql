-- =========================================================
-- SALES & CUSTOMER BI PROJECT
-- FILE: 04_advanced_analysis.sql
-- PURPOSE: Advanced SQL analysis using CTEs and window functions
-- =========================================================

USE SalesCustomerBI;
GO


-- =========================================================
-- 1. PRODUCT REVENUE RANKING
-- =========================================================

WITH ProductRevenue AS (
    SELECT
        p.product_type,
        SUM(f.quantity * p.unit_price) AS revenue
    FROM fact_order f
    JOIN dim_product p
        ON f.product_id = p.product_id
    GROUP BY
        p.product_type
)

SELECT
    product_type,
    revenue,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM ProductRevenue

ORDER BY
    revenue_rank;
GO


-- =========================================================
-- 2. MONTHLY REVENUE GROWTH
-- =========================================================

WITH MonthlyRevenue AS (
    SELECT
        DATEFROMPARTS(
            YEAR(f.purchase_date),
            MONTH(f.purchase_date),
            1
        ) AS month_start,

        SUM(f.quantity * p.unit_price) AS revenue

    FROM fact_order f

    JOIN dim_product p
        ON f.product_id = p.product_id

    GROUP BY
        YEAR(f.purchase_date),
        MONTH(f.purchase_date)
),

RevenueWithPreviousMonth AS (
    SELECT
        month_start,
        revenue,

        LAG(revenue) OVER (
            ORDER BY month_start
        ) AS previous_month_revenue

    FROM MonthlyRevenue
)

SELECT
    month_start,
    revenue,
    previous_month_revenue,

    100.0 *
    (revenue - previous_month_revenue)
    / NULLIF(previous_month_revenue, 0)
        AS revenue_growth_pct

FROM RevenueWithPreviousMonth

ORDER BY
    month_start;
GO


-- =========================================================
-- 3. CUSTOMER REVENUE RANKING
-- =========================================================

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.age,
        c.gender,

        COUNT(DISTINCT f.order_id) AS total_orders,

        SUM(f.quantity * p.unit_price) AS revenue,

        SUM(
            f.quantity * (p.unit_price - f.unit_cost)
        ) AS profit

    FROM fact_order f

    JOIN dim_customer c
        ON f.customer_id = c.customer_id

    JOIN dim_product p
        ON f.product_id = p.product_id

    GROUP BY
        c.customer_id,
        c.age,
        c.gender
)

SELECT
    customer_id,
    age,
    gender,
    total_orders,
    revenue,
    profit,

    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM CustomerRevenue

ORDER BY
    revenue_rank;
GO