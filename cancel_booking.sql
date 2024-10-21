-- STORED PROCEDURE FOR BOOKING CANCELLATION

DELIMITER //
CREATE PROCEDURE Cancel_Booking(IN book_id INT)
BEGIN
DELETE FROM bookings 
WHERE Booking_ID=book_id;

SELECT CONCAT('Booking ', book_id, ' has been cancelled') AS Status;
END //
DELIMITER ;

CALL Cancel_Booking(20) ;

