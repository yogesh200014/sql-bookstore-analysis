CREATE DATABASE project_db;
USE project_db;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
 
# questions
 
-- 1) Retrieve all books in the "Fiction" genre:

-- 2) Find books published after the year 1950:

-- 3) List all customers from the Canada:

-- 4) Show orders placed in November 2023:

-- 5) Retrieve the total stock of books available:

-- 6) Find the details of the most expensive book:

-- 7) Show all customers who ordered more than 1 quantity of a book:

-- 8) Retrieve all orders where the total amount exceeds $20:

-- 9) List all genres available in the Books table:

-- 10) Find the book with the lowest stock:

-- 11) Calculate the total revenue generated from all orders:

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

-- 2) Find the average price of books in the "Fantasy" genre:

-- 3) List customers who have placed at least 2 orders:

-- 4) Find the most frequently ordered book:

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

-- 6) Retrieve the total quantity of books sold by each author:

-- 7) List the cities where customers who spent over $30 are located:

-- 8) Find the customer who spent the most on orders:

#1) Retrieve all books in the "Fiction" genre:
select * from books
where genre = 'fiction';

#2)  Find books published after the year 1950:
select title,author,published_year from books 
where published_year >1950;

#3)  List all customers from the Canada:
select * from customers 
where country = 'canada';

#4)  Show orders placed in November 2023:
select * from orders
where order_date like '2023-11-__';

#5)  Retrieve the total stock of books available:
select sum(stock) as total_stock
from books;

#6) Find the details of the most expensive book:
select * from books
order by price desc limit 1;

#7) Show all customers who ordered more than 1 quantity of a book:
select name,quantity from orders
join customers
on orders.customer_id =customers.customer_id
where quantity > 1;

select * from orders
where quantity>1;

#8) Retrieve all orders where the total amount exceeds $20:
select * from orders 
where total_amount > 20;

#9) List all genres available in the Books table:
select genre from books
group by genre;

select distinct genre from books;

#10) Find the book with the lowest stock:
select * from books
order by stock asc limit 1; 

#11) Calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue from orders;

#advance questions

#1) Retrieve the total number of books sold for each genre:
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;


#2) Find the average price of books in the "Fantasy" genre:
select avg(price),genre from books
where genre = 'fantasy';

#3) List customers who have placed at least 2 orders:
SELECT 
    customers.name, 
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.name
HAVING COUNT(orders.order_id) >= 2;

#4)  Find the most frequently ordered book:
SELECT 
    o.book_id, 
    b.title, 
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;


#5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre = 'fantasy'
order by price desc limit 3;

#6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_books_sold
from orders o 
join books b 
on o.book_id = b.book_id
group by b.author;

#7) List the cities where customers who spent over $30 are located:
select distinct c.city,total_amount
from orders o
join customers c 
on c.customer_id = o.customer_id
where total_amount > 30;

#8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.customer_id,c.name
order by total_spent desc limit 1;
