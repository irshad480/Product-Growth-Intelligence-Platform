"""
Test Session Generator
Product Growth Intelligence Platform
"""

from generators.session_generator import generate_session_fact


def main():

    # Generate Session Fact Table
    df = generate_session_fact()

    print("=" * 70)
    print("SESSION FACT TEST")
    print("=" * 70)

    print("\nFirst 10 Rows:\n")
    print(df.head(10))

    print("\n" + "=" * 70)

    print(f"Total Rows    : {len(df)}")
    print(f"Total Columns : {len(df.columns)}")

    print("\nColumns:")

    for col in df.columns:
        print(f"- {col}")

    print("\nData Types:\n")
    print(df.dtypes)

    print("\nMissing Values:\n")
    print(df.isnull().sum())

    print("\nSession Summary:\n")
    print(df.describe(include="all"))


if __name__ == "__main__":
    main()