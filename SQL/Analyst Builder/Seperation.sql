-- Data was input incorrectly into the database. The ID was combined with the First Name.
-- Write a query to separate the ID and First Name into two separate columns.
-- Each ID is 5 characters long.

-- MySQL
SELECT LEFT(id,5) as ID, substring(id,6) as First_Name
FROM bad_data;

-- PostgreSQL
SELECT LEFT(id,5) as ID, substring(id,6) as First_Name
FROM bad_data;

-- MSSQL
SELECT LEFT(id,5) as ID, substring(id,6,20) as First_Name
FROM bad_data;
