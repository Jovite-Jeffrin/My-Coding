# Cars need to be inspected every year in order to pass inspection and be street legal. If a car has any critical issues it will fail inspection or if it has more than 3 minor issues it will also fail.
# Write a query to identify all of the cars that passed inspection.
# Output should include the owner name and vehicle name. Order by the owner name alphabetically.

# access datasets as pandas dataframes
import pandas as pd;

inspections.head()

inspections[(inspections['minor_issues'] <= 3) & (inspections['critical_issues'] == 0)][['owner_name','vehicle']].sort_values('owner_name')
