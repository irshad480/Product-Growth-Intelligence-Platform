-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- MARKETING ANALYTICS
-- ==========================================================

------------------------------------------------------------
-- 1. Sessions by Traffic Source
------------------------------------------------------------

SELECT
    Traffic_Source,
    COUNT(*) AS Sessions
FROM fact_sessions
GROUP BY Traffic_Source
ORDER BY Sessions DESC;

------------------------------------------------------------
-- 2. Revenue by Traffic Source
------------------------------------------------------------

SELECT
    s.Traffic_Source,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN fact_sessions s
ON o.Session_ID = s.Session_ID
GROUP BY s.Traffic_Source
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 3. Orders by Traffic Source
------------------------------------------------------------

SELECT
    s.Traffic_Source,
    COUNT(o.Order_ID) AS Orders
FROM fact_orders o
JOIN fact_sessions s
ON o.Session_ID = s.Session_ID
GROUP BY s.Traffic_Source
ORDER BY Orders DESC;

------------------------------------------------------------
-- 4. Conversion Rate by Traffic Source
------------------------------------------------------------

SELECT
    Traffic_Source,
    ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE Converted = TRUE)
        / COUNT(*),
        2
    ) AS Conversion_Rate
FROM fact_sessions
GROUP BY Traffic_Source
ORDER BY Conversion_Rate DESC;

------------------------------------------------------------
-- 5. Bounce Rate by Traffic Source
------------------------------------------------------------

SELECT
    Traffic_Source,
    ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE Bounce = TRUE)
        / COUNT(*),
        2
    ) AS Bounce_Rate
FROM fact_sessions
GROUP BY Traffic_Source
ORDER BY Bounce_Rate ASC;

------------------------------------------------------------
-- 6. Average Session Duration
------------------------------------------------------------

SELECT
    Traffic_Source,
    ROUND(AVG(Session_Duration_Min),2) AS Avg_Session_Duration
FROM fact_sessions
GROUP BY Traffic_Source
ORDER BY Avg_Session_Duration DESC;

------------------------------------------------------------
-- 7. Average Page Views
------------------------------------------------------------

SELECT
    Traffic_Source,
    ROUND(AVG(Page_Views),2) AS Avg_Page_Views
FROM fact_sessions
GROUP BY Traffic_Source
ORDER BY Avg_Page_Views DESC;

------------------------------------------------------------
-- 8. Device Performance
------------------------------------------------------------

SELECT
    Device,
    COUNT(*) AS Sessions,
    ROUND(AVG(Session_Duration_Min),2) AS Avg_Duration,
    ROUND(AVG(Page_Views),2) AS Avg_Page_Views
FROM fact_sessions
GROUP BY Device
ORDER BY Sessions DESC;

------------------------------------------------------------
-- 9. Browser Performance
------------------------------------------------------------

SELECT
    Browser,
    COUNT(*) AS Sessions,
    ROUND(AVG(Session_Duration_Min),2) AS Avg_Duration
FROM fact_sessions
GROUP BY Browser
ORDER BY Sessions DESC;

------------------------------------------------------------
-- 10. Top Traffic Sources by Revenue
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
-- 11. Revenue by Acquisition Channel
------------------------------------------------------------

SELECT
    u.Acquisition_Channel,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN dim_users u
ON o.User_ID = u.User_ID
GROUP BY u.Acquisition_Channel
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 12. Top Acquisition Channels
------------------------------------------------------------

SELECT
    Acquisition_Channel,
    COUNT(*) AS Customers
FROM dim_users
GROUP BY Acquisition_Channel
ORDER BY Customers DESC;