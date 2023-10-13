--- 2023-10-11
--- week 2 : Create SQL queries to check available bookings based on user input
--- task 1
--- Little Lemon wants to populate the Bookings table of their database with some records of data. 
--- Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 

--- the data insert to bookings table
--- but there are 6 data in bookings table, so I change something.
--- my changes in below because my Little Lemon ER model is different.
--- origin:
INSERT INTO bookings (bookingID, bookingDate, tableNo, customerID) VALUES
(1, '2022-10-1-', 5, 1)
,(2, '2022-11-12', 3, 3)
,(3, '2022-10-11', 2, 2)
,(4, '2022-10-13', 2, 1);

--- change:
INSERT INTO bookings (bookingID, bookingDate, bookingSlot, tableNo, customerID, staffID, orderDeliveryID) VALUES
(7, '2022-10-1-', '17:00:00', 5, 1, 1, 1)
,(8, '2022-11-12', '19:00:00', 3, 3, 1, 3)
,(9, '2022-10-11', '18:30:00', 2, 2, 3, 3)
,(10, '2022-10-13', '17:00:00', 2, 1, 4, 2);

Query OK, 4 rows affected, 1 warning (0.10 sec)
Records: 4  Duplicates: 0  Warnings: 1

ysql> select * from bookings;
+-----------+-------------+-------------+---------+------------+---------+-----------------+
| bookingID | bookingDate | bookingSlot | tableNo | customerID | staffID | orderDeliveryID |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
|         1 | 2023-09-28  | 18:00:00    |      19 |          1 |       3 |               1 |
|         2 | 2023-09-01  | 15:00:00    |       5 |          2 |       4 |               2 |
|         3 | 2023-09-10  | 17:30:00    |       8 |          3 |       2 |               1 |
|         4 | 2023-09-22  | 18:00:00    |      12 |          4 |       1 |               1 |
|         5 | 2023-08-22  | 18:00:00    |      12 |          5 |       1 |               1 |
|         6 | 2023-07-03  | 19:00:00    |      15 |          6 |       5 |               3 |
|         7 | 2022-10-01  | 17:00:00    |       5 |          1 |       1 |               1 |
|         8 | 2022-11-12  | 19:00:00    |       3 |          3 |       1 |               3 |
|         9 | 2022-10-11  | 18:30:00    |       2 |          2 |       3 |               3 |
|        10 | 2022-10-13  | 17:00:00    |       2 |          1 |       4 |               2 |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
10 rows in set (0.00 sec)

--- task 2
--- For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. 
--- Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.
--- The procedure should have two input parameters in the form of booking date and table number. 
--- You can also create a variable in the procedure to check the status of each table.
SELECT CONCAT('Table ', tableNo, ' is already booked') AS 'Booking status'
    FROM bookings
   WHERE bookingDate = '2022-11-12'
     AND tableNo = 3;

DELIMITER //
CREATE PROCEDURE CheckBooking (dateInput DATE, tableNo INT)
BEGIN
  SELECT CONCAT('Table ', tableNo, ' is already booked') AS 'Booking status'
    FROM bookings
   WHERE bookingDate = dateInput
     AND tableNo = tableNo;
END //
DELIMITER ;

mysql> call CheckBooking('2022-11-12', 3);
+---------------------------+
| Booking status            |
+---------------------------+
| Table 3 is already booked |
+---------------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

--- task 3
--- add a booking before check table number
--- then should two input so bookingSlot is pass
--- if it is exists then rollback overwise insert it.
--- just practice for this task 3
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN dateInput DATE, IN tableNoInput INT)
BEGIN
  DECLARE tableNo_input INT;
  START TRANSACTION;
    SELECT tableNo INTO tableNo_input FROM bookings WHERE tableNo = tableNoInput LIMIT 1;
    IF tableNo_input IS NULL THEN 
      INSERT INTO bookings (bookingDate, bookingSlot, tableNo, customerID, staffID, orderDeliveryID) VALUES 
      (dateInput, '19:30:00', tableNoInput, 1, 1, 1);
    ELSE
      ROLLBACK;
      SELECT CONCAT('Table ', tableNo_input, ' is already booked - booking cancelled') AS 'Booking status';
    END IF;
  COMMIT;
END //
DELIMITER ;

Query OK, 0 rows affected (0.20 sec)

--- if table number was exists...
CALL AddValidBooking('2022-11-12', 3);
+-----------------------------------------------+
| Booking status                                |
+-----------------------------------------------+
| Table 3 is already booked - booking cancelled |
+-----------------------------------------------+
1 row in set (0.00 sec)

--- if table number was not exists...
CALL AddValidBooking('2022-12-17', 6);
Query OK, 0 rows affected (0.06 sec)

mysql> select * from bookings where bookingDate = '2022-12-17';
+-----------+-------------+-------------+---------+------------+---------+-----------------+
| bookingID | bookingDate | bookingSlot | tableNo | customerID | staffID | orderDeliveryID |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
|        12 | 2022-12-17  | 19:30:00    |       6 |          1 |       1 |               1 |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
1 row in set (0.00 sec)

