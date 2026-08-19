-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- BUSINESS KPIs
-- ==========================================================

------------------------------------------------------------
-- Total Revenue
------------------------------------------------------------

SELECT
ROUND(SUM(Revenue),2) AS Total_Revenue
FROM fact_orders;

------------------------------------------------------------
-- Total Profit
------------------------------------------------------------

SELECT
ROUND(SUM(Profit),2) AS Total_Profit
FROM fact_orders;

------------------------------------------------------------
-- Total Orders
------------------------------------------------------------

SELECT
COUNT(*) AS Total_Orders
FROM fact_orders;

------------------------------------------------------------
-- Average Order Value
------------------------------------------------------------

SELECT
ROUND(AVG(Revenue),2) AS Average_Order_Value
FROM fact_orders;

------------------------------------------------------------
-- Total Customers
------------------------------------------------------------

SELECT
COUNT(DISTINCT User_ID) AS Total_Customers
FROM dim_users;

------------------------------------------------------------
-- Total Sessions
------------------------------------------------------------

SELECT
COUNT(*) AS Total_Sessions
FROM fact_sessions;

------------------------------------------------------------
-- Conversion Rate
------------------------------------------------------------

SELECT

ROUND(

100.0 *

COUNT(*) FILTER (WHERE Converted = TRUE)

/

COUNT(*)

,2)

AS Conversion_Rate

FROM fact_sessions;

------------------------------------------------------------
-- Bounce Rate
------------------------------------------------------------

SELECT

ROUND(

100.0 *

COUNT(*) FILTER (WHERE Bounce = TRUE)

/

COUNT(*)

,2)

AS Bounce_Rate

FROM fact_sessions;