DROP PROCEDURE AddNewCustomer
DELIMITER //
CREATE PROCEDURE AddNewCustomer(
    IN p_First_Name VARCHAR(225),
    IN p_Last_Name VARCHAR(225),
    IN p_Age INT,
    IN p_Mobile_Number VARCHAR(225),
    IN p_Email VARCHAR(225)
)
BEGIN
    DECLARE customer_exists INT;

    -- Check if customer with the given mobile number already exists
    SELECT COUNT(*) INTO customer_exists
    FROM customer
    WHERE Mobile_Number = p_Mobile_Number;

    -- If customer does not exist, insert a new record
    IF customer_exists = 0 THEN
        INSERT INTO customer (First_Name, Last_Name, Age, Mobile_Number, Email)
        VALUES (p_First_Name, p_Last_Name, p_Age, p_Mobile_Number, p_Email);
        SELECT LAST_INSERT_ID() AS New_Customer_ID, 'Created' AS Status;
    ELSE
        -- Output a message if the customer already exists
        SELECT 'Customer already exists' AS Message;
    END IF;
END //
DELIMITER ;

CALL AddNewCustomer('Alice', 'Smith', 28, '1112223333', 'alice.smith@xyz.com');
CALL AddNewCustomer('Alice', 'Smith', 28, '1112223343', 'alice.smith@xyz.com');
CALL AddNewCustomer('Harry', 'Smith', 28, '1112223303', 'alice.smith@xyz.com');
