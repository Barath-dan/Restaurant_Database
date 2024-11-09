-- STORED PROCEDURE FOR UPDATING BOOKING DATE

DELIMITER //
CREATE PROCEDURE Update_Booking(IN book_id INT,IN New_Date DATE)
BEGIN
UPDATE bookings SET Booking_Date=New_Date
WHERE Booking_ID=book_id;

SELECT CONCAT('Booking ID ', book_id, ' has been updated to ', New_Date) AS Status;
END //
DELIMITER ;

CALL update_Booking(20,'2022-10-15') ;

