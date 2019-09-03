-- use database name
use `employees`;

show tables;

select * from employees;
describe employees;
-- I assume emp_no are numeric, 
-- names are string types
-- birth and hire dates are date types

select * from departments;
describe departments;
describe dept_emp;
-- Linked through dept_emp table

show create table dept_manager;