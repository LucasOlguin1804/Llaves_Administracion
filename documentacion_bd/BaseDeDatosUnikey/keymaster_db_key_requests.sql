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
-- Table structure for table `key_requests`
--

DROP TABLE IF EXISTS `key_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `key_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `classroom_id` int NOT NULL,
  `schedule_id` int DEFAULT NULL,
  `needs_data_control` tinyint(1) DEFAULT '0',
  `estado` varchar(20) DEFAULT NULL,
  `request_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `approval_time` timestamp NULL DEFAULT NULL,
  `return_time` timestamp NULL DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`request_id`),
  KEY `user_id` (`user_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `approved_by` (`approved_by`),
  CONSTRAINT `key_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `key_requests_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`),
  CONSTRAINT `key_requests_ibfk_3` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`),
  CONSTRAINT `key_requests_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_requests`
--

LOCK TABLES `key_requests` WRITE;
/*!40000 ALTER TABLE `key_requests` DISABLE KEYS */;
INSERT INTO `key_requests` VALUES (1,4,9,7,0,'completed','2025-05-13 18:44:03','2025-05-14 12:50:48','2025-05-14 12:50:53',7,''),(2,4,9,7,0,'completed','2025-05-13 18:45:32','2025-05-14 12:50:47','2025-05-14 12:50:50',7,''),(3,4,9,7,0,'completed','2025-05-13 20:16:24','2025-05-14 12:50:22','2025-05-14 12:50:34',7,''),(4,4,9,7,1,'completed','2025-05-13 20:17:26','2025-05-13 20:33:56','2025-05-13 20:34:12',7,''),(5,7,14,10,0,'completed','2025-05-14 05:06:39','2025-05-14 05:06:39','2025-05-14 05:12:47',7,''),(6,7,14,10,0,'completed','2025-05-14 05:07:47','2025-05-14 05:07:47','2025-05-14 05:12:27',7,''),(7,5,20,43,0,'completed','2025-05-14 05:15:11','2025-05-14 05:15:35','2025-05-14 05:15:48',7,''),(8,4,14,10,0,'completed','2025-05-14 13:04:34','2025-05-14 13:04:53','2025-05-14 13:05:06',7,''),(9,4,14,10,0,'completed','2025-05-14 13:25:23','2025-05-14 13:25:41','2025-05-14 13:25:47',7,''),(10,5,9,40,0,'completed','2025-05-14 13:26:12','2025-05-14 13:28:56','2025-05-14 13:28:57',7,''),(11,5,7,49,0,'completed','2025-05-14 13:26:15','2025-05-14 13:26:31','2025-05-14 13:26:47',7,''),(12,4,9,7,0,'completed','2025-05-14 13:36:14','2025-05-14 13:38:11','2025-05-14 13:41:05',7,''),(13,4,14,11,0,'completed','2025-05-14 13:36:18','2025-05-14 13:40:58','2025-05-14 13:41:04',7,''),(14,4,10,16,0,'completed','2025-05-14 13:41:24','2025-05-14 13:42:22','2025-05-14 13:42:44',7,''),(15,4,14,11,0,'completed','2025-05-14 13:41:29','2025-05-14 13:57:06','2025-05-14 13:57:14',7,''),(16,4,14,10,0,'completed','2025-05-14 13:41:33','2025-05-14 13:42:10','2025-05-14 13:42:50',7,''),(17,5,20,43,0,'completed','2025-05-14 13:41:48','2025-05-14 13:42:33','2025-05-14 13:42:47',7,''),(18,5,20,47,0,'completed','2025-05-14 13:41:51','2025-05-14 13:42:19','2025-05-14 13:43:10',7,''),(19,5,20,43,0,'completed','2025-05-14 13:51:28','2025-05-14 13:53:29','2025-05-14 13:56:00',7,''),(20,4,14,10,0,'completed','2025-05-14 13:51:55','2025-05-14 13:57:28','2025-05-14 13:57:46',7,''),(21,7,14,10,0,'completed','2025-05-14 13:53:42','2025-05-14 13:53:42','2025-05-14 13:56:17',7,'Prestado manualmente'),(22,5,9,40,0,'completed','2025-05-14 13:55:41','2025-05-14 13:57:31','2025-05-14 13:58:02',7,''),(23,7,14,10,0,'completed','2025-05-14 13:56:36','2025-05-14 13:56:36','2025-05-14 13:57:11',7,'Prestado manualmente'),(24,7,9,76,0,'completed','2025-05-14 13:56:51','2025-05-14 13:56:51','2025-05-14 13:57:26',7,'Prestado manualmente'),(25,7,14,10,0,'completed','2025-05-14 16:26:39','2025-05-14 16:26:39','2025-05-14 16:26:41',7,'Prestado manualmente'),(26,4,14,10,0,'completed','2025-05-14 16:27:36','2025-05-14 16:27:49','2025-05-14 16:29:22',7,''),(27,4,14,10,0,'completed','2025-05-14 16:30:11','2025-05-14 16:33:33','2025-05-14 16:33:36',7,''),(28,7,14,10,0,'completed','2025-05-14 16:33:08','2025-05-14 16:33:08','2025-05-14 16:33:28',7,'Prestado manualmente'),(29,4,14,10,0,'completed','2025-05-14 16:34:26','2025-05-14 16:35:41','2025-05-14 16:38:04',7,''),(30,4,14,10,0,'completed','2025-05-14 16:35:53','2025-05-14 16:36:41','2025-05-14 16:38:01',7,''),(31,7,14,10,0,'completed','2025-05-14 16:39:08','2025-05-14 16:39:08','2025-05-14 16:41:46',7,'Prestado manualmente');
/*!40000 ALTER TABLE `key_requests` ENABLE KEYS */;
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
