-- Cars need to be inspected every year in order to pass inspection and be street legal. If a car has any critical issues it will fail inspection or if it has more than 3 minor issues it will also fail.
-- Write a query to identify all of the cars that passed inspection.
-- Output should include the owner name and vehicle name. Order by the owner name alphabetically.

-- MySQL
SELECT owner_name, vehicle
FROM inspections 
where critical_issues = 0 AND minor_issues <= 3
order by 1;

-- PostgreSQL
SELECT owner_name, vehicle
FROM inspections 
where critical_issues = 0 AND minor_issues <= 3
order by 1;

-- MSSQL
SELECT owner_name, vehicle
FROM inspections 
where critical_issues = 0 AND minor_issues <= 3
order by 1;
