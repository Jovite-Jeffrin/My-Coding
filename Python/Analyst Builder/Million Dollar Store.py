# Write a query that returns all of the stores whose average yearly revenue is greater than one million dollars.
# Output the store ID and average revenue. Round the average to 2 decimal places.
# Order by store ID.

# access datasets as pandas dataframes
import pandas as pd;

stores.head()

s1 = stores.groupby('store_id')['revenue'].mean().reset_index()
s1[s1['revenue'] > 1000000].round(2)
