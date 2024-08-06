# I love chocolate and only want delicious baked goods that have chocolate in them!
# Write a Query to return bakery items that contain the word "Chocolate".

# access datasets as pandas dataframes
import pandas as pd;

# bakery_items.head()

df = pd.DataFrame(bakery_items)
df[df['product_name'].str.contains('Chocolate')]
