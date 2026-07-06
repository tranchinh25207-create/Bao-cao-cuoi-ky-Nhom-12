-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: petcare
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `member_id` int NOT NULL,
  `session_id` int NOT NULL,
  `attendance_status` enum('Present','Absent') COLLATE utf8mb4_unicode_ci DEFAULT 'Present',
  `check_in_time` datetime DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`member_id`,`session_id`),
  KEY `fk_attendance_session` (`session_id`),
  CONSTRAINT `fk_attendance_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_session` FOREIGN KEY (`session_id`) REFERENCES `trainingsession` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberlevel`
--

DROP TABLE IF EXISTS `memberlevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberlevel` (
  `member_id` int NOT NULL,
  `level_id` int NOT NULL,
  `achieved_date` date NOT NULL,
  PRIMARY KEY (`member_id`,`level_id`),
  KEY `fk_memberlevel_level` (`level_id`),
  CONSTRAINT `fk_memberlevel_level` FOREIGN KEY (`level_id`) REFERENCES `traininglevel` (`level_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_memberlevel_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberlevel`
--

LOCK TABLES `memberlevel` WRITE;
/*!40000 ALTER TABLE `memberlevel` DISABLE KEYS */;
/*!40000 ALTER TABLE `memberlevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `member_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `join_date` date NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `uq_member_code` (`member_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessiontrainer`
--

DROP TABLE IF EXISTS `sessiontrainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessiontrainer` (
  `session_id` int NOT NULL,
  `trainer_id` int NOT NULL,
  `role` enum('head','assistant') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'assistant',
  PRIMARY KEY (`session_id`,`trainer_id`),
  KEY `fk_sessiontrainer_trainer` (`trainer_id`),
  CONSTRAINT `fk_sessiontrainer_session` FOREIGN KEY (`session_id`) REFERENCES `trainingsession` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sessiontrainer_trainer` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessiontrainer`
--

LOCK TABLES `sessiontrainer` WRITE;
/*!40000 ALTER TABLE `sessiontrainer` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessiontrainer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainer`
--

DROP TABLE IF EXISTS `trainer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainer` (
  `member_id` int NOT NULL,
  `start_date` date NOT NULL,
  `status` enum('paid','volunteer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'volunteer',
  PRIMARY KEY (`member_id`),
  CONSTRAINT `fk_trainer_member` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainer`
--

LOCK TABLES `trainer` WRITE;
/*!40000 ALTER TABLE `trainer` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainingclass`
--

DROP TABLE IF EXISTS `trainingclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainingclass` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `level_id` int NOT NULL,
  `trainer_id` int NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `training_area` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk_class_level` (`level_id`),
  KEY `fk_class_trainer` (`trainer_id`),
  CONSTRAINT `fk_class_level` FOREIGN KEY (`level_id`) REFERENCES `traininglevel` (`level_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_class_trainer` FOREIGN KEY (`trainer_id`) REFERENCES `trainer` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainingclass`
--

LOCK TABLES `trainingclass` WRITE;
/*!40000 ALTER TABLE `trainingclass` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainingclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traininglevel`
--

DROP TABLE IF EXISTS `traininglevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traininglevel` (
  `level_id` int NOT NULL AUTO_INCREMENT,
  `level_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `badge_color` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`level_id`),
  UNIQUE KEY `uq_level_name` (`level_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traininglevel`
--

LOCK TABLES `traininglevel` WRITE;
/*!40000 ALTER TABLE `traininglevel` DISABLE KEYS */;
/*!40000 ALTER TABLE `traininglevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainingrequirement`
--

DROP TABLE IF EXISTS `trainingrequirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainingrequirement` (
  `requirement_id` int NOT NULL AUTO_INCREMENT,
  `level_id` int NOT NULL,
  `requirement_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`requirement_id`),
  KEY `fk_requirement_level` (`level_id`),
  CONSTRAINT `fk_requirement_level` FOREIGN KEY (`level_id`) REFERENCES `traininglevel` (`level_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainingrequirement`
--

LOCK TABLES `trainingrequirement` WRITE;
/*!40000 ALTER TABLE `trainingrequirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainingrequirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainingsession`
--

DROP TABLE IF EXISTS `trainingsession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainingsession` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `session_date` date NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `fk_session_class` (`class_id`),
  CONSTRAINT `fk_session_class` FOREIGN KEY (`class_id`) REFERENCES `trainingclass` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainingsession`
--

LOCK TABLES `trainingsession` WRITE;
/*!40000 ALTER TABLE `trainingsession` DISABLE KEYS */;
/*!40000 ALTER TABLE `trainingsession` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-03 21:17:25
