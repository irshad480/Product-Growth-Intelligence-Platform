"""
Project Configuration
Product Growth Intelligence Platform
"""

from pathlib import Path

# ==========================================================
# PROJECT PATHS
# ==========================================================

BASE_DIR = Path(__file__).resolve().parent

OUTPUT_DIR = BASE_DIR / "output"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# ==========================================================
# DATASET MODE
# ==========================================================

# Available Modes:
# "development" -> Small dataset for testing
# "production"  -> Large dataset for portfolio/demo

MODE = "development"
# MODE = "production"

# ==========================================================
# RANDOM SEED
# ==========================================================

RANDOM_SEED = 42

# ==========================================================
# DATE RANGE
# ==========================================================

START_DATE = "2024-01-01"
END_DATE = "2025-12-31"

# ==========================================================
# DATASET SIZE
# ==========================================================

if MODE == "development":

    USERS = 2_000
    PRODUCTS = 1_000
    CAMPAIGNS = 60
    EXPERIMENTS = 15

    SESSIONS = 10_000
    EVENTS = 40_000
    ORDERS = 1_800

else:

    USERS = 50_000
    PRODUCTS = 1_000
    CAMPAIGNS = 60
    EXPERIMENTS = 15

    SESSIONS = 250_000
    EVENTS = 1_000_000
    ORDERS = 40_000