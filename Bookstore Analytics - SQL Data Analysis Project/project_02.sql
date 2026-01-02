---- see data of the tables

select * from books
select * from customers
select * from orders


-- 1) Retrieve all books in the "Fiction" genre:

select*from books
where genre = 'Fiction'


---2) Find books published after the year 1950:

select * from books
where Published_Year > 1950


-- 3) List all customers from the Canada:

select * from customers
where Country = 'Canada'


-- 4) Show orders placed in November 2023:
select * from orders 
where Order_Date between '2023-11-01' and '2023-11-30'

-- 5) Retrieve the total stock of books available:
select sum(Stock) as Total_stock from books


-- 6) Find the details of the most expensive book:
select * from books
where Price = (select max(Price) from books)


-- 7) Show all customers who ordered more than 1 quantity of a book:
select Name,Quantity from customers
join orders
on customers.Customer_ID = orders.Customer_ID
where Quantity>1

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where Total_Amount>20



-- 9) List all genres available in the Books table:
select distinct Genre from books



-- 10) Find the book with the lowest stock:
select * from books
where Stock = (select min(Stock) from books)

SELECT top(1) * FROM Books 
ORDER BY stock 

-- 11) Calculate the total revenue generated from all orders:

select sum(Total_Amount) as Revenue from orders




-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

select Genre, sum(Quantity) AS Sold from books
join orders
on orders.Book_id = books.Book_id
group by Genre
order by Sold asc

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(Price) as Avg_price from books
where Genre = 'Fantasy'




-- 3) List customers who have placed at least 2 orders:

select o.customer_id, c.Name,count(Order_ID) from orders o
join customers c
on c.Customer_ID = o.Customer_ID
group by o.customer_id,c.Name
having count(Order_ID)>=2




-- 4) Find the most frequently ordered book:
select o.Book_ID,b.Title,count(o.Order_ID) from orders o
join books b on b.Book_ID = o.Book_ID 
group by o.Book_ID,Title
order by count(o.Order_ID) desc


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select top(3) Title,Price from books
where genre = 'Fantasy'
order by Price desc


-- 6) Retrieve the total quantity of books sold by each author:
select b.Author,sum(o.Quantity) as sold_by_each_author from books b
join orders o on b.Book_ID = o.Book_ID
group by b.Author


-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city from customers c
join orders o
on c.Customer_ID = o.Customer_ID
where o.Total_Amount>30

-- 8) Find the customer who spent the most on orders:
select top(1) c.Customer_ID,c.Name,sum(o.Total_Amount)from customers c
join orders o on c.Customer_ID = o.Customer_ID
group by c.Customer_ID,c.Name
order by sum(o.Total_Amount) desc 




--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity),0) AS Order_quantity,  
	b.Stock- COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.Book_ID=o.Book_ID
GROUP BY b.Book_ID 
ORDER BY b.Book_ID


--- top customer how did more time or spentive customer

select top(2) c.Customer_ID,c.Name, sum(o.Quantity),sum(o.Total_Amount) from customers c
join orders o on c.Customer_ID = o.Customer_ID
group by c.Customer_ID,c.Name
order by sum(o.Quantity) desc

