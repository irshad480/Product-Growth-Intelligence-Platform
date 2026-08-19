-- ==========================================================
-- STORED PROCEDURES
-- ==========================================================

------------------------------------------------------------
-- Refresh Statistics
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_refresh_statistics()

LANGUAGE SQL

AS
$$

ANALYZE dim_users;

ANALYZE dim_products;

ANALYZE fact_sessions;

ANALYZE fact_events;

ANALYZE fact_orders;

$$;

------------------------------------------------------------
-- Vacuum Database
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_optimize_database()

LANGUAGE SQL

AS
$$

VACUUM ANALYZE;

$$;