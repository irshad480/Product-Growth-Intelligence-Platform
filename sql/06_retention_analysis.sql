-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- RETENTION ANALYSIS
-- ==========================================================

------------------------------------------------------------
-- 1. Total Customers
------------------------------------------------------------

SELECT
COUNT(*) AS Total_Customers
FROM dim_users;

------------------------------------------------------------
-- 2. Customers Who Placed Orders
------------------------------------------------------------

SELECT
COUNT(DISTINCT User_ID) AS Purchasing_Customers
FROM fact_orders;

------------------------------------------------------------
-- 3. Average Orders Per Customer
------------------------------------------------------------

SELECT

ROUND(
COUNT(*)::NUMERIC /
COUNT(DISTINCT User_ID),
2
) AS Avg_Orders_Per_Customer

FROM fact_orders;

------------------------------------------------------------
-- 4. Repeat Customers
------------------------------------------------------------

SELECT

COUNT(*) AS Repeat_Customers

FROM
(
SELECT
User_ID
FROM fact_orders
GROUP BY User_ID
HAVING COUNT(*) > 1
) t;

------------------------------------------------------------
-- 5. Repeat Purchase Rate
------------------------------------------------------------

WITH customer_orders AS
(
SELECT
User_ID,
COUNT(*) AS Orders
FROM fact_orders
GROUP BY User_ID
)

SELECT

ROUND(

100.0 *

COUNT(*) FILTER (WHERE Orders > 1)

/

COUNT(*),

2

) AS Repeat_Purchase_Rate

FROM customer_orders;

------------------------------------------------------------
-- 6. Average Revenue Per Customer (ARPU)
------------------------------------------------------------

SELECT

ROUND(

SUM(Revenue)
/
COUNT(DISTINCT User_ID),

2

) AS ARPU

FROM fact_orders;

------------------------------------------------------------
-- 7. Top 10 Customers by Revenue
------------------------------------------------------------

SELECT

User_ID,

COUNT(*) AS Orders,

ROUND(SUM(Revenue),2) AS Revenue,

ROUND(SUM(Profit),2) AS Profit

FROM fact_orders

GROUP BY User_ID

ORDER BY Revenue DESC

LIMIT 10;

------------------------------------------------------------
-- 8. Top 10 Customers by Profit
------------------------------------------------------------

SELECT

User_ID,

ROUND(SUM(Profit),2) AS Profit

FROM fact_orders

GROUP BY User_ID

ORDER BY Profit DESC

LIMIT 10;

------------------------------------------------------------
-- 9. Customer Purchase Frequency
------------------------------------------------------------

SELECT

Orders,

COUNT(*) AS Customers

FROM
(
SELECT
User_ID,
COUNT(*) AS Orders
FROM fact_orders
GROUP BY User_ID
) t

GROUP BY Orders

ORDER BY Orders;

------------------------------------------------------------
-- 10. Revenue by Loyalty Level
------------------------------------------------------------

SELECT

u.Loyalty_Level,

ROUND(SUM(o.Revenue),2) AS Revenue,

ROUND(SUM(o.Profit),2) AS Profit

FROM fact_orders o

JOIN dim_users u

ON o.User_ID=u.User_ID

GROUP BY u.Loyalty_Level

ORDER BY Revenue DESC;

------------------------------------------------------------
-- 11. Revenue by Subscription Type
------------------------------------------------------------

SELECT

u.Subscription_Type,

ROUND(SUM(o.Revenue),2) AS Revenue,

ROUND(SUM(o.Profit),2) AS Profit

FROM fact_orders o

JOIN dim_users u

ON o.User_ID=u.User_ID

GROUP BY u.Subscription_Type

ORDER BY Revenue DESC;

------------------------------------------------------------
-- 12. Customer Lifetime Value by Segment
------------------------------------------------------------

SELECT

Customer_Segment,

ROUND(AVG(Lifetime_Value),2) AS Avg_LTV,

ROUND(MAX(Lifetime_Value),2) AS Max_LTV,

ROUND(MIN(Lifetime_Value),2) AS Min_LTV

FROM dim_users

GROUP BY Customer_Segment

ORDER BY Avg_LTV DESC;