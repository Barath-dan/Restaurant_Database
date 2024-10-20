-- Use the Little Lemon database
USE littlelemondb;

-- VIRTUAL TABLE

CREATE VIEW OrdersView
AS SELECT orders.Order_ID,orders.Quantity,orders.Total_Cost
FROM orders
WHERE Quantity>2;
-- Querrying Virtual Table
SELECT * FROM OrdersView;

-- JOINS

SELECT customer.Customer_ID, CONCAT(customer.First_Name,' ',customer.Last_Name) AS Full_Name,
orders.Order_ID,orders.Total_Cost,
menu.Cuisines,menu.Starters,menu.Courses
FROM customer 
INNER JOIN orders ON customer.Customer_ID = orders.Customer_ID
INNER JOIN menu ON orders.Menu_ID = menu.Menu_ID;

-- SUB-QUERY

SELECT menu.Courses 
FROM menu 
WHERE menu.Menu_ID = ANY(SELECT orders.Menu_ID FROM orders 
WHERE orders.Quantity > 2);

-- STORED-PROCEDURE

CREATE PROCEDURE GetMaxQuantity()
SELECT max(Quantity) AS Maximum_Ordered_Quantity
FROM orders;
-- Invoking-Procedure
CALL GetMaxQuantity();

-- PREPARED STATEMENT

PREPARE GetOrderDetail FROM
'SELECT customer.Customer_ID, orders.Order_ID, orders.Quantity, orders.Total_Cost
FROM customer INNER JOIN orders ON
customer.Customer_ID=orders.Customer_ID
WHERE customer.Customer_ID=?';
-- Variable declaration
SET @id=1;
-- Execution
EXECUTE GetOrderDetail USING @id;

-- STORED PROCEDURE 
CREATE PROCEDURE CancelOrder(IN ID INT)
DELETE FROM Orders
WHERE Order_ID=ID;
-- Invoking-Procedure
call CancelOrder(10)



