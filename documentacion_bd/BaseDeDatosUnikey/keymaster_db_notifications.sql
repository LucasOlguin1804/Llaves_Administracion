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
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `action_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-13 18:45:32'),(2,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-13 20:16:24'),(3,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-13 20:17:26'),(4,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 05:15:11'),(5,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:04:34'),(6,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:25:23'),(7,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:26:12'),(8,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:26:15'),(9,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:36:14'),(10,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:36:18'),(11,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:41:24'),(12,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:41:29'),(13,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:41:33'),(14,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:41:48'),(15,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:41:51'),(16,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:51:28'),(17,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:51:55'),(18,1,'Nueva solicitud de llave','El docente con ID 5 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 13:55:41'),(19,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 16:27:36'),(20,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 16:30:11'),(21,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 16:34:26'),(22,1,'Nueva solicitud de llave','El docente con ID 4 ha solicitado una llave.','key_request',0,NULL,'2025-05-14 16:35:53');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
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
