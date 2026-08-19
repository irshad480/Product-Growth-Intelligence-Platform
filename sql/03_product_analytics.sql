-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- PRODUCT ANALYTICS
-- ==========================================================

------------------------------------------------------------
-- 1. Revenue by Category
------------------------------------------------------------

SELECT
    p.Category,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit,
    COUNT(o.Order_ID) AS Orders
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 2. Revenue by Brand
------------------------------------------------------------

SELECT
    p.Brand,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Brand
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 3. Top 10 Products by Revenue
------------------------------------------------------------

SELECT
    p.Product_Name,
    p.Brand,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_Name,
    p.Brand
ORDER BY Revenue DESC
LIMIT 10;

------------------------------------------------------------
-- 4. Top 10 Products by Profit
------------------------------------------------------------

SELECT
    p.Product_Name,
    ROUND(SUM(o.Profit),2) AS Profit
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Profit DESC
LIMIT 10;

------------------------------------------------------------
-- 5. Bottom 10 Products by Revenue
------------------------------------------------------------

SELECT
    p.Product_Name,
    ROUND(SUM(o.Revenue),2) AS Revenue
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Revenue ASC
LIMIT 10;

------------------------------------------------------------
-- 6. Average Selling Price by Category
------------------------------------------------------------

SELECT
    p.Category,
    ROUND(AVG(o.Unit_Price),2) AS Avg_Selling_Price
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Avg_Selling_Price DESC;

------------------------------------------------------------
-- 7. Inventory by Category
------------------------------------------------------------

SELECT
    Category,
    SUM(Inventory) AS Total_Inventory
FROM dim_products
GROUP BY Category
ORDER BY Total_Inventory DESC;

------------------------------------------------------------
-- 8. Average Product Rating
------------------------------------------------------------

SELECT
    Category,
    ROUND(AVG(Rating),2) AS Avg_Rating
FROM dim_products
GROUP BY Category
ORDER BY Avg_Rating DESC;

------------------------------------------------------------
-- 9. Active vs Discontinued Products
------------------------------------------------------------

SELECT
    Status,
    COUNT(*) AS Products
FROM dim_products
GROUP BY Status;

------------------------------------------------------------
-- 10. Profit Margin by Category
------------------------------------------------------------

SELECT
    Category,
    ROUND(AVG(Profit_Margin),2) AS Avg_Profit_Margin
FROM dim_products
GROUP BY Category
ORDER BY Avg_Profit_Margin DESC;

------------------------------------------------------------
-- 11. Category Contribution to Revenue (%)
------------------------------------------------------------

SELECT
    p.Category,
    ROUND(SUM(o.Revenue),2) AS Revenue,
    ROUND(
        100.0 * SUM(o.Revenue)
        / SUM(SUM(o.Revenue)) OVER (),
        2
    ) AS Revenue_Percentage
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 12. Most Ordered Products
------------------------------------------------------------

SELECT
    p.Product_Name,
    SUM(o.Quantity) AS Units_Sold
FROM fact_orders o
JOIN dim_products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Units_Sold DESC
LIMIT 10;