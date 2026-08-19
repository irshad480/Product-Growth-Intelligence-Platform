"""
Event Fact Generator
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
# EVENT ID
# ==========================================================

def generate_event_id(number: int) -> str:
    """
    Generate Event ID.
    Example: E00000001
    """
    return f"E{number:08d}"


# ==========================================================
# RANDOM EVENT TIME
# ==========================================================

def random_time() -> str:
    """
    Generate a random time in HH:MM:SS format.
    """
    hour = random.randint(0, 23)
    minute = random.randint(0, 59)
    second = random.randint(0, 59)

    return f"{hour:02d}:{minute:02d}:{second:02d}"


# ==========================================================
# EVENT FACT GENERATOR
# ==========================================================

def generate_event_fact() -> pd.DataFrame:
    """
    Generate Event Fact table.
    """

    sessions_df = load_dataframe("fact_sessions.csv")
    products_df = load_dataframe("dim_products.csv")

    events = []

    for i in range(1, config.EVENTS + 1):

        session = sessions_df.sample(1).iloc[0]
        product = products_df.sample(1).iloc[0]

        events.append({

            "Event_ID": generate_event_id(i),

            "Session_ID": session["Session_ID"],

            "User_ID": session["User_ID"],

            "Product_ID": product["Product_ID"],

            "Date": session["Date"],

            "Event_Type": random.choice(
                constants.EVENT_TYPES
            ),

            "Page": random.choice(
                constants.PAGES
            ),

            "Event_Time": random_time()

        })

    return pd.DataFrame(events)