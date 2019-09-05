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
;

-- Find the name of all departments currently managed by women.
select d.dept_name, concat(e.first_name, ' ', e.last_name) as manager_name
from departments as d
join dept_manager as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
where ref.to_date > now() and e.gender = 'f'
order by d.dept_name
;

-- Find the current titles of employees currently working in the Customer Service department.
select t.title, count(t.title)
from titles as t
join dept_emp as ref
on t.emp_no = ref.emp_no
where ref.dept_no = 'd009' and t.`to_date` > now() and ref.to_date > now()
group by t.title
;

-- Find the current salary of all current managers.
select d.dept_name, concat(e.first_name, ' ', e.last_name) as manager_name, sal.salary
from departments as d
join dept_manager as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
join salaries as sal
on sal.emp_no = ref.emp_no
where ref.to_date > now() and sal.to_date > now()
order by d.dept_name
;

-- Find the number of employees in each department.
select d.dept_no, d.dept_name, count(*)
from departments as d
join dept_emp as ref
on d.dept_no = ref.dept_no
where ref.to_date > now()
group by d.dept_name
order by d.dept_no
;

-- Which department has the highest average salary?
select d.dept_name, avg(sal.salary) as avg_salary
from departments as d
join dept_emp as ref
on d.dept_no = ref.dept_no
join salaries as sal
on ref.emp_no = sal.emp_no
where sal.to_date > now() and ref.to_date > now()
group by d.dept_name
order by avg_salary desc
limit 1
;

-- Who is the highest paid employee in the Marketing department?
select concat(e.first_name, ' ', e.last_name), sal.salary
from employees as e
join dept_emp as ref
on e.emp_no = ref.emp_no
join salaries as sal
on ref.emp_no = sal.emp_no
where sal.to_date > now() and ref.to_date > now() and ref.dept_no = 'd001'
order by sal.salary desc
limit 1
;

-- Which current department manager has the highest salary?
select d.dept_name, concat(e.first_name, ' ', e.last_name) as manager_name, sal.salary
from departments as d
join dept_manager as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
join salaries as sal
on sal.emp_no = ref.emp_no
where ref.to_date > now() and sal.to_date > now()
order by sal.salary desc
limit 1
;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
-- Bonus Find the names of all current employees, their department name, and their current manager's name.
select concat(e.first_name, ' ', e.last_name) as employee_name, d.dept_name, m.manager_name
from departments as d
join dept_emp as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
join
(
-- subquery of first exercise matching current manager to department
select d.dept_name, concat(e.first_name, ' ', e.last_name) as manager_name
from departments as d
join dept_manager as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
where ref.to_date > now()
order by d.dept_name
)
as m
on m.dept_name = d.dept_name
where ref.to_date > now()
;

-- Bonus Find the highest paid employee in each department.
select d.dept_name, max(sal.salary) as 'max_salary'
from departments as d
join dept_emp as ref
on d.dept_no = ref.dept_no
join employees as e
on e.emp_no = ref.emp_no
join salaries as sal
on sal.emp_no = ref.emp_no
where sal.to_date > now() and ref.to_date > now()
group by d.dept_name
;
