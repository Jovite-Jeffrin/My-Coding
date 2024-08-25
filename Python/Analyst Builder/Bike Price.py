# Sarah's Bike Shop sells a lot of bikes and wants to know what the average sale price is of her bikes.
# She sometimes gives away a bike for free for a charity event and if she does she leaves the price of the bike as blank, but marks it sold.
# Write a query to show her the average sale price of bikes for only bikes that were sold, and not donated.
# Round answer to 2 decimal places.

# access datasets as pandas dataframes
import pandas as pd;

df = pd.DataFrame(inventory)
df1 = df[(df['bike_price'].notnull()) & (df['bike_sold'] == 'Y')]
avg = df1['bike_price'].mean()
print(round(avg,2))
