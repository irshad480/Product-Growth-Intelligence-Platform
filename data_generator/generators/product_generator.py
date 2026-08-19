"""
Product Dimension Generator
Product Growth Intelligence Platform
"""

import random

import pandas as pd

import config
import constants


# ==========================================================
# RANDOM SEED
# ==========================================================

random.seed(config.RANDOM_SEED)


# ==========================================================
# PRICE RANGES
# ==========================================================

PRICE_RANGES = {
    "Electronics": (150, 2500),
    "Fashion": (20, 300),
    "Beauty": (5, 80),
    "Sports": (30, 500),
    "Books": (8, 60),
    "Home": (15, 800),
    "Toys": (10, 150),
    "Accessories": (10, 250),
}


# ==========================================================
# HELPER FUNCTIONS
# ==========================================================

def generate_product_id(number: int) -> str:
    """Generate Product ID."""
    return f"P{number:06d}"


def generate_price(category: str) -> float:
    """Generate selling price."""

    min_price, max_price = PRICE_RANGES[category]

    return round(
        random.uniform(min_price, max_price),
        2
    )


def generate_cost(price: float) -> float:
    """Generate product cost."""

    return round(
        price * random.uniform(0.45, 0.75),
        2
    )


def generate_margin(price: float, cost: float) -> float:
    """Calculate profit margin."""

    return round(
        ((price - cost) / price) * 100,
        2
    )


# ==========================================================
# PRODUCT DIMENSION
# ==========================================================

def generate_product_dimension() -> pd.DataFrame:
    """
    Generate Product Dimension table.
    """

    products = []

    for i in range(1, config.PRODUCTS + 1):

        category = random.choice(
            constants.PRODUCT_CATEGORIES
        )

        brand = random.choice(
            constants.CATEGORY_BRANDS[category]
        )

        if (
            category in constants.PRODUCT_CATALOG
            and brand in constants.PRODUCT_CATALOG[category]
        ):

            product_name = random.choice(
                constants.PRODUCT_CATALOG[category][brand]
            )

        else:

            product_name = (
                f"{brand} {category} Product"
            )

        subcategory = random.choice(
            constants.SUBCATEGORIES[category]
        )

        supplier = random.choice(
            constants.SUPPLIERS
        )

        country = random.choice(
            constants.COUNTRY_OF_ORIGIN
        )

        price = generate_price(category)

        cost = generate_cost(price)

        margin = generate_margin(
            price,
            cost
        )

        rating = round(
            random.uniform(3.5, 5.0),
            1
        )

        inventory = random.randint(
            20,
            500
        )

        status = random.choice([
            "Active",
            "Active",
            "Active",
            "Discontinued"
        ])

        products.append({

            "Product_ID": generate_product_id(i),

            "Category": category,

            "Subcategory": subcategory,

            "Brand": brand,

            "Product_Name": product_name,

            "Supplier": supplier,

            "Country_of_Origin": country,

            "Price": price,

            "Cost": cost,

            "Profit_Margin": margin,

            "Rating": rating,

            "Inventory": inventory,

            "Status": status

        })

    return pd.DataFrame(products)