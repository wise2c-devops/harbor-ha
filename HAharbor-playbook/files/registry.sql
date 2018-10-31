-- MySQL dump 10.16  Distrib 10.2.14-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: registry
-- ------------------------------------------------------
-- Server version	10.2.14-MariaDB

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

CREATE DATABASE registry;
USE registry;
--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `access_code` char(1) DEFAULT NULL,
  `comment` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (1,'M','Management access for project'),(2,'R','Read access for project'),(3,'W','Write access for project'),(4,'D','Delete access for project'),(5,'S','Search access for project');
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `access_log`
--

DROP TABLE IF EXISTS `access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `repo_name` varchar(256) DEFAULT NULL,
  `repo_tag` varchar(128) DEFAULT NULL,
  `GUID` varchar(64) DEFAULT NULL,
  `operation` varchar(20) NOT NULL,
  `op_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `pid_optime` (`project_id`,`op_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_log`
--

LOCK TABLES `access_log` WRITE;
/*!40000 ALTER TABLE `access_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('1.5.0');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clair_vuln_timestamp`
--

DROP TABLE IF EXISTS `clair_vuln_timestamp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clair_vuln_timestamp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(128) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clair_vuln_timestamp`
--

LOCK TABLES `clair_vuln_timestamp` WRITE;
/*!40000 ALTER TABLE `clair_vuln_timestamp` DISABLE KEYS */;
/*!40000 ALTER TABLE `clair_vuln_timestamp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `harbor_label`
--

DROP TABLE IF EXISTS `harbor_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `harbor_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(16) DEFAULT NULL,
  `level` char(1) NOT NULL,
  `scope` char(1) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_label` (`name`,`scope`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `harbor_label`
--

LOCK TABLES `harbor_label` WRITE;
/*!40000 ALTER TABLE `harbor_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `harbor_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `harbor_resource_label`
--

DROP TABLE IF EXISTS `harbor_resource_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `harbor_resource_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label_id` int(11) NOT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_name` varchar(256) DEFAULT NULL,
  `resource_type` char(1) NOT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_label_resource` (`label_id`,`resource_id`,`resource_name`,`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `harbor_resource_label`
--

LOCK TABLES `harbor_resource_label` WRITE;
/*!40000 ALTER TABLE `harbor_resource_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `harbor_resource_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img_scan_job`
--

DROP TABLE IF EXISTS `img_scan_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `img_scan_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(64) NOT NULL,
  `repository` varchar(256) NOT NULL,
  `tag` varchar(128) NOT NULL,
  `digest` varchar(128) DEFAULT NULL,
  `job_uuid` varchar(64) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_digest` (`digest`),
  KEY `idx_uuid` (`job_uuid`),
  KEY `idx_repository_tag` (`repository`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_scan_job`
--

LOCK TABLES `img_scan_job` WRITE;
/*!40000 ALTER TABLE `img_scan_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `img_scan_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img_scan_overview`
--

DROP TABLE IF EXISTS `img_scan_overview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `img_scan_overview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_digest` varchar(128) NOT NULL,
  `scan_job_id` int(11) NOT NULL,
  `severity` int(11) NOT NULL DEFAULT 0,
  `components_overview` varchar(2048) DEFAULT NULL,
  `details_key` varchar(128) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `image_digest` (`image_digest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_scan_overview`
--

LOCK TABLES `img_scan_overview` WRITE;
/*!40000 ALTER TABLE `img_scan_overview` DISABLE KEYS */;
/*!40000 ALTER TABLE `img_scan_overview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `name` (`name`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,1,'library','2018-09-14 12:49:40','2018-09-14 12:49:40',0);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_member`
--

DROP TABLE IF EXISTS `project_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `entity_type` char(1) NOT NULL,
  `role` int(11) NOT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_entity_type` (`project_id`,`entity_id`,`entity_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_member`
--

LOCK TABLES `project_member` WRITE;
/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` VALUES (1,1,1,'u',1,'2018-09-14 12:49:40','2018-09-14 12:49:40');
/*!40000 ALTER TABLE `project_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_metadata`
--

DROP TABLE IF EXISTS `project_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_id_and_name` (`project_id`,`name`),
  CONSTRAINT `project_metadata_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_metadata`
--

LOCK TABLES `project_metadata` WRITE;
/*!40000 ALTER TABLE `project_metadata` DISABLE KEYS */;
INSERT INTO `project_metadata` VALUES (1,1,'public','true','2018-09-14 12:49:40','2018-09-14 12:49:40',0);
/*!40000 ALTER TABLE `project_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `k` varchar(64) NOT NULL,
  `v` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `k` (`k`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'token_expiration','30'),(2,'registry_storage_provider_name','filesystem'),(3,'clair_db_host','postgres'),(4,'ldap_group_attribute_name','cn'),(5,'token_service_url','http://ui:8080/service/token'),(6,'mysql_port','3306'),(7,'ldap_group_base_dn','ou=group,dc=mydomain,dc=com'),(8,'clair_db_password','<enc-v1>qxqa0ZCbz7sL79U6DmUT4oFy+QUnQ/nB'),(9,'email_from','admin <sample_admin@mydomain.com>'),(10,'email_port','25'),(11,'email_identity',''),(12,'uaa_endpoint','uaa.mydomain.org'),(13,'ldap_filter',''),(14,'ldap_group_search_filter','objectclass=group'),(15,'ui_url','http://ui:8080'),(16,'mysql_database','registry'),(17,'email_password','<enc-v1>U3GXp4MkO/xFBjv1D6xmd2Qp5g=='),(18,'with_clair','false'),(19,'ldap_scope','2'),(20,'uaa_verify_cert','true'),(21,'clair_db_port','5432'),(22,'clair_db_username','postgres'),(23,'notary_url','http://notary-server:4443'),(24,'ext_endpoint','http://192.168.92.139'),(25,'mysql_username','root'),(26,'uaa_client_secret','<enc-v1>2wiBnieP+koJ57MyA0UJcjAiwbGt+A=='),(27,'registry_url','http://registry:5000'),(28,'ldap_url','ldaps://ldap.mydomain.com'),(29,'with_notary','false'),(30,'auth_mode','db_auth'),(31,'ldap_verify_cert','true'),(32,'jobservice_url','http://jobservice:8080'),(33,'clair_db','postgres'),(34,'admin_initial_password','<enc-v1>4VS0Vl1O65IdM+7EuY0z9TaM+NaeUvpkBnx5'),(35,'ldap_base_dn','ou=people,dc=mydomain,dc=com'),(36,'uaa_client_id','id'),(37,'database_type','mysql'),(38,'email_username','sample_admin@mydomain.com'),(39,'max_job_workers','50'),(40,'mysql_password','<enc-v1>sHFXSadb/eLARTJXyXQz8I3FaTSA044='),(41,'reload_key',''),(42,'sqlite_file',''),(43,'read_only','false'),(44,'ldap_uid','uid'),(45,'cfg_expiration','5'),(46,'email_ssl','false'),(47,'email_insecure','false'),(48,'admiral_url','NA'),(49,'ldap_search_dn',''),(50,'project_creation_restriction','everyone'),(51,'mysql_host','mysql'),(52,'ldap_group_search_scope','2'),(53,'ldap_timeout','5'),(54,'clair_url','http://clair:6060'),(55,'email_host','smtp.mydomain.com'),(56,'ldap_search_password','<enc-v1>utQkq/K2ARsXca9BnC4hEA=='),(57,'self_registration','true');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replication_immediate_trigger`
--

DROP TABLE IF EXISTS `replication_immediate_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replication_immediate_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `namespace` varchar(256) NOT NULL,
  `on_push` tinyint(1) NOT NULL DEFAULT 0,
  `on_deletion` tinyint(1) NOT NULL DEFAULT 0,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replication_immediate_trigger`
--

LOCK TABLES `replication_immediate_trigger` WRITE;
/*!40000 ALTER TABLE `replication_immediate_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `replication_immediate_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replication_job`
--

DROP TABLE IF EXISTS `replication_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replication_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(64) NOT NULL,
  `policy_id` int(11) NOT NULL,
  `repository` varchar(256) NOT NULL,
  `operation` varchar(64) NOT NULL,
  `tags` varchar(16384) DEFAULT NULL,
  `job_uuid` varchar(64) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `policy` (`policy_id`),
  KEY `poid_uptime` (`policy_id`,`update_time`),
  KEY `poid_status` (`policy_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replication_job`
--

LOCK TABLES `replication_job` WRITE;
/*!40000 ALTER TABLE `replication_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `replication_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replication_policy`
--

DROP TABLE IF EXISTS `replication_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replication_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `target_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `cron_str` varchar(256) DEFAULT NULL,
  `filters` varchar(1024) DEFAULT NULL,
  `replicate_deletion` tinyint(1) NOT NULL DEFAULT 0,
  `start_time` timestamp NULL DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replication_policy`
--

LOCK TABLES `replication_policy` WRITE;
/*!40000 ALTER TABLE `replication_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `replication_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replication_target`
--

DROP TABLE IF EXISTS `replication_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replication_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `url` varchar(64) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `target_type` tinyint(1) NOT NULL DEFAULT 0,
  `insecure` tinyint(1) NOT NULL DEFAULT 0,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replication_target`
--

LOCK TABLES `replication_target` WRITE;
/*!40000 ALTER TABLE `replication_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `replication_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repository`
--

DROP TABLE IF EXISTS `repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository` (
  `repository_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `pull_count` int(11) NOT NULL DEFAULT 0,
  `star_count` int(11) NOT NULL DEFAULT 0,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`repository_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repository`
--

LOCK TABLES `repository` WRITE;
/*!40000 ALTER TABLE `repository` DISABLE KEYS */;
/*!40000 ALTER TABLE `repository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_mask` int(11) NOT NULL DEFAULT 0,
  `role_code` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,0,'MDRWS','projectAdmin'),(2,0,'RWS','developer'),(3,0,'RS','guest');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(40) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `comment` varchar(30) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `reset_uuid` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `sysadmin_flag` tinyint(1) DEFAULT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin@example.com','c01d7a12394be395238ef2a93ab5ae5b','system admin','admin user',0,NULL,'ix2boxvfxz3yhaqjgwbnz9xgeabypsst',1,'2018-09-14 12:49:43','2018-09-14 12:49:40'),(2,'anonymous','anonymous@example.com','','anonymous user','anonymous user',1,NULL,NULL,0,'2018-09-14 12:49:40','2018-09-14 12:49:40');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `group_type` int(11) DEFAULT 0,
  `ldap_group_dn` varchar(512) NOT NULL,
  `creation_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-14 13:02:08
