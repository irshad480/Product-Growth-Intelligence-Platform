-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- SQL FUNCTIONS
-- ==========================================================

------------------------------------------------------------
-- Revenue
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_total_revenue()
RETURNS NUMERIC AS
$$
SELECT COALESCE(SUM(Revenue),0)
FROM fact_orders;
$$
LANGUAGE SQL;

------------------------------------------------------------
-- Profit
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_total_profit()
RETURNS NUMERIC AS
$$
SELECT COALESCE(SUM(Profit),0)
FROM fact_orders;
$$
LANGUAGE SQL;

------------------------------------------------------------
-- Total Customers
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_total_customers()
RETURNS INTEGER AS
$$
SELECT COUNT(DISTINCT User_ID)
FROM fact_orders;
$$
LANGUAGE SQL;

------------------------------------------------------------
-- Average Order Value
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_average_order_value()
RETURNS NUMERIC AS
$$
SELECT ROUND(AVG(Revenue),2)
FROM fact_orders;
$$
LANGUAGE SQL;

------------------------------------------------------------
-- Profit Margin %
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_profit_margin()
RETURNS NUMERIC AS
$$
SELECT ROUND(
SUM(Profit)
/ NULLIF(SUM(Revenue),0)
*100,
2)
FROM fact_orders;
$$
LANGUAGE SQL;

------------------------------------------------------------
-- Revenue by Category
------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_revenue_by_category(category_name TEXT)
RETURNS NUMERIC AS
$$

SELECT COALESCE(SUM(o.Revenue),0)

FROM fact_orders o

JOIN dim_products p

ON o.Product_ID=p.Product_ID

WHERE p.Category=category_name;

$$
LANGUAGE SQL;