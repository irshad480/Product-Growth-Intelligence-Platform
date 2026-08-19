"""
AI Insight Generator
Product Growth Intelligence Platform
"""

import pandas as pd


def generate_executive_insights(
    monthly_df,
    category_df,
    traffic_df,
    product_df,
    executive_df
):

    insights = []

    # ======================================================
    # Executive KPIs
    # ======================================================

    summary = executive_df.iloc[0]

    insights.append(
        f"Total Revenue: ${summary['revenue']:,.2f}"
    )

    insights.append(
        f"Total Profit: ${summary['profit']:,.2f}"
    )

    insights.append(
        f"Profit Margin: {summary['profit_margin']:.2f}%"
    )

    # ======================================================
    # Top Category
    # ======================================================

    top_category = category_df.sort_values(
        "revenue",
        ascending=False
    ).iloc[0]

    insights.append(

        f"Top Category: {top_category['category']} "
        f"generated ${top_category['revenue']:,.2f}"

    )

    # ======================================================
    # Top Product
    # ======================================================

    top_product = product_df.iloc[0]

    insights.append(

        f"Best Selling Product: "
        f"{top_product['product_name']} "

        f"(${top_product['revenue']:,.2f})"

    )

    # ======================================================
    # Traffic Source
    # ======================================================

    top_channel = traffic_df.sort_values(
        "conversion_rate",
        ascending=False
    ).iloc[0]

    insights.append(

        f"Highest Conversion Channel: "
        f"{top_channel['traffic_source']} "

        f"({top_channel['conversion_rate']:.2f}%)"

    )

    # ======================================================
    # Monthly Trend
    # ======================================================

    if len(monthly_df) >= 2:

        last_month = monthly_df.iloc[-1]

        previous = monthly_df.iloc[-2]

        growth = (

            (
                last_month["revenue"]
                - previous["revenue"]
            )

            / previous["revenue"]

        ) * 100

        if growth > 0:

            insights.append(

                f"Revenue increased "

                f"{growth:.2f}% "

                f"compared to last month."

            )

        else:

            insights.append(

                f"Revenue decreased "

                f"{abs(growth):.2f}% "

                f"compared to last month."

            )

    return insights