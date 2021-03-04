-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: ocpizzadb
-- ------------------------------------------------------
-- Server version	5.7.32

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `additional` varchar(100) DEFAULT NULL,
  `number` varchar(10) NOT NULL,
  `street_name` varchar(45) NOT NULL,
  `zip` varchar(5) NOT NULL,
  `city` varchar(45) NOT NULL,
  `observation` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Mas Roca','12','rue Lucie Bartre','66000','Perpignan',NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande_line`
--

DROP TABLE IF EXISTS `commande_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commande_line` (
  `product_id` int(10) unsigned NOT NULL,
  `order_order_number` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`order_order_number`),
  KEY `fk_product_has_order_order1_idx` (`order_order_number`),
  KEY `fk_product_has_order_product1_idx` (`product_id`),
  CONSTRAINT `fk_product_has_order_order1` FOREIGN KEY (`order_order_number`) REFERENCES `order` (`order_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande_line`
--

LOCK TABLES `commande_line` WRITE;
/*!40000 ALTER TABLE `commande_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `commande_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` int(10) unsigned NOT NULL,
  `favorite_payment_type` enum('Cash','Check','RestaurantTicket','CreditCard') DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_customer_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'CreditCard');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `function` enum('Pizzaiolo','DeliveryMan','Manager','Director','Cashier') NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_employee_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `number` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `payed` tinyint(4) NOT NULL,
  `customer_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`number`),
  KEY `fk_invoice_customer1_idx` (`customer_user_id`),
  CONSTRAINT `fk_invoice_customer1` FOREIGN KEY (`customer_user_id`) REFERENCES `customer` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,'2021-02-05',0,1);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_number` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('Pending','BeingPrepared','Prepared','InDelivering','Delivered','Completed') NOT NULL,
  `date` datetime NOT NULL,
  `invoice_number` int(10) unsigned NOT NULL,
  `payment_id` int(10) unsigned NOT NULL,
  `customer_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`order_number`,`payment_id`),
  KEY `fk_order_invoice1_idx` (`invoice_number`),
  KEY `fk_order_payment1_idx` (`payment_id`),
  KEY `fk_order_customer1_idx` (`customer_user_id`),
  CONSTRAINT `fk_order_customer1` FOREIGN KEY (`customer_user_id`) REFERENCES `customer` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_invoice1` FOREIGN KEY (`invoice_number`) REFERENCES `invoice` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_payment1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'Prepared','2021-02-04 10:20:34',1,1,1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_type` enum('Cash','Check','RestaurantTicket','CreditCard') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'CreditCard');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzeria`
--

DROP TABLE IF EXISTS `pizzeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzeria` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `corporate_name` varchar(45) NOT NULL,
  `phone_number` int(10) NOT NULL,
  `is_open` tinyint(4) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`address_id`),
  KEY `fk_pizzeria_address1_idx` (`address_id`),
  CONSTRAINT `fk_pizzeria_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzeria`
--

LOCK TABLES `pizzeria` WRITE;
/*!40000 ALTER TABLE `pizzeria` DISABLE KEYS */;
/*!40000 ALTER TABLE `pizzeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `experition_date` date DEFAULT NULL,
  `recipe` longtext,
  `category` enum('Pizza','Drink','Dessert') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Ortolana',5,7.99,NULL,'Ingredients\n\n1 batch of pizza dough\n400 ml – 13.5 oz. tomato purée\n2 tbsp extra virgin olive oil\n1 tbsp oregano\nSalt to taste\n350 gms – 12.5 oz. bocconcini or fresh mozzarella (half sliced and half shredded)\n2 red bell peppers roasted, skinned and sliced\n12 slices eggplant roasted\n7 artichoke hearts marinated in oil, quartered\nExtra virgin olive oil\nBasil\n\nInstructions\n\nMake the pizza dough as per this recipe and keep it to rise.\nWhile the dough rests, prepare the toppings: slice and shred the mozzarella.\nPrepare the tomato base by mixing the tomato purée with the extra virgin olive oil, oregano and salt to taste.\n\nWhen the pizza dough is ready, divide it in 4 smaller balls and roll them with a rolling pin into 4 circles approximately 0.5 cm – ¼ inch thick.\nNow spread the tomato base on the pizza and bake in a preheated fan forced oven at 180°C – 355°F for 15 minutes.\nTake them out of the oven and put the mozzarella, eggplant, bell peppers and artichoke hearts on the top. Put back in the oven for 5 minutes to let the cheese melt.\n\nWhen ready, take the pizze out of the oven and drizzle with some extra virgin olive oil.\nDecorate with fresh basil leaves, cut and enjoy warm!','Pizza');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `pizzeria_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `list` longtext,
  PRIMARY KEY (`pizzeria_id`,`product_id`),
  KEY `fk_pizzeria_has_product_product1_idx` (`product_id`),
  KEY `fk_pizzeria_has_product_pizzeria1_idx` (`pizzeria_id`),
  CONSTRAINT `fk_pizzeria_has_product_pizzeria1` FOREIGN KEY (`pizzeria_id`) REFERENCES `pizzeria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzeria_has_product_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `phone_number` int(10) unsigned NOT NULL,
  `is_logged` tinyint(4) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_id` int(10) unsigned NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`address_id`),
  KEY `fk_user_address1_idx` (`address_id`),
  CONSTRAINT `fk_user_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Sebastien','Kothe',614722442,0,'sebastien.kothe@icloud.com',1,'sebastienkothe','OCperpignan66');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-05 16:27:26
