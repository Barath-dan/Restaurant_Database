DROP PROCEDURE IF EXISTS Available_Tables ;
DELIMITER //

CREATE PROCEDURE Available_Tables(IN date DATE)
BEGIN
		SELECT DISTINCT Table_Number AS Available_Tables FROM bookings
		WHERE Table_Number NOT IN (SELECT Table_Number
		FROM bookings WHERE Booking_Date = date)
		ORDER BY Table_Number ASC;
END //

DELIMITER ;


CALL Available_Tables('2024-12-10')