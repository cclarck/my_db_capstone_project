--- task1 : create view
--- which order with a quantity greater than 2
CREATE VIEW orderView AS
SELECT orderID
     , quantity
     , totalCost
 FROM orders
WHERE quantity > 2;
Query OK, 0 rows affected (0.16 sec)

mysql> select * from orderView;
+---------+----------+-----------+
| orderID | quantity | totalCost |
+---------+----------+-----------+
|       2 |        5 |   1000.00 |
|       4 |        3 |     39.00 |
+---------+----------+-----------+
2 rows in set (0.01 sec)


--- task 2 : join
SELECT b.customerID
      , c.name
      , o.orderID
      , m.cuisine
      , mi.name
  FROM orders AS o
  JOIN bookings AS b
    ON o.bookingID = b.bookingID
  JOIN customers AS c
    ON c.customerID = b.customerID
  JOIN menu AS m
    ON o.menuID = m.menuID
  JOIN menuItem AS mi
    ON m.itemID = mi.itemID
 WHERE o.totalCost > 150;
 
+------------+------+---------+---------+----------------+
| customerID | name | orderID | cuisine | name           |
+------------+------+---------+---------+----------------+
|          3 | Eric |       2 | Italian | Minestrone     |
|          3 | Eric |       2 | Italian | Pizza          |
|          3 | Eric |       2 | Italian | Cheesecake     |
|          3 | Eric |       2 | Italian | Turkish Coffee |
+------------+------+---------+---------+----------------+
4 rows in set (0.00 sec)

    
--- task 3: subquery

SELECT m.cuisine
  FROM menu AS m
  JOIN menuItem AS mi
    ON m.itemID = mi.itemID
  JOIN orders AS o
    ON o.menuID = m.menuID
 WHERE o.quantity > ANY (SELECT quantity FROM orders WHERE quantity = 2)
  
+---------+
| cuisine |
+---------+
| Italian |
| Italian |
| Italian |
| Italian |
| Greek   |
| Greek   |
| Greek   |
| Greek   |
+---------+
8 rows in set (0.00 sec)



 
