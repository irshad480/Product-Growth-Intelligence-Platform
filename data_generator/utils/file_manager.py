"""
File Manager
Product Growth Intelligence Platform

Handles reading and writing CSV files.
"""

from pathlib import Path

import pandas as pd

import config


# ==========================================================
# OUTPUT DIRECTORY
# ==========================================================

OUTPUT_DIR = config.OUTPUT_DIR


# ==========================================================
# SAVE DATAFRAME
# ==========================================================

def save_dataframe(df: pd.DataFrame, filename: str) -> None:
    """
    Save a DataFrame as a CSV file in the output directory.
    """

    path = OUTPUT_DIR / filename

    df.to_csv(path, index=False)

    print(f"✅ Saved -> {path}")


# ==========================================================
# LOAD DATAFRAME
# ==========================================================

def load_dataframe(filename: str) -> pd.DataFrame:
    """
    Load a CSV file from the output directory.
    """

    path = OUTPUT_DIR / filename

    if not path.exists():
        raise FileNotFoundError(
            f"\nFile not found:\n{path}\n"
            "Generate this dataset before loading it."
        )

    return pd.read_csv(path)


# ==========================================================
# CHECK FILE EXISTS
# ==========================================================

def file_exists(filename: str) -> bool:
    """
    Check whether a CSV file exists.
    """

    return (OUTPUT_DIR / filename).exists()


# ==========================================================
# LIST OUTPUT FILES
# ==========================================================

def list_output_files():
    """
    Return a list of all generated CSV files.
    """

    return sorted(OUTPUT_DIR.glob("*.csv"))