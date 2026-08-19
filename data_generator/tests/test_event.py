"""
Test Event Generator
"""

from generators.event_generator import generate_event_fact


def main():

    df = generate_event_fact()

    print("=" * 70)
    print("EVENT FACT TEST")
    print("=" * 70)

    print("\nFirst 10 Rows:\n")
    print(df.head(10))

    print("\n" + "=" * 70)

    print(f"Rows    : {len(df)}")
    print(f"Columns : {len(df.columns)}")

    print("\nColumns:")

    for col in df.columns:
        print("-", col)


if __name__ == "__main__":
    main()