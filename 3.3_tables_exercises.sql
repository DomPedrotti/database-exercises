-- use database name
use `employees`;

show tables;

select * from employees;
-- I assume emp_no are numeric, 
-- names are string types
-- birth and hire dates are date types

select * from departments;
-- I don't see any relationship between the employees and deparptments tables
 
show create table departments;

-- show create table dept_manager;