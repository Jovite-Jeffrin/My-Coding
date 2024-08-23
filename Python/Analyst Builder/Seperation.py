# Data was input incorrectly into the database. The ID was combined with the First Name.
# Write a query to separate the ID and First Name into two separate columns.
# Each ID is 5 characters long.

# access datasets as pandas dataframes
import pandas as pd;

df = pd.DataFrame(bad_data)
df['ID'] = df['id'].str[:5]
df['First_name'] = df['id'].str[5:]
df.drop(columns=['id'])
