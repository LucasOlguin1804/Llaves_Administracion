-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: keymaster_db
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
-- Table structure for table `external_loans`
--

DROP TABLE IF EXISTS `external_loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_loans` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `person_name` varchar(100) NOT NULL,
  `tipo_persona` enum('Personal de Mantenimiento','Personal de limpieza','Invitado','Otro') DEFAULT NULL,
  `classroom_id` int NOT NULL,
  `key_id` int NOT NULL,
  `loan_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expected_return_time` timestamp NULL DEFAULT NULL,
  `actual_return_time` timestamp NULL DEFAULT NULL,
  `registered_by` int NOT NULL,
  `estado` enum('prestada','devuelta','vencida') DEFAULT 'prestada',
  PRIMARY KEY (`loan_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `key_id` (`key_id`),
  KEY `registered_by` (`registered_by`),
  CONSTRAINT `external_loans_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`),
  CONSTRAINT `external_loans_ibfk_2` FOREIGN KEY (`key_id`) REFERENCES `key_aula` (`key_id`),
  CONSTRAINT `external_loans_ibfk_3` FOREIGN KEY (`registered_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_loans`
--

LOCK TABLES `external_loans` WRITE;
/*!40000 ALTER TABLE `external_loans` DISABLE KEYS */;
INSERT INTO `external_loans` VALUES (36,'Carla C','Personal de limpieza',2,2,'2025-05-13 17:41:20','2025-05-13 19:41:10','2025-05-13 17:41:28',7,'devuelta'),(37,'Kevin Prieto','Invitado',15,15,'2025-05-13 17:44:35','2025-05-13 18:44:00','2025-05-13 17:44:42',7,'devuelta'),(38,'cdf','Personal de limpieza',10,10,'2025-05-14 05:01:43','2025-05-14 07:01:35','2025-05-14 05:01:47',7,'devuelta'),(39,'Marta A','Personal de limpieza',10,10,'2025-05-14 16:29:36','2025-05-14 18:29:30','2025-05-14 16:29:40',7,'devuelta'),(40,'Carla C','Personal de limpieza',10,10,'2025-05-14 16:44:10','2025-05-14 18:42:44','2025-05-14 16:44:14',7,'devuelta');
/*!40000 ALTER TABLE `external_loans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16  9:53:34
