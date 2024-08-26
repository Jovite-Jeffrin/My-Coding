# In the United States, fast food is the cornerstone of it's very society. Without it, it would cease to exist.
# But which region spends the most money on fast food?
# Write a query to determine which region spends the most amount of money on fast food.

# access datasets as pandas dataframes
import pandas as pd;

df = food_regions.groupby('region')['fast_food_millions'].sum().reset_index()
df[df['fast_food_millions'] == df['fast_food_millions'].max()][['region']]
