-- Create a new SQL script named 3.5.3_limit_exercises.sql.
;
-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees.
use employees;
select first_name, last_name from employees 
where (hire_date between'1990-01-01' and '1999-12-31') and (birth_date like '%-12-25')
order by hire_date desc, birth_date desc
limit 5;

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
use employees;
select * from employees 
where (hire_date between'1990-01-01' and '1999-12-31') and (birth_date like '%-12-25')
limit 5 offset 45;

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
'offset/limit +1 = page number'