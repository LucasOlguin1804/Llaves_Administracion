-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: keymaster_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_loans`
--

LOCK TABLES `external_loans` WRITE;
/*!40000 ALTER TABLE `external_loans` DISABLE KEYS */;
INSERT INTO `external_loans` VALUES (1,'chris','Personal de Mantenimiento',1,1,'2025-05-04 23:58:54','2025-05-05 02:10:00','2025-05-05 01:04:31',9,'devuelta'),(2,'christian','Invitado',2,10,'2025-05-05 00:01:00','2025-05-05 03:00:00','2025-05-05 01:04:47',9,'devuelta'),(3,'XDD','Invitado',2,10,'2025-05-05 01:20:04','2025-05-04 05:19:00','2025-05-05 01:20:11',9,'devuelta'),(4,'christian','Invitado',3,18,'2025-05-05 01:21:39','2025-05-05 01:21:00','2025-05-05 01:27:43',9,'devuelta'),(5,'erik','Personal de limpieza',3,18,'2025-05-05 01:46:59','2025-05-04 12:45:00','2025-05-05 01:47:17',9,'devuelta'),(6,'juli','Personal de Mantenimiento',3,18,'2025-05-05 03:10:54','2025-05-04 04:00:00','2025-05-05 03:11:01',9,'devuelta'),(7,'nose','Personal de Mantenimiento',4,19,'2025-05-05 04:02:00','2025-05-05 06:01:00','2025-05-05 04:02:04',9,'devuelta'),(8,'saas','Invitado',5,20,'2025-05-05 04:02:25','2025-05-05 06:02:16','2025-05-05 04:02:29',9,'devuelta'),(9,'as','Invitado',3,18,'2025-05-05 04:05:09','2025-05-05 06:05:01','2025-05-05 04:05:32',9,'devuelta'),(10,'SAA','Invitado',4,19,'2025-05-05 04:18:14','2025-05-05 06:18:08','2025-05-05 04:32:39',9,'devuelta'),(11,'xddd','Personal de Mantenimiento',5,20,'2025-05-05 04:24:54','2025-05-05 06:24:38','2025-05-05 04:32:32',9,'devuelta'),(12,'nuevo','Invitado',8,2,'2025-05-05 04:25:19','2025-05-05 06:25:10','2025-05-05 04:32:23',9,'devuelta'),(13,'noice','Otro',5,20,'2025-05-05 04:31:45','2025-05-05 06:31:35','2025-05-05 04:32:15',9,'devuelta'),(14,'xddd','Invitado',5,20,'2025-05-05 04:32:56','2025-05-05 06:32:50','2025-05-05 04:33:03',9,'devuelta'),(15,'jajaja','Invitado',7,22,'2025-05-05 04:39:16','2025-05-05 06:39:07','2025-05-05 04:39:24',9,'devuelta'),(16,'sasas','Personal de limpieza',3,18,'2025-05-05 04:39:39','2025-05-05 06:39:31','2025-05-05 05:03:32',9,'devuelta'),(17,'zzzzz','Otro',1,1,'2025-05-05 04:59:34','2025-05-05 05:02:00','2025-05-05 05:03:11',9,'devuelta'),(18,'dsfsdf','Invitado',7,22,'2025-05-05 05:07:18','2025-05-05 07:10:00','2025-05-05 05:12:40',9,'devuelta'),(19,'SAD','Invitado',7,22,'2025-05-05 05:08:43','2025-05-05 07:19:00','2025-05-05 05:12:48',9,'devuelta'),(20,'DASASDASD','Invitado',9,3,'2025-05-05 05:12:01','2025-05-05 07:15:00','2025-05-05 05:12:56',9,'devuelta'),(21,'sad','Invitado',5,20,'2025-05-05 05:22:43','2025-05-05 09:22:00','2025-05-05 05:22:51',9,'devuelta'),(22,'gfdfg','Invitado',7,22,'2025-05-05 05:26:52','2025-05-05 08:26:00','2025-05-05 05:26:56',9,'devuelta'),(23,'ghdfg','Invitado',8,2,'2025-05-05 05:30:10','2025-05-05 07:29:00','2025-05-05 05:30:14',9,'devuelta'),(24,'adasdas','Invitado',3,18,'2025-05-05 05:37:40','2025-05-05 10:37:00','2025-05-05 05:37:47',9,'devuelta'),(25,'sssss','Invitado',6,21,'2025-05-05 05:53:10','2025-05-05 05:54:00',NULL,9,'vencida'),(26,'starkiller','Invitado',8,2,'2025-05-05 05:58:54','2025-05-05 06:00:00','2025-05-05 05:59:15',9,'devuelta'),(27,'XDDD','Invitado',7,22,'2025-05-05 06:11:00','2025-05-05 06:12:00',NULL,9,'vencida'),(28,'jajaja','Invitado',6,21,'2025-05-05 06:17:21','2025-05-05 06:19:00',NULL,9,'vencida'),(29,'ASDASDSA','Invitado',7,22,'2025-05-05 06:38:33','2025-05-05 06:40:00','2025-05-05 06:38:46',9,'devuelta'),(30,'STAK','Invitado',7,22,'2025-05-05 06:41:02','2025-05-05 06:43:00','2025-05-05 06:43:32',9,'devuelta'),(31,'ASDAS','Invitado',7,22,'2025-05-05 06:44:29','2025-05-05 06:46:00',NULL,9,'vencida'),(32,'hhfghfg','Personal de limpieza',7,22,'2025-05-05 06:49:36','2025-05-05 06:51:00',NULL,9,'vencida'),(33,'sfgdfd','Invitado',7,22,'2025-05-05 06:51:45','2025-05-05 06:53:00','2025-05-05 06:51:53',9,'devuelta'),(34,'sdasdas','Invitado',7,22,'2025-05-05 06:56:58','2025-05-05 06:58:00','2025-05-05 07:01:50',9,'vencida'),(35,'ADMIN','Invitado',7,22,'2025-05-05 07:02:41','2025-05-05 07:04:00','2025-05-05 07:02:50',9,'devuelta');
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

-- Dump completed on 2025-05-05  3:20:39
