"""
Common helper functions
"""

import random


def random_choice(values):
    return random.choice(values)


def random_boolean(probability):
    """
    Example:

    probability = 0.25

    returns True roughly 25% of time
    """

    return random.random() < probability