create database
create database if not exists walmartSales;

create table
create table if not exists sales(
invoice_id varchar(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity int NOT NULL,
tax_pct FLOAT (6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12,4),
rating FLOAT(2,1)
);

alter table sales modify column rating FLOAT(3,1)
Truncate table sales;
select * from sales;

-- Data cleaning
select * from sales;

-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server
UPDATE sales
SET time_of_day = (
CASE
WHEN 'time' BETWEEN "00;00;00" AND "12;00;00" THEN "Morning"
WHEN 'time' BETWEEN "12;01;00" AND "16;00:00" THEN "Afternoon"
ELSE "Evening"
    END
);

-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

Update sales
set day_name = dayname(date);

-- Add month_name column
Select date, monthname(date) from sales;

Alter table sales ADD COLUMN Month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
select distinct city from sales;

-- In which city is each branch?
select distinct city, branch from sales;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------
-- How many unique product lines does the data have?
select distinct product_line from sales;

-- What is the most selling product line
select sum(quantity) as qty, product_line from sales
group by product_line order by qty DESC;

-- What is the total revenue by month
select month_name as month, sum(total) as total_revenue from sales
group by month_name order by total_revenue;

