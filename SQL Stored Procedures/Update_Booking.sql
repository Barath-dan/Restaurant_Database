DROP PROCEDURE Update_Booking;

DELIMITER $$

CREATE PROCEDURE `Update_Booking`(IN book_id INT, IN New_Date DATE)
BEGIN
    -- Check if the booking exists
    DECLARE booking_exists INT;

    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE Booking_ID = book_id;

    IF booking_exists > 0 THEN
        -- If the booking exists, update the booking date
        UPDATE bookings 
        SET Booking_Date = New_Date
        WHERE Booking_ID = book_id;

        -- Return success message
        SELECT CONCAT('Booking ID ', book_id, ' has been updated to ', New_Date) AS Status;
    ELSE
        -- If the booking does not exist, return an error message
        SELECT 'Booking not found.' AS Status;
    END IF;
END $$

DELIMITER ;
