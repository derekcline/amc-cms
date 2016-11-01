-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: amc
-- ------------------------------------------------------
-- Server version	5.5.52-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grouping_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(25) NOT NULL,
  `display_name` tinytext NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `grouping_id` (`grouping_id`),
  CONSTRAINT `attribute_ibfk_1` FOREIGN KEY (`grouping_id`) REFERENCES `grouping` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
INSERT INTO `attribute` VALUES (1,1,'S','Small','A Small Mother Fucking TShirt'),(2,1,'M','Medium','A Medium Mother Fucking TShirt'),(3,1,'L','Large','A Large Mother Fucking TShirt'),(4,1,'XL','X-Large','A Extra Large Mother Fucking TShirt'),(5,2,'home','Home Phone','');
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grouping`
--

DROP TABLE IF EXISTS `grouping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grouping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `display_name` text NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grouping`
--

LOCK TABLES `grouping` WRITE;
/*!40000 ALTER TABLE `grouping` DISABLE KEYS */;
INSERT INTO `grouping` VALUES (1,'shirt_size','Shirt Size','Size of T Shirt'),(2,'phone','Phone Number','');
/*!40000 ALTER TABLE `grouping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grouping_attribute`
--

DROP TABLE IF EXISTS `grouping_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grouping_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grouping_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `grouping_id` (`grouping_id`),
  CONSTRAINT `grouping_attribute_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `grouping_attribute_ibfk_2` FOREIGN KEY (`grouping_id`) REFERENCES `grouping` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grouping_attribute`
--

LOCK TABLES `grouping_attribute` WRITE;
/*!40000 ALTER TABLE `grouping_attribute` DISABLE KEYS */;
INSERT INTO `grouping_attribute` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,5);
/*!40000 ALTER TABLE `grouping_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` tinytext NOT NULL,
  `middle_initial` tinytext,
  `last_name` tinytext NOT NULL,
  `user_name` tinytext NOT NULL,
  `password` tinytext NOT NULL,
  `email` tinytext,
  `phone` tinytext,
  `address` text,
  `city` text,
  `state` tinytext,
  `zip_code` tinytext,
  `join_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Erik','','Tank','skeletonkey','temp123!',NULL,NULL,NULL,NULL,NULL,NULL,'2016-10-22');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_attribute`
--

DROP TABLE IF EXISTS `user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `value` tinytext NOT NULL,
  `comment` text,
  `preferred` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_attribute_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_attribute_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attribute`
--

LOCK TABLES `user_attribute` WRITE;
/*!40000 ALTER TABLE `user_attribute` DISABLE KEYS */;
INSERT INTO `user_attribute` VALUES (1,1,4,'','',0),(2,1,5,'480-555-6666','',1);
/*!40000 ALTER TABLE `user_attribute` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-25 17:42:13
