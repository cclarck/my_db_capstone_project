insert into customers (customerID, name, contactNumber, address, email) values 
(1, 'May', 0912345678, '台北市', 'may@may.com')
,(2, 'Tom', 0922345678, '新竹市', 'tom@tom.com')
,(3, 'Eric', 0932345678, '台南市', 'eric@eric.com')
,(4, 'Chris', 0942345678, '台中市', 'chris@chris.com')
,(5, 'Peter', 0952345678, '台東縣', 'peter@peter.com')
,(6, 'Sandy', 0962345678, '高雄縣', 'sandy@peter.com');

insert into staff (staffID, name, role, annualsalary) values
(1, 'Adm', 'Manager', '$65000')
,(2, 'John', 'Head Waiter', '$35000')
,(3, 'Elsa', 'Head Chef', '$50000')
,(4, 'John', 'Receptionist', '$30000')
,(5, 'Paul', 'Assistant Chef', '$45000');

insert into orderDelivery (orderDeliveryID, status) values
(1, 'finish')
,(2, 'cancel')
,(3, 'on schedule');

insert into menuItem (itemID, name, type, price) values
(1, 'Olivers', 'Starters', 5)
,(2, 'Flatbread', 'Starters', 5)
,(3, 'Minestrone', 'Starters', 8)
,(4, 'Tomato bread', 'Starters', 8)
,(5, 'Falafel', 'Starters', 7)
,(6, 'Hummus', 'Starters', 5)
,(7, 'Greek salad', 'Main Courses', 15)
,(8, 'Bean soup', 'Main Courses', 12)
,(9, 'Pizza', 'Main Courses', 15)
,(10, 'Greek yoghurt', 'Desserts', 7)
,(11, 'Ice cream', 'Desserts', 6)
,(12, 'Cheesecake', 'Desserts', 4)
,(13, 'Athens White wine', 'Drinks', 25)
,(14, 'Corfu Red wine', 'Drinks', 30)
,(15, 'Turkish Coffee', 'Drinks', 10)
,(16, 'Turkish Coffee', 'Drinks', 10)
,(17, 'Kabasa', 'Main Courses', 17);

insert into bookings (bookingID, bookingDate, bookingSlot, tableNo, customerID, staffID, orderDeliveryID) values
(1, '2023-09-28', '18:00:00', 19, 1, 3, 1)
,(2, '2023-09-01', '15:00:00', 5, 2, 4, 2)
,(3, '2023-09-10', '17:30:00', 8, 3, 2, 1)
,(4, '2023-09-22', '18:00:00', 12, 4, 1, 1)
,(5, '2023-08-22', '18:00:00', 12, 5, 1, 1)
,(6, '2023-07-03', '19:00:00', 15, 6, 5, 3);

insert into menu (menuID, itemID, cuisine) values
(1, 1, 'Greek')
,(1, 7, 'Greek')
,(1, 10, 'Greek')
,(1, 13, 'Greek')
,(2, 3, 'Italian')
,(2, 9, 'Italian')
,(2, 12, 'Italian')
,(2, 15, 'Italian')
,(3, 5, 'Turkish')
,(3, 11, 'Turkish')
,(3, 16, 'Turkish')
,(3, 17, 'Turkish');

insert into orders (orderID, menuID, orderDate, quantity, billAmount, bookingID) values
(1, 1, '2023-09-28', 12, 37, 1)
,(2, 2, '2023-09-10', 15, 40, 3)
,(3, 3, '2023-09-22', 5, 86, 4)
,(4, 1, '2023-07-03', 8, 43, 5);
