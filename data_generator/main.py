from generators.date_generator import generate_date_dimension
from generators.product_generator import generate_product_dimension
from generators.user_generator import generate_user_dimension
from generators.session_generator import generate_session_fact
from generators.event_generator import generate_event_fact
from generators.order_generator import generate_order_fact

from utils.file_manager import save_dataframe


def main():

    print("=" * 60)
    print("PRODUCT GROWTH INTELLIGENCE PLATFORM")
    print("=" * 60)

    # ======================================================
    # Date Dimension
    # ======================================================

    print("\nGenerating Date Dimension...")

    date_df = generate_date_dimension()
    save_dataframe(date_df, "dim_date.csv")

    # ======================================================
    # Product Dimension
    # ======================================================

    print("\nGenerating Product Dimension...")

    product_df = generate_product_dimension()
    save_dataframe(product_df, "dim_products.csv")

    # ======================================================
    # User Dimension
    # ======================================================

    print("\nGenerating User Dimension...")

    user_df = generate_user_dimension()
    save_dataframe(user_df, "dim_users.csv")

    # ======================================================
    # Session Fact
    # ======================================================

    print("\nGenerating Session Fact...")

    session_df = generate_session_fact()
    save_dataframe(session_df, "fact_sessions.csv")

    # ======================================================
    # Event Fact
    # ======================================================

    print("\nGenerating Event Fact...")

    event_df = generate_event_fact()
    save_dataframe(event_df, "fact_events.csv")

    # ======================================================
    # Order Fact
    # ======================================================

    print("\nGenerating Order Fact...")

    order_df = generate_order_fact()
    save_dataframe(order_df, "fact_orders.csv")

    # ======================================================
    # Finished
    # ======================================================

    print("\n" + "=" * 60)
    print("DATA GENERATION COMPLETED SUCCESSFULLY")
    print("=" * 60)


if __name__ == "__main__":
    main()