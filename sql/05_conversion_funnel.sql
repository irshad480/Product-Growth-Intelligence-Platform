-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- CONVERSION FUNNEL ANALYTICS
-- ==========================================================

------------------------------------------------------------
-- 1. Total Sessions
------------------------------------------------------------

SELECT
COUNT(*) AS Total_Sessions
FROM fact_sessions;

------------------------------------------------------------
-- 2. Converted Sessions
------------------------------------------------------------

SELECT
COUNT(*) AS Converted_Sessions
FROM fact_sessions
WHERE Converted = TRUE;

------------------------------------------------------------
-- 3. Overall Conversion Rate
------------------------------------------------------------

SELECT

ROUND(
100.0 *
COUNT(*) FILTER (WHERE Converted = TRUE)
/ COUNT(*),
2
) AS Conversion_Rate

FROM fact_sessions;

------------------------------------------------------------
-- 4. Bounce Rate
------------------------------------------------------------

SELECT

ROUND(
100.0 *
COUNT(*) FILTER (WHERE Bounce = TRUE)
/ COUNT(*),
2
) AS Bounce_Rate

FROM fact_sessions;

------------------------------------------------------------
-- 5. Event Distribution
------------------------------------------------------------

SELECT

Event_Type,

COUNT(*) AS Events

FROM fact_events

GROUP BY Event_Type

ORDER BY Events DESC;

------------------------------------------------------------
-- 6. Funnel Steps
------------------------------------------------------------

SELECT

Event_Type,

COUNT(DISTINCT Session_ID) AS Sessions

FROM fact_events

WHERE Event_Type IN
(
'Landing',
'Page View',
'Product View',
'Add To Cart',
'Begin Checkout',
'Purchase'
)

GROUP BY Event_Type

ORDER BY Sessions DESC;

------------------------------------------------------------
-- 7. Purchase Sessions
------------------------------------------------------------

SELECT

COUNT(DISTINCT Session_ID) AS Purchase_Sessions

FROM fact_events

WHERE Event_Type='Purchase';

------------------------------------------------------------
-- 8. Add To Cart Sessions
------------------------------------------------------------

SELECT

COUNT(DISTINCT Session_ID) AS Cart_Sessions

FROM fact_events

WHERE Event_Type='Add To Cart';

------------------------------------------------------------
-- 9. Checkout Sessions
------------------------------------------------------------

SELECT

COUNT(DISTINCT Session_ID) AS Checkout_Sessions

FROM fact_events

WHERE Event_Type='Begin Checkout';

------------------------------------------------------------
-- 10. Purchase Rate
------------------------------------------------------------

SELECT

ROUND(

100.0 *

COUNT(DISTINCT CASE
WHEN Event_Type='Purchase'
THEN Session_ID
END)

/

COUNT(DISTINCT Session_ID),

2

) AS Purchase_Rate

FROM fact_events;

------------------------------------------------------------
-- 11. Cart Abandonment Rate
------------------------------------------------------------

WITH cart AS
(
SELECT COUNT(DISTINCT Session_ID) cnt
FROM fact_events
WHERE Event_Type='Add To Cart'
),

purchase AS
(
SELECT COUNT(DISTINCT Session_ID) cnt
FROM fact_events
WHERE Event_Type='Purchase'
)

SELECT

ROUND(

100.0 *

(cart.cnt-purchase.cnt)

/

cart.cnt,

2

)

AS Cart_Abandonment_Rate

FROM cart,purchase;

------------------------------------------------------------
-- 12. Checkout Success Rate
------------------------------------------------------------

WITH checkout AS
(
SELECT COUNT(DISTINCT Session_ID) cnt
FROM fact_events
WHERE Event_Type='Begin Checkout'
),

purchase AS
(
SELECT COUNT(DISTINCT Session_ID) cnt
FROM fact_events
WHERE Event_Type='Purchase'
)

SELECT

ROUND(

100.0 *

purchase.cnt

/

checkout.cnt,

2

)

AS Checkout_Success_Rate

FROM checkout,purchase;