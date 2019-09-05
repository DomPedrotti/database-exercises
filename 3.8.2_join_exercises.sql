-- Use the employees database.
use employees;
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
select d.dept_name, concat(e.first_name, ' ', e.last_name) as manager_name
from departments as d
join dept_manager as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
where ref.to_date > now()
order by d.dept_name
