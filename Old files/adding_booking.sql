-- TRANSACTIONS AND STORED PROCEDURE TO CHECK IF A TABLE IS ALREADY BOOKED AND ADDING THE BOOKING DETAILS IF TABLE IS NOT BOOKED

DELIMITER //
CREATE PROCEDURE Add_Valid_Booking(IN Book_ID INT, IN book_date DATE, Table_No INT,Cust_ID INT,Stf_ID INT)
BEGIN
DECLARE Check_Booking INT;

SELECT COUNT(*) INTO Check_Booking
FROM bookings
WHERE Booking_Date=book_date AND Table_Number=Table_No;

IF Check_Booking>0 THEN
ROLLBACK;
SELECT CONCAT('Table ',Table_No,' is already booked-Booking cancelled') AS Status;
ELSE
INSERT INTO bookings (Booking_ID, Booking_Date, Table_Number, Customer_ID, Staff_ID)
        VALUES (Book_ID, book_date, Table_No, Cust_ID, Stf_ID);
COMMIT;
SELECT 'Booking Successful' AS Status;        
END IF;
END //

DELIMITER ;

CALL Add_Valid_Booking(17,'2022-12-01', 3,2,2);
CALL Add_Valid_Booking(19,'2022-10-13', 2,2,2);


