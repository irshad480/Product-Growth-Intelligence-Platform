import pandas as pd
from database import engine


def load_view(view_name):
    query = f"SELECT * FROM {view_name}"
    return pd.read_sql(query, engine)