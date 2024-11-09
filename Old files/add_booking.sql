-- TRANSACTIONS AND STORED PROCEDURE TO ADD A TABLE BOOKING
DELIMITER //
CREATE PROCEDURE AddBooking(IN book_id INT,IN book_date DATE,IN table_n INT,IN cust_id INT, IN staff_ID INT)
BEGIN
DECLARE check_booking INT;

SELECT COUNT(*) INTO check_booking
FROM bookings
WHERE Booking_Date=book_date AND Table_Number=table_n;

IF check_booking>0 THEN
rollback;
SELECT 'Table is already booked' AS Not_Confirm;
ELSE
INSERT INTO bookings (Booking_ID, Booking_Date, Table_Number, Customer_ID, Staff_ID)
VALUES (book_id, book_date, table_n, cust_id, staff_ID);
COMMIT;
SELECT 'New Booking Added' AS Confirmation;        
END IF;
END //

DELIMITER ;

CALL AddBooking(20,'2022-10-14', 2,2,2);
        
