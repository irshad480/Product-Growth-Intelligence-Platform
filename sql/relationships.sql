-- ==========================================================
-- PRODUCT GROWTH INTELLIGENCE PLATFORM
-- FOREIGN KEY RELATIONSHIPS
-- ==========================================================

-- Session → User

ALTER TABLE fact_sessions
ADD CONSTRAINT fk_sessions_users
FOREIGN KEY (User_ID)
REFERENCES dim_users(User_ID);

------------------------------------------------------------

-- Event → Session

ALTER TABLE fact_events
ADD CONSTRAINT fk_events_sessions
FOREIGN KEY (Session_ID)
REFERENCES fact_sessions(Session_ID);

------------------------------------------------------------

-- Event → User

ALTER TABLE fact_events
ADD CONSTRAINT fk_events_users
FOREIGN KEY (User_ID)
REFERENCES dim_users(User_ID);

------------------------------------------------------------

-- Event → Product

ALTER TABLE fact_events
ADD CONSTRAINT fk_events_products
FOREIGN KEY (Product_ID)
REFERENCES dim_products(Product_ID);

------------------------------------------------------------

-- Order → User

ALTER TABLE fact_orders
ADD CONSTRAINT fk_orders_users
FOREIGN KEY (User_ID)
REFERENCES dim_users(User_ID);

------------------------------------------------------------

-- Order → Session

ALTER TABLE fact_orders
ADD CONSTRAINT fk_orders_sessions
FOREIGN KEY (Session_ID)
REFERENCES fact_sessions(Session_ID);

------------------------------------------------------------

-- Order → Product

ALTER TABLE fact_orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (Product_ID)
REFERENCES dim_products(Product_ID);