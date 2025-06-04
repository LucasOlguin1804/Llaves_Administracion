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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `primer_apellido` varchar(100) DEFAULT NULL,
  `segundo_apellido` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('administrador','docente') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,NULL,'LuisSant@est.univalle.edu','$2b$10$78IoHJFi/.uZElOq5plX..NYROy8SjTueoOX8zkeYZ0OkcjxWEE62','administrador','2025-04-23 16:59:34','2025-04-23 16:59:34'),(2,'Pedro','Galvez','Pereira','pedrito@gmail.com','$2b$10$aUlSVA6erUDA8BulA7URB.1hFtYEY8aLkqa/Mf0sE61OH95sryVpC','administrador','2025-04-28 02:41:52','2025-04-28 02:41:52'),(3,'Marlene','Aiza','Choque','marlene@gmail.com','$2b$10$gZ5o6R2lbc8mITXR0K7Ehu7EKNuMrsdysL63JVw1Jpq8EVP.wFvnC','docente','2025-04-28 04:13:00','2025-04-28 04:13:00'),(4,'Joel','Alanez','dURAN','joel@gmail.com','$2b$10$tmqj8xRkpUc.qkyiKHUogu6wIOGDQz9hSKbFRpMM5U.u.XtX/M2pO','docente','2025-04-28 04:25:05','2025-04-28 04:25:05'),(5,'luis','claros','TORRICO','luis@gmail.com','$2b$10$l9WzYl6P0NxpFjE3mV3nfujuYVUdcJVntIwgMd5FkNbQsUncIvWDC','docente','2025-04-28 05:17:36','2025-04-28 05:17:36'),(6,'Edson','flores','CONDORI','edson@gmail.com','$2b$10$M5JdMFYoNFDcNYXypZwhle3KDNrJC9un1Gllio6x.IlhfZ2/0XO1q','docente','2025-04-28 05:19:48','2025-04-28 05:19:48'),(7,'Saul Carlos','Peredo','','saul@gmail.com','$2b$10$4BPET9goXtICghO.j74bU.qK7/BQF2E/Ct34wFCCvqfVXI2zU0dtO','administrador','2025-04-28 06:08:59','2025-04-28 06:08:59'),(8,'jose','gordillo','pizarro','jose@gmail.com','$2b$10$/UgLz.7OT7h6/.w4KhcdV.sZw7iEsverysV.1QZJHmOFsEYq7/8pO','docente','2025-04-28 06:09:54','2025-04-28 06:09:54'),(9,'chris','flowers','herrera','adminsxd@est.univalle.edu','$2b$10$efJJ/pkRlF2v7AXmYzTGSemcCP67NryuGlnfKd2w2IrEg8rEj5QeC','administrador','2025-05-04 18:45:41','2025-05-04 18:45:41');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16  9:53:33
