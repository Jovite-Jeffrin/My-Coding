# Write a query to determine the popularity of a post on LinkedIn
# Popularity is defined by number of actions (likes, comments, shares, etc.) divided by the number impressions the post received * 100.
# If the post receives a score higher than 1 it was very popular.
# Return all the post IDs and their popularity where the score is 1 or greater.
# Order popularity from highest to lowest.

# access datasets as pandas dataframes
import pandas as pd;

df = pd.DataFrame(linkedin_posts)
df['popularity'] = (df['actions']/df['impressions'])*100
df[df['popularity'] > 1][['post_id','popularity']].sort_values(by='popularity', ascending = False)
