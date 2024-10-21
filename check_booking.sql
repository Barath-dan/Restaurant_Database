-- STORED PROCEDURE TO CHECK BOOKING STATUS OF A TABLE

DELIMITER //
CREATE PROCEDURE CheckBookings(IN B_Date DATE,IN Table_No INT)
BEGIN
DECLARE Count INT;

SELECT COUNT(*) INTO Count
FROM bookings
WHERE Booking_Date=B_Date AND Table_Number=Table_No;

IF Count>0 THEN SELECT CONCAT('Table ',Table_No,' is already booked') AS Booking_Status;
ELSE SELECT CONCAT('Table ',Table_No,' is available for booking') AS Booking_Status;

END IF;

END //

DELIMITER ;

-- CALLING THE PROCEDURE

CALL CheckBookings("2022-11-12", 3);
CALL CheckBookings("2024-11-12", 3)



