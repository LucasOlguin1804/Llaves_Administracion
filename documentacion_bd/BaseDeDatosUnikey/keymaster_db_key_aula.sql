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
-- Table structure for table `key_aula`
--

DROP TABLE IF EXISTS `key_aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `key_aula` (
  `key_id` int NOT NULL AUTO_INCREMENT,
  `classroom_id` int NOT NULL,
  `estado` enum('disponible','prestada','perdida','mantenimiento') DEFAULT 'disponible',
  `has_data_control` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key_id`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `key_aula_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_aula`
--

LOCK TABLES `key_aula` WRITE;
/*!40000 ALTER TABLE `key_aula` DISABLE KEYS */;
INSERT INTO `key_aula` VALUES (1,1,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(2,2,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(3,3,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(4,4,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(5,5,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(6,6,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(7,7,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(8,8,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(9,9,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(10,10,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(11,11,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(12,12,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(13,13,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(14,14,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(15,15,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(16,16,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(17,17,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(18,18,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(19,19,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(20,20,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(21,21,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28'),(22,22,'disponible',0,'2025-05-13 17:17:28','2025-05-13 17:17:28');
/*!40000 ALTER TABLE `key_aula` ENABLE KEYS */;
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
