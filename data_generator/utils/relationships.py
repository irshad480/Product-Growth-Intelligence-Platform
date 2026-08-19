"""
Relationship Utilities
"""

import random


def random_user(users_df):
    return users_df.sample(1).iloc[0]


def random_product(products_df):
    return products_df.sample(1).iloc[0]


def random_session(session_df):
    return session_df.sample(1).iloc[0]