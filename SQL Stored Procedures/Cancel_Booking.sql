-- STORED PROCEDURE FOR BOOKING CANCELLATION
DROP PROCEDURE Cancel_Booking

DELIMITER //

CREATE PROCEDURE Cancel_Booking(IN book_id INT, IN cust_id INT)
BEGIN
    -- Check if the booking exists
    DECLARE booking_exists INT;
    
    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE Booking_ID = book_id AND Customer_ID = cust_id;

    IF booking_exists > 0 THEN
        -- If the booking exists, delete it
        DELETE FROM bookings
        WHERE Booking_ID = book_id AND Customer_ID = cust_id;

        -- Return success message
        SELECT CONCAT('Booking ', book_id, ' has been cancelled') AS Status;
    ELSE
        -- If the booking does not exist, return an error message
        SELECT 'Booking not found or not associated with the customer.' AS Status;
    END IF;
END //

DELIMITER ;

CALL Cancel_Booking(14,101) ;