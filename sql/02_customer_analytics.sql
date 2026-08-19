-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- CUSTOMER ANALYTICS
-- ==========================================================

------------------------------------------------------------
-- 1. Customers by Segment
------------------------------------------------------------

SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers
FROM dim_users
GROUP BY Customer_Segment
ORDER BY Total_Customers DESC;

------------------------------------------------------------
-- 2. Customers by Country
------------------------------------------------------------

SELECT
    Country,
    COUNT(*) AS Total_Customers
FROM dim_users
GROUP BY Country
ORDER BY Total_Customers DESC;

------------------------------------------------------------
-- 3. Customers by City
------------------------------------------------------------

SELECT
    City,
    COUNT(*) AS Total_Customers
FROM dim_users
GROUP BY City
ORDER BY Total_Customers DESC
LIMIT 10;

------------------------------------------------------------
-- 4. Customers by Subscription Type
------------------------------------------------------------

SELECT
    Subscription_Type,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Subscription_Type;

------------------------------------------------------------
-- 5. Customers by Loyalty Level
------------------------------------------------------------

SELECT
    Loyalty_Level,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Loyalty_Level
ORDER BY Users DESC;

------------------------------------------------------------
-- 6. Average Lifetime Value by Segment
------------------------------------------------------------

SELECT
    Customer_Segment,
    ROUND(AVG(Lifetime_Value),2) AS Avg_Lifetime_Value
FROM dim_users
GROUP BY Customer_Segment
ORDER BY Avg_Lifetime_Value DESC;

------------------------------------------------------------
-- 7. Revenue by Customer Segment
------------------------------------------------------------

SELECT
    u.Customer_Segment,
    COUNT(o.Order_ID) AS Orders,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN dim_users u
ON o.User_ID = u.User_ID
GROUP BY u.Customer_Segment
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 8. Top 10 Customers by Revenue
------------------------------------------------------------

SELECT
    o.User_ID,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit,
    COUNT(*) AS Orders
FROM fact_orders o
GROUP BY o.User_ID
ORDER BY Revenue DESC
LIMIT 10;

------------------------------------------------------------
-- 9. Preferred Product Categories
------------------------------------------------------------

SELECT
    Preferred_Category,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Preferred_Category
ORDER BY Users DESC;

------------------------------------------------------------
-- 10. Device Usage
------------------------------------------------------------

SELECT
    Device,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Device
ORDER BY Users DESC;

------------------------------------------------------------
-- 11. Operating System Usage
------------------------------------------------------------

SELECT
    Operating_System,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Operating_System
ORDER BY Users DESC;

------------------------------------------------------------
-- 12. Browser Usage
------------------------------------------------------------

SELECT
    Browser,
    COUNT(*) AS Users
FROM dim_users
GROUP BY Browser
ORDER BY Users DESC;