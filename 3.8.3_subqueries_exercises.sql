use employees
;

-- Find all the employees with the same hire date as employee 101010 using a sub-query.
select concat(first_name, ' ', last_name) as emp_name
from employees 
where hire_date in (
	select hire_date 
	from employees
	where emp_no = 101010
	)
;

-- Find all the titles held by all employees with the first name Aamod.
select title
from titles
where emp_no in(
	select emp_no 
	from employees
	where first_name = 'Aamod'
	)
;

-- How many people in the employees table are no longer working for the company?
select count(*)
from employees 
where emp_no in (
	select emp_no
	from dept_emp
	where to_date < now()
	)
;

-- Find all the current department managers that are female.
select first_name, last_name
from employees
where gender = 'f' and emp_no in(
	select emp_no
	from dept_manager
	where to_date > now()
	)
;
-- Find all the employees that currently have a higher than average salary.
select e.first_name, e.last_name, sal.salary
from employees as e
join salaries as sal
on e.emp_no = sal.emp_no
where sal.to_date > now() and salary > (
	select avg(salary)
	from salaries
	)	
;

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
select e.first_name, e.last_name, sal.salary
from employees as e
join salaries as sal
on e.emp_no = sal.emp_no
where sal.to_date > now() and salary > (
	select MAX(salary)-std(salary)
	from salaries
	)
;
-- Find all the department names that currently have female managers.
select d.dept_name
from departments as d
join dept_manager as ref
on ref.dept_no = d.dept_no
join employees as e
on e.emp_no = ref.emp_no
where e.gender = 'f' and e.emp_no in(
	select emp_no
	from dept_manager
	where to_date > now()
	)
;

-- Find the first and last name of the employee with the highest salary.
select first_name, last_name 
from employees as e
join salaries as sal
on e.emp_no = sal.emp_no
where sal.salary = (
	select max(salary)
	from salaries
	) 
;

-- Find the department name that the employee with the highest salary works in.
select d.dept_name
from departments as d
join dept_emp as ref
on ref.dept_no = d.dept_no
join employees as e
on ref.emp_no = e.emp_no
join salaries as sal
on ref.emp_no = sal.emp_no
where sal.salary = (
	select max(salary)
	from salaries
	) 
;
