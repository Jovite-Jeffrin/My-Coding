# Tesla just provided their quarterly sales for their major vehicles.
# Determine which Tesla Model has made the most profit.
# Include all columns with the "profit" column at the end.

# access datasets as pandas dataframes
import pandas as pd;

tesla_models['profit'] = (tesla_models['car_price'] - tesla_models['production_cost']) * tesla_models['cars_sold']
pr = tesla_models.sort_values(by='profit',ascending = False)
pr.head(1)
