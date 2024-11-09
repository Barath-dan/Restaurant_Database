-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `Booking_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_Date` datetime NOT NULL,
  `Table_Number` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Staff_ID` int NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `Customer_fk_idx` (`Customer_ID`),
  KEY `Staff_fk_idx` (`Staff_ID`),
  CONSTRAINT `Customer_fk` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`),
  CONSTRAINT `Staff_fk` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (11,'2022-10-10 00:00:00',5,1,1),(12,'2022-11-12 00:00:00',3,3,2),(13,'2022-10-11 00:00:00',2,2,3),(14,'2022-10-13 00:00:00',2,4,4),(15,'2024-10-10 00:00:00',5,1,1),(16,'2024-11-12 00:00:00',3,3,2),(17,'2024-10-11 00:00:00',2,2,3),(18,'2024-10-13 00:00:00',2,4,4),(19,'2024-12-01 00:00:00',3,2,2),(21,'2024-10-14 00:00:00',2,2,2),(22,'2024-11-14 00:00:00',2,2,2),(23,'2024-08-14 00:00:00',2,2,2),(24,'2024-07-14 00:00:00',2,2,2),(25,'2024-06-14 00:00:00',2,1,2),(26,'2024-06-16 00:00:00',2,1,2),(27,'2024-11-01 00:00:00',3,2,2),(28,'2024-10-13 00:00:00',2,2,2),(29,'2024-11-01 00:00:00',3,2,2),(30,'2024-11-13 00:00:00',2,2,2);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(225) NOT NULL,
  `Last_Name` varchar(225) NOT NULL,
  `Age` int NOT NULL,
  `Mobile_Number` varchar(225) NOT NULL,
  `Email` varchar(225) NOT NULL,
  PRIMARY KEY (`Customer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Alice','Smith',28,'1112223333','alice.smith@xyz.com'),(2,'Bob','Johnson',35,'2223334444','bob.johnson@xyz.com'),(3,'Carol','Davis',22,'3334445555','carol.davis@xyz.com'),(4,'David','Martinez',40,'4445556666','david.martinez@xyz.com'),(5,'Eve','Wilson',31,'5556667777','eve.wilson@xyz.com'),(6,'Alice','Smith',28,'1112223343','alice.smith@xyz.com'),(7,'Hello','Smith',28,'1112223383','alice.smith@xyz.com'),(8,'Harry','Smith',28,'1112223393','alice.smith@xyz.com'),(9,'Harry','Smith',28,'1112223303','alice.smith@xyz.com'),(10,'Harry','Smith',28,'1112225673','alice.smith@xyz.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `Menu_ID` int NOT NULL,
  `Cuisines` varchar(225) NOT NULL,
  `Starters` varchar(225) NOT NULL,
  `Courses` varchar(225) NOT NULL,
  `Drinks` varchar(225) NOT NULL,
  `Desserts` varchar(225) NOT NULL,
  PRIMARY KEY (`Menu_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_delivery_status`
--

DROP TABLE IF EXISTS `order_delivery_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_delivery_status` (
  `Delivery_ID` int NOT NULL AUTO_INCREMENT,
  `Delivery_Date` datetime NOT NULL,
  `Status` varchar(225) NOT NULL,
  PRIMARY KEY (`Delivery_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_delivery_status`
--

LOCK TABLES `order_delivery_status` WRITE;
/*!40000 ALTER TABLE `order_delivery_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_delivery_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Order_Date` datetime NOT NULL,
  `Quantity` int NOT NULL,
  `Total_Cost` int NOT NULL,
  `Menu_ID` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Deliver_ID` int NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Customer_fk_idx` (`Customer_ID`),
  KEY `Menu_fk_idx` (`Menu_ID`),
  KEY `Delivery_fk_idx` (`Deliver_ID`),
  CONSTRAINT `Customer1_fk` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`),
  CONSTRAINT `Delivery_fk` FOREIGN KEY (`Deliver_ID`) REFERENCES `order_delivery_status` (`Delivery_ID`),
  CONSTRAINT `Menu_fk` FOREIGN KEY (`Menu_ID`) REFERENCES `menu` (`Menu_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ordersview`
--

DROP TABLE IF EXISTS `ordersview`;
/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview` AS SELECT 
 1 AS `Order_ID`,
 1 AS `Quantity`,
 1 AS `Total_Cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `Staff_ID` int NOT NULL,
  `Role` varchar(225) NOT NULL,
  `Salary` int NOT NULL,
  PRIMARY KEY (`Staff_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Manager',22000),(2,'Waiter',35000),(3,'Bartender',28000),(4,'Chef',22000),(5,'Waiter',25000);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `ordersview`
--

/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Barath Kumar`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview` AS select `orders`.`Order_ID` AS `Order_ID`,`orders`.`Quantity` AS `Quantity`,`orders`.`Total_Cost` AS `Total_Cost` from `orders` where (`orders`.`Quantity` > 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-09 12:11:49
