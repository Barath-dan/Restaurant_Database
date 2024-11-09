-- TRANSACTIONS AND STORED PROCEDURE TO ADD A TABLE BOOKING
DROP PROCEDURE AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(IN book_date DATE,IN table_n INT,IN cust_id INT, IN staff_ID INT)
BEGIN
DECLARE check_booking INT;

SELECT COUNT(*) INTO check_booking
FROM bookings
WHERE Booking_Date=book_date AND Table_Number=table_n;

IF check_booking>0 THEN
rollback;
SELECT 'Table is already booked' AS Not_Confirm;
ELSE
INSERT INTO bookings (Booking_Date, Table_Number, Customer_ID, Staff_ID)
VALUES (book_date, table_n, cust_id, staff_ID);
COMMIT;
SELECT 'New Booking Added' AS Confirmation, table_n AS 'Table No',book_date AS 'Date', cust_id AS 'Customer ID', 
CONCAT(customer.First_Name,' ',customer.Last_Name) AS 'Customer Name'
FROM customer WHERE customer.Customer_ID=cust_ID;       
END IF;
END //

DELIMITER ;

CALL AddBooking('2024-6-16', 2,1,2);
        
