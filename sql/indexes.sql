-- ==========================================================
-- INDEXES
-- ==========================================================

CREATE INDEX idx_sessions_user
ON fact_sessions(User_ID);

CREATE INDEX idx_sessions_date
ON fact_sessions(Date);

CREATE INDEX idx_events_session
ON fact_events(Session_ID);

CREATE INDEX idx_events_user
ON fact_events(User_ID);

CREATE INDEX idx_events_product
ON fact_events(Product_ID);

CREATE INDEX idx_events_date
ON fact_events(Date);

CREATE INDEX idx_orders_user
ON fact_orders(User_ID);

CREATE INDEX idx_orders_product
ON fact_orders(Product_ID);

CREATE INDEX idx_orders_session
ON fact_orders(Session_ID);

CREATE INDEX idx_orders_date
ON fact_orders(Order_Date);



