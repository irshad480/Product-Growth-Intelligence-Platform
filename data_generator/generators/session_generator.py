"""
Session Fact Generator
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
# SESSION ID
# ==========================================================

def generate_session_id(number: int) -> str:
    """
    Generate Session ID.

    Example:
    S0000001
    """
    return f"S{number:07d}"


# ==========================================================
# HELPER FUNCTIONS
# ==========================================================

def generate_session_duration() -> int:
    """
    Generate session duration in minutes.
    """
    return random.randint(1, 60)


def generate_page_views() -> int:
    """
    Generate number of page views.
    """
    return random.randint(1, 12)


# ==========================================================
# SESSION FACT GENERATOR
# ==========================================================

def generate_session_fact() -> pd.DataFrame:
    """
    Generate Session Fact table.
    """

    users_df = load_dataframe("dim_users.csv")
    dates_df = load_dataframe("dim_date.csv")

    sessions = []

    for i in range(1, config.SESSIONS + 1):

        user = users_df.sample(1).iloc[0]
        date = dates_df.sample(1).iloc[0]

        duration = generate_session_duration()

        page_views = generate_page_views()

        bounce = page_views == 1

        converted = random.random() < 0.10

        sessions.append({

            "Session_ID": generate_session_id(i),

            "User_ID": user["User_ID"],

            "Date": date["Date"],

            "Device": random.choice(
                constants.DEVICES
            ),

            "Operating_System": random.choice(
                constants.OPERATING_SYSTEMS
            ),

            "Browser": random.choice(
                constants.BROWSERS
            ),

            "Traffic_Source": random.choice(
                constants.TRAFFIC_SOURCES
            ),

            "Session_Duration_Min": duration,

            "Page_Views": page_views,

            "Bounce": bounce,

            "Converted": converted

        })

    return pd.DataFrame(sessions)