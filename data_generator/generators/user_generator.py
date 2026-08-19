"""
User Dimension Generator
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
# USER ID
# ==========================================================

def generate_user_id(number: int) -> str:
    """
    Generate User ID.

    Example:
    U000001
    """
    return f"U{number:06d}"


# ==========================================================
# AGE
# ==========================================================

def generate_age() -> int:
    """Generate random user age."""
    return random.randint(18, 65)


def get_age_group(age: int) -> str:
    """Return age group."""

    if age <= 24:
        return "18-24"
    elif age <= 34:
        return "25-34"
    elif age <= 44:
        return "35-44"
    elif age <= 54:
        return "45-54"
    else:
        return "55+"


# ==========================================================
# LOCATION
# ==========================================================

def generate_country_city():
    """Generate country and city."""

    country = random.choice(constants.COUNTRIES)

    city = random.choice(
        constants.COUNTRY_CITIES[country]
    )

    return country, city


# ==========================================================
# USER DIMENSION
# ==========================================================

def generate_user_dimension() -> pd.DataFrame:
    """
    Generate User Dimension table.
    """

    users = []

    for i in range(1, config.USERS + 1):

        age = generate_age()

        country, city = generate_country_city()

        loyalty_score = random.randint(1, 100)

        # Lifetime Value loosely correlated with loyalty
        lifetime_value = round(
            loyalty_score * random.uniform(25, 80),
            2
        )

        users.append({

            "User_ID": generate_user_id(i),

            "Gender": random.choice(
                constants.GENDERS
            ),

            "Age": age,

            "Age_Group": get_age_group(age),

            "Country": country,

            "City": city,

            "Device": random.choice(
                constants.DEVICES
            ),

            "Operating_System": random.choice(
                constants.OPERATING_SYSTEMS
            ),

            "Browser": random.choice(
                constants.BROWSERS
            ),

            "Customer_Segment": random.choice(
                constants.CUSTOMER_SEGMENTS
            ),

            "Acquisition_Channel": random.choice(
                constants.MARKETING_CHANNELS
            ),

            "Preferred_Category": random.choice(
                constants.PRODUCT_CATEGORIES
            ),

            "Subscription_Type": random.choice(
                constants.SUBSCRIPTION_TYPES
            ),

            "Loyalty_Level": random.choice(
                constants.LOYALTY_LEVELS
            ),

            "Loyalty_Score": loyalty_score,

            "Lifetime_Value": lifetime_value

        })

    return pd.DataFrame(users)