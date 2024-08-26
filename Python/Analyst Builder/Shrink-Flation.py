# Write a query to identify products that have undergone shrink-flation over the last year. Shrink-flation is defined as a reduction in product size while maintaining or increasing the price.
# Include a flag for Shrinkflation. This should be a boolean value (True or False) indicating whether the product has undergone shrink-flation
# The output should have the columns Product_Name, Size_Change_Percentage, Price_Change_Percentage, and Shrinkflation_Flag.
# Round percentages to the nearest whole number and order the output on the product names alphabetically.

# access datasets as pandas dataframes
import pandas as pd;

df = pd.DataFrame(products)
df['size_percentage'] = round(((df['new_size'] - df['original_size'])/df['original_size'])*100,2)
df['price_percentage'] = round(((df['new_price'] - df['original_price'])/df['original_price'])*100,2)

df['shrinkflation_Flag'] = ((df['new_size'] < df['original_size']) | (df['new_price'] > df['original_price']))
df['shrinkflation_Flag'] = df['shrinkflation_Flag'].astype(str)
df[['product_name','size_percentage','price_percentage','shrinkflation_Flag']].sort_values(by='product_name')
