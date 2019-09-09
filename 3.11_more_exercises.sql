use employees;

-- How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

select dept_name, avg(man_sal.salary) as manager_salary, avg(sal.salary) as avg_salary from
departments as d
join dept_emp as ref
on d.dept_no = ref.`dept_no`
join salaries as sal
on sal.emp_no = ref.emp_no
join(
	select dept.dept_name, salary
	from departments as dept	
	join dept_emp as ref
	on ref.dept_no = dept.dept_no
	join salaries as sal
	on sal.emp_no = ref.emp_no
	join dept_manager as man
	on man.emp_no = ref.emp_no
	where man.to_date > NOW() and sal.to_date > now()
	order by dept_name
	) as man_sal
using(dept_name)
where ref.to_date > now()
group by dept_name;

-- ---------------------------------------------------------

-- Use the world database for the questions below.
use world;

-- What languages are spoken in Santa Monica?
select language, percentage
from countrylanguage as cl
right join country as c
on c.Code = cl.CountryCode
right join city
on city.CountryCode = c.Code
where city.name like 'santa monica'
order by percentage;

-- How many different countries are in each region?
select Region, count(name)
from country
group by Region;

-- What is the population for each region?
select Region, sum(Population)
from country
group by Region;

-- What is the population for each continent?
select Continent, sum(Population)
from country
group by Continent
;
-- What is the average life expectancy globally?
select avg(LifeExpectancy)
from country
;
-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
select Region, avg(LifeExpectancy)
from country
group by region
order by avg(LifeExpectancy)
;
select Continent, avg(lifeexpectancy)
from country
group by continent
order by avg(lifeexpectancy)
;
-- Find all the countries whose local name is different from the official name
select name from country 
where name != localname
;
-- How many countries have a life expectancy less than 50?
select name, lifeexpectancy from country
where lifeexpectancy < 50
;
-- What state is city x located in? 
select name as city, district as state from city
where countrycode = 'usa'
;
-- What region of the world is city x located in?
select city.name, country.region 
from city
join country
on country.code = city.countrycode
;
-- What country (use the human readable name) city x located in?
select city.name, country.name
from city
join country
on country.code = city.countrycode;
;
-- What is the life expectancy in city x?
select city.name, country.lifeexpectancy
from city
join country
where country.code = city.countrycode
;
-- ----------------------------------------------------------------------
-- Sakila Database
use sakila;
-- Display the first and last names in all lowercase of all the actors.
select lower(concat(first_name, ' ', last_name)) from actor
;
-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?
select first_name, last_name, actor_id from actor where first_name like 'joe'
;
-- Find all actors whose last name contain the letters "gen":
select first_name, last_name from actor where last_name like '%gen%'
;
-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
select first_name, last_name from actor where last_name like '%li%' order by last_name, first_name
;
-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China')
;

