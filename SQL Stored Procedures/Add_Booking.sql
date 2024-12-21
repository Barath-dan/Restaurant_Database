DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //

CREATE PROCEDURE AddBooking(IN book_date DATE, IN table_n INT, IN cust_id INT, IN staff_ID INT)
BEGIN
    DECLARE check_booking INT;
    DECLARE check_customer INT;

    -- Check if the Customer_ID exists
    SELECT COUNT(*) INTO check_customer
    FROM customer
    WHERE Customer_ID = cust_id;

    IF check_customer = 0 THEN
        -- If Customer_ID is not found, display the message
        SELECT 'Customer data not found! Please register first.' AS Error_Message;
    ELSE
        -- Check if the table is already booked
        SELECT COUNT(*) INTO check_booking
        FROM bookings
        WHERE Booking_Date = book_date AND Table_Number = table_n;

        IF check_booking > 0 THEN
            -- If the table is already booked, rollback
            ROLLBACK;
            SELECT 'Table is already booked for the given date! Please select an available table from Available Table option.' AS Not_Confirm;
        ELSE
            -- If table is available, insert new booking
            INSERT INTO bookings (Booking_Date, Table_Number, Customer_ID, Staff_ID)
            VALUES (book_date, table_n, cust_id, staff_ID);
            COMMIT;
            
            SELECT 'New Booking Added' AS Confirmation, table_n AS 'Table No', book_date AS 'Date', cust_id AS 'Customer ID',
                   CONCAT(customer.First_Name, ' ', customer.Last_Name) AS 'Customer Name'
            FROM customer WHERE customer.Customer_ID = cust_id;
        END IF;
    END IF;
END //

DELIMITER ;

CALL AddBooking('2024-12-10', 9, 101, 202);