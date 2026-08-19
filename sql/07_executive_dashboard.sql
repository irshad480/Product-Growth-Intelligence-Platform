-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- EXECUTIVE DASHBOARD
-- ==========================================================

------------------------------------------------------------
-- 1. Executive KPIs
------------------------------------------------------------

SELECT
    ROUND(SUM(Revenue),2) AS Total_Revenue,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Revenue),2) AS Average_Order_Value
FROM fact_orders;

------------------------------------------------------------
-- 2. Monthly Revenue Trend
------------------------------------------------------------

SELECT
    DATE_TRUNC('month', Order_Date) AS Month,
    ROUND(SUM(Revenue),2) AS Revenue
FROM fact_orders
GROUP BY DATE_TRUNC('month', Order_Date)
ORDER BY Month;

------------------------------------------------------------
-- 3. Monthly Profit Trend
------------------------------------------------------------

SELECT
    DATE_TRUNC('month', Order_Date) AS Month,
    ROUND(SUM(Profit),2) AS Profit
FROM fact_orders
GROUP BY DATE_TRUNC('month', Order_Date)
ORDER BY Month;

------------------------------------------------------------
-- 4. Revenue by Country
------------------------------------------------------------

SELECT
    u.Country,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN dim_users u
ON o.User_ID = u.User_ID
GROUP BY u.Country
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 5. Revenue by Category
------------------------------------------------------------

SELECT
    p.Category,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 6. Revenue by Traffic Source
------------------------------------------------------------

SELECT
    s.Traffic_Source,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN fact_sessions s
ON o.Session_ID = s.Session_ID
GROUP BY s.Traffic_Source
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 7. Revenue by Device
------------------------------------------------------------

SELECT
    s.Device,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN fact_sessions s
ON o.Session_ID = s.Session_ID
GROUP BY s.Device
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 8. Revenue by Customer Segment
------------------------------------------------------------

SELECT
    u.Customer_Segment,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN dim_users u
ON o.User_ID = u.User_ID
GROUP BY u.Customer_Segment
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 9. Top 10 Products
------------------------------------------------------------

SELECT
    p.Product_Name,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Revenue DESC
LIMIT 10;

------------------------------------------------------------
-- 10. Top 10 Customers
------------------------------------------------------------

SELECT
    o.User_ID,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
GROUP BY o.User_ID
ORDER BY Revenue DESC
LIMIT 10;

------------------------------------------------------------
-- 11. Monthly Growth Rate
------------------------------------------------------------

WITH monthly_sales AS (

SELECT
    DATE_TRUNC('month', Order_Date) AS Month,
    SUM(Revenue) AS Revenue
FROM fact_orders
GROUP BY DATE_TRUNC('month', Order_Date)

)

SELECT

    Month,

    ROUND(Revenue,2) AS Revenue,

    ROUND(

        (
            Revenue -
            LAG(Revenue) OVER (ORDER BY Month)
        )

        /

        LAG(Revenue) OVER (ORDER BY Month)

        *100,

        2

    ) AS Growth_Percentage

FROM monthly_sales;

------------------------------------------------------------
-- 12. Executive Summary
------------------------------------------------------------

SELECT

COUNT(DISTINCT User_ID) AS Customers,

COUNT(*) AS Orders,

ROUND(SUM(Revenue),2) AS Revenue,

ROUND(SUM(Profit),2) AS Profit,

ROUND(AVG(Revenue),2) AS Avg_Order_Value

FROM fact_orders;