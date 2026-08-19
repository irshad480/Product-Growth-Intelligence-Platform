-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- AI READY SUMMARY VIEWS
-- ==========================================================

------------------------------------------------------------
-- 1. Monthly Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_monthly_summary AS

SELECT
    DATE_TRUNC('month', Order_Date) AS Month,
    COUNT(*) AS Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(AVG(Revenue), 2) AS Average_Order_Value
FROM fact_orders
GROUP BY DATE_TRUNC('month', Order_Date);

------------------------------------------------------------
-- 2. Category Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_category_summary AS

SELECT
    p.Category,
    COUNT(o.Order_ID) AS Orders,
    ROUND(SUM(o.Revenue), 2) AS Revenue,
    ROUND(SUM(o.Profit), 2) AS Profit,
    ROUND(AVG(o.Profit), 2) AS Avg_Profit_Per_Order
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category;

------------------------------------------------------------
-- 3. Country Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_country_summary AS

SELECT
    u.Country,
    COUNT(o.Order_ID) AS Orders,
    ROUND(SUM(o.Revenue), 2) AS Revenue,
    ROUND(SUM(o.Profit), 2) AS Profit
FROM fact_orders o
JOIN dim_users u
ON o.User_ID = u.User_ID
GROUP BY u.Country;

------------------------------------------------------------
-- 4. Traffic Source Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_traffic_summary AS

SELECT
    Traffic_Source,

    COUNT(*) AS Sessions,

    ROUND(
        AVG(Session_Duration_Min),
        2
    ) AS Avg_Session_Duration,

    ROUND(
        AVG(Page_Views),
        2
    ) AS Avg_Page_Views,

    ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE Converted = TRUE)
        /
        COUNT(*),
        2
    ) AS Conversion_Rate,

    ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE Bounce = TRUE)
        /
        COUNT(*),
        2
    ) AS Bounce_Rate

FROM fact_sessions

GROUP BY Traffic_Source;

------------------------------------------------------------
-- 5. Top Products
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_top_products AS

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    p.Brand,

    COUNT(o.Order_ID) AS Orders,

    SUM(o.Quantity) AS Units_Sold,

    ROUND(SUM(o.Revenue), 2) AS Revenue,

    ROUND(SUM(o.Profit), 2) AS Profit

FROM fact_orders o

JOIN dim_products p
ON o.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category,
    p.Brand

ORDER BY Revenue DESC

LIMIT 20;

------------------------------------------------------------
-- 6. Customer Segment Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_customer_summary AS

SELECT

    u.Customer_Segment,

    COUNT(DISTINCT u.User_ID) AS Customers,

    ROUND(AVG(u.Lifetime_Value),2) AS Avg_Lifetime_Value,

    ROUND(SUM(o.Revenue),2) AS Revenue,

    ROUND(SUM(o.Profit),2) AS Profit

FROM dim_users u

LEFT JOIN fact_orders o

ON u.User_ID = o.User_ID

GROUP BY u.Customer_Segment;

------------------------------------------------------------
-- 7. Executive Summary
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_ai_executive_summary AS

SELECT

    COUNT(*) AS Orders,

    COUNT(DISTINCT User_ID) AS Customers,

    ROUND(SUM(Revenue),2) AS Revenue,

    ROUND(SUM(Profit),2) AS Profit,

    ROUND(AVG(Revenue),2) AS Average_Order_Value,

    ROUND(AVG(Profit),2) AS Average_Profit,

    ROUND(
        SUM(Profit) / NULLIF(SUM(Revenue),0) * 100,
        2
    ) AS Profit_Margin

FROM fact_orders;



