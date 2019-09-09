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
-- List the last names of all the actors, as well as how many actors have that last name.
select last_name, count(`last_name`) from actor group by last_name
;
-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(`last_name`) as count from actor  
group by last_name
having count > 1
;
-- You cannot locate the schema of the address table. Which query would you use to re-create it?
use sakila
;
-- Use JOIN to display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address 
from staff
join address
using(address_id)
;
-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
select staff.first_name, staff.last_name, sum(payment.amount)
from payment
join staff
using (staff_id)
where year(payment.payment_date) = 2005 and month(payment.payment_date) = 8 
group by (staff_id)
;
-- List each film and the number of actors who are listed for that film.
select title, count(*)
from film
join film_actor
using(film_id) 
group by title
;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
select count(*)
from inventory
join film
using(film_id)
where film.title like 'hunchback impossible'
group by film_id
;
-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title 
from(
	select title, language_id from film
	where title like 'q%' or title like 'k%'
	) as qk_titles
join language as lan
using(language_id)
where lan.name like 'english'
;
-- Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name 
from actor
join film_actor as ref
using (actor_id)
join film
using (film_id)
where film.title like 'alone trip'
;
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
select first_name, last_name, email
from customer
join address
using(address_id)
join city
using(city_id)
join country 
using(country_id)
where country.country like 'canada'
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select title 
from film
join film_category
using (film_id)
join category as cat
using (category_id)
where cat.name like 'family'
;
-- Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount)
from store
join customer as cust
using (store_id)
join payment as pmt
using (customer_id)
group by store_id
;
-- Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store
join address
using (address_id)
join city 
using(city_id)
join country 
using(country_id) 
;
-- List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select cat.name, sum(amount)
from category as cat
join film_category
using (category_id)
join film 
using(film_id)
join inventory
using (film_id)
join rental
using (inventory_id)
join payment 
using (rental_id)
group by cat.name
limit 5
