-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customer` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(225) NOT NULL,
  `Last_Name` VARCHAR(225) NOT NULL,
  `Age` INT NOT NULL,
  `Mobile_Number` VARCHAR(225) NOT NULL,
  `Email` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 122
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `Booking_ID` INT NOT NULL AUTO_INCREMENT,
  `Booking_Date` DATE NULL DEFAULT NULL,
  `Table_Number` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `Customer_fk_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_fk`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `littlelemondb`.`customer` (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu` (
  `Menu_ID` INT NOT NULL,
  `Cuisines` VARCHAR(225) NOT NULL,
  `Starters` VARCHAR(225) NOT NULL,
  `Courses` VARCHAR(225) NOT NULL,
  `Drinks` VARCHAR(225) NOT NULL,
  `Desserts` VARCHAR(225) NOT NULL,
  `price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Menu_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`order_delivery_status` (
  `Delivery_ID` INT NOT NULL AUTO_INCREMENT,
  `Delivery_Date` DATETIME NOT NULL,
  `Status` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`Delivery_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 411
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_Date` DATETIME NOT NULL,
  `Quantity` INT NOT NULL,
  `Total_Cost` INT NOT NULL,
  `Menu_ID` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  `Deliver_ID` INT NOT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Customer_fk_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Menu_fk_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Delivery_fk_idx` (`Deliver_ID` ASC) VISIBLE,
  CONSTRAINT `Customer1_fk`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `littlelemondb`.`customer` (`Customer_ID`),
  CONSTRAINT `Delivery_fk`
    FOREIGN KEY (`Deliver_ID`)
    REFERENCES `littlelemondb`.`order_delivery_status` (`Delivery_ID`),
  CONSTRAINT `Menu_fk`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `littlelemondb`.`menu` (`Menu_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staff` (
  `Staff_ID` INT NOT NULL,
  `Role` VARCHAR(225) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `littlelemondb` ;

-- -----------------------------------------------------
-- Placeholder table for view `littlelemondb`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`ordersview` (`Order_ID` INT, `Quantity` INT, `Total_Cost` INT);

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(IN book_date DATE, IN table_n INT, IN cust_id INT)
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
            -- Insert the new booking
            INSERT INTO bookings (Booking_Date, Table_Number, Customer_ID)
            VALUES (book_date, table_n, cust_id);
            COMMIT;

            -- Return confirmation with details
            SELECT 'New Booking Added' AS Confirmation, table_n AS 'Table No', book_date AS 'Date', cust_id AS 'Customer ID',
                   CONCAT(customer.First_Name, ' ', customer.Last_Name) AS 'Customer Name'
					FROM customer WHERE customer.Customer_ID = cust_id;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddNewCustomer
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewCustomer`(
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
        SELECT LAST_INSERT_ID() AS New_Customer_ID, 'Added Successfully!' AS Message;
    ELSE
        -- Output a message if the customer already exists
        SELECT 'Customer already exists' AS Message;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Available_Tables
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Available_Tables`(IN date DATE)
BEGIN
		SELECT DISTINCT Table_Number AS Available_Tables FROM bookings
		WHERE Table_Number NOT IN (SELECT Table_Number
		FROM bookings WHERE Booking_Date = date)
		ORDER BY Table_Number ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Cancel_Booking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Cancel_Booking`(IN cust_id INT,IN b_date DATE)
BEGIN
    -- Check if the booking exists
    DECLARE booking_exists INT;
    
    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE Customer_ID = cust_id AND Booking_Date=b_date;

    IF booking_exists > 0 THEN
        -- If the booking exists, delete it
        DELETE FROM bookings
        WHERE Customer_ID = cust_id AND Booking_Date=b_date;

        -- Return success message
        SELECT CONCAT('Your Booking has been cancelled.') AS Status;
    ELSE
        -- If the booking does not exist, return an error message
        SELECT 'Booking not found.' AS Status;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBookings
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBookings`(IN B_Date DATE,IN Table_No INT)
BEGIN
DECLARE Count INT;

SELECT COUNT(*) INTO Count
FROM bookings
WHERE Booking_Date=B_Date AND Table_Number=Table_No;

IF Count>0 THEN SELECT CONCAT('Table ',Table_No,' is already booked') AS Booking_Status;
ELSE SELECT CONCAT('Table ',Table_No,' is available for booking') AS Booking_Status;

END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`Barath Kumar`@`%` PROCEDURE `GetMaxQuantity`()
SELECT max(Quantity) AS Maximum_Ordered_Quantity
FROM orders$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure NEW_ORDER
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `NEW_ORDER`(
    IN order_date DATE,
    IN cust_id INT,
    IN menu_id INT,
    IN quantity INT
)
BEGIN
    -- Declare variables
    DECLARE total_cost DECIMAL(10, 2);
    DECLARE new_delivery_id INT;

    -- Calculate total cost based on menu price
    SELECT price INTO total_cost
    FROM menu
    WHERE menu.menu_id = menu_id;
    
    -- Multiply the price by quantity to get the total cost
    SET total_cost = total_cost * quantity;

    -- Determine the new delivery ID
    SELECT IFNULL(MAX(delivery_id), 0) + 1 INTO new_delivery_id
    FROM orders;

    -- Insert the new order into the orders table
    INSERT INTO orders (order_date, quantity, total_cost, menu_id, customer_id, delivery_id)
    VALUES (order_date, quantity, total_cost, menu_id, cust_id, new_delivery_id);

    -- Return the ID of the newly created order
    SELECT LAST_INSERT_ID() AS new_order_id, new_delivery_id AS assigned_delivery_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Update_Booking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemondb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Booking`(
    IN old_date DATE,
    IN new_date DATE,
    IN cust_id INT,
    IN tab_no INT
)
BEGIN
    -- Declare variables
    DECLARE booking_exists INT;
    DECLARE check_booking INT;

    -- Check if the old booking exists for the customer
    SELECT COUNT(*) INTO booking_exists
    FROM bookings
    WHERE Booking_Date = old_date AND Customer_ID = cust_id;

    -- Check if the table is already booked for the new date
    SELECT COUNT(*) INTO check_booking
    FROM bookings
    WHERE Booking_Date = new_date AND Table_Number = tab_no;

    IF check_booking > 0 THEN
        -- If the table is already booked
        SELECT 'Table is already booked for the given date! Please select an available table.' AS Not_Confirm;
    ELSE
        IF booking_exists > 0 THEN
            -- Delete the old booking record
            DELETE FROM bookings
            WHERE Booking_Date = old_date AND Customer_ID = cust_id;

            -- Insert the new booking record
            INSERT INTO bookings (Booking_Date, Table_Number, Customer_ID)
            VALUES (new_date, tab_no, cust_id);

            -- Return success message
            SELECT CONCAT('Your booking has been successfully updated to ', new_date) AS Status;
        ELSE
            -- If the old booking does not exist
            SELECT 'Booking not found. Please check the details and try again.' AS Status;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `littlelemondb`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `littlelemondb`.`ordersview`;
USE `littlelemondb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`Barath Kumar`@`%` SQL SECURITY DEFINER VIEW `littlelemondb`.`ordersview` AS select `littlelemondb`.`orders`.`Order_ID` AS `Order_ID`,`littlelemondb`.`orders`.`Quantity` AS `Quantity`,`littlelemondb`.`orders`.`Total_Cost` AS `Total_Cost` from `littlelemondb`.`orders` where (`littlelemondb`.`orders`.`Quantity` > 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
