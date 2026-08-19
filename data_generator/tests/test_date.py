from data_generator.generators.date_generator import generate_date_dimension

df = generate_date_dimension()

print(df.head())
print(f"\nRows: {len(df)}")