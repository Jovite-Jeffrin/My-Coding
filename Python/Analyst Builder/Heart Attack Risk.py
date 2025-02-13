# Dr. Obrien has seen an uptick in heart attacks for his patients over the past few months. He has been noticing some trends across his patients and wants to get ahead of things by reaching out to current patients who are at a high risk of a heart attack.
# We need to identify which clients he needs to reach out to and provide that information to Dr. Obrien.
# If a patient is over the age of 50, cholesterol level of 240 or over, and weight 200 or greater, then they are at high risk of having a heart attack.
# Write a query to retrieve these patients. Include all columns in your output.
# As Cholesterol level is the largest indicator, order the output by Cholesterol from Highest to Lowest so he can reach out to them first.

# access datasets as pandas dataframes
import pandas as pd;

# patients.head()

df = pd.DataFrame(patients)
df

df1 = df[(df['age'] > 50) & (df['cholesterol'] >= 240) & (df['weight'] >= 200)]

df2 = df1.sort_values(by = 'cholesterol', ascending = False)
df2
