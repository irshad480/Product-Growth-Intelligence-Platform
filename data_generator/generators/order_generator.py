"""
Order Fact Generator
Product Growth Intelligence Platform
"""

import random

import pandas as pd

import config
import constants

from utils.file_manager import load_dataframe


# ==========================================================
# RANDOM SEED
# ==========================================================

random.seed(config.RANDOM_SEED)


# ==========================================================
# ORDER ID
# ==========================================================

def generate_order_id(number: int) -> str:
    """
    Generate Order ID.

    Example:
    O0000001
    """
    return f"O{number:07d}"


# ==========================================================
# BUSINESS CALCULATIONS
# ==========================================================

def generate_quantity() -> int:
    """Generate purchase quantity."""
    return random.randint(1, 5)


def generate_discount() -> int:
    """Generate discount percentage."""
    return random.choice(constants.DISCOUNT_LEVELS)


def calculate_revenue(price: float,
                      quantity: int,
                      discount: int) -> float:
    """
    Calculate order revenue after discount.
    """

    gross = price * quantity

    revenue = gross * (1 - discount / 100)

    return round(revenue, 2)


def calculate_cost(cost_per_unit: float,
                   quantity: int) -> float:
    """
    Calculate total product cost.
    """

    return round(
        cost_per_unit * quantity,
        2
    )


def calculate_profit(revenue: float,
                     cost: float) -> float:
    """
    Calculate order profit.
    """

    return round(
        revenue - cost,
        2
    )


# ==========================================================
# ORDER FACT GENERATOR
# ==========================================================

def generate_order_fact() -> pd.DataFrame:
    """
    Generate Order Fact table.
    """

    sessions_df = load_dataframe("fact_sessions.csv")
    products_df = load_dataframe("dim_products.csv")

    orders = []

    for i in range(1, config.ORDERS + 1):

        session = sessions_df.sample(1).iloc[0]

        product = products_df.sample(1).iloc[0]

        quantity = generate_quantity()

        unit_price = float(product["Price"])

        unit_cost = float(product["Cost"])

        discount = generate_discount()

        revenue = calculate_revenue(
            unit_price,
            quantity,
            discount
        )

        cost = calculate_cost(
            unit_cost,
            quantity
        )

        profit = calculate_profit(
            revenue,
            cost
        )

        orders.append({

            "Order_ID": generate_order_id(i),

            "User_ID": session["User_ID"],

            "Session_ID": session["Session_ID"],

            "Product_ID": product["Product_ID"],

            "Order_Date": session["Date"],

            "Quantity": quantity,

            "Unit_Price": unit_price,

            "Discount": discount,

            "Revenue": revenue,

            "Cost": cost,

            "Profit": profit,

            "Payment_Method": random.choice(
                constants.PAYMENT_METHODS
            ),

            "Shipping_Method": random.choice(
                constants.SHIPPING_METHODS
            ),

            "Order_Status": random.choice(
                constants.ORDER_STATUS
            )

        })

    return pd.DataFrame(orders)