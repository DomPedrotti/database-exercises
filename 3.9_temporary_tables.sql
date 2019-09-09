use `bayes_816`;

select * from emp_with_dept;

-- Using the example from the lesson, re-create the employees_with_departments table.
create temporary table emp_with_dept as
	select e.first_name, e.last_name, d.dept_name
	from employees.employees as e
	join employees.dept_emp as ref
	on e.emp_no = ref.emp_no
	join employees.departments as d
	on d.dept_no = ref.dept_no
;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
alter table emp_with_dept add full_name varchar(31)
;

-- Update the table so that full name column contains the correct data
update emp_with_dept
set full_name = concat(first_name, ' ', last_name)
;

-- Remove the first_name and last_name columns from the table.
alter table emp_with_dept
drop column first_name, last_name
;
select first_name, last_name from emp_with_dept
;

-- What is another way you could have ended up with this same table?
'using a subquery'
;

-- Create a temporary table based on the payment table from the sakila database.
create temporary table payment as
	select * 
	from sakila.payment
; 
select * from payment
;
show create table payment
;
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
alter table payment add amount_c int
;
update payment
set amount_c = amount * 100
;

-- Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?
create temporary table dept_z_sal as	
	select d.dept_name, avg(salary) as avg_sal
	from employees.departments as d
	join employees.dept_emp as ref
	using (dept_no)
	join employees.salaries as sal
	using (emp_no)
	where sal.to_date > now()
	group by d.dept_name 
	;
	
alter table dept_z_sal add avg_global float;

update dept_z_sal
set avg_global = (select avg(salary) from employees.salaries where to_date > now());

alter table dept_z_sal add std_global float;

update dept_z_sal
set std_global = (select std(salary) from employees.salaries where to_date > now());

alter table dept_z_sal add salary_z_score float;

update dept_z_sal
set salary_z_score = (avg_sal - avg_global)/std_global;

select * from dept_z_sal;

drop table dept_z_sal;

-- What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.
create temporary table tenure_z_sal as	
	select 2002 - year(ref.from_date) as tenure, avg(salary) as avg_sal, count(*)
	from employees.dept_emp as ref
	join employees.salaries as sal
	using (emp_no)
	where ref.to_date > now()
	group by 2002- year(ref.from_date);
	
alter table tenure_z_sal add avg_global float;

update tenure_z_sal
set avg_global = (select avg(salary) from employees.salaries where to_date > now());

alter table tenure_z_sal add std_global float;

update tenure_z_sal
set std_global = (select std(salary) from employees.salaries where to_date > now());

alter table tenure_z_sal add salary_z_score float;

update tenure_z_sal
set salary_z_score = (avg_sal - avg_global)/std_global;

select * from tenure_z_sal;
