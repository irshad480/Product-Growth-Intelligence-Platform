CREATE TABLE dim_date (

    Date DATE,

    Date_Key INTEGER PRIMARY KEY,

    Year INTEGER,

    Quarter VARCHAR(5),

    Month_Number INTEGER,

    Month_Name VARCHAR(20),

    Day INTEGER,

    Week INTEGER,

    Weekday VARCHAR(20),

    Day_of_Week_Number INTEGER,

    Is_Weekend BOOLEAN,

    Is_Month_Start BOOLEAN,

    Is_Month_End BOOLEAN,

    Is_Quarter_End BOOLEAN

);

DROP TABLE IF EXISTS dim_users CASCADE;

CREATE TABLE dim_users (

    User_ID VARCHAR(10) PRIMARY KEY,

    Gender VARCHAR(20),

    Age INTEGER,

    Age_Group VARCHAR(20),

    Country VARCHAR(50),

    City VARCHAR(50),

    Device VARCHAR(20),

    Operating_System VARCHAR(20),

    Browser VARCHAR(20),

    Customer_Segment VARCHAR(30),

    Acquisition_Channel VARCHAR(50),

    Preferred_Category VARCHAR(50),

    Subscription_Type VARCHAR(20),

    Loyalty_Level VARCHAR(20),

    Loyalty_Score INTEGER,

    Lifetime_Value NUMERIC(12,2)

);


CREATE TABLE dim_products (

    Product_ID VARCHAR(10) PRIMARY KEY,

    Category VARCHAR(50),

    Subcategory VARCHAR(50),

    Brand VARCHAR(50),

    Product_Name VARCHAR(150),

    Supplier VARCHAR(100),

    Country_of_Origin VARCHAR(50),

    Price NUMERIC(12,2),

    Cost NUMERIC(12,2),

    Profit_Margin NUMERIC(8,2),

    Rating NUMERIC(3,1),

    Inventory INTEGER,

    Status VARCHAR(30)

);

DROP TABLE IF EXISTS fact_sessions CASCADE;

CREATE TABLE fact_sessions (

    Session_ID VARCHAR(10) PRIMARY KEY,

    User_ID VARCHAR(10),

    Date DATE,

    Device VARCHAR(20),

    Operating_System VARCHAR(20),

    Browser VARCHAR(20),

    Traffic_Source VARCHAR(50),

    Session_Duration_Min INTEGER,

    Page_Views INTEGER,

    Bounce BOOLEAN,

    Converted BOOLEAN

);


CREATE TABLE fact_events (

    Event_ID VARCHAR(12) PRIMARY KEY,

    Session_ID VARCHAR(10),

    User_ID VARCHAR(10),

    Product_ID VARCHAR(10),

    Date DATE,

    Event_Type VARCHAR(50),

    Page VARCHAR(30),

    Event_Time TIME

);

DROP TABLE IF EXISTS fact_orders CASCADE;

CREATE TABLE fact_orders (

    Order_ID VARCHAR(10) PRIMARY KEY,

    User_ID VARCHAR(10),

    Session_ID VARCHAR(10),

    Product_ID VARCHAR(10),

    Order_Date DATE,

    Quantity INTEGER,

    Unit_Price NUMERIC(12,2),

    Discount NUMERIC(5,2),

    Revenue NUMERIC(12,2),

    Cost NUMERIC(12,2),

    Profit NUMERIC(12,2),

    Payment_Method VARCHAR(30),

    Shipping_Method VARCHAR(30),

    Order_Status VARCHAR(30)

);