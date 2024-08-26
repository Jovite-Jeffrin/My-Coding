# Kroger's is a very popular grocery chain in the US. They offer a membership card in exchange for a discount on select items. Customers can still shop at Krogers without the card.
# Write a query to find the percentage of customers who shop at Kroger's who also have a Kroger's membership card. Round to 2 decimal places.

# access datasets as pandas dataframes
import pandas as pd;

df = pd.DataFrame(customers)
member = df[df['has_member_card'] == 'Y'].shape[0]
tot = df['kroger_id'].shape[0]
perc = (member/tot)*100.00
print(round(perc,2))
