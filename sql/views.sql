-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- BUSINESS VIEWS
-- ==========================================================

------------------------------------------------------------
-- BUSINESS KPIs
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_business_kpis AS

SELECT

COUNT(*) AS Total_Orders,

COUNT(DISTINCT User_ID) AS Customers,

ROUND(SUM(Revenue),2) AS Revenue,

ROUND(SUM(Profit),2) AS Profit,

ROUND(AVG(Revenue),2) AS Average_Order_Value

FROM fact_orders;

------------------------------------------------------------
-- CUSTOMER ANALYTICS
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_customer_analytics AS

SELECT

u.Customer_Segment,

COUNT(o.Order_ID) Orders,

ROUND(SUM(o.Revenue),2) Revenue,

ROUND(SUM(o.Profit),2) Profit,

ROUND(AVG(u.Lifetime_Value),2) Avg_LTV

FROM dim_users u

LEFT JOIN fact_orders o

ON u.User_ID=o.User_ID

GROUP BY u.Customer_Segment;

------------------------------------------------------------
-- PRODUCT ANALYTICS
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_product_analytics AS

SELECT

p.Category,

p.Brand,

COUNT(o.Order_ID) Orders,

ROUND(SUM(o.Revenue),2) Revenue,

ROUND(SUM(o.Profit),2) Profit,

ROUND(AVG(p.Rating),2) Rating

FROM dim_products p

LEFT JOIN fact_orders o

ON p.Product_ID=o.Product_ID

GROUP BY

p.Category,

p.Brand;

------------------------------------------------------------
-- MARKETING ANALYTICS
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_marketing_analytics AS

SELECT

s.Traffic_Source,

COUNT(*) Sessions,

ROUND(AVG(Session_Duration_Min),2) Avg_Duration,

ROUND(AVG(Page_Views),2) Avg_Page_Views,

ROUND(

100.0*

COUNT(*) FILTER(WHERE Converted)

/COUNT(*),

2

) Conversion_Rate

FROM fact_sessions s

GROUP BY s.Traffic_Source;

------------------------------------------------------------
-- RETENTION ANALYTICS
------------------------------------------------------------

CREATE OR REPLACE VIEW vw_retention_analysis AS

SELECT

u.Loyalty_Level,

COUNT(DISTINCT o.User_ID) Customers,

ROUND(SUM(o.Revenue),2) Revenue,

ROUND(AVG(u.Lifetime_Value),2) Avg_LTV

FROM dim_users u

LEFT JOIN fact_orders o

ON u.User_ID=o.User_ID

GROUP BY u.Loyalty_Level;