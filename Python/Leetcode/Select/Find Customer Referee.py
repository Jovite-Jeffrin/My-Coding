# Find the names of the customer that are not referred by the customer with id = 2.
# Return the result table in any order.
# The result format is in the following example.

import pandas as pd

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    df = customer[(customer['referee_id'] != 2) | (customer['referee_id'].isnull())]
    return df[['name']]
