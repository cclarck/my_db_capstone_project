--- 2023-10-09
--- task 1
--- In this first task, Little Lemon need you to create a procedure that displays the maximum ordered quantity in the Orders table. 
--- Creating this procedure will allow Little Lemon to reuse the logic 
--- implemented in the procedure easily without retyping the same code over again and again to check the maximum quantity. 

You can call the procedure GetMaxQuantity and invoke it as follows:

mysql> show full tables where table_type = 'VIEW';
+----------------------------------+------------+
| Tables_in_capstone_LittleLemonDB | Table_type |
+----------------------------------+------------+
| orderView                        | VIEW       |
+----------------------------------+------------+
1 row in set (0.00 sec)


SELECT MAX(quantity) AS 'Max Quantity in Order'
  FROM orders

+-----------------------+
| Max Quantity in Order |
+-----------------------+
|                     5 |
+-----------------------+
1 row in set (0.00 sec)

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(quantity) AS 'Max Quantity in Order'
  FROM orders;
END //
DELIMITER ;

mysql> CALL GetMaxQuantity();
+-----------------------+
| Max Quantity in Order |
+-----------------------+
|                     5 |
+-----------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

--- task 2: 
--- In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. 
--- This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.
--- The prepared statement should accept one input argument, the CustomerID value, from a variable. 
--- The statement should return the order id, the quantity and the order cost from the Orders table. 
--- Once you create the prepared statement, you can create a variable called id and assign it value of 1. 

PREPARE GetOrderDetail FROM
'SELECT o.orderID
      , o.quantity
      , o.totalCost
   FROM orders AS o
   JOIN bookings AS b
     ON o.bookingID = b.bookingID
  WHERE b.customerID = ?';
  
Query OK, 0 rows affected (0.00 sec)
Statement prepared

mysql> SET @id = 1;
Query OK, 0 rows affected (0.00 sec)

mysql> EXECUTE GetOrderDetail USING @id;
+---------+----------+-----------+
| orderID | quantity | totalCost |
+---------+----------+-----------+
|       1 |        2 |     20.00 |
+---------+----------+-----------+
1 row in set (0.00 sec)

--- task 3
--- Your third and final task is to create a stored procedure called CancelOrder. 
--- Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.
--- Creating this procedure will allow Little Lemon to cancel 
--- any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement.   

DELIMITER //
CREATE PROCEDURE CancelOrder(orderIDInput INT)
BEGIN
  DELETE FROM orders WHERE orderID = orderIDInput;
  SELECT CONCAT('Order ', orderIDInput, ' is cancelled') AS 'Confirmation';
END //
DELIMITER ;

mysql> call CancelOrder(1);
+----------------------+
| Confirmation         |
+----------------------+
| Order 1 is cancelled |
+----------------------+
1 row in set (0.11 sec)

Query OK, 0 rows affected (0.11 sec)
