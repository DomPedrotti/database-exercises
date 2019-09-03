SHOW databases;

-- mysql.user means use the mysql database and read from the user table
select * from mysql.user;

-- select user and host colums from user table
select user, host from mysql.user;

select * from mysql.help_topic;

SELECT help_topic_id, help_category_id, url from mysql.help_topic;
