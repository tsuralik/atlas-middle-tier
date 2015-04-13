-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: ecfs
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `indexFields`
--

DROP TABLE IF EXISTS `indexFields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `indexFields` (
  `applicant` varchar(50) DEFAULT NULL,
  `applicant_sort` varchar(50) DEFAULT NULL,
  `brief` boolean NOT NULL DEFAULT 0,
  `city` varchar(50) DEFAULT NULL,
  `dateRcpt` timestamp NULL,
  `disseminated` timestamp NULL,
  `exParte` boolean NOT NULL DEFAULT 0,
  `id` bigint unsigned AUTO_INCREMENT,
  `modified` timestamp NULL,
  `pages` int unsigned DEFAULT NULL,
  `proceeding` varchar(50) DEFAULT NULL,
  `regFlexAnalysis` boolean NOT NULL DEFAULT 0,
  `score` float unsigned DEFAULT NULL,
  `smallBusinessImpact` boolean NOT NULL DEFAULT 0,
  `stateCd` varchar(2) DEFAULT NULL,
  `submissionType` varchar(50) DEFAULT NULL,
  `text` text character set utf8 DEFAULT NULL,
  `viewingStatus` varchar(50) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structures for materialized views
--
DROP TABLE IF EXISTS `indexFields_for_solr`;
CREATE TABLE IF NOT EXISTS `indexFields_for_solr` (
  `applicant` varchar(50) DEFAULT NULL,
  `applicant_sort` varchar(50) DEFAULT NULL,
  `brief` boolean NOT NULL DEFAULT 0,
  `city` varchar(50) DEFAULT NULL,
  `dateRcpt` timestamp NULL,
  `disseminated` timestamp NULL,
  `exParte` boolean NOT NULL DEFAULT 0,
  `id` bigint unsigned DEFAULT NULL,
  `modified` timestamp NULL,
  `pages` int unsigned DEFAULT NULL,
  `proceeding` varchar(50) DEFAULT NULL,
  `regFlexAnalysis` boolean NOT NULL DEFAULT 0,
  `score` float unsigned DEFAULT NULL,
  `smallBusinessImpact` boolean NOT NULL DEFAULT 0,
  `stateCd` varchar(2) DEFAULT NULL,
  `submissionType` varchar(50) DEFAULT NULL,
  `text` text character set utf8 DEFAULT NULL,
  `viewingStatus` varchar(50) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structures for materialized views
--
DROP TABLE IF EXISTS `indexFields_for_solr_summary`;
CREATE TABLE IF NOT EXISTS `indexFields_for_solr_summary` (
  `max_id` bigint unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `indexFields_for_solr_summary` (max_id) VALUES (0);

--
-- Dumping events for database 'ecfs'
--

--
-- Dumping routines for database 'ecfs'
--

/*!50003 DROP TRIGGER IF EXISTS `indexFields_insert_data_clone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER indexFields_insert_data_clone
AFTER INSERT ON indexFields
FOR EACH ROW
BEGIN

    INSERT INTO indexFields_for_solr (applicant, applicant_sort, brief, city, dateRcpt, 
        disseminated, exParte, id, modified, pages, proceeding, regFlexAnalysis, score, 
        smallBusinessImpact, stateCd, submissionType, text, viewingStatus, zip)
    VALUES (NEW.applicant, NEW.applicant_sort, NEW.brief, NEW.city, NEW.dateRcpt, 
        NEW.disseminated, NEW.exParte, NEW.id, NEW.modified, NEW.pages, NEW.proceeding, NEW.regFlexAnalysis, NEW.score, 
        NEW.smallBusinessImpact, NEW.stateCd, NEW.submissionType, NEW.text, NEW.viewingStatus, NEW.zip);

    UPDATE indexFields_for_solr_summary 
    SET max_id = NEW.id;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for clearing 'indexFields_for_solr'
--

/*!50003 DROP PROCEDURE IF EXISTS `clear_indexFields_ingested_into_solr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `clear_indexFields_ingested_into_solr`(
    IN maxId integer unsigned
)
BEGIN

    DELETE FROM indexFields_for_solr
    WHERE indexFields_for_solr.id <= maxId;

END */;;
DELIMITER ;


/*!50003 DROP PROCEDURE IF EXISTS `insert_indexFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `insert_indexFields` (
  IN applicant varchar(50),
  IN city varchar(50),
  IN proceeding varchar(50),
  IN stateCd varchar(2),
  IN text text character set utf8,
  IN zip varchar(10)
)
BEGIN

    INSERT INTO indexFields (applicant, applicant_sort, brief, city, dateRcpt, 
        disseminated, exParte, modified, pages, proceeding, regFlexAnalysis, score, 
        smallBusinessImpact, stateCd, submissionType, text, viewingStatus, zip)
    VALUES (applicant, applicant, 0, city, '2011-01-11 01:11:01', 
        '2011-01-11 01:11:01', 0, '2011-01-11 01:11:01', 2, proceeding, 0, 11.11, 
        0, stateCd, 'COMMENTS', text, 'REVIEWED', zip);

END */;;
DELIMITER ;


/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-13 21:57:41

