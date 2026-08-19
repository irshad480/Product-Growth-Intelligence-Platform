"""
Test Product Generator
"""

from data_generator.generators.product_generator import generate_product_dimension


def main():

    print("=" * 60)
    print("PRODUCT DIMENSION TEST")
    print("=" * 60)

    df = generate_product_dimension()

    print("\nFirst 10 Rows:\n")
    print(df.head(10))

    print("\n" + "=" * 60)
    print(f"Total Rows    : {len(df)}")
    print(f"Total Columns : {len(df.columns)}")

    print("\nColumns:")
    for col in df.columns:
        print(f" - {col}")

    print("\nSample Products:")
    print(
        df[
            [
                "Product_ID",
                "Category",
                "Brand",
                "Product_Name",
                "Price",
            ]
        ].head(15)
    )

    print("\nProduct Generator Working Successfully ✔")


if __name__ == "__main__":
    main()