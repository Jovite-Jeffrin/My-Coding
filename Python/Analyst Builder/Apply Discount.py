# A Computer store is offering a 25% discount for all new customers over the age of 65 or customers that spend more than $200 on their first purchase.
# The owner wants to know how many customers received that discount since they started the promotion.
# Write a query to see how many customers received that discount.

# access datasets as pandas dataframes
import pandas as pd;

# customers.head()
df = customers[(customers['age'] > 65) | (customers['total_purchase'] > 200)]
df['customer_id'].count()
