-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: snsboard
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `board_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) NOT NULL,
  `title` tinytext DEFAULT NULL,
  `content` text DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `likes_num` int(11) DEFAULT 0,
  `add_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `comment_num` int(11) DEFAULT 0,
  PRIMARY KEY (`board_idx`),
  KEY `user_idx` (`user_idx`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`user_idx`) REFERENCES `user` (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (23,1,'첫번째 태스트','태스트 글... 수정후',3,0,'2020-06-30 14:19:05','2020-06-30 14:21:24',0),(24,2,'100자 이상 테스트','동해물과 백두산이 마르고 닳도록\r\n하느님이 보우하사 우리나라만세\r\n(후렴)무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세\r\n남산위에 저 소나무 철갑을 두른듯\r\n바람서리 불변함은 우리기상 일세\r\n(후렴)무궁화 삼천리 화려강산 대한사람 대한으로 길이보전하세\r\n가을하늘 공활한데 높고 구름없이 \r\n밝은달은 우리가슴 일편단심일세\r\n(후렴)무궁화 삼천리 화려강산 대한사람 대한으로 길이보전하세\r\n이 기상과 이 맘으로 충성을 다하여\r\n괴로우나 즐거우나 나라사랑하세\r\n(후렴)무궁화 삼천리 화려강산 대한사람 대한으로 길이보전하세',9,2,'2020-06-30 14:20:08','2020-06-30 20:46:40',4),(25,3,'testing','게시글 태스트',1,3,'2020-06-30 15:44:35',NULL,0),(26,1,'게시글 작성 태스트','태스트중임',12,1,'2020-06-30 20:01:12',NULL,1);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `comment_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `content` tinytext DEFAULT NULL,
  `add_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `board_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`comment_idx`),
  KEY `user_idx` (`user_idx`),
  KEY `board_idx` (`board_idx`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_idx`) REFERENCES `user` (`user_idx`),
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`board_idx`) REFERENCES `board` (`board_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (32,3,'댓글1 테스트','2020-06-30 14:21:53',NULL,24),(33,3,'댓글 2 태스트','2020-06-30 14:22:02',NULL,24),(34,3,'댓글 3 태스트','2020-06-30 14:22:10',NULL,24),(35,1,'댓글 확인용 수정','2020-06-30 20:31:54','2020-06-30 20:32:49',24),(36,3,'확인','2020-06-30 21:21:08',NULL,26);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `file_idx` int(11) NOT NULL AUTO_INCREMENT,
  `board_idx` int(11) NOT NULL,
  `appendfile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`file_idx`),
  KEY `board_idx` (`board_idx`),
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`board_idx`) REFERENCES `board` (`board_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (26,23,'e5e784ee6333fd6fe50ccb9d8030a7eb.gif'),(27,23,'1548256753.gif'),(28,23,'you-should-be-working-now-53136-1920x1080.jpg'),(29,25,'sun.jpg'),(30,26,'you-should-be-working-now-53136-1920x10801.jpg'),(31,26,'15482567531.gif'),(32,26,'e5e784ee6333fd6fe50ccb9d8030a7eb1.gif'),(33,24,'e5e784ee6333fd6fe50ccb9d8030a7eb2.gif'),(34,24,'asdfasdf.png'),(35,24,'you-should-be-working-now-53136-1920x10802.jpg');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `board_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `board_idx` (`board_idx`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`board_idx`) REFERENCES `board` (`board_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (9,2,24),(10,2,26),(14,3,25),(15,3,24),(16,2,25),(17,1,25);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(10) DEFAULT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `user_password` text DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test1','태스트','1234','2017050801699_01.jpg'),(2,'222','second','222','sun2.jpg'),(3,'333','세번째','333','face1.png');
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

-- Dump completed on 2020-06-30 21:54:18
