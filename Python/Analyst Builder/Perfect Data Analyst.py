# Return all the candidate IDs that have problem solving skills, SQL experience, knows Python or R, and has domain knowledge.
# Order output on IDs from smallest to largest.

# access datasets as pandas dataframes
import pandas as pd;

candidates.head()

candidates[(candidates['problem_solving'] == 'X') & (candidates['sql_experience'] == 'X') & ((candidates['python'] == 'X') | (candidates['r_programming'] == 'X')) & (candidates['domain_knowledge'] == 'X')][['candidate_id']]
