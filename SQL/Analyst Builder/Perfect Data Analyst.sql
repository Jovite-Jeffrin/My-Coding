-- Return all the candidate IDs that have problem solving skills, SQL experience, knows Python or R, and has domain knowledge.
-- Order output on IDs from smallest to largest.

-- MySQL
SELECT candidate_id 
FROM candidates
where 
  sql_experience = 'X' and 
  (python = 'X' or r_programming = 'X') and
  problem_solving = 'X' and
  domain_knowledge = 'X'
order by 1;

--PostgreSQL
SELECT candidate_id 
FROM candidates
where 
  sql_experience = 'X' and 
  (python = 'X' or r_programming = 'X') and
  problem_solving = 'X' and
  domain_knowledge = 'X'
order by 1;

-- MSSQL
SELECT candidate_id 
FROM candidates
where 
  sql_experience = 'X' and 
  (python = 'X' or r_programming = 'X') and
  problem_solving = 'X' and
  domain_knowledge = 'X'
order by 1;
