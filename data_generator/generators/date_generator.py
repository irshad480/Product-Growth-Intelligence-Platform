"""
Date Dimension Generator
Product Growth Intelligence Platform
"""

import pandas as pd

import config


def generate_date_dimension() -> pd.DataFrame:
    """
    Generate a comprehensive Date Dimension table.
    """

    dates = pd.date_range(
        start=config.START_DATE,
        end=config.END_DATE,
        freq="D"
    )

    df = pd.DataFrame({
        "Date": dates
    })

    # ======================================================
    # Date Key
    # ======================================================

    df["Date_Key"] = (
        df["Date"]
        .dt.strftime("%Y%m%d")
        .astype(int)
    )

    # ======================================================
    # Calendar Attributes
    # ======================================================

    df["Year"] = df["Date"].dt.year

    df["Quarter"] = (
        "Q" +
        df["Date"].dt.quarter.astype(str)
    )

    df["Month_Number"] = df["Date"].dt.month

    df["Month_Name"] = df["Date"].dt.month_name()

    df["Day"] = df["Date"].dt.day

    df["Week"] = (
        df["Date"]
        .dt.isocalendar()
        .week
        .astype(int)
    )

    df["Weekday"] = df["Date"].dt.day_name()

    df["Day_of_Week_Number"] = (
        df["Date"].dt.weekday + 1
    )

    # ======================================================
    # Flags
    # ======================================================

    df["Is_Weekend"] = (
        df["Date"].dt.weekday >= 5
    )

    df["Is_Month_Start"] = (
        df["Date"].dt.is_month_start
    )

    df["Is_Month_End"] = (
        df["Date"].dt.is_month_end
    )

    df["Is_Quarter_End"] = (
        df["Date"].dt.is_quarter_end
    )

    return df