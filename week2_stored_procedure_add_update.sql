--- 2023-10-13
--- week 2
--- Create SQL queries to add and update bookings

--- task 1
--- In this first task you need to create a new procedure 
--- called AddBooking to add a new table booking record.
--- booking id, customer id, booking date, table number
--- but my design bookings have other columns so some column with default value
DELIMITER //
CREATE PROCEDURE AddBooking (bookingIDInput INT, customerIDInput INT, tableNoInput INT, bookingDateInput DATE)
BEGIN
  INSERT INTO bookings (bookingID, customerID, tableNo, bookingDate, bookingSlot, staffID, orderDeliveryID) VALUES
  (bookingIDInput, customerIDInput, tableNoInput,bookingDateInput, '19:30:00', 1, 3);
  SELECT CONCAT('New booking added');
END //
DELIMITER ;

CALL AddBooking(13, 3, 4, "2022-12-30");

+-----------------------------+
| CONCAT('New booking added') |
+-----------------------------+
| New booking added           |
+-----------------------------+
1 row in set (0.09 sec)

mysql> select * from bookings;
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
|        12 | 2022-12-17  | 19:30:00    |       6 |          1 |       1 |               1 |
|        13 | 2022-12-30  | 19:30:00    |       4 |          3 |       1 |               3 |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
12 rows in set (0.00 sec)

--- task 2
--- you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.

DELIMITER //
CREATE PROCEDURE UpdateBooking (IDInput INT, dateInut DATE)
BEGIN
  UPDATE bookings
     SET bookingDate = dateInut
   WHERE bookingID = IDInput;
  SELECT CONCAT('Booking ', IDInput, ' updated') AS 'Confirmation'; 
END //
DELIMITER ;

CALL UpdateBooking(9, "2022-12-17");


+-------------------+
| Confirmation      |
+-------------------+
| Booking 9 updated |
+-------------------+
1 row in set (0.10 sec)

Query OK, 0 rows affected (0.10 sec)



mysql> select * from bookings where bookingID = 9;
+-----------+-------------+-------------+---------+------------+---------+-----------------+
| bookingID | bookingDate | bookingSlot | tableNo | customerID | staffID | orderDeliveryID |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
|         9 | 2022-12-17  | 18:30:00    |       2 |          2 |       3 |               3 |
+-----------+-------------+-------------+---------+------------+---------+-----------------+
1 row in set (0.00 sec)


--- task 3
--- For the third and final task, 
--- Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.

DELIMITER //
CREATE PROCEDURE CancelBooking(IDInput INT)
BEGIN
  DELETE FROM bookings WHERE bookingID = IDInput;
  SELECT CONCAT('Booking ', IDInput, ' cancelled') AS 'Confirmation';  
END //
DELIMITER ;

CALL CancelBooking(9);

+---------------------+
| Confirmation        |
+---------------------+
| Booking 9 cancelled |
+---------------------+
1 row in set (0.10 sec)

Query OK, 0 rows affected (0.10 sec)

select * from bookings where bookingID = 9;
Empty set (0.00 sec)
