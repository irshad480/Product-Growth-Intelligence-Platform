"""
Test Order Generator
Product Growth Intelligence Platform
"""

from generators.order_generator import generate_order_fact


def main():

    df = generate_order_fact()

    print("=" * 70)
    print("ORDER FACT TEST")
    print("=" * 70)

    print("\nFirst 10 Rows:\n")
    print(df.head(10))

    print("\n" + "=" * 70)

    print(f"Total Rows    : {len(df)}")
    print(f"Total Columns : {len(df.columns)}")

    print("\nColumns:")

    for col in df.columns:
        print("-", col)

    print("\nData Types:\n")
    print(df.dtypes)

    print("\nMissing Values:\n")
    print(df.isnull().sum())

    print("\nSummary:\n")
    print(df.describe(include="all"))


if __name__ == "__main__":
    main()