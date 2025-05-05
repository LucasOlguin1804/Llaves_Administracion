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
-- Table structure for table `access_logs`
--

DROP TABLE IF EXISTS `access_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `key_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `external_loan_id` int DEFAULT NULL,
  `accion` enum('prestada','devuelta') NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`log_id`),
  KEY `key_id` (`key_id`),
  KEY `user_id` (`user_id`),
  KEY `external_loan_id` (`external_loan_id`),
  CONSTRAINT `access_logs_ibfk_1` FOREIGN KEY (`key_id`) REFERENCES `key_aula` (`key_id`),
  CONSTRAINT `access_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `access_logs_ibfk_3` FOREIGN KEY (`external_loan_id`) REFERENCES `external_loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_logs`
--

LOCK TABLES `access_logs` WRITE;
/*!40000 ALTER TABLE `access_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buildings` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buildings`
--

LOCK TABLES `buildings` WRITE;
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
INSERT INTO `buildings` VALUES (1,'Facultad de Informática y Electrónica','2025-04-25 06:34:43','2025-04-25 06:34:43');
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classrooms` (
  `classroom_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `number` varchar(20) NOT NULL,
  `capacity` int DEFAULT NULL,
  `has_projector` tinyint(1) DEFAULT '0',
  `has_computers` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`classroom_id`),
  UNIQUE KEY `building_id` (`building_id`,`number`),
  CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,1,'T-1',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(2,1,'T-2',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(3,1,'T-3',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(4,1,'T-4',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(5,1,'T-5',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(6,1,'T-6',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(7,1,'T-7',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(8,1,'T-103',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(9,1,'T-105',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(10,1,'T-106',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(11,1,'T-107',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(12,1,'T-108',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(13,1,'T-109',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(14,1,'T-110',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(15,1,'T-111',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(16,1,'T-202',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(17,1,'T-203',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(18,1,'T-204',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(19,1,'T-205',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(20,1,'T-206',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(21,1,'T-208',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25'),(22,1,'T-209',30,0,0,'2025-04-25 06:47:25','2025-04-25 06:47:25');
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docentes`
--

DROP TABLE IF EXISTS `docentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docentes` (
  `docente_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `primer_apellido` varchar(100) DEFAULT NULL,
  `segundo_apellido` varchar(100) DEFAULT NULL,
  `nombre_completo_formateado` varchar(250) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`docente_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `docentes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
INSERT INTO `docentes` VALUES (1,NULL,'MARLENE','AIZA','CHOQUE','AIZA CHOQUE MARLENE',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(2,4,'JOEL','ALANEZ','DURAN','ALANEZ DURAN JOEL','joel@gmail.com','2025-04-28 04:10:27','2025-04-28 04:25:05'),(3,NULL,'BENJAMIN','BUITRAGO','CONDE','BUITRAGO CONDE BENJAMIN',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(4,NULL,'ERICK','CESPEDES','GAMARRA','CESPEDES GAMARRA ERICK',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(5,5,'LUIS','CLAROS','TORRICO','CLAROS TORRICO LUIS','luis@gmail.com','2025-04-28 04:10:27','2025-04-28 05:17:36'),(6,NULL,'EVER','CONDORI','TORRICO','CONDORI TORRICO EVER',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(7,NULL,'OSCAR','CONTRERAS','CARRASCO','CONTRERAS CARRASCO OSCAR',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(8,NULL,'ANGEL','ESCALERA','CRUZ','ESCALERA CRUZ ANGEL',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(9,6,'EDSON','FLORES','CONDORI','FLORES CONDORI EDSON','edson@gmail.com','2025-04-28 04:10:27','2025-04-28 05:19:48'),(10,NULL,'MAGALY','GOMEZ','UGARTE','GOMEZ UGARTE MAGALY',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(11,8,'JOSE','GORDILLO','PIZARRO','GORDILLO PIZARRO JOSE','jose@gmail.com','2025-04-28 04:10:27','2025-04-28 06:09:54'),(12,NULL,'PABLO','GUZMAN','MORALES','GUZMAN MORALES PABLO',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(13,NULL,'LIZBETH','JARAMILLO','MARTINEZ','JARAMILLO MARTINEZ LIZBETH',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(14,NULL,'JOAQUIN','JUSTINIANO','ZABALA','JUSTINIANO ZABALA JOAQUIN',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(15,NULL,'JANNETH','MEDINA','ALEMAN','MEDINA ALEMAN JANNETH',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(16,NULL,'NIBETH','MENA','MAMANI','MENA MAMANI NIBETH',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(17,NULL,'JOSE','MENDOZA','CLAROS','MENDOZA CLAROS JOSE',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(18,NULL,'CHRISTIAN','MONTANO','SALVATIERRA','MONTANO SALVATIERRA CHRISTIAN',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(19,NULL,'XIMENA','MORALES','JIMENEZ','MORALES JIMENEZ XIMENA',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(20,NULL,'CESAR','NOGALES','CAERO','NOGALES CAERO CESAR',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(21,NULL,'ZULMA','OLMOS','FORONDA','OLMOS FORONDA ZULMA',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(22,NULL,'GUIDO','PEREZ','MALLO','PEREZ MALLO GUIDO',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(23,NULL,'RAMIRO','RAMALLO','ROCHA','RAMALLO ROCHA RAMIRO',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(24,NULL,'CECILIA','REYES','TRIGO','REYES TRIGO CECILIA',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(25,NULL,'GASTON','SILVA','SANCHEZ','SILVA SANCHEZ GASTON',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(26,NULL,'DUNIA','SOLIZ','TORRICO','SOLIZ TORRICO DUNIA',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(27,NULL,'CESAR','SUAREZ','SUAREZ','SUAREZ SUAREZ CESAR',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(28,NULL,'JAVIER','VASQUEZ','CRUZ','VASQUEZ CRUZ JAVIER',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(29,NULL,'RAUL','VERA','PORTANDA','VERA PORTANDA RAUL',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(30,NULL,'FERNANDO','ZEBALLOS','ORELLANA','ZEBALLOS ORELLANA FERNANDO',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53'),(31,NULL,'PABLO','ZELADA','GARCIA','ZELADA GARCIA PABLO',NULL,'2025-04-28 04:10:27','2025-04-28 04:14:53');
/*!40000 ALTER TABLE `docentes` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `gestiones`
--

DROP TABLE IF EXISTS `gestiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestiones` (
  `gestion_id` int NOT NULL AUTO_INCREMENT,
  `anio` int NOT NULL,
  `semestre` enum('1','2') NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gestion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestiones`
--

LOCK TABLES `gestiones` WRITE;
/*!40000 ALTER TABLE `gestiones` DISABLE KEYS */;
INSERT INTO `gestiones` VALUES (1,2025,'1',NULL,1,'2025-04-28 04:10:27');
/*!40000 ALTER TABLE `gestiones` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_aula`
--

LOCK TABLES `key_aula` WRITE;
/*!40000 ALTER TABLE `key_aula` DISABLE KEYS */;
INSERT INTO `key_aula` VALUES (1,1,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(2,8,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(3,9,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(4,10,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(5,11,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(6,12,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(7,13,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(8,14,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(9,15,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(10,2,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(11,16,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(12,17,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(13,18,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(14,19,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(15,20,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(16,21,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(17,22,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(18,3,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(19,4,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(20,5,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(21,6,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38'),(22,7,'disponible',0,'2025-05-04 22:20:38','2025-05-04 22:20:38');
/*!40000 ALTER TABLE `key_aula` ENABLE KEYS */;
UNLOCK TABLES;

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
  `estado` enum('pendiente','aprobada','completada','rechazada') DEFAULT 'pendiente',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_requests`
--

LOCK TABLES `key_requests` WRITE;
/*!40000 ALTER TABLE `key_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `key_requests` ENABLE KEYS */;
UNLOCK TABLES;

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
  `tipo` enum('informacion','advertencia','exito','error') DEFAULT 'informacion',
  `is_read` tinyint(1) DEFAULT '0',
  `action_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `subject_id` int NOT NULL,
  `classroom_id` int NOT NULL,
  `docente_id` int DEFAULT NULL,
  `gestion_id` int NOT NULL,
  `day_of_week` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`schedule_id`),
  KEY `subject_id` (`subject_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `gestion_id` (`gestion_id`),
  KEY `fk_docente_schedule` (`docente_id`),
  CONSTRAINT `fk_docente_schedule` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`docente_id`),
  CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `schedules_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`classroom_id`),
  CONSTRAINT `schedules_ibfk_4` FOREIGN KEY (`gestion_id`) REFERENCES `gestiones` (`gestion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,1,11,1,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(2,1,9,1,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(3,1,11,1,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(4,2,11,1,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(5,2,12,1,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(6,2,11,1,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(7,3,9,2,1,'Lunes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(8,4,6,2,1,'Jueves','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(9,4,5,2,1,'Martes','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(10,5,14,2,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(11,5,14,2,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(12,5,14,2,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(13,6,14,2,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(14,6,14,2,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(15,6,14,2,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(16,7,10,2,1,'Jueves','09:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(17,7,10,2,1,'Martes','09:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(18,8,14,2,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(19,8,14,2,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(20,8,14,2,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(21,9,13,3,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(22,9,20,3,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(23,10,20,3,1,'Miércoles','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(24,10,9,3,1,'Viernes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(25,11,7,3,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(26,11,7,3,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(27,11,7,3,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(28,12,7,3,1,'Jueves','11:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(29,12,7,3,1,'Martes','11:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(30,13,4,4,1,'Jueves','09:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(31,13,4,4,1,'Martes','09:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(32,14,20,4,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(33,14,12,4,1,'Martes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(34,14,12,4,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(35,15,12,4,1,'Jueves','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(36,15,6,4,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(37,15,12,4,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(38,16,12,4,1,'Lunes','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(39,16,12,4,1,'Miércoles','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(40,17,9,5,1,'Lunes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(41,17,9,5,1,'Miércoles','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(42,17,9,5,1,'Viernes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(43,18,20,5,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(44,18,20,5,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(45,18,6,5,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(46,19,20,5,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(47,19,20,5,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(48,19,6,5,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(49,20,7,5,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(50,20,7,5,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(51,20,7,5,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(52,21,11,5,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(53,21,11,5,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(54,21,11,5,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(55,22,5,5,1,'Jueves','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(56,22,5,5,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(57,22,5,5,1,'Martes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(58,23,6,5,1,'Jueves','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(59,23,6,5,1,'Martes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(60,24,8,6,1,'Martes','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(61,24,8,6,1,'Sábado','08:35:00','11:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(62,25,4,6,1,'Jueves','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(63,25,4,6,1,'Martes','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(64,26,4,7,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(65,26,4,7,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(66,27,15,7,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(67,27,15,7,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(68,28,11,8,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(69,28,11,8,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(70,28,11,8,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(71,29,5,8,1,'Miércoles','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(72,29,5,8,1,'Viernes','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(73,30,7,8,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(74,30,7,8,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(75,30,7,8,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(76,31,9,9,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(77,31,9,9,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(78,31,9,9,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(79,32,16,10,1,'Jueves','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(80,32,16,10,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(81,32,16,10,1,'Martes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(82,33,14,10,1,'Martes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(83,34,15,10,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(84,35,20,10,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(85,36,13,11,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(86,36,13,11,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(87,37,13,11,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(88,37,13,11,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(89,38,14,11,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(90,38,14,11,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(91,39,14,11,1,'Jueves','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(92,39,14,11,1,'Martes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(93,40,21,12,1,'Lunes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(94,40,21,12,1,'Miércoles','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(95,40,21,12,1,'Viernes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(96,41,20,13,1,'Jueves','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(97,41,20,13,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(98,42,15,14,1,'Jueves','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(99,42,3,14,1,'Miércoles','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(100,43,9,14,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(101,43,1,14,1,'Martes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(102,43,9,14,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(103,44,20,14,1,'Jueves','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(104,44,12,14,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(105,44,1,14,1,'Martes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(106,45,6,15,1,'Miércoles','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(107,45,6,15,1,'Viernes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(108,46,12,15,1,'Jueves','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(109,46,12,15,1,'Martes','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(110,47,13,16,1,'Viernes','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(111,48,18,17,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(112,48,13,17,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(113,48,12,17,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(114,49,12,17,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(115,49,16,17,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(116,49,12,17,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(117,50,15,17,1,'Jueves','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(118,50,15,17,1,'Martes','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(119,51,7,18,1,'Jueves','15:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(120,51,11,18,1,'Martes','15:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(121,51,9,18,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(122,52,4,18,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(123,52,4,18,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(124,52,4,18,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(125,53,4,18,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(126,53,4,18,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(127,53,4,18,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(128,54,11,18,1,'Jueves','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(129,54,11,18,1,'Martes','13:05:00','15:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(130,55,15,18,1,'Lunes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(131,55,15,18,1,'Miércoles','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(132,55,15,18,1,'Viernes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(133,56,14,19,1,'Jueves','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(134,56,14,19,1,'Martes','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(135,57,7,20,1,'Miércoles','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(136,57,7,20,1,'Viernes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(137,58,15,21,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(138,58,15,21,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(139,58,15,21,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(140,59,15,21,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(141,59,17,21,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(142,59,15,21,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(143,60,15,21,1,'Lunes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(144,60,14,21,1,'Viernes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(145,61,19,22,1,'Jueves','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(146,61,19,22,1,'Martes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(147,62,19,22,1,'Jueves','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(148,62,19,22,1,'Martes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(149,63,19,22,1,'Jueves','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(150,63,19,22,1,'Martes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(151,64,19,22,1,'Jueves','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(152,64,19,22,1,'Martes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(153,65,19,22,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(154,65,19,22,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(155,65,19,22,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(156,66,16,22,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(157,66,16,22,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(158,66,16,22,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(159,67,19,22,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(160,67,19,22,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(161,67,19,22,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(162,68,6,23,1,'Jueves','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(163,68,6,23,1,'Martes','14:55:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(164,69,16,23,1,'Jueves','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(165,69,16,23,1,'Martes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(166,69,16,23,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(167,70,6,23,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(168,70,10,23,1,'Miércoles','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(169,70,10,23,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(170,71,10,23,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(171,71,16,23,1,'Miércoles','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(172,71,10,23,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(173,72,15,23,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(174,72,15,23,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(175,72,15,23,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(176,73,9,23,1,'Jueves','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(177,73,9,23,1,'Martes','12:15:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(178,74,20,24,1,'Lunes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(179,74,20,24,1,'Viernes','12:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(180,75,5,25,1,'Jueves','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(181,75,5,25,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(182,75,5,25,1,'Martes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(183,76,7,25,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(184,76,6,25,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(185,77,20,25,1,'Jueves','11:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(186,77,20,25,1,'Martes','11:15:00','13:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(187,78,4,26,1,'Jueves','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(188,78,4,26,1,'Martes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(189,79,20,26,1,'Lunes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(190,79,20,26,1,'Miércoles','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(191,79,20,26,1,'Viernes','16:45:00','18:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(192,80,2,27,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(193,80,21,27,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(194,81,22,27,1,'Jueves','10:25:00','13:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(195,81,2,27,1,'Martes','10:25:00','13:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(196,82,21,27,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(197,82,22,27,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(198,82,2,27,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(199,83,2,27,1,'Jueves','14:05:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(200,83,21,27,1,'Martes','14:05:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(201,84,11,28,1,'Jueves','10:25:00','13:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(202,84,11,28,1,'Martes','10:25:00','13:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(203,85,16,28,1,'Lunes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(204,85,13,28,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(205,85,13,28,1,'Viernes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(206,86,13,28,1,'Lunes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(207,86,13,28,1,'Viernes','13:05:00','14:55:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(208,87,12,28,1,'Lunes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(209,87,13,28,1,'Viernes','10:25:00','12:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(210,88,20,28,1,'Martes','14:05:00','17:35:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(211,89,6,29,1,'Lunes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(212,89,10,29,1,'Miércoles','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(213,89,10,29,1,'Viernes','08:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(214,90,14,30,1,'Sábado','07:35:00','10:15:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(215,91,14,30,1,'Sábado','10:25:00','13:05:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(216,92,9,31,1,'Jueves','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(217,92,9,31,1,'Martes','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27'),(218,92,9,31,1,'Miércoles','14:55:00','16:45:00','2025-04-28 04:10:27','2025-04-28 04:10:27');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'PROGRAMACION I  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(2,'PROGRAMACION I  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(3,'BASE DE DATOS  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(4,'BASE DE DATOS I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(5,'BASE DE DATOS II  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(6,'BASE DE DATOS II  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(7,'BASE DE DATOS II  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(8,'BASE DE DATOS II  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(9,'COMPUTACION  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(10,'PROGRAMACION  (I)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(11,'TALLER DE SISTEMAS I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(12,'TALLER DE SISTEMAS I  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(13,'GAME DEVELOPMENT  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(14,'PROCESAMIENTO DIGITAL DE IMAGENES  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(15,'PROCESAMIENTO DIGITAL DE IMAGENES  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(16,'PROCESAMIENTO DIGITAL DE IMAGENES  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(17,'BASE DE DATOS  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(18,'BASE DE DATOS  (D)  Alias',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(19,'BASE DE DATOS I  (D)  Alias',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(20,'INGENIERIA DE SOFTWARE  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(21,'PROGRAMACION I  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(22,'PROGRAMACION WEB I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(23,'PROYECTO DE SISTEMAS II  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(24,'BASE DE DATOS I  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(25,'BASE DE DATOS III  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(26,'TECNOLOGIAS EMERGENTES II  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(27,'TECNOLOGIAS EMERGENTES II  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(28,'PROGRAMACION I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(29,'SISTEMAS OPERATIVOS  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(30,'TALLER DE SISTEMAS I  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(31,'BASE DE DATOS  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(32,'FUNDAMENTOS DE DESARROLLO DE SOFTWARE  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(33,'METODOLOGIA DE LA INVESTIGACION  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(34,'METODOLOGIA DE LA INVESTIGACION  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(35,'METODOLOGIA DE LA INVESTIGACION  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(36,'ANIMACION DIGITAL  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(37,'ANIMACION DIGITAL  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(38,'ANIMACION DIGITAL  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(39,'ANIMACION DIGITAL  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(40,'ELECTRONICA DIGITAL APLICADA  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(41,'PROGRAMACION I  (E)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(42,'REDES Y COMUNICACION DE DATOS I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(43,'REDES Y COMUNICACION DE DATOS I  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(44,'REDES Y COMUNICACION DE DATOS I  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(45,'PROGRAMACION  (K)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(46,'PROGRAMACION  (U)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(47,'SOFTWARE PROJECT MANAGEMENT  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(48,'SISTEMAS DISTRIBUIDOS  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(49,'SISTEMAS DISTRIBUIDOS  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(50,'SISTEMAS DISTRIBUIDOS  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(51,'PROGRAMACION MOVIL II  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(52,'PROGRAMACION WEB II  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(53,'PROGRAMACION WEB II  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(54,'PROGRAMACION WEB II  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(55,'PROGRAMACION WEB III  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(56,'COMPUTACION  (J)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(57,'PROYECTO DE SISTEMAS I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(58,'PROGRAMACION III  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(59,'PROGRAMACION III  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(60,'PROGRAMACION III  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(61,'FUNDAMENTOS DE LAS CS. DE LA COMPUTACION  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(62,'FUNDAMENTOS DE LAS CS. DE LA COMPUTACION  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(63,'FUNDAMENTOS DE LAS CS. DE LA COMPUTACION  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(64,'FUNDAMENTOS DE LAS CS. DE LA COMPUTACION  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(65,'MATEMATICA COMPUTACIONAL  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(66,'MATEMATICA COMPUTACIONAL  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(67,'MATEMATICA COMPUTACIONAL  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(68,'AUDITORIA Y SEGURIDAD INFORMATICA  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(69,'FUNDAMENTOS DE DESARROLLO DE SOFTWARE  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(70,'MANAGEMENT INFORMATION SYSTEMS  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(71,'MANAGEMENT INFORMATION SYSTEMS  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(72,'MANAGEMENT INFORMATION SYSTEMS  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(73,'PROGRAMACION I  (G)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(74,'PROGRAMACION  (J)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(75,'PROGRAMACION II  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(76,'PROYECTO DE SISTEMAS II  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(77,'SOFTWARE PROJECT MANAGEMENT  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(78,'PROGRAMACION I  (T)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(79,'PROGRAMACION II  (E)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(80,'IOT Y ROBOTICA  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(81,'IOT Y ROBOTICA  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(82,'IOT Y ROBOTICA  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(83,'IOT Y ROBOTICA  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(84,'PROGRAMACION MOVIL I  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(85,'PROGRAMACION MOVIL I  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(86,'PROGRAMACION MOVIL I  (C)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(87,'PROGRAMACION MOVIL I  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(88,'SISTEMAS INFORMATICOS APLICADOS  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(89,'PROGRAMACION WEB II  (D)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(90,'DATA WAREHOUSING  (A)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(91,'DATA WAREHOUSING  (B)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27'),(92,'PROGRAMACION I  (N)',NULL,'2025-04-28 04:10:27','2025-04-28 04:10:27');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2025-05-05  3:23:29
