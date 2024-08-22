# Social Media Addiction can be a crippling disease affecting millions every year.
# We need to identify people who may fall into that category.
# Write a query to find the people who spent a higher than average amount of time on social media.
# Provide just their first names alphabetically so we can reach out to them individually.

# access datasets as pandas dataframes
import pandas as pd;

user_time.head()

df = pd.DataFrame(user_time)
df1 = pd.DataFrame(users)

avg = df['media_time_minutes'].mean()

df2 = pd.merge(df,df1, on='user_id',how='inner')
df2[df2['media_time_minutes'] > avg].sort_values(by='first_name')[['first_name']]
