from data_generator.generators.user_generator import generate_user_dimension


def main():

    df = generate_user_dimension()

    print("=" * 70)
    print("USER DIMENSION TEST")
    print("=" * 70)

    print("\nFirst 10 Rows:\n")
    print(df.head(10))

    print("\n" + "=" * 70)

    print(f"Total Rows    : {len(df)}")
    print(f"Total Columns : {len(df.columns)}")

    print("\nColumns:")

    for col in df.columns:
        print("-", col)


if __name__ == "__main__":
    main()