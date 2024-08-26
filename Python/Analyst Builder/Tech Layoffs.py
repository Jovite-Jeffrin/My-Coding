# Tech companies have been laying off employees after a large surge of hires in the past few years.
# Write a query to determine the percentage of employees that were laid off from each company.
# Output should include the company and the percentage (to 2 decimal places) of laid off employees.
# Order by company name alphabetically.

# access datasets as pandas dataframes
import pandas as pd;

tech_layoffs['percentage'] = round((tech_layoffs['employees_fired']/tech_layoffs['company_size'])*100,2)
tech_layoffs[['company','percentage']].sort_values(by='company')
