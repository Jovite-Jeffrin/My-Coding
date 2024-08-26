-- Write a query to determine how many direct reports each Manager has.
-- Note: Managers will have "Manager" in their title.
-- Report the Manager ID, Manager Title, and the number of direct reports in your output.

-- MSSQL
SELECT man.employee_id as manager_id, man.position, COUNT(*) as direct_reports
FROM direct_reports emp
join direct_reports man on emp.managers_id = man.employee_id
where man.position like '%Manager%'
group by man.employee_id, man.position;

-- postgreSQL
SELECT man.employee_id as manager_id, man.position, COUNT(*) as direct_reports
FROM direct_reports emp
join direct_reports man on emp.managers_id = man.employee_id
where man.position like '%Manager%'
group by 1,2;

-- MySQL
SELECT man.employee_id as manager_id, man.position, COUNT(*) as direct_reports
FROM direct_reports emp
join direct_reports man on emp.managers_id = man.employee_id
where man.position like '%Manager%'
group by 1,2;
