use littlelemondb;
show tables;
select * from bookings;
INSERT INTO customer (Customer_ID, First_Name, Last_Name, Age, Mobile_Number, Email) VALUES
(101, 'John', 'Doe', 30, '1234567890', 'john.doe@xyz.com'),
(102, 'Jane', 'Smith', 25, '0987654321', 'jane.smith@xys.com'),
(103, 'Emily', 'Davis', 28, '1231231234', 'emily.davis@ple.com'),
(104, 'Michael', 'Brown', 35, '4321432143', 'michael.brown@exa.com'),
(105, 'Sarah', 'Wilson', 29, '5555555555', 'sarah.wilson@ample.com'),
(106, 'David', 'Taylor', 40, '6666666666', 'david.taylor@le.com'),
(107, 'Jessica', 'Miller', 22, '7777777777', 'jessica.miller@asle.com'),
(108, 'Daniel', 'Anderson', 32, '8888888888', 'daniel.anderson@apple.com'),
(109, 'Sophia', 'Thomas', 27, '9999999999', 'sophia.thomas@firle.com'),
(110, 'James', 'Moore', 33, '1230984567', 'james.moore@abc.com');
INSERT INTO menu (Menu_ID, Cuisines, Starters, Courses, Drinks, Desserts) VALUES
(301, 'Italian', 'Bruschetta', 'Spaghetti', 'Wine', 'Tiramisu'),
(302, 'Chinese', 'Spring Rolls', 'Kung Pao Chicken', 'Tea', 'Mango Pudding'),
(303, 'Indian', 'Samosa', 'Butter Chicken', 'Lassi', 'Gulab Jamun'),
(304, 'Mexican', 'Nachos', 'Tacos', 'Margarita', 'Churros'),
(305, 'French', 'Escargot', 'Beef Bourguignon', 'Champagne', 'Macarons'),
(306, 'Japanese', 'Edamame', 'Sushi', 'Sake', 'Mochi'),
(307, 'Greek', 'Tzatziki', 'Moussaka', 'Ouzo', 'Baklava'),
(308, 'Thai', 'Satay', 'Green Curry', 'Iced Tea', 'Sticky Rice'),
(309, 'American', 'Wings', 'Burger', 'Coke', 'Brownie'),
(310, 'Spanish', 'Patatas Bravas', 'Paella', 'Sangria', 'Crema Catalana');
INSERT INTO order_delivery_status (Delivery_ID, Delivery_Date, Status) VALUES
(401, '2024-01-01 12:00:00', 'Delivered'),
(402, '2024-01-02 13:30:00', 'Delivered'),
(403, '2024-01-03 14:00:00', 'Pending'),
(404, '2024-01-04 15:45:00', 'Cancelled'),
(405, '2024-01-05 16:20:00', 'Delivered'),
(406, '2024-01-06 17:15:00', 'Pending'),
(407, '2024-01-07 18:00:00', 'Delivered'),
(408, '2024-01-08 19:30:00', 'Cancelled'),
(409, '2024-01-09 20:45:00', 'Delivered'),
(410, '2024-01-10 21:00:00', 'Pending');
INSERT INTO staff (Staff_ID, Role, Salary) VALUES
(201, 'Manager', 60000),
(202, 'Chef', 40000),
(203, 'Waiter', 25000),
(204, 'Bartender', 30000),
(205, 'Cleaner', 20000),
(206, 'Receptionist', 35000),
(207, 'Manager', 60000),
(208, 'Chef', 45000),
(209, 'Waiter', 26000),
(210, 'Bartender', 31000);
INSERT INTO orders (Order_ID, Order_Date, Quantity, Total_Cost, Menu_ID, Customer_ID, Deliver_ID) VALUES
(1, '2024-12-01', 2, 500, 301, 101, 401),
(2, '2024-12-02', 3, 750, 302, 102, 402),
(3, '2024-12-03', 1, 200, 303, 103, 403),
(4, '2024-12-04', 4, 1000, 304, 104, 404),
(5, '2024-12-05', 2, 600, 305, 105, 405),
(6, '2024-12-06', 5, 1500, 306, 106, 406),
(7, '2024-12-07', 3, 900, 307, 107, 407),
(8, '2024-12-08', 6, 1800, 308, 108, 408),
(9, '2024-12-09', 1, 300, 309, 109, 409),
(10, '2024-12-10', 4, 1200, 310, 110, 410);
INSERT INTO bookings (Booking_ID, Booking_Date, Table_Number, Customer_ID, Staff_ID) VALUES
(1, '2024-12-01', 5, 101, 201),
(2, '2024-12-02', 3, 102, 202),
(3, '2024-12-03', 7, 103, 203),
(4, '2024-12-04', 4, 104, 204),
(5, '2024-12-05', 6, 105, 205),
(6, '2024-12-06', 2, 106, 206),
(7, '2024-12-07', 8, 107, 207),
(8, '2024-12-08', 1, 108, 208),
(9, '2024-12-09', 10, 109, 209),
(10, '2024-12-10', 9, 110, 210);

select * from bookings;