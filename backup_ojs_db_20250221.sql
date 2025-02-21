/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.20-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ojsdb
-- ------------------------------------------------------
-- Server version	10.6.20-MariaDB-cll-lve

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
-- Table structure for table `access_keys`
--

DROP TABLE IF EXISTS `access_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_keys` (
  `access_key_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context` varchar(40) NOT NULL,
  `key_hash` varchar(40) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  `expiry_date` datetime NOT NULL,
  PRIMARY KEY (`access_key_id`),
  KEY `access_keys_user_id` (`user_id`),
  KEY `access_keys_hash` (`key_hash`,`user_id`,`context`),
  CONSTRAINT `access_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Access keys are used to provide pseudo-login functionality for security-minimal tasks. Passkeys can be emailed directly to users, who can use them for a limited time in lieu of standard username and password.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_keys`
--

LOCK TABLES `access_keys` WRITE;
/*!40000 ALTER TABLE `access_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_settings`
--

DROP TABLE IF EXISTS `announcement_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_settings` (
  `announcement_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `announcement_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`announcement_setting_id`),
  UNIQUE KEY `announcement_settings_unique` (`announcement_id`,`locale`,`setting_name`),
  KEY `announcement_settings_announcement_id` (`announcement_id`),
  CONSTRAINT `announcement_settings_announcement_id_foreign` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`announcement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about announcements, including localized properties like names and contents.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_settings`
--

LOCK TABLES `announcement_settings` WRITE;
/*!40000 ALTER TABLE `announcement_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_type_settings`
--

DROP TABLE IF EXISTS `announcement_type_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_type_settings` (
  `announcement_type_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`announcement_type_setting_id`),
  UNIQUE KEY `announcement_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  KEY `announcement_type_settings_type_id` (`type_id`),
  CONSTRAINT `announcement_type_settings_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about announcement types, including localized properties like their names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_type_settings`
--

LOCK TABLES `announcement_type_settings` WRITE;
/*!40000 ALTER TABLE `announcement_type_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_type_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_types`
--

DROP TABLE IF EXISTS `announcement_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_types` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  PRIMARY KEY (`type_id`),
  KEY `announcement_types_context_id` (`context_id`),
  CONSTRAINT `announcement_types_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Announcement types allow for announcements to optionally be categorized.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_types`
--

LOCK TABLES `announcement_types` WRITE;
/*!40000 ALTER TABLE `announcement_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `announcement_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` smallint(6) DEFAULT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `date_expire` date DEFAULT NULL,
  `date_posted` datetime NOT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `announcements_type_id` (`type_id`),
  KEY `announcements_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `announcements_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Announcements are messages that can be presented to users e.g. on the homepage.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author_settings`
--

DROP TABLE IF EXISTS `author_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_settings` (
  `author_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`author_setting_id`),
  UNIQUE KEY `author_settings_unique` (`author_id`,`locale`,`setting_name`),
  KEY `author_settings_author_id` (`author_id`),
  CONSTRAINT `author_settings_author_id` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about authors, including localized properties such as their name and affiliation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author_settings`
--

LOCK TABLES `author_settings` WRITE;
/*!40000 ALTER TABLE `author_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `author_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `author_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(90) NOT NULL,
  `include_in_browse` smallint(6) NOT NULL DEFAULT 1,
  `publication_id` bigint(20) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `user_group_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `authors_user_group_id` (`user_group_id`),
  KEY `authors_publication_id` (`publication_id`),
  CONSTRAINT `authors_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  CONSTRAINT `authors_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='The authors of a publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `seq` bigint(20) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `image` text DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_path` (`context_id`,`path`),
  KEY `category_context_id` (`context_id`),
  KEY `category_context_parent_id` (`context_id`,`parent_id`),
  KEY `category_parent_id` (`parent_id`),
  CONSTRAINT `categories_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Categories permit the organization of submissions into a heirarchical structure.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_settings`
--

DROP TABLE IF EXISTS `category_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_settings` (
  `category_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`category_setting_id`),
  UNIQUE KEY `category_settings_unique` (`category_id`,`locale`,`setting_name`),
  KEY `category_settings_category_id` (`category_id`),
  CONSTRAINT `category_settings_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about categories, including localized properties such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_settings`
--

LOCK TABLES `category_settings` WRITE;
/*!40000 ALTER TABLE `category_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_settings`
--

DROP TABLE IF EXISTS `citation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citation_settings` (
  `citation_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `citation_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`citation_setting_id`),
  UNIQUE KEY `citation_settings_unique` (`citation_id`,`locale`,`setting_name`),
  KEY `citation_settings_citation_id` (`citation_id`),
  CONSTRAINT `citation_settings_citation_id` FOREIGN KEY (`citation_id`) REFERENCES `citations` (`citation_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Additional data about citations, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_settings`
--

LOCK TABLES `citation_settings` WRITE;
/*!40000 ALTER TABLE `citation_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citations`
--

DROP TABLE IF EXISTS `citations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citations` (
  `citation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `publication_id` bigint(20) NOT NULL,
  `raw_citation` text NOT NULL,
  `seq` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`citation_id`),
  UNIQUE KEY `citations_publication_seq` (`publication_id`,`seq`),
  KEY `citations_publication` (`publication_id`),
  CONSTRAINT `citations_publication` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A citation made by an associated publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citations`
--

LOCK TABLES `citations` WRITE;
/*!40000 ALTER TABLE `citations` DISABLE KEYS */;
/*!40000 ALTER TABLE `citations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completed_payments`
--

DROP TABLE IF EXISTS `completed_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_payments` (
  `completed_payment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `payment_type` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `currency_code_alpha` varchar(3) DEFAULT NULL,
  `payment_method_plugin_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`completed_payment_id`),
  KEY `completed_payments_context_id` (`context_id`),
  KEY `completed_payments_user_id` (`user_id`),
  CONSTRAINT `completed_payments_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `completed_payments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of completed (fulfilled) payments relating to a payment type such as a subscription payment.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completed_payments`
--

LOCK TABLES `completed_payments` WRITE;
/*!40000 ALTER TABLE `completed_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `completed_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocab_entries`
--

DROP TABLE IF EXISTS `controlled_vocab_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controlled_vocab_entries` (
  `controlled_vocab_entry_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `controlled_vocab_id` bigint(20) NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`controlled_vocab_entry_id`),
  KEY `controlled_vocab_entries_controlled_vocab_id` (`controlled_vocab_id`),
  KEY `controlled_vocab_entries_cv_id` (`controlled_vocab_id`,`seq`),
  CONSTRAINT `controlled_vocab_entries_controlled_vocab_id_foreign` FOREIGN KEY (`controlled_vocab_id`) REFERENCES `controlled_vocabs` (`controlled_vocab_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='The order that a word or phrase used in a controlled vocabulary should appear. For example, the order of keywords in a publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocab_entries`
--

LOCK TABLES `controlled_vocab_entries` WRITE;
/*!40000 ALTER TABLE `controlled_vocab_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `controlled_vocab_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocab_entry_settings`
--

DROP TABLE IF EXISTS `controlled_vocab_entry_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controlled_vocab_entry_settings` (
  `controlled_vocab_entry_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `controlled_vocab_entry_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`controlled_vocab_entry_setting_id`),
  UNIQUE KEY `c_v_e_s_pkey` (`controlled_vocab_entry_id`,`locale`,`setting_name`),
  KEY `c_v_e_s_entry_id` (`controlled_vocab_entry_id`),
  CONSTRAINT `c_v_e_s_entry_id` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about a controlled vocabulary entry, including localized properties such as the actual word or phrase.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocab_entry_settings`
--

LOCK TABLES `controlled_vocab_entry_settings` WRITE;
/*!40000 ALTER TABLE `controlled_vocab_entry_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `controlled_vocab_entry_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocabs`
--

DROP TABLE IF EXISTS `controlled_vocabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controlled_vocabs` (
  `controlled_vocab_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `symbolic` varchar(64) NOT NULL,
  `assoc_type` bigint(20) NOT NULL DEFAULT 0,
  `assoc_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`controlled_vocab_id`),
  UNIQUE KEY `controlled_vocab_symbolic` (`symbolic`,`assoc_type`,`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Every word or phrase used in a controlled vocabulary. Controlled vocabularies are used for submission metadata like keywords and subjects, reviewer interests, and wherever a similar dictionary of words or phrases is required. Each entry corresponds to a word or phrase like "cellular reproduction" and a type like "submissionKeyword".';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocabs`
--

LOCK TABLES `controlled_vocabs` WRITE;
/*!40000 ALTER TABLE `controlled_vocabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `controlled_vocabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_issue_orders`
--

DROP TABLE IF EXISTS `custom_issue_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_issue_orders` (
  `custom_issue_order_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL,
  `journal_id` bigint(20) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`custom_issue_order_id`),
  UNIQUE KEY `custom_issue_orders_unique` (`issue_id`),
  KEY `custom_issue_orders_issue_id` (`issue_id`),
  KEY `custom_issue_orders_journal_id` (`journal_id`),
  CONSTRAINT `custom_issue_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `custom_issue_orders_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Ordering information for the issue list, when custom issue ordering is specified.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_issue_orders`
--

LOCK TABLES `custom_issue_orders` WRITE;
/*!40000 ALTER TABLE `custom_issue_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_issue_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_section_orders`
--

DROP TABLE IF EXISTS `custom_section_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_section_orders` (
  `custom_section_order_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL,
  `section_id` bigint(20) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`custom_section_order_id`),
  UNIQUE KEY `custom_section_orders_unique` (`issue_id`,`section_id`),
  KEY `custom_section_orders_issue_id` (`issue_id`),
  KEY `custom_section_orders_section_id` (`section_id`),
  CONSTRAINT `custom_section_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `custom_section_orders_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Ordering information for sections within issues, when issue-specific section ordering is specified.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_section_orders`
--

LOCK TABLES `custom_section_orders` WRITE;
/*!40000 ALTER TABLE `custom_section_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_section_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstone_oai_set_objects`
--

DROP TABLE IF EXISTS `data_object_tombstone_oai_set_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_object_tombstone_oai_set_objects` (
  `object_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  PRIMARY KEY (`object_id`),
  KEY `data_object_tombstone_oai_set_objects_tombstone_id` (`tombstone_id`),
  CONSTRAINT `data_object_tombstone_oai_set_objects_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Relationships between tombstones and other data that can be collected in OAI sets, e.g. sections.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstone_oai_set_objects`
--

LOCK TABLES `data_object_tombstone_oai_set_objects` WRITE;
/*!40000 ALTER TABLE `data_object_tombstone_oai_set_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstone_oai_set_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstone_settings`
--

DROP TABLE IF EXISTS `data_object_tombstone_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_object_tombstone_settings` (
  `tombstone_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`tombstone_setting_id`),
  UNIQUE KEY `data_object_tombstone_settings_unique` (`tombstone_id`,`locale`,`setting_name`),
  KEY `data_object_tombstone_settings_tombstone_id` (`tombstone_id`),
  CONSTRAINT `data_object_tombstone_settings_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about data object tombstones, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstone_settings`
--

LOCK TABLES `data_object_tombstone_settings` WRITE;
/*!40000 ALTER TABLE `data_object_tombstone_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstone_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstones`
--

DROP TABLE IF EXISTS `data_object_tombstones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_object_tombstones` (
  `tombstone_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_object_id` bigint(20) NOT NULL,
  `date_deleted` datetime NOT NULL,
  `set_spec` varchar(255) NOT NULL,
  `set_name` varchar(255) NOT NULL,
  `oai_identifier` varchar(255) NOT NULL,
  PRIMARY KEY (`tombstone_id`),
  KEY `data_object_tombstones_data_object_id` (`data_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Entries for published data that has been removed. Usually used in the OAI endpoint.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstones`
--

LOCK TABLES `data_object_tombstones` WRITE;
/*!40000 ALTER TABLE `data_object_tombstones` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doi_settings`
--

DROP TABLE IF EXISTS `doi_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doi_settings` (
  `doi_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doi_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`doi_setting_id`),
  UNIQUE KEY `doi_settings_unique` (`doi_id`,`locale`,`setting_name`),
  KEY `doi_settings_doi_id` (`doi_id`),
  CONSTRAINT `doi_settings_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about DOIs, including the registration agency.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doi_settings`
--

LOCK TABLES `doi_settings` WRITE;
/*!40000 ALTER TABLE `doi_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `doi_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dois`
--

DROP TABLE IF EXISTS `dois`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dois` (
  `doi_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `doi` varchar(255) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  PRIMARY KEY (`doi_id`),
  KEY `dois_context_id` (`context_id`),
  CONSTRAINT `dois_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Stores all DOIs used in the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dois`
--

LOCK TABLES `dois` WRITE;
/*!40000 ALTER TABLE `dois` DISABLE KEYS */;
/*!40000 ALTER TABLE `dois` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edit_decisions`
--

DROP TABLE IF EXISTS `edit_decisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edit_decisions` (
  `edit_decision_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `review_round_id` bigint(20) DEFAULT NULL,
  `stage_id` bigint(20) DEFAULT NULL,
  `round` smallint(6) DEFAULT NULL,
  `editor_id` bigint(20) NOT NULL,
  `decision` smallint(6) NOT NULL COMMENT 'A numeric constant indicating the decision that was taken. Possible values are listed in the Decision class.',
  `date_decided` datetime NOT NULL,
  PRIMARY KEY (`edit_decision_id`),
  KEY `edit_decisions_submission_id` (`submission_id`),
  KEY `edit_decisions_editor_id` (`editor_id`),
  KEY `edit_decisions_review_round_id` (`review_round_id`),
  CONSTRAINT `edit_decisions_editor_id` FOREIGN KEY (`editor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `edit_decisions_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  CONSTRAINT `edit_decisions_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Editorial decisions recorded on a submission, such as decisions to accept or decline the submission, as well as decisions to send for review, send to copyediting, request revisions, and more.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edit_decisions`
--

LOCK TABLES `edit_decisions` WRITE;
/*!40000 ALTER TABLE `edit_decisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `edit_decisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log`
--

DROP TABLE IF EXISTS `email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `date_sent` datetime NOT NULL,
  `event_type` bigint(20) DEFAULT NULL,
  `from_address` varchar(255) DEFAULT NULL,
  `recipients` text DEFAULT NULL,
  `cc_recipients` text DEFAULT NULL,
  `bcc_recipients` text DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `email_log_assoc` (`assoc_type`,`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A record of email messages that are sent in relation to an associated entity, such as a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log_users`
--

DROP TABLE IF EXISTS `email_log_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_log_users` (
  `email_log_user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_log_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`email_log_user_id`),
  UNIQUE KEY `email_log_user_id` (`email_log_id`,`user_id`),
  KEY `email_log_users_email_log_id` (`email_log_id`),
  KEY `email_log_users_user_id` (`user_id`),
  CONSTRAINT `email_log_users_email_log_id_foreign` FOREIGN KEY (`email_log_id`) REFERENCES `email_log` (`log_id`) ON DELETE CASCADE,
  CONSTRAINT `email_log_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A record of users associated with an email log entry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log_users`
--

LOCK TABLES `email_log_users` WRITE;
/*!40000 ALTER TABLE `email_log_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_templates` (
  `email_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `context_id` bigint(20) NOT NULL,
  `alternate_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email_templates_email_key` (`email_key`,`context_id`),
  KEY `email_templates_context_id` (`context_id`),
  KEY `email_templates_alternate_to` (`alternate_to`),
  CONSTRAINT `email_templates_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Custom email templates created by each context, and overrides of the default templates.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'COPYEDIT_REQUEST',1,'DISCUSSION_NOTIFICATION_COPYEDITING'),(2,'EDITOR_ASSIGN_SUBMISSION',1,'DISCUSSION_NOTIFICATION_SUBMISSION'),(3,'EDITOR_ASSIGN_REVIEW',1,'DISCUSSION_NOTIFICATION_REVIEW'),(4,'EDITOR_ASSIGN_PRODUCTION',1,'DISCUSSION_NOTIFICATION_PRODUCTION'),(5,'LAYOUT_REQUEST',1,'DISCUSSION_NOTIFICATION_PRODUCTION'),(6,'LAYOUT_COMPLETE',1,'DISCUSSION_NOTIFICATION_PRODUCTION');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates_default_data`
--

DROP TABLE IF EXISTS `email_templates_default_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_templates_default_data` (
  `email_templates_default_data_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `locale` varchar(14) NOT NULL DEFAULT 'en',
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text DEFAULT NULL,
  PRIMARY KEY (`email_templates_default_data_id`),
  UNIQUE KEY `email_templates_default_data_unique` (`email_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Default email templates created for every installed locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates_default_data`
--

LOCK TABLES `email_templates_default_data` WRITE;
/*!40000 ALTER TABLE `email_templates_default_data` DISABLE KEYS */;
INSERT INTO `email_templates_default_data` VALUES (1,'PASSWORD_RESET_CONFIRM','es','Confirmación de restablecimiento de contraseña','Confirmación de cambio de contraseña','Hemos recibido una petición para cambiar su contraseña en {$siteTitle}.<br />\n<br />\nSi no hizo usted esta petición ignore este correo-e y su contraseña no cambiará. Si desea cambiar su contraseña pinche en el enlace que le mostramos a continuación.<br />\n<br />\nCambiar mi contraseña: {$passwordResetUrl}<br />\n<br />\n{$siteContactName}'),(2,'USER_REGISTER','es','Usuario/a creado','Nuevo registro de usuaria/o','{$recipientName}<br />\n<br />\nSe ha registrado con éxito como usuario/a en {$journalName}. En este correo se incluyen su nombre de usuario/a y contraseña, datos necesarios para realizar cualquier tarea relacionada con la revista a través de la página web. En cualquier momento puede solicitar que se le elimine de la lista de usuarios/as de la revista contactándome.<br />\n<br />\nNombre de usuario/a: {$recipientUsername}<br />\nContraseña: {$password}<br />\n<br />\nGracias,<br />\n{$signature}'),(3,'USER_VALIDATE_CONTEXT','es','Validar correo electrónico (registro en la revista)','Valide su cuenta','Estimado/a {$recipientName}<br />\n<br />\nHa creado una cuenta de usuario/a en {$journalName}, pero antes de poder utilizarla debe validar su correo electrónico. Para ello, simplemente haga clic en el siguiente enlace:<br />\n<br />\n{$activateUrl}<br />\n<br />\nGracias,<br />\n{$journalSignature}'),(4,'USER_VALIDATE_SITE','es','Validar correo electrónico (Sitio)','Valide su cuenta','{$recipientName}<br />\n<br />\nHa creado una cuenta en {$siteTitle}, pero antes de poder utilizarla, debe validar su email. Para hacerlo, simplemente haga clic en el siguiente enlace:<br />\n<br />\n{$activateUrl}<br />\n<br />\nGracias,<br />\n{$siteSignature}'),(5,'REVIEWER_REGISTER','es','Registro de revisor/a','Registro como Revisor en {$journalName}','<p>Estimado/a {$recipientName},</p><p>En vista de su experiencia, hemos registrado su nombre en la base de datos de revisores/as de {$journalName}. Esto no implica ningún compromiso por su parte, simplemente nos permite contactarle para una posible revisión de un trabajo. Cuando reciba una invitación para revisar podrá ver el título y el resumen del artículo en cuestión, y siempre tendrá la posibilidad de aceptar o rechazar la invitación. También puede pedirnos en cualquier momento que lo eliminemos de la lista de revisores/as.</p><p>Le enviamos el nombre de usuario/a y la contraseña, que le servirán para realizar cualquier tarea de la revista a través de su página web. Por ejemplo, puede actualizar su perfil e incluir sus intereses de revisión.</p><p>Nombre de usuario/a: {$recipientUsername}<br />Contraseña: {$password}</p><p>Gracias,</p>{$signature}'),(6,'ISSUE_PUBLISH_NOTIFY','es','Notificación de número publicado','Nuevo número publicado: {$issueIdentification} en {$journalName}','<p>Estimado/a {$recipientName},</p><p>Nos complace anunciar la publicación de <a href=\"{$issueUrl}\">{$issueIdentification}</a> de {$journalName}. Le invitamos a leer y compartir este trabajo con su comunidad académica.</p><p>Agradecemos a nuestros autores/as, revisores/as y editores/as sus valiosas contribuciones, y a nuestros lectores/as su interés.</p><p>Gracias,</p>{$signature}'),(7,'SUBMISSION_ACK','es','Confirmación de envío','Gracias por su envío a {$journalName}','<p>Estimado/a {$recipientName}:</p><p>Gracias por su envío a {$journalName}. Hemos recibido su original, {$submissionTitle}, y un miembro de nuestro equipo editorial lo revisará pronto. Le enviaremos un correo electrónico cuando se tome una decisión inicial, y podríamos contactarlo para darle más información.</p></p> Puede ver el envío y seguir su progreso a través del proceso editorial en el enlace siguiente:</p><p>URL del envío: {$authorSubmissionUrl}</p><p>Si se ha cerrado la sesión, puede volver a iniciarla con su nombre de usuario/a {$recipientUsername}.</p><p>Si tiene cualquier duda contacte con nosotros desde el <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Gracias por tener en cuenta {$journalName} como hogar para su trabajo.</p>{$journalSignature}'),(8,'SUBMISSION_ACK_NOT_USER','es','Confirmación del envío (otros autores/as)','Acuse de recibo del envío','Hola,<br />\n<br />\n{$submitterName} ha enviado el manuscrito &quot;{$submissionTitle}&quot; a {$journalName}. <br />\n<br />\nSi tiene cualquier pregunta no dude en contactarme. Le agradecemos que haya elegido esta revista para dar a conocer su obra.<br />\n<br />\n{$journalSignature}'),(9,'EDITOR_ASSIGN','es','Editor/a asignado','Ha sido asignado como editor/a de un envío para {$journalName}','<p>Estimado/a {$recipientName},</p><p>Se le ha asignado el siguiente envío para que coordine su proceso editorial.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Resumen</b></p>{$submissionAbstract}<p>Si le parece que el envío es relevante para {$journalName}, envíelo a la fase de revisión seleccionando \"Enviar a revisión\" y luego asigne revisores/as haciendo clic en \"Añadir revisor/a\".</p><p>Si el envío no es apropiado para esta revista, rechácelo.</p><p>Gracias de antemano.</p><p>Atentamente,</p>{$journalSignature}'),(10,'REVIEW_CANCEL','es','Desasignar revisor/a','Petición de revisión cancelada','<p>Estimado/a {$recipientName},</p><p>Recientemente, le pedimos que revisara una presentación para {$journalName}. Hemos decidido cancelar la solicitud para que revise el artículo, {$submissionTitle}.</p><p>Lamentamos cualquier inconveniente que esto pueda causarle y esperamos poder contar con su ayuda en el futuro para el proceso de revisión de esta revista.</p><p>Si tiene alguna pregunta, por favor contácteme.</p>{$signature}'),(11,'REVIEW_REINSTATE','es','Restaurar revisor/a','¿Aún puede hacer revisiones para {$journalName}?','<p>Estimado {$recipientName},</p><p>Recientemente cancelamos nuestra solicitud para que revisara una presentación, {$submissionTitle}, para {$journalName}. Hemos revertido esa decisión y esperamos que todavía pueda llevar a cabo la revisión.</p><p>Si puede ayudar con la revisión de este artículo, puede <a href=\"{$reviewAssignmentUrl}\">iniciar sesión en la revista</a> para ver la presentación, cargar archivos de revisión y enviar su solicitud de revisión.</p><p>Si tiene alguna pregunta, por favor contácteme.</p><p>Atentamente,</p>{$signature}'),(12,'REVIEW_RESEND_REQUEST','es','Reenviar la solicitud de revisión al revisor/a','Solicitando de nuevo su revisión para {$journalName}',''),(13,'REVIEW_REQUEST','es','Solicitud de revisión','Invitación de revisión','<p>Estimado/a {$recipientName},</p><p>Creemos que sería un excelente revisor/a para el envío a {$journalName}. El título y el resumen del envío se encuentran a continuación, espero que considere asumir esta tarea tan importante para nosotros.</p><p>Si puede revisar este envío, debería devolvernos su revisión antes del {$reviewDueDate}. Puede ver el envío, cargar los archivos de revisión y enviarnos su revisión iniciando sesión en el sitio de la revista y siguiendo los pasos del siguiente enlace.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Resumen</b></p>{$submissionAbstract}<p>Por favor, <a href=\"{$reviewAssignmentUrl}\">acepte o rechace</a> la revisión antes del <b>{$responseDueDate}</b>.</p><p>Puede ponerse en contacto con nosotros si tiene alguna pregunta sobre el envío o el proceso de revisión.</p><p>Gracias por considerar esta solicitud. Apreciamos mucho su ayuda.</p><p>Atentamente,</p>{$signature}'),(14,'REVIEW_REQUEST_SUBSEQUENT','es','Solicitud de revisión posterior','Solicitud para revisar un envío ya revisado','<p>Estimado/a {$recipientName},</p><p>Le agradecemos su revisión de <a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a>. Los autores/as han tenido en cuenta los comentarios de los revisores/as y han enviado una versión revisada de su trabajo. Le escribo para preguntarle si podría realizar una segunda ronda de revisión por pares de este envío.</p><p>Si está disponible para revisar este envío, debería devolvernos su revisión antes del {$reviewDueDate}. Puede <a href=\"{$reviewAssignmentUrl}\">seguir los pasos de revisión</a> para ver el envío, cargar archivos de revisión y enviar sus comentarios de revisión.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Resumen</b></p>{$submissionAbstract}<p>Por favor, <a href=\"{$reviewAssignmentUrl}\">acepte o rechace</a> la revisión antes del <b>{$responseDueDate}</b>.</p><p>No dude en ponerse en contacto con nosotros si tiene alguna pregunta sobre el envío o el proceso de revisión.</p><p>Gracias por considerar esta solicitud. Apreciamos mucho su ayuda.</p><p>Atentamente,</p>{$signature}'),(15,'REVIEW_RESPONSE_OVERDUE_AUTO','es','Respuesta de revisión vencida (automática)','¿Podrá llevar a cabo la revisión?','<p>Estimado/a {$recipientName},</p><p>Este correo electrónico es un recordatorio automático de {$journalName} en relación con la solicitud de revisión del envío, \"{$submissionTitle}.\"</p><p>El motivo de este mensaje es que aún no hemos recibido la confirmación de si podrá llevar a cabo la revisión de este envío.</p><p>Por favor, háganos saber su decisión mediante nuestro software de gestión de envíos aceptando o rechazando dicha solicitud.</p><p>Si está dispuesto a aceptar el encargo, su revisión debería estar lista el {$reviewDueDate}. Puede seguir los pasos de revisión para visualizar el envío, cargar archivos de revisión y enviar sus comentarios.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Resumen</b></p>{$submissionAbstract}<p>No dude en ponerse en contacto con nosotros si tiene cualquier pregunta acerca del envío o del proceso de revisión.</p><p>Gracias por tomar en consideración esta petición. Su ayuda es muy valiosa.</p><p>Saludos cordiales,</p>{$journalSignature}'),(16,'REVIEW_CONFIRM','es','Confirmación de la revisión','Revisión aceptada: {$reviewerName} aceptó la asignación de revisión de #{$submissionId} {$authorsShort} — {$submissionTitle}','Editores/as:<br />\n<br />\nTengo la capacidad y deseo revisar el envío &quot;{$submissionTitle},&quot; para {$journalName}. Gracias por acordarse de mí, es mi intención tener la revisión completa en el plazo indicado: {$reviewDueDate}, a ser posible antes.<br />\n<br />\n{$senderName}'),(17,'REVIEW_DECLINE','es','Rechazo de la revisión','Rechazo la revisión','Editores/as:<br />\n<br />\nMe temo que en este momento no voy a poder revisar el envío &quot;{$submissionTitle},&quot; para {$journalName}. Gracias por pensar en mí, espero que vuelvan a contar conmigo en futuras ocasiones.<br />\n<br />\n{$senderName}'),(18,'REVIEW_ACK','es','Agradecimiento por la revisión','Gracias por su revisión','<p>Estimado/a {$recipientName},</p>\n<p>Gracias por completar la revisión del envío, {$submissionTitle}, para {$journalName}. Le agradecemos su tiempo y su pericia, que contribuyen a la calidad de las obras que publicamos.</p>\n<p>Ha sido un placer trabajar con usted como revisor/a para {$journalName}, y esperamos tener la oportunidad de seguir haciéndolo en el futuro.</p>\n<p>Saludos cordiales,</p>\n<p>{$signature}</p>'),(19,'REVIEW_REMIND','es','Recordatorio de la revisión','Recordatorio para que complete la revisión','<p>Estimado/a {$recipientName},</p><p>Esto es solo un amable recordatorio de nuestra solicitud de revisión del artículo \"{$submissionTitle}\" para {$journalName}. Esperábamos recibir la revisión el {$reviewDueDate}, por lo que nos complacería recibirla tan pronto como sea posible.</p><p>Puede <a href=\"{$reviewAssignmentUrl}\">iniciar sesión en la revista</a> y seguir los pasos de revisión para ver el artículo, cargar archivos de revisión y enviar sus comentarios.</p><p>Si necesita una prórroga en la fecha límite, póngase en contacto con nosotros. Espero tener noticias suyas pronto.</p><p>Muchas gracias y cordiales saludos,</p>{$signature}'),(20,'REVIEW_REMIND_AUTO','es','Recordatorio de revisión (automático)','Recordatorio para que complete su revisión','<p>Estimado/a {$recipientName}:</p><p>Este correo electrónico es un recordatorio automático de {$journalName} en relación con nuestra solicitud de revisión del envío \"{$submissionTitle}\".</p><p>Esperábamos disponer de esta revisión el {$reviewDueDate} y nos complacería recibirla tan pronto como sea posible.</p><p>Por favor, <a href=\"{$reviewAssignmentUrl}\">inicie sesión en la revista</a> y siga los pasos de revisión para ver el artículo, cargar archivos de revisión y enviar sus comentarios de revisión.</p><p>Si necesita una extensión de la fecha límite, póngase en contacto con nosotros. Espero tener noticias suyas pronto.</p><p>Muchas gracias y saludos cordiales,</p>{$journalSignature}'),(21,'REVIEW_COMPLETE','es','Revisión finalizada','Revisión completada: {$reviewerName} recomienda {$reviewRecommendation} para #{$submissionId} {$authorsShort} — {$submissionTitle}',''),(22,'REVIEW_EDIT','es','Revisión editada','Se ha modificado su asignación de revisión para {$journalName}',''),(23,'EDITOR_DECISION_ACCEPT','es','Envío aceptado','Su envío a {$journalName} ha sido aceptado','<p>Estimado/a {$recipientName},</p><p>Nos complace informarle de que hemos decidido aceptar su envío sin necesidad de realizar más revisiones. Tras una minuciosa revisión le confirmamos que su artículo \"{$submissionTitle}\" cumple o supera nuestras expectativas. Estamos entusiasmados por publicar su trabajo en {$journalName} y le agradecemos que haya elegido nuestra revista como hogar de su obra.</p><p>Su envío se publicará en un número futuro de {$journalName}, le invitamos a incluirlo en su lista de publicaciones. Reconocemos el arduo trabajo que conlleva cada envío exitoso, así que queremos felicitarlo por haber alcanzado esta fase.</p><p>Ahora su envío será sometido a edición y formateo para prepararlo para su publicación.</p><p>Pronto recibirá más instrucciones.</p><p>Si tiene alguna pregunta, póngase en contacto con nosotros a través del <a href=\"{$authorSubmissionUrl}\">panel de envío</a>.</p><p>Atentamente,</p>{$signature}'),(24,'EDITOR_DECISION_SEND_TO_EXTERNAL','es','Enviar a revisión','Su envío se ha enviado a revisión','<p>Estimado/a {$recipientName},</p><p>Me complace anunciarle que un editor/a ha revisado su envío, {$submissionTitle}, y ha decidido remitirlo a evaluación por pares. El editor/a identificará a revisores/as cualificados que aportarán comentarios sobre su envío.</p><p>{$reviewTypeDescription} Le enviaremos dichos comentarios y la información acerca de los próximos pasos.</p><p>Tenga en cuenta que el hecho de enviar su artículo a evaluación por pares no garantiza que se acabe publicando. Consideraremos las recomendaciones de los revisores/as antes de decidir si aceptamos el envío para publicarse. Podríamos solicitarle que haga revisiones y responda a los comentarios de los revisores/as antes de tomar la decisión final.</p><p>Si tiene cualquier duda puede contactar con nosotros desde su panel de control del envío.</p><p>{$signature}</p>'),(25,'EDITOR_DECISION_SEND_TO_PRODUCTION','es','Enviar a producción','Próximos pasos para publicar su envío','<p>Estimado/a {$recipientName},</p><p>Le escribo de {$journalName} para informarle de que la edición de su envío, {$submissionTitle}, ha finalizado. Ahora su envío avanzará a la fase de producción, donde prepararemos las galeradas finales para su publicación. Nos pondremos en contacto con usted si necesitamos más ayuda.</p><p>Si tiene cualquier duda contacte con nosotros desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Saludos cordiales,</p>{$signature}'),(26,'EDITOR_DECISION_REVISIONS','es','Revisiones solicitadas','Su envío se ha revisado y le animamos a que tramite sus revisiones','<p>Estimado/a {$recipientName},</p><p>Su envío {$submissionTitle} ha sido revisado y nos gustaría animarlo a que nos remita las revisiones que respondan a los comentarios de los revisores/as. Un editor/a examinará dichas revisiones y, si resuelven adecuadamente los problemas, su envío podrá ser aceptado para publicarse.</p><p>Los comentarios de los revisores/as se incluyen al final de este correo electrónico. Responda a cada uno de los punto de los comentarios de los revisores/as e identifique los cambios que haya hecho. Si considera que alguno de los comentarios de los revisores/as no está justificado o es inapropiado, explíquenos su punto de vista.</p><p>Cuando haya completado las revisiones puede cargar los documentos revisados, junto con la respuesta a los comentarios de los revisores/as, en su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>. Si ha cerrado la sesión puede volver a iniciarla con su nombre de usuario/a {$recipientUsername}.</p><p>Si tiene cualquier pregunta no dude en contactarnos desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Quedamos a la espera de recibir su envío revisado.</p><p>Saludos cordiales,</p>{$signature}<hr><p>Se recibieron los siguientes comentarios de los revisores/as.</p>{$allReviewerComments}'),(27,'EDITOR_DECISION_RESUBMIT','es','Reenviar para revisión','Se ha revisado su envío. Por favor, revíselo y vuelva a enviarlo','<p>Estimado/a {$recipientName},</p><p>Tras revisar su envío, {$submissionTitle}, los revisores/as han recomendado que no puede ser aceptado para publicarse en su estado actual. No obstante, nos gustaría animarle a que nos envíe una versión revisada que tenga en cuenta los comentarios de los revisores/as. Los cambios serán revisados por el editor/a y el artículo podría ser enviado a una nueva ronda de evaluación por pares.</p><p>Tenga en cuenta que el hecho de volver a enviar su artículo no garantiza que sea aceptado.</p><p>Los comentarios de los revisores/as se incluyen al final de este correo electrónico. Por favor, responda a cada punto e identifique los cambios que haga. Si considera inapropiado algún comentario de los revisores/as, explíquenos su punto de vista. Si tiene dudas acerca de las recomendaciones en su revisión, inclúyalas en su respuesta.</p><p>Cuando haya completado las revisiones puede cargar los documentos revisados, junto con la respuesta a los comentarios de los revisores/as, en su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>. Si ha cerrado la sesión puede volver a iniciarla con su nombre de usuario/a {$recipientUsername}.</p><p>Si tiene cualquier pregunta no dude en contactarnos desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Quedamos a la espera de recibir su envío revisado.</p><p>Saludos cordiales,</p>{$signature}<hr><p>Se recibieron los siguientes comentarios de los revisores/as.</p>{$allReviewerComments}'),(28,'EDITOR_DECISION_DECLINE','es','Envío rechazado','Se ha rechazado su envío','<p>Estimado/a{$recipientName},</p><p>Aunque valoramos mucho la recepción de su envío, de acuerdo con los comentarios de los revisores/as no podemos aceptar {$submissionTitle} para publicarse.</p><p>Dichos comentarios se incluyen al final de este correo electrónico.</p><p>Gracias por su envío a {$journalName}. A pesar de que es decepcionante que se rechace el envío, esperamos que los comentarios de los revisores/as le resulten constructivos y útiles.</p><p>Ahora es libre de presentar el trabajo en otro sitio si así lo desea.</p><p>Saludos cordiales,</p>{$signature}<hr><p>Se recibieron los siguientes comentarios de los revisores.</p>{$allReviewerComments}'),(29,'EDITOR_DECISION_INITIAL_DECLINE','es','Envío rechazado (antes de revisión)','Su envío ha sido rechazado','<p>Estimado/a {$recipientName},</p><p>Lamento informarlo de que, tras la revisión de su artículo, {$submissionTitle}, el editor/a ha considerado que no cumple los requisitos de publicación en {$journalName}.</p><p>Le deseo mucha suerte si decide enviarlo a otro sitio.</p><p>Saludos cordiales,</p>{$signature}'),(30,'EDITOR_RECOMMENDATION','es','Recomendación hecha','Recomendación del editor/a','<p>Estimado/a{$recipientName},</p><p>Tras considerar los comentarios de los revisores/as, me gustaría emitir la siguiente recomendación en relación con su envío {$submissionTitle}.</p><p>Mi recomendación es: {$recommendation}.</p><p>Visite el <a href=\"{$submissionUrl}\">flujo editorial</a> del envío para actuar sobre esta recomendación.</p><p>Si tiene alguna pregunta, no dude en ponerse en contacto conmigo.</p><p>Saludos cordiales,</p><p>{$senderName}</p>'),(31,'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS','es','Notificar a los otros autores/as','Actualización acerca de su envío','<p>El siguiente correo electrónico fue enviado a {$submittingAuthorName} desde {$journalName} en relación con {$submissionTitle}.</p>\n<p>El motivo por el que recibe una copia de esta notificación es porque está identificado como autor/a de este envío. Las instrucciones que figuran en el siguiente mensaje se dirigen al autor/a principal del envío, {$submittingAuthorName}, por lo que no se requiere ninguna acción suya en este momento.</p>\n\n{$messageToSubmittingAuthor}'),(32,'EDITOR_DECISION_NOTIFY_REVIEWERS','es','Notificar a los revisores/as de la decisión','Gracias por su revisión','<p>Estimado/a {$recipientName},</p>\n<p>Gracias por completar la revisión del envío, {$submissionTitle}, para {$journalName}. Le agradecemos su tiempo y su pericia, que contribuyen a la calidad de las obras que publicamos. Hemos compartido sus comentarios con los autores/as, junto con los comentarios de los otros revisores/as y la decisión editorial.</p>\n<p>A partir de los comentarios recibidos, hemos notificado a los autores/as lo siguiente:</p>\n<p>{$decisionDescription}</p>\n<p>Su recomendación, junto con la de otros revisores/as, se ha considerado antes de llegar a una decisión final. A veces, la decisión del editor/a puede diferir de la recomendación hecha por uno o más revisores/as. El editor/a tiene en cuenta muchos factores y no se toma estas decisiones a la ligera. Estamos muy agradecidos por la pericia y las sugerencias de nuestros revisores/as.</p>\n<p>Ha sido un placer trabajar con usted como revisor/a para {$journalName}, y esperamos tener la oportunidad de seguir haciéndolo en el futuro.</p>\n<p>Saludos cordiales,</p>\n<p>{$signature}</p>'),(33,'EDITOR_DECISION_NEW_ROUND','es','Se inició una ronda de revisión nueva','Su envío se ha tramitado a otra ronda de revisión','<p>Estimado/a {$recipientName},</p>\n<p>Su manuscrito revisado, {$submissionTitle}, se ha enviado a una ronda de evaluación por pares nueva.\nLe comunicaremos los comentarios de los revisores/as y la información sobre los próximos pasos.</p>\n<p>Si tiene cualquier pregunta puede contactar con nosotros desde el <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p>\n<p>Saludos cordiales,</p>\n<p>{$signature}</p>\n'),(34,'EDITOR_DECISION_REVERT_DECLINE','es','Restaurar envío rechazado','Hemos revertido la decisión de rechazar su envío','<p>Estimado/a {$recipientName},</p>\n<p>La decisión de rechazar su envío, {$submissionTitle}, se ha revertido.\nUn editor/a completará la ronda de revisión y, cuando se haya tomado una decisión, \nse le notificará.</p>\n<p>A veces se registra accidentalmente en nuestro sistema la decisión de rechazar un envío\ny esta acción debe ser revertida. Le pedimos disculpas por la confusión que esto le haya podido causar.</p>\n<p>Nos pondremos en contacto con usted si necesitamos más ayuda.</p>\n<p>Si tiene cualquier pregunta puede contactarnos desde el <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p>\n<p>Saludos cordiales,</p>\n<p>{$signature}</p>\n'),(35,'EDITOR_DECISION_REVERT_INITIAL_DECLINE','es','Restaurar el envío rechazado sin revisión','Hemos revertido la decisión de rechazar su envío','<p>Estimado/a {$recipientName},</p>\n<p>La decisión de rechazar su envío, {$submissionTitle}, se ha revertido. \nUn editor/a estudiará su propuesta antes de decidir si la rechaza \no la envía a revisión.</p>\n<p>A veces se registra accidentalmente en nuestro sistema la decisión de rechazar un envío\ny esta acción debe ser revertida. Le pedimos disculpas por la confusión que esto le haya podido causar.</p>\n<p>Nos pondremos en contacto con usted si necesitamos más ayuda.</p>\n<p>Si tiene cualquier pregunta puede contactarnos desde el <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p>\n<p>Saludos cordiales,</p>\n<p>{$signature}</p>\n'),(36,'EDITOR_DECISION_SKIP_REVIEW','es','Envío aceptado (sin revisión)','Su artículo se ha enviado a edición','<p>Estimado/a {$recipientName},</p>\n<p>Me complace informarle de que hemos decidido aceptar su envío sin pasar por la fase de revisión por pares. Le confirmamos que su envío \"{$submissionTitle}\" cumple con nuestras expectativas, por lo que no necesitamos que este tipo de trabajo pase por la fase de revisión por pares. Estamos emocionados por publicar su trabajo en {$journalName} y le agradecemos que haya elegido nuestra revista como hogar de su trabajo.</p>\n<p>Su envío se publicará en un número futuro de {$journalName}, así que le invitamos a incluirlo en su lista de publicaciones. Reconocemos el arduo trabajo que implica cada envío exitoso y queremos felicitarle por sus esfuerzos.</p>\n<p>Ahora su envío pasará a edición y formateo para su posterior publicación. </p>\n<p>En breve recibirá más instrucciones.</p>\n<p>Si tiene alguna pregunta, póngase en contacto con nosotros a través de su <a href=\"{$authorSubmissionUrl}\">panel de envíos</a>.</p>\n<p>Atentamente,</p>\n<p>{$signature}</p>\n'),(37,'EDITOR_DECISION_BACK_FROM_PRODUCTION','es','Se ha retornado el envío a Edición','Su envío se ha devuelto a edición','<p>Estimado/a {$recipientName},</p><p>Su envío, {$submissionTitle}, se ha devuelto a la fase de edición, donde se someterá a una nueva corrección y formateo para prepararlo para su publicación.</p><p>A veces, un envío pasa a la fase de producción antes de estar listo para preparar las galeradas finales que se utilizarán para su publicación. Su envío aún está en preparación. Lamentamos cualquier confusión que le hayamos causado.</p><p>Si tiene cualquier duda puede contactarnos desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Nos pondremos en contacto con usted si necesitamos más ayuda.</p><p>Saludos cordiales,</p><p>{$signature}</p>'),(38,'EDITOR_DECISION_BACK_FROM_COPYEDITING','es','Envío retornado desde Edición','Su envío se ha devuelto a revisión','<p>Estimado/a {$recipientName},</p><p>Su envío, {$submissionTitle}, se ha devuelto a la fase de revisión, donde se someterá a una nueva revisión antes de ser aceptado para su publicación.</p><p>A veces, la decisión de aceptar un envío puede registrarse accidentalmente en el sistema y por ello debemos enviarlo de nuevo a revisión. Lamentamos cualquier confusión que le hayamos causado. Nos encargaremos de completar rápidamente cualquier otra revisión para darle la decisión final lo antes posible.</p><p>Nos pondremos en contacto con usted si necesitamos más ayuda.</p><p>Si tiene cualquier duda puede contactarnos desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Saludos cordiales,</p><p>{$signature}</p>'),(39,'EDITOR_DECISION_CANCEL_REVIEW_ROUND','es','Ronda de revisión cancelada','Se ha cancelado una ronda de revisión de su envío','<p>Estimado/a {$recipientName},</p><p>Hace poco iniciamos una ronda de revisión nueva para su envío, {$submissionTitle}. Ahora la vamos a cerrar.</p><p>A veces, la decisión de iniciar una ronda de revisión nueva puede registrarse accidentalmente en el sistema y por ello debemos cancelarla. Lamentamos cualquier confusión que le hayamos causado.</p><p>Nos pondremos en contacto con usted si necesitamos más ayuda.</p><p>Si tiene cualquier duda puede contactarnos desde su <a href=\"{$authorSubmissionUrl}\">panel de control del envío</a>.</p><p>Saludos cordiales,</p><p>{$signature}</p>'),(40,'SUBSCRIPTION_NOTIFY','es','Notificación de suscripción','Notificación de suscripción','{$recipientName}:<br />\n<br />\nAcaba de registrarse como suscriptor/a en nuestro sistema de gestión de revistas online para la revista {$journalName}, a continuación le mostramos los datos de su suscripción:<br />\n<br />\n{$subscriptionType}<br />\n<br />\nPara acceder al contenido exclusivo para suscriptores/as, simplemente tiene que identificarse con su nombre de usuaria/o, &quot;{$recipientUsername}&quot;.<br />\n<br />\nUna vez se haya identificado en el sistema puede cambiar los detalles de su perfil y su contraseña en cualquier momento.<br />\n<br />\nTenga en cuenta que si se trata de una suscripción institucional no es necesario que los/as usuarios/as de su institución se identifiquen, ya que las peticiones de contenido bajo suscripción serán autentificadas automáticamente por el sistema.<br />\n<br />\nSi tiene cualquier pregunta no dude en contactar con nosotros/as.<br />\n<br />\n{$subscriptionSignature}'),(41,'OPEN_ACCESS_NOTIFY','es','Notificación de acceso abierto','Acceso libre: {$issueIdentification} de {$journalName} ahora está disponible en acceso abierto','<p>Estimado/a {$recipientName},</p><p>Nos complace informarle de que <a href=\"{$issueUrl}\">{$issueIdentification}</a> de {$journalName} ya está disponible en acceso abierto. Por lo tanto, ya no es necesaria una suscripción para leer este número.</p><p>Gracias por mantener el interés en nuestro trabajo.</p>{$journalSignature}'),(42,'SUBSCRIPTION_BEFORE_EXPIRY','es','La suscripción caduca pronto','Notificación de expiración de suscripción','{$recipientName}:<br />\n<br />\n	Su suscripción a {$journalName} está a punto de caducar.<br />\n<br />\n	{$subscriptionType}<br />\n	Fecha de caducidad: {$expiryDate}<br />\n<br />\n	Para asegurarse de que continúa teniendo acceso a la revista, acceda a la página web de la revista y renueve su suscripción. Puede iniciar sesión en el sistema con su nombre de usuario/a, &quot;{$recipientUsername}&quot;.<br />\n<br />\n	Si tiene cualquier pregunta no dude en contactarme.<br />\n<br />\n	{$subscriptionSignature}'),(43,'SUBSCRIPTION_AFTER_EXPIRY','es','Suscripción caducada','Subscripción expirada','{$recipientName}:<br />\n<br />\n	Su suscripción a {$journalName} ha caducado.<br />\n<br />\n	{$subscriptionType}<br />\n	Fecha de caducidad: {$expiryDate}<br />\n<br />\n	Para renovar su suscripción acceda a la página web de la revista. Puede iniciar sesión en el sistema con su nombre de usuario/a, &quot;{$recipientUsername}&quot;.<br />\n<br />\n	Si tiene cualquier pregunta no dude en contactarme.<br />\n<br />\n	{$subscriptionSignature}'),(44,'SUBSCRIPTION_AFTER_EXPIRY_LAST','es','Última suscripción caducada','Suscripción expirada - Último recordatorio','{$recipientName}:<br />\n<br />\n	Su suscripción a {$journalName} ha caducado.<br />\n	Tenga en cuenta que este es el último correo que recibirá para recordárselo.<br />\n<br />\n	{$subscriptionType}<br />\n	Fecha de caducidad: {$expiryDate}<br />\n<br />\n	Para renovar su suscripción acceda a la página web de la revista. Puede iniciar sesión en el sistema con su nombre de usuario/a, &quot;{$recipientUsername}&quot;.<br />\n<br />\n	Si tiene cualquier pregunta no dude en contactarme.<br />\n<br />\n	{$subscriptionSignature}'),(45,'SUBSCRIPTION_PURCHASE_INDL','es','Adquirir suscripción individual','Compra de suscripción: Individual','Se ha adquirido en línea una suscripción individual para {$journalName} con los detalles siguientes:<br />\n<br />\nTipo de suscripción:<br />\n{$subscriptionType}<br />\n<br />\nUsuario/a:<br />\n{$subscriberDetails}<br />\n<br />\nInformación de membresía (si se proporciona):<br />\n{$membership}<br />\n<br />\nPara ver o editar esta suscripción, use la siguiente URL.<br />\n<br />\nURL de la suscripción: {$subscriptionUrl}<br />\n'),(46,'SUBSCRIPTION_PURCHASE_INSTL','es','Adquirir suscripción institucional','Compra de suscripción: Institucional','Se ha adquirido en línea una suscripción institucional para {$journalName} con los siguientes detalles. Para activar la suscripción, use el enlace proporcionado y configure el estado de la suscripción como \'Activo\'.<br />\n<br />\nTipo de suscripción:<br />\n{$subscriptionType}<br />\n<br />\nInstitución:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDominio (si se proporciona):<br />\n{$domain}<br />\n<br />\nRangos de IP (si se proporcionan):<br />\n{$ipRanges}<br />\n<br />\nPersona de contacto:<br />\n{$subscriberDetails}<br />\n<br />\nInformación de membresía (si se proporciona):<br />\n{$membership}<br />\n<br />\nPara ver o editar esta suscripción, use el siguiente enlace.<br />\n<br />\nEnlace de la suscripción: {$subscriptionUrl}<br />\n'),(47,'SUBSCRIPTION_RENEW_INDL','es','Renovar suscripción individual','Renovación de suscripción: Individual','Una suscripción individual ha sido renovada en línea para {$journalName} con los siguientes detalles.<br />\n<br />\nTipo de suscripción:<br />\n{$subscriptionType}<br />\n<br />\nUsuario/a:<br />\n{$subscriberDetails}<br />\n<br />\nInformación de membresía (si se proporciona):<br />\n{$membership}<br />\n<br />\nPara ver o editar esta suscripción use la siguiente URL:<br />\n<br />\nURL para gestionar la suscripción: {$subscriptionUrl}<br />\n'),(48,'SUBSCRIPTION_RENEW_INSTL','es','Renovar suscripción institucional','Renovación de suscripción: Institucional','Se ha renovado en línea una suscripción institucional para {$journalName} con los detalles siguientes.<br />\n<br />\nTipo de suscripción:<br />\n{$subscriptionType}<br />\n<br />\nInstitución:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDominio (si se proporciona):<br />\n{$domain}<br />\n<br />\nRangos IP (si se proporcionan):<br />\n{$ipRanges}<br />\n<br />\nPersona de contacto:<br />\n{$subscriberDetails}<br />\n<br />\nInformación de membresía (si se proporciona):<br />\n{$membership}<br />\n<br />\nPara ver o editar esta suscripción use la siguiente URL:<br />\n<br />\nURL para gestionar la suscripción: {$subscriptionUrl}<br />\n'),(49,'REVISED_VERSION_NOTIFY','es','Notificación de versión revisada','Versión revisada cargada','<p>Estimado/a {$recipientName},</p><p>El autor/a ha cargado revisiones para el envío, <b>{$authorsShort} — {$submissionTitle}</b>.</p><p>Como editor/a asignado, le solicitamos que inicie sesión, <a href=\"{$submissionUrl}\">visualice las revisiones</a> y tome la decisión de aceptar, rechazar o remitir el envío a otra revisión.</p><br><br>—<br>Este es un mensaje automatizado de <a href=\"{$journalUrl}\">{$journalName}</a>.'),(50,'STATISTICS_REPORT_NOTIFICATION','es','Notificación de informe de estadísticas','Actividad editorial por {$month}, {$year}','\n{$recipientName}, <br />\n<br />\nEl informe de estado de su revista de {$month}, {$year} ya está disponible. Las estadísticas clave de este mes son las siguientes.<br />\n<ul>\n	<li>Nuevos envíos este mes: {$newSubmissions}</li>\n	<li>Envíos rechazados este mes: {$declinedSubmissions}</li>\n	<li>Envíos aceptados este mes: {$acceptedSubmissions}</li>\n	<li>Envíos totales en el sistema: {$totalSubmissions}</li>\n</ul>\nInicie sesión en la revista para obtener más detalles sobre las <a href=\"{$editorialStatsLink}\">tendencias editoriales</a> y las <a href=\"{$publicationStatsLink}\">estadísticas de artículos publicados</a>. Se adjunta una copia completa del informe correspondiente a este mes .<br />\n<br />\nSaludos cordiales,<br />\n{$journalSignature}'),(51,'ANNOUNCEMENT','es','Nuevo aviso','{$announcementTitle}','<b>{$announcementTitle}</b><br />\n<br />\n{$announcementSummary}<br />\n<br />\nVisite nuestro site para leer el <a href=\"{$announcementUrl}\">anuncio completo</a>.'),(52,'DISCUSSION_NOTIFICATION_SUBMISSION','es','Discusión (envío)','Mensaje sobre {$journalName}','Introduzca su mensaje.'),(53,'DISCUSSION_NOTIFICATION_REVIEW','es','Discusión (revisión)','Mensaje sobre {$journalName}','Introduzca su mensaje.'),(54,'DISCUSSION_NOTIFICATION_COPYEDITING','es','Discusión (edición)','Mensaje sobre {$journalName}','Introduzca su mensaje.'),(55,'DISCUSSION_NOTIFICATION_PRODUCTION','es','Discusión (producción)','Mensaje sobre {$journalName}','Introduzca su mensaje.'),(56,'COPYEDIT_REQUEST','es','Solicitar corrección','El envío {$submissionId} está listo para ser corregido para {$contextAcronym}','<p>Estimado/a{$recipientName},</p><p>Hay un envío nuevo listo para ser corregido:</p><p><a href\"{$submissionUrl}\">{$submissionId} — {$submissionTitle}</a><br />{$journalName}</p><p>Siga estos pasos para completar la tarea:</p><ol><li>Haga clic en la URL del envío que encontrará más abajo.</li><li>Abra todos los archivos disponibles en \"Borradores finales\" y haga la corrección. Utilice las \"Discusiones de corrección\" si necesita contactar con editores/as o autores/as.</li><li>Guarde los archivos corregidos y cárguelos en el panel \"Corregido\".</li><li>Utilice las \"Discusiones de corrección\" para notificar a los editores/as que los documentos están preparados y que el proceso de producción podría empezar.</li></ol><p>Si no puede llevar a cabo esta tarea en este momento, o si tiene cualquier duda, contacte conmigo por favor. Gracias por su contribución a {$journalName}.</p><p>Saludos cordiales,</p>{$signature}'),(57,'EDITOR_ASSIGN_SUBMISSION','es','Asignar editor/a','Ha sido asignado como editor/a de un envío para {$journalName}','<p>Estimado/a {$recipientName},</p><p>Se le ha asignado el siguiente envío para que coordine su proceso editorial.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Resumen</b></p>{$submissionAbstract}<p>Si le parece que el envío es relevante para {$journalName}, envíelo a la fase de revisión seleccionando \"Enviar a revisión\" y luego asigne revisores/as haciendo clic en \"Añadir revisor/a\".</p><p>Si el envío no es apropiado para esta revista, rechácelo.</p><p>Gracias de antemano.</p><p>Atentamente,</p>{$journalSignature}'),(58,'EDITOR_ASSIGN_REVIEW','es','Asignar editor/a','Ha sido asignado como editor/a de un envío para {$journalName}','<p>Estimado/a {$recipientName},</p><p>Se le ha asignado el siguiente envío para que lo supervise durante el proceso de revisión por pares.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Resumen</b></p>{$submissionAbstract}<p>Inicie sesión para <a href=\"{$submissionUrl}\">ver el envío</a> y asignar revisores/as cualificados. Puede asignar un revisor/a haciendo clic en \"Añadir revisor/a\".</p><p>Gracias de antemano.</p><p>Atentamente,</p>{$signature}'),(59,'EDITOR_ASSIGN_PRODUCTION','es','Asignar editor/a','Ha sido asignado como editor/a de un envío para {$journalName}','<p>Estimado/a {$recipientName},</p><p>Se le ha asignado el siguiente envío para que coordine su fase de producción.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Resumen</b></p>{$submissionAbstract}<p>Inicie sesión para <a href=\"{$submissionUrl}\">ver el envío</a>. Cuando estén disponibles los archivos de producción cárguelos en la sección <strong>Publicación > Galeradas</strong>. Después programe el trabajo para su publicación haciendo clic en el botón <strong>Programar para publicación</strong>.</p><p>Gracias de antemano.</p><p>Atentamente,</p>{$signature}'),(60,'LAYOUT_REQUEST','es','Listo para producción','El envío {$submissionId} está listo para producción en {$contextAcronym}','<p>Estimado/a {$recipientName},</p><p>Un nuevo envío está listo para la maquetación:</p><p><a href=\"{$submissionUrl}\">{$submissionId} — {$submissionTitle}</a><br />{$journalName}</p><ol><li>Haga clic en la URL anterior.</li><li>Descargue los archivos de producción y utilícelos para crear las galeradas de acuerdo con los estándares de la revista.</li><li>Cargue las galeradas en la sección de publicación del envío.</li><li>Use las discusiones de producción para notificar al editor/a que las galeradas están listas.</li></ol><p>Si no puede llevar a cabo este trabajo en este momento o tiene alguna pregunta, póngase en contacto con nosotros. Gracias por su contribución a esta revista.</p><p>Atentamente,</p>{$signature}'),(61,'LAYOUT_COMPLETE','es','Galeradas completas','Galeradas completadas','<p>Estimado/a {$recipientName},</p><p>Le informamos que las galeradas del siguiente envío ya han sido preparadas y están listas para su revisión final.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$journalName}</p><p>Si tiene alguna pregunta, póngase en contacto con nosotros.</p><p>Atentamente,</p><p>{$signature}</p>'),(62,'VERSION_CREATED','es','Versión creada','Se ha creado una versión nueva de {$submissionTitle}',''),(63,'EDITORIAL_REMINDER','es','Recordatorio editorial','Tareas editoriales pendientes de {$journalName}','<p>Estimado/a {$recipientName},</p><p>Actualmente tiene asignado(s) {$numberOfSubmissions} envío(s) en <a href=\"{$journalUrl}\">{$journalName}</a>. Los envíos siguientes están <b>esperando su respuesta</b>.</p>{$outstandingTasks}<p>Puede ver todas sus tareas en su <a href=\"{$submissionsUrl}\">panel de control del envío</a>.</p><p>Si tiene cualquier duda acerca de sus asignaciones contacte con {$contactName} en {$contactEmail}.</p>'),(64,'SUBMISSION_SAVED_FOR_LATER','es','Se guardó el envío para más adelante','Continuar su envío a {$journalName}',''),(65,'SUBMISSION_NEEDS_EDITOR','es','El envío necesita un editor/a','Un envío nuevo necesita que le asignen un editor/a: {$submissionTitle}',''),(66,'PAYMENT_REQUEST_NOTIFICATION','es','Solicitud de pago','Notificación de solicitud de pago','<p>Estimado/a {$recipientName},</p><p>Le felicitamos por la aceptación de su envío, {$submissionTitle}, en {$journalName}. Ahora que ha sido aceptado, nos gustaría solicitarle el pago de la tasa de publicación.</p><p>Esta tasa cubre los costes de producción para su publicación. Para realizar el pago, visite <a href=\"{$queuedPaymentUrl}\">{$queuedPaymentUrl}</a>.</p><p>Si tiene alguna pregunta consulte nuestras <a href=\"{$submissionGuidelinesUrl}\">directrices de envío</a>.</p>'),(67,'ORCID_COLLECT_AUTHOR_ID','es','orcidCollectAuthorId','ORCID de envío','Estimado/a {$recipientName},\n<br/>\nSe le ha añadido como coautor/a de un artículo para {$journalName}. <br/>\nPara confirmar su autoría, añada su identificador ORCID a este envío mediante el siguiente enlace.<br/>\n<br/>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Registrar o conectar su identificador ORCID</a><br/>\n<br/>\n<br>\n<a href=\"{$orcidAboutUrl}\">Puede encontrar más información sobre ORCID en {$journalName}</a><br/>\n<br/>\nSi tiene cualquier pregunta no dude en contactarme.<br/>\n<br/>\n{$principalContactSignature}<br/>\n'),(68,'ORCID_REQUEST_AUTHOR_AUTHORIZATION','es','orcidRequestAuthorAuthorization','Solicitando acceso de registro ORCID','Estimado/a {$recipientName},<br>\n<br>\nUsted ha sido incluido como autor en la presentación del manuscrito \"{$submissionTitle}\" a {$journalName}.\n<br>\n<br>\nPermítanos agregar su identificación ORCID a este envío y también agregar el mismo a su perfil ORCID en la publicación.<br>\nVisite el enlace al sitio web oficial de ORCID, inicie sesión con su perfil y autorice el acceso siguiendo las instrucciones.<br>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Registre o conecte su ORCID iD</a><br/>\n<br>\n<br>\n<a href=\"{$orcidAboutUrl}\">Más acerca de ORCID en{$journalName}</a><br/>\n<br>\nSi tiene alguna pregunta, por favor póngase en contacto conmigo.<br>\n<br>\n{$principalContactSignature}<br>\n'),(69,'MANUAL_PAYMENT_NOTIFICATION','es','Notificación de pago manual','Notificación de pago manual','Se necesita procesar un pago manual para la revista {$journalName} y el usuario/a {$senderName} (username &quot;{$senderUsername}&quot;).<br />\n<br />\nEl elemento pagado es &quot;{$paymentName}&quot;.<br />\nEl precio es {$paymentAmount} ({$paymentCurrencyCode}).<br />\n<br />\nEste correo ha sido generado por el módulo de pago manual de Open Journal Systems.');
/*!40000 ALTER TABLE `email_templates_default_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates_settings`
--

DROP TABLE IF EXISTS `email_templates_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_templates_settings` (
  `email_template_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`email_template_setting_id`),
  UNIQUE KEY `email_templates_settings_unique` (`email_id`,`locale`,`setting_name`),
  KEY `email_templates_settings_email_id` (`email_id`),
  CONSTRAINT `email_templates_settings_email_id` FOREIGN KEY (`email_id`) REFERENCES `email_templates` (`email_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about custom email templates, including localized properties such as the subject and body.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates_settings`
--

LOCK TABLES `email_templates_settings` WRITE;
/*!40000 ALTER TABLE `email_templates_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_templates_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL COMMENT 'NULL if it''s system or automated event',
  `date_logged` datetime NOT NULL,
  `event_type` bigint(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_translated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `event_log_user_id` (`user_id`),
  KEY `event_log_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `event_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A log of all events related to an object like a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log`
--

LOCK TABLES `event_log` WRITE;
/*!40000 ALTER TABLE `event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log_settings`
--

DROP TABLE IF EXISTS `event_log_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log_settings` (
  `event_log_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`event_log_setting_id`),
  UNIQUE KEY `event_log_settings_unique` (`log_id`,`setting_name`,`locale`),
  KEY `event_log_settings_log_id` (`log_id`),
  KEY `event_log_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `event_log_settings_log_id` FOREIGN KEY (`log_id`) REFERENCES `event_log` (`log_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Data about an event log entry. This data is commonly used to display information about an event to a user.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log_settings`
--

LOCK TABLES `event_log_settings` WRITE;
/*!40000 ALTER TABLE `event_log_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_log_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A log of all failed jobs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `file_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Records information in the database about files tracked by the system, linking them to the local filesystem.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_groups`
--

DROP TABLE IF EXISTS `filter_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_groups` (
  `filter_group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `symbolic` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `input_type` varchar(255) DEFAULT NULL,
  `output_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`filter_group_id`),
  UNIQUE KEY `filter_groups_symbolic` (`symbolic`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Filter groups are used to organized filters into named sets, which can be retrieved by the application for invocation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_groups`
--

LOCK TABLES `filter_groups` WRITE;
/*!40000 ALTER TABLE `filter_groups` DISABLE KEYS */;
INSERT INTO `filter_groups` VALUES (1,'issue=>crossref-xml','plugins.importexport.crossref.displayName','plugins.importexport.crossref.description','class::classes.issue.Issue[]','xml::schema(https://www.crossref.org/schemas/crossref5.3.1.xsd)'),(2,'article=>crossref-xml','plugins.importexport.crossref.displayName','plugins.importexport.crossref.description','class::classes.submission.Submission[]','xml::schema(https://www.crossref.org/schemas/crossref5.3.1.xsd)'),(3,'issue=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::classes.issue.Issue','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(4,'article=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::classes.submission.Submission','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(5,'galley=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::lib.pkp.classes.galley.Galley','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(6,'article=>dc11','plugins.metadata.dc11.articleAdapter.displayName','plugins.metadata.dc11.articleAdapter.description','class::classes.submission.Submission','metadata::APP\\plugins\\metadata\\dc11\\schema\\Dc11Schema(ARTICLE)'),(7,'article=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.submission.Submission[]','xml::schema(plugins/importexport/native/native.xsd)'),(8,'native-xml=>article','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.submission.Submission[]'),(9,'issue=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.issue.Issue[]','xml::schema(plugins/importexport/native/native.xsd)'),(10,'native-xml=>issue','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.issue.Issue[]'),(11,'issuegalley=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.issue.IssueGalley[]','xml::schema(plugins/importexport/native/native.xsd)'),(12,'native-xml=>issuegalley','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.issue.IssueGalley[]'),(13,'author=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.author.Author[]','xml::schema(plugins/importexport/native/native.xsd)'),(14,'native-xml=>author','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.author.Author[]'),(15,'SubmissionFile=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::lib.pkp.classes.submissionFile.SubmissionFile','xml::schema(plugins/importexport/native/native.xsd)'),(16,'native-xml=>SubmissionFile','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::lib.pkp.classes.submissionFile.SubmissionFile[]'),(17,'article-galley=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::lib.pkp.classes.galley.Galley','xml::schema(plugins/importexport/native/native.xsd)'),(18,'native-xml=>ArticleGalley','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::lib.pkp.classes.galley.Galley[]'),(19,'publication=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.publication.Publication','xml::schema(plugins/importexport/native/native.xsd)'),(20,'native-xml=>Publication','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.publication.Publication[]'),(21,'article=>doaj-xml','plugins.importexport.doaj.displayName','plugins.importexport.doaj.description','class::classes.submission.Submission[]','xml::schema(plugins/importexport/doaj/doajArticles.xsd)'),(22,'article=>doaj-json','plugins.importexport.doaj.displayName','plugins.importexport.doaj.description','class::classes.submission.Submission','primitive::string'),(23,'user=>user-xml','plugins.importexport.users.displayName','plugins.importexport.users.description','class::lib.pkp.classes.user.User[]','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),(24,'user-xml=>user','plugins.importexport.users.displayName','plugins.importexport.users.description','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)','class::classes.users.User[]'),(25,'usergroup=>user-xml','plugins.importexport.users.displayName','plugins.importexport.users.description','class::lib.pkp.classes.security.UserGroup[]','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),(26,'user-xml=>usergroup','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)','class::lib.pkp.classes.security.UserGroup[]'),(27,'article=>pubmed-xml','plugins.importexport.pubmed.displayName','plugins.importexport.pubmed.description','class::classes.submission.Submission[]','xml::dtd');
/*!40000 ALTER TABLE `filter_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_settings`
--

DROP TABLE IF EXISTS `filter_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_settings` (
  `filter_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`filter_setting_id`),
  UNIQUE KEY `filter_settings_unique` (`filter_id`,`locale`,`setting_name`),
  KEY `filter_settings_id` (`filter_id`),
  CONSTRAINT `filter_settings_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`filter_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about filters, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_settings`
--

LOCK TABLES `filter_settings` WRITE;
/*!40000 ALTER TABLE `filter_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filters`
--

DROP TABLE IF EXISTS `filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filters` (
  `filter_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `filter_group_id` bigint(20) NOT NULL DEFAULT 0,
  `context_id` bigint(20) NOT NULL DEFAULT 0,
  `display_name` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `is_template` smallint(6) NOT NULL DEFAULT 0,
  `parent_filter_id` bigint(20) NOT NULL DEFAULT 0,
  `seq` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`filter_id`),
  KEY `filters_filter_group_id` (`filter_group_id`),
  CONSTRAINT `filters_filter_group_id_foreign` FOREIGN KEY (`filter_group_id`) REFERENCES `filter_groups` (`filter_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Filters represent a transformation of a supported piece of data from one form to another, such as a PHP object into an XML document.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filters`
--

LOCK TABLES `filters` WRITE;
/*!40000 ALTER TABLE `filters` DISABLE KEYS */;
INSERT INTO `filters` VALUES (1,1,0,'Crossref XML issue export','APP\\plugins\\generic\\crossref\\filter\\IssueCrossrefXmlFilter',0,0,0),(2,2,0,'Crossref XML article export','APP\\plugins\\generic\\crossref\\filter\\ArticleCrossrefXmlFilter',0,0,0),(3,3,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(4,4,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(5,5,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(6,6,0,'Extract metadata from a(n) Submission','APP\\plugins\\metadata\\dc11\\filter\\Dc11SchemaArticleAdapter',0,0,0),(7,7,0,'Native XML submission export','APP\\plugins\\importexport\\native\\filter\\ArticleNativeXmlFilter',0,0,0),(8,8,0,'Native XML submission import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFilter',0,0,0),(9,9,0,'Native XML issue export','APP\\plugins\\importexport\\native\\filter\\IssueNativeXmlFilter',0,0,0),(10,10,0,'Native XML issue import','APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueFilter',0,0,0),(11,11,0,'Native XML issue galley export','APP\\plugins\\importexport\\native\\filter\\IssueGalleyNativeXmlFilter',0,0,0),(12,12,0,'Native XML issue galley import','APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueGalleyFilter',0,0,0),(13,13,0,'Native XML author export','APP\\plugins\\importexport\\native\\filter\\AuthorNativeXmlFilter',0,0,0),(14,14,0,'Native XML author import','APP\\plugins\\importexport\\native\\filter\\NativeXmlAuthorFilter',0,0,0),(15,16,0,'Native XML submission file import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFileFilter',0,0,0),(16,15,0,'Native XML submission file export','PKP\\plugins\\importexport\\native\\filter\\SubmissionFileNativeXmlFilter',0,0,0),(17,17,0,'Native XML representation export','APP\\plugins\\importexport\\native\\filter\\ArticleGalleyNativeXmlFilter',0,0,0),(18,18,0,'Native XML representation import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleGalleyFilter',0,0,0),(19,19,0,'Native XML Publication export','APP\\plugins\\importexport\\native\\filter\\PublicationNativeXmlFilter',0,0,0),(20,20,0,'Native XML publication import','APP\\plugins\\importexport\\native\\filter\\NativeXmlPublicationFilter',0,0,0),(21,21,0,'DOAJ XML export','APP\\plugins\\importexport\\doaj\\filter\\DOAJXmlFilter',0,0,0),(22,22,0,'DOAJ JSON export','APP\\plugins\\importexport\\doaj\\filter\\DOAJJsonFilter',0,0,0),(23,23,0,'User XML user export','PKP\\plugins\\importexport\\users\\filter\\PKPUserUserXmlFilter',0,0,0),(24,24,0,'User XML user import','PKP\\plugins\\importexport\\users\\filter\\UserXmlPKPUserFilter',0,0,0),(25,25,0,'Native XML user group export','PKP\\plugins\\importexport\\users\\filter\\UserGroupNativeXmlFilter',0,0,0),(26,26,0,'Native XML user group import','PKP\\plugins\\importexport\\users\\filter\\NativeXmlUserGroupFilter',0,0,0),(27,27,0,'APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter','APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter',0,0,0);
/*!40000 ALTER TABLE `filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_settings`
--

DROP TABLE IF EXISTS `genre_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre_settings` (
  `genre_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `genre_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`genre_setting_id`),
  UNIQUE KEY `genre_settings_unique` (`genre_id`,`locale`,`setting_name`),
  KEY `genre_settings_genre_id` (`genre_id`),
  CONSTRAINT `genre_settings_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about file genres, including localized properties such as the genre name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_settings`
--

LOCK TABLES `genre_settings` WRITE;
/*!40000 ALTER TABLE `genre_settings` DISABLE KEYS */;
INSERT INTO `genre_settings` VALUES (1,1,'es','name','Texto del artículo','string'),(2,2,'es','name','Instrumento de investigación','string'),(3,3,'es','name','Materiales de investigación','string'),(4,4,'es','name','Resultados de la investigación','string'),(5,5,'es','name','Transcripciones','string'),(6,6,'es','name','Análisis de datos','string'),(7,7,'es','name','Conjunto de datos','string'),(8,8,'es','name','Textos fuente','string'),(9,9,'es','name','Multimedia','string'),(10,10,'es','name','Imagen','string'),(11,11,'es','name','Hoja de estilo HTML','string'),(12,12,'es','name','Otro','string');
/*!40000 ALTER TABLE `genre_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `genre_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `seq` bigint(20) NOT NULL,
  `enabled` smallint(6) NOT NULL DEFAULT 1,
  `category` bigint(20) NOT NULL DEFAULT 1,
  `dependent` smallint(6) NOT NULL DEFAULT 0,
  `supplementary` smallint(6) NOT NULL DEFAULT 0,
  `required` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Whether or not at least one file of this genre is required for a new submission.',
  `entry_key` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`genre_id`),
  KEY `genres_context_id` (`context_id`),
  CONSTRAINT `genres_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='The types of submission files configured for each context, such as Article Text, Data Set, Transcript, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,1,0,1,1,0,0,1,'SUBMISSION'),(2,1,1,1,3,0,1,0,'RESEARCHINSTRUMENT'),(3,1,2,1,3,0,1,0,'RESEARCHMATERIALS'),(4,1,3,1,3,0,1,0,'RESEARCHRESULTS'),(5,1,4,1,3,0,1,0,'TRANSCRIPTS'),(6,1,5,1,3,0,1,0,'DATAANALYSIS'),(7,1,6,1,3,0,1,0,'DATASET'),(8,1,7,1,3,0,1,0,'SOURCETEXTS'),(9,1,8,1,1,1,1,0,'MULTIMEDIA'),(10,1,9,1,2,1,0,0,'IMAGE'),(11,1,10,1,1,1,0,0,'STYLE'),(12,1,11,1,3,0,1,0,'OTHER');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_ip`
--

DROP TABLE IF EXISTS `institution_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institution_ip` (
  `institution_ip_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `institution_id` bigint(20) NOT NULL,
  `ip_string` varchar(40) NOT NULL,
  `ip_start` bigint(20) NOT NULL,
  `ip_end` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`institution_ip_id`),
  KEY `institution_ip_institution_id` (`institution_id`),
  KEY `institution_ip_start` (`ip_start`),
  KEY `institution_ip_end` (`ip_end`),
  CONSTRAINT `institution_ip_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Records IP address ranges and associates them with institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_ip`
--

LOCK TABLES `institution_ip` WRITE;
/*!40000 ALTER TABLE `institution_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_settings`
--

DROP TABLE IF EXISTS `institution_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institution_settings` (
  `institution_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institution_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`institution_setting_id`),
  UNIQUE KEY `institution_settings_unique` (`institution_id`,`locale`,`setting_name`),
  KEY `institution_settings_institution_id` (`institution_id`),
  CONSTRAINT `institution_settings_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about institutions, including localized properties like names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_settings`
--

LOCK TABLES `institution_settings` WRITE;
/*!40000 ALTER TABLE `institution_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutional_subscriptions`
--

DROP TABLE IF EXISTS `institutional_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institutional_subscriptions` (
  `institutional_subscription_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`institutional_subscription_id`),
  KEY `institutional_subscriptions_subscription_id` (`subscription_id`),
  KEY `institutional_subscriptions_institution_id` (`institution_id`),
  KEY `institutional_subscriptions_domain` (`domain`),
  CONSTRAINT `institutional_subscriptions_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `institutional_subscriptions_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of institutional subscriptions, linking a subscription with an institution.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutional_subscriptions`
--

LOCK TABLES `institutional_subscriptions` WRITE;
/*!40000 ALTER TABLE `institutional_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `institutional_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutions`
--

DROP TABLE IF EXISTS `institutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institutions` (
  `institution_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `ror` varchar(255) DEFAULT NULL COMMENT 'ROR (Research Organization Registry) ID',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`institution_id`),
  KEY `institutions_context_id` (`context_id`),
  CONSTRAINT `institutions_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Institutions for statistics and subscriptions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutions`
--

LOCK TABLES `institutions` WRITE;
/*!40000 ALTER TABLE `institutions` DISABLE KEYS */;
/*!40000 ALTER TABLE `institutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_files`
--

DROP TABLE IF EXISTS `issue_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_files` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `content_type` bigint(20) NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `issue_files_issue_id` (`issue_id`),
  CONSTRAINT `issue_files_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Relationships between issues and issue files, such as cover images.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_files`
--

LOCK TABLES `issue_files` WRITE;
/*!40000 ALTER TABLE `issue_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_galley_settings`
--

DROP TABLE IF EXISTS `issue_galley_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_galley_settings` (
  `issue_galley_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`issue_galley_setting_id`),
  UNIQUE KEY `issue_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  KEY `issue_galley_settings_galley_id` (`galley_id`),
  CONSTRAINT `issue_galleys_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about issue galleys, including localized content such as labels.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_galley_settings`
--

LOCK TABLES `issue_galley_settings` WRITE;
/*!40000 ALTER TABLE `issue_galley_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_galley_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_galleys`
--

DROP TABLE IF EXISTS `issue_galleys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_galleys` (
  `galley_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `locale` varchar(14) DEFAULT NULL,
  `issue_id` bigint(20) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `url_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`galley_id`),
  KEY `issue_galleys_issue_id` (`issue_id`),
  KEY `issue_galleys_file_id` (`file_id`),
  KEY `issue_galleys_url_path` (`url_path`),
  CONSTRAINT `issue_galleys_file_id` FOREIGN KEY (`file_id`) REFERENCES `issue_files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `issue_galleys_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Issue galleys are representations of the entire issue in a single file, such as a complete issue PDF.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_galleys`
--

LOCK TABLES `issue_galleys` WRITE;
/*!40000 ALTER TABLE `issue_galleys` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_galleys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_settings`
--

DROP TABLE IF EXISTS `issue_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_settings` (
  `issue_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`issue_setting_id`),
  UNIQUE KEY `issue_settings_unique` (`issue_id`,`locale`,`setting_name`),
  KEY `issue_settings_issue_id` (`issue_id`),
  KEY `issue_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `issue_settings_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about issues, including localized properties such as issue titles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_settings`
--

LOCK TABLES `issue_settings` WRITE;
/*!40000 ALTER TABLE `issue_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `issue_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) NOT NULL,
  `volume` smallint(6) DEFAULT NULL,
  `number` varchar(40) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `published` smallint(6) NOT NULL DEFAULT 0,
  `date_published` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `access_status` smallint(6) NOT NULL DEFAULT 1,
  `open_access_date` datetime DEFAULT NULL,
  `show_volume` smallint(6) NOT NULL DEFAULT 0,
  `show_number` smallint(6) NOT NULL DEFAULT 0,
  `show_year` smallint(6) NOT NULL DEFAULT 0,
  `show_title` smallint(6) NOT NULL DEFAULT 0,
  `style_file_name` varchar(90) DEFAULT NULL,
  `original_style_file_name` varchar(255) DEFAULT NULL,
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issues_journal_id` (`journal_id`),
  KEY `issues_doi_id` (`doi_id`),
  KEY `issues_url_path` (`url_path`),
  CONSTRAINT `issues_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `issues_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of all journal issues, with identifying information like year, number, volume, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` text NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Job batches allow jobs to be collected into groups for managed processing.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
INSERT INTO `job_batches` VALUES ('9e42ebba-c594-4490-8aca-8da944383d37','',0,0,0,'[]','a:0:{}',NULL,1740102599,NULL);
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='All pending or in-progress jobs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_settings`
--

DROP TABLE IF EXISTS `journal_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_settings` (
  `journal_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`journal_setting_id`),
  UNIQUE KEY `journal_settings_unique` (`journal_id`,`locale`,`setting_name`),
  KEY `journal_settings_journal_id` (`journal_id`),
  CONSTRAINT `journal_settings_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about journals, including localized properties like policies.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_settings`
--

LOCK TABLES `journal_settings` WRITE;
/*!40000 ALTER TABLE `journal_settings` DISABLE KEYS */;
INSERT INTO `journal_settings` VALUES (1,1,'es','acronym','UDELLPA'),(2,1,'es','authorGuidelines','<p>Se invita a los autores/as a realizar un envío a esta revista. Todas los envíos serán evaluados por un editor/a para determinar si cumplen con los objetivos y el alcance de esta revista. Los que se consideren adecuados se enviarán a una revisión por pares antes de determinar si serán aceptados o rechazados.</p><p>Antes de remitir un envío, los autores/as son responsables de obtener el permiso para publicar cualquier material incluido en él, como fotos, documentos y conjuntos de datos. Todos los autores/as identificados en el envío deben dar su consentimiento para ser identificados como autores/as. Cuando corresponda, la investigación debe ser aprobada por un comité de ética apropiado de acuerdo con los requisitos legales del país del estudio.</p><p>Un editor/a puede rechazar un envío si no cumple con los estándares mínimos de calidad. Antes de hacer el envío, asegúrese de que el diseño del estudio y el argumento de la investigación estén estructurados y articulados correctamente. El título debe ser conciso y el resumen debe poder sostenerse por sí solo. Esto aumentará la probabilidad de que los revisores/as acepten revisar el artículo. Cuando tenga la certeza de que su envío cumple con este estándar, continúe a la lista de verificación que hay a continuación para preparar su envío.</p>'),(3,1,'es','authorInformation','¿Está interesado en publicar en la revista? Se recomienda revisar la página <a href=\"https://www.revistasrelatic.org/index.php/home/about\">Acerca de la revista</a> para consultar las políticas de sección de la revista, así como las <a href=\"https://www.revistasrelatic.org/index.php/home/about/submissions#authorGuidelines\">Directrices del autor/a</a>. Los autores/as deben <a href=\"https://www.revistasrelatic.org/index.php/home/user/register\">registrarse</a> en la revista antes de publicar o, si ya están registrados, pueden simplemente <a href=\"https://www.revistasrelatic.org/index.php/index/login\">iniciar sesión</a> y comenzar el proceso de cinco pasos.'),(4,1,'es','beginSubmissionHelp','<p>Gracias por su envío a Universidad de los Llanos del Pacífico. Se le pedirá que cargue archivos, identifique coautores y proporcione información como el título y el resumen.<p><p>Lea nuestras <a href=\"https://www.revistasrelatic.org/index.php/home/about/submissions\" target=\"_blank\">directrices de envío</a> si aún no lo ha hecho. Cuando rellene los formularios, proporcione todos los detalles posibles para ayudar a nuestros editores/as a evaluar su trabajo.</p><p>Una vez iniciado, podrá guardar el envío y recuperarlo más tarde, así como revisar y corregir cualquier información antes de remitirlo.</p>'),(5,1,'','contactEmail','israel.samuelsg@gmail.com'),(6,1,'','contactName','ISRAEL A. SAMUELS'),(7,1,'es','contributorsHelp','<p>Añada los detalles de todos los colaboradores/as de este envío. Los colaboradores/as que añada aquí recibirán un correo electrónico de confirmación del envío, así como una copia de todas las decisiones editoriales registradas relacionadas con este envío.</p><p>Si un colaborador/a no quiere ser contactado por correo electrónico, ya sea porque quiere permanecer anónimo o porque no tiene una cuenta de correo, no introduzca una dirección de correo electrónico falsa. Puede añadir información sobre este colaborador/a en un mensaje para el editor/a en el último paso del proceso de envío.</p>'),(8,1,'','country','PA'),(9,1,'','defaultReviewMode','2'),(10,1,'es','description','<p>Investigación</p>'),(11,1,'es','detailsHelp','<p>Proporcione los detalles siguientes para ayudarnos a gestionar su envío en nuestro sistema.</p>'),(12,1,'','copySubmissionAckPrimaryContact','0'),(13,1,'','copySubmissionAckAddress',''),(14,1,'','emailSignature','<br><br>—<br><p>Esto es un mensaje automático desde <a href=\"https://www.revistasrelatic.org/index.php/home\">Universidad de los Llanos del Pacífico</a>.</p>'),(15,1,'','enableDois','1'),(16,1,'','doiSuffixType','default'),(17,1,'','registrationAgency',''),(18,1,'','disableSubmissions','0'),(19,1,'','editorialStatsEmail','1'),(20,1,'es','forTheEditorsHelp','<p>Proporcione los detalles siguientes para ayudar a nuestro equipo editorial a gestionar su envío.</p><p>Cuando introduzca los metadatos, facilite las entradas que considere más útiles para la persona que gestione su envío. Esta información puede modificarse antes de la publicación.</p>'),(21,1,'','itemsPerPage','25'),(22,1,'','keywords','request'),(23,1,'es','librarianInformation','Se recomienda a los investigadores/as bibliotecarios/as que incluyan esta revista en su listado de revistas electrónicas. Asimismo, cabría destacar que el sistema de publicación de código abierto de esta revista es apto para bibliotecas con personal docente que desee editar sus propias revistas (ver <a href=\"http://pkp.sfu.ca/ojs\">Open Journal Systems</a>).'),(24,1,'es','name','Universidad de los Llanos del Pacífico'),(25,1,'','notifyAllAuthors','1'),(26,1,'','numPageLinks','10'),(27,1,'','numWeeksPerResponse','4'),(28,1,'','numWeeksPerReview','4'),(29,1,'es','openAccessPolicy','Esta revista proporciona un acceso abierto inmediato a su contenido, basado en el principio de ofrecer al público un acceso libre a las investigaciones ayuda a un mayor intercambio global de conocimiento.'),(30,1,'es','privacyStatement','<p>Los nombres y las direcciones de correo electrónico introducidos en esta revista se usarán exclusivamente para los fines establecidos en ella y no se proporcionarán a terceros o para su uso con otros fines.</p>'),(31,1,'es','readerInformation','Animamos a los lectores/as a registrarse en el servicio de notificación de publicaciones de la revista. Utilice el enlace <a href=\"https://www.revistasrelatic.org/index.php/home/user/register\">Registro</a> de la parte superior de la página de inicio de la revista. Como resultado del registro, el lector/a recibirá por correo electrónico la Tabla de contenidos de cada número de la revista. Esta lista también permite que se le atribuya a la revista un cierto nivel de apoyo o número de lectores/as. Consulte la <a href=\"https://www.revistasrelatic.org/index.php/home/about/submissions#privacyStatement\">Declaración de privacidad</a> de la revista, que garantiza a los lectores/as que sus nombres y direcciones de correo electrónico no se usarán con otros fines.'),(32,1,'es','reviewHelp','<p>Revise la información que ha introducido antes de finalizar el envío. Puede modificar cualquier detalle que se muestre aquí a través del botón de edición situado en la parte superior de cada sección.</p><p>Una vez finalizado el envío, este se asignará a una persona de nuestro equipo editorial para que lo revise. Asegúrese de que la información que ha introducido sea lo más precisa posible.</p>'),(33,1,'','submissionAcknowledgement','allAuthors'),(34,1,'es','submissionChecklist','<p>Todos los envíos deben cumplir con los siguientes requisitos.</p><ul><li>Este envío cumple con los requisitos descritos en las <a href=\"https://www.revistasrelatic.org/index.php/home/about/submissions\">Directrices para autores/as</a>.</li><li>Este envío no ha sido publicado previamente, ni se ha presentado ante otra revista para su consideración.</li><li>Todas las referencias han sido verificadas para ver si son precisas y completas.</li><li>Todas las tablas y figuras han sido numeradas y etiquetadas.</li><li>Se ha obtenido permiso para publicar todas las imágenes, conjuntos de datos y cualquier otro material proporcionado con este envío.</li></ul>'),(35,1,'','submitWithCategories','0'),(36,1,'','supportedFormLocales','[\"es\"]'),(37,1,'','supportedLocales','[\"es\"]'),(38,1,'','supportedSubmissionLocales','[\"es\"]'),(39,1,'','themePluginPath','default'),(40,1,'es','uploadFilesHelp','<p>Proporcione todos los archivos que nuestro equipo editorial necesite para evaluar su envío. Además de la obra principal puede enviarnos conjuntos de datos, declaraciones de conflictos de interés u otros archivos adicionales si considera que serán de ayuda para nuestros editores/as.</p>'),(41,1,'','enableGeoUsageStats','disabled'),(42,1,'','enableInstitutionUsageStats','0'),(43,1,'','isSushiApiPublic','1'),(44,1,'es','abbreviation','UDELLPA'),(45,1,'es','clockssLicense','Esta revista utiliza el sistema CLOCKSS para crear un sistema de archivos distribuido entre las bibliotecas participantes y permite a estas bibliotecas crear archivos permanentes de la revista con finalidad de preservación y restauración. <a href=\"https://clockss.org/\">Saber más...</a>'),(46,1,'','copyrightYearBasis','issue'),(47,1,'','enabledDoiTypes','[\"publication\"]'),(48,1,'','doiCreationTime','copyEditCreationTime'),(49,1,'','enableOai','1'),(50,1,'es','lockssLicense','Esta revista utiliza el sistema LOCKSS para crear un sistema de archivos distribuido entre las bibliotecas participantes y permite a estas bibliotecas crear archivos permanentes de la revista con finalidades de preservación y restauración. <a href=\"https://lockss.org/\">Saber más...</a>'),(51,1,'','membershipFee','0'),(52,1,'','publicationFee','0'),(53,1,'','purchaseArticleFee','0'),(54,1,'','doiVersioning','0');
/*!40000 ALTER TABLE `journal_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `journal_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `path` varchar(32) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00 COMMENT 'Used to order lists of journals',
  `primary_locale` varchar(14) NOT NULL,
  `enabled` smallint(6) NOT NULL DEFAULT 1 COMMENT 'Controls whether or not the journal is considered "live" and will appear on the website. (Note that disabled journals may still be accessible, but only if the user knows the URL.)',
  `current_issue_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`journal_id`),
  UNIQUE KEY `journals_path` (`path`),
  KEY `journals_issue_id` (`current_issue_id`),
  CONSTRAINT `journals_current_issue_id_foreign` FOREIGN KEY (`current_issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of all journals in the installation of OJS.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (1,'home',1.00,'es',1,NULL);
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_file_settings`
--

DROP TABLE IF EXISTS `library_file_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_file_settings` (
  `library_file_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object|date)',
  PRIMARY KEY (`library_file_setting_id`),
  UNIQUE KEY `library_file_settings_unique` (`file_id`,`locale`,`setting_name`),
  KEY `library_file_settings_file_id` (`file_id`),
  CONSTRAINT `library_file_settings_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `library_files` (`file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about library files, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_file_settings`
--

LOCK TABLES `library_file_settings` WRITE;
/*!40000 ALTER TABLE `library_file_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_file_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_files`
--

DROP TABLE IF EXISTS `library_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_files` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `type` smallint(6) NOT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `submission_id` bigint(20) DEFAULT NULL,
  `public_access` smallint(6) DEFAULT 0,
  PRIMARY KEY (`file_id`),
  KEY `library_files_context_id` (`context_id`),
  KEY `library_files_submission_id` (`submission_id`),
  CONSTRAINT `library_files_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `library_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Library files can be associated with the context (press/server/journal) or with individual submissions, and are typically forms, agreements, and other administrative documents that are not part of the scholarly content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_files`
--

LOCK TABLES `library_files` WRITE;
/*!40000 ALTER TABLE `library_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_context`
--

DROP TABLE IF EXISTS `metrics_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_context` (
  `metrics_context_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL,
  PRIMARY KEY (`metrics_context_id`),
  KEY `metrics_context_load_id` (`load_id`),
  KEY `metrics_context_context_id` (`context_id`),
  CONSTRAINT `metrics_context_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics for views of the homepage.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_context`
--

LOCK TABLES `metrics_context` WRITE;
/*!40000 ALTER TABLE `metrics_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_daily`
--

DROP TABLE IF EXISTS `metrics_counter_submission_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_counter_submission_daily` (
  `metrics_counter_submission_daily_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_daily_id`),
  UNIQUE KEY `msd_uc_load_id_context_id_submission_id_date` (`load_id`,`context_id`,`submission_id`,`date`),
  KEY `msd_load_id` (`load_id`),
  KEY `metrics_counter_submission_daily_context_id` (`context_id`),
  KEY `metrics_counter_submission_daily_submission_id` (`submission_id`),
  KEY `msd_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_daily`
--

LOCK TABLES `metrics_counter_submission_daily` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_institution_daily`
--

DROP TABLE IF EXISTS `metrics_counter_submission_institution_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_counter_submission_institution_daily` (
  `metrics_counter_submission_institution_daily_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_institution_daily_id`),
  UNIQUE KEY `msid_uc_load_id_context_id_submission_id_institution_id_date` (`load_id`,`context_id`,`submission_id`,`institution_id`,`date`),
  KEY `msid_load_id` (`load_id`),
  KEY `metrics_counter_submission_institution_daily_context_id` (`context_id`),
  KEY `metrics_counter_submission_institution_daily_submission_id` (`submission_id`),
  KEY `metrics_counter_submission_institution_daily_institution_id` (`institution_id`),
  KEY `msid_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msid_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msid_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `msid_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads from institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_institution_daily`
--

LOCK TABLES `metrics_counter_submission_institution_daily` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_institution_monthly`
--

DROP TABLE IF EXISTS `metrics_counter_submission_institution_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_counter_submission_institution_monthly` (
  `metrics_counter_submission_institution_monthly_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  `month` int(11) NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_institution_monthly_id`),
  UNIQUE KEY `msim_uc_context_id_submission_id_institution_id_month` (`context_id`,`submission_id`,`institution_id`,`month`),
  KEY `metrics_counter_submission_institution_monthly_context_id` (`context_id`),
  KEY `metrics_counter_submission_institution_monthly_submission_id` (`submission_id`),
  KEY `metrics_counter_submission_institution_monthly_institution_id` (`institution_id`),
  KEY `msim_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msim_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msim_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `msim_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads from institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_institution_monthly`
--

LOCK TABLES `metrics_counter_submission_institution_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_monthly`
--

DROP TABLE IF EXISTS `metrics_counter_submission_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_counter_submission_monthly` (
  `metrics_counter_submission_monthly_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `month` int(11) NOT NULL,
  `metric_investigations` int(11) NOT NULL,
  `metric_investigations_unique` int(11) NOT NULL,
  `metric_requests` int(11) NOT NULL,
  `metric_requests_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_monthly_id`),
  UNIQUE KEY `msm_uc_context_id_submission_id_month` (`context_id`,`submission_id`,`month`),
  KEY `metrics_counter_submission_monthly_context_id` (`context_id`),
  KEY `metrics_counter_submission_monthly_submission_id` (`submission_id`),
  KEY `msm_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_monthly`
--

LOCK TABLES `metrics_counter_submission_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_issue`
--

DROP TABLE IF EXISTS `metrics_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_issue` (
  `metrics_issue_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `issue_galley_id` bigint(20) DEFAULT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL,
  PRIMARY KEY (`metrics_issue_id`),
  KEY `metrics_issue_load_id` (`load_id`),
  KEY `metrics_issue_context_id` (`context_id`),
  KEY `metrics_issue_issue_id` (`issue_id`),
  KEY `metrics_issue_issue_galley_id` (`issue_galley_id`),
  KEY `metrics_issue_context_id_issue_id` (`context_id`,`issue_id`),
  CONSTRAINT `metrics_issue_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_issue_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_issue_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics for views and downloads of published issues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_issue`
--

LOCK TABLES `metrics_issue` WRITE;
/*!40000 ALTER TABLE `metrics_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission`
--

DROP TABLE IF EXISTS `metrics_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_submission` (
  `metrics_submission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `file_type` bigint(20) DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `metric` int(11) NOT NULL,
  PRIMARY KEY (`metrics_submission_id`),
  KEY `ms_load_id` (`load_id`),
  KEY `metrics_submission_context_id` (`context_id`),
  KEY `metrics_submission_submission_id` (`submission_id`),
  KEY `metrics_submission_representation_id` (`representation_id`),
  KEY `metrics_submission_submission_file_id` (`submission_file_id`),
  KEY `ms_context_id_submission_id_assoc_type_file_type` (`context_id`,`submission_id`,`assoc_type`,`file_type`),
  CONSTRAINT `metrics_submission_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission`
--

LOCK TABLES `metrics_submission` WRITE;
/*!40000 ALTER TABLE `metrics_submission` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission_geo_daily`
--

DROP TABLE IF EXISTS `metrics_submission_geo_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_submission_geo_daily` (
  `metrics_submission_geo_daily_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `date` date NOT NULL,
  `metric` int(11) NOT NULL,
  `metric_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_submission_geo_daily_id`),
  UNIQUE KEY `msgd_uc_load_context_submission_c_r_c_date` (`load_id`,`context_id`,`submission_id`,`country`,`region`,`city`(80),`date`),
  KEY `msgd_load_id` (`load_id`),
  KEY `metrics_submission_geo_daily_context_id` (`context_id`),
  KEY `metrics_submission_geo_daily_submission_id` (`submission_id`),
  KEY `msgd_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msgd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msgd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Daily statistics by country, region and city for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission_geo_daily`
--

LOCK TABLES `metrics_submission_geo_daily` WRITE;
/*!40000 ALTER TABLE `metrics_submission_geo_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission_geo_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission_geo_monthly`
--

DROP TABLE IF EXISTS `metrics_submission_geo_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metrics_submission_geo_monthly` (
  `metrics_submission_geo_monthly_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `month` int(11) NOT NULL,
  `metric` int(11) NOT NULL,
  `metric_unique` int(11) NOT NULL,
  PRIMARY KEY (`metrics_submission_geo_monthly_id`),
  UNIQUE KEY `msgm_uc_context_submission_c_r_c_month` (`context_id`,`submission_id`,`country`,`region`,`city`(80),`month`),
  KEY `metrics_submission_geo_monthly_context_id` (`context_id`),
  KEY `metrics_submission_geo_monthly_submission_id` (`submission_id`),
  KEY `msgm_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msgm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msgm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Monthly statistics by country, region and city for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission_geo_monthly`
--

LOCK TABLES `metrics_submission_geo_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_submission_geo_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission_geo_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_assignment_settings`
--

DROP TABLE IF EXISTS `navigation_menu_item_assignment_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_menu_item_assignment_settings` (
  `navigation_menu_item_assignment_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `navigation_menu_item_assignment_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`navigation_menu_item_assignment_setting_id`),
  UNIQUE KEY `navigation_menu_item_assignment_settings_unique` (`navigation_menu_item_assignment_id`,`locale`,`setting_name`),
  KEY `navigation_menu_item_assignment_settings_n_m_i_a_id` (`navigation_menu_item_assignment_id`),
  CONSTRAINT `assignment_settings_navigation_menu_item_assignment_id` FOREIGN KEY (`navigation_menu_item_assignment_id`) REFERENCES `navigation_menu_item_assignments` (`navigation_menu_item_assignment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about navigation menu item assignments to navigation menus, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_assignment_settings`
--

LOCK TABLES `navigation_menu_item_assignment_settings` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_assignment_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `navigation_menu_item_assignment_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_assignments`
--

DROP TABLE IF EXISTS `navigation_menu_item_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_menu_item_assignments` (
  `navigation_menu_item_assignment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `navigation_menu_id` bigint(20) NOT NULL,
  `navigation_menu_item_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `seq` bigint(20) DEFAULT 0,
  PRIMARY KEY (`navigation_menu_item_assignment_id`),
  KEY `navigation_menu_item_assignments_navigation_menu_id` (`navigation_menu_id`),
  KEY `navigation_menu_item_assignments_navigation_menu_item_id` (`navigation_menu_item_id`),
  CONSTRAINT `navigation_menu_item_assignments_navigation_menu_id_foreign` FOREIGN KEY (`navigation_menu_id`) REFERENCES `navigation_menus` (`navigation_menu_id`) ON DELETE CASCADE,
  CONSTRAINT `navigation_menu_item_assignments_navigation_menu_item_id_foreign` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Links navigation menu items to navigation menus.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_assignments`
--

LOCK TABLES `navigation_menu_item_assignments` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_assignments` DISABLE KEYS */;
INSERT INTO `navigation_menu_item_assignments` VALUES (1,1,1,0,0),(2,1,2,0,1),(3,1,3,0,2),(4,1,4,3,0),(5,1,5,3,1),(6,1,6,3,2),(7,1,7,3,3),(8,2,8,0,0),(9,2,9,0,1),(10,2,10,0,2),(11,2,11,10,0),(12,2,12,10,1),(13,2,13,10,2),(14,2,14,10,3),(15,3,15,0,0),(16,3,16,0,1),(17,3,17,0,2),(18,3,18,0,3),(19,3,19,18,0),(20,3,20,18,1),(21,3,21,18,2),(22,3,22,18,3),(23,3,23,18,4);
/*!40000 ALTER TABLE `navigation_menu_item_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_settings`
--

DROP TABLE IF EXISTS `navigation_menu_item_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_menu_item_settings` (
  `navigation_menu_item_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `navigation_menu_item_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`navigation_menu_item_setting_id`),
  UNIQUE KEY `navigation_menu_item_settings_unique` (`navigation_menu_item_id`,`locale`,`setting_name`),
  KEY `navigation_menu_item_settings_navigation_menu_item_id` (`navigation_menu_item_id`),
  CONSTRAINT `navigation_menu_item_settings_navigation_menu_id` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about navigation menu items, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_settings`
--

LOCK TABLES `navigation_menu_item_settings` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_settings` DISABLE KEYS */;
INSERT INTO `navigation_menu_item_settings` VALUES (1,1,'','titleLocaleKey','navigation.register','string'),(2,2,'','titleLocaleKey','navigation.login','string'),(3,3,'','titleLocaleKey','{$loggedInUsername}','string'),(4,4,'','titleLocaleKey','navigation.dashboard','string'),(5,5,'','titleLocaleKey','common.viewProfile','string'),(6,6,'','titleLocaleKey','navigation.admin','string'),(7,7,'','titleLocaleKey','user.logOut','string'),(8,8,'','titleLocaleKey','navigation.register','string'),(9,9,'','titleLocaleKey','navigation.login','string'),(10,10,'','titleLocaleKey','{$loggedInUsername}','string'),(11,11,'','titleLocaleKey','navigation.dashboard','string'),(12,12,'','titleLocaleKey','common.viewProfile','string'),(13,13,'','titleLocaleKey','navigation.admin','string'),(14,14,'','titleLocaleKey','user.logOut','string'),(15,15,'','titleLocaleKey','navigation.current','string'),(16,16,'','titleLocaleKey','navigation.archives','string'),(17,17,'','titleLocaleKey','manager.announcements','string'),(18,18,'','titleLocaleKey','navigation.about','string'),(19,19,'','titleLocaleKey','about.aboutContext','string'),(20,20,'','titleLocaleKey','about.submissions','string'),(21,21,'','titleLocaleKey','about.editorialTeam','string'),(22,22,'','titleLocaleKey','manager.setup.privacyStatement','string'),(23,23,'','titleLocaleKey','about.contact','string'),(24,24,'','titleLocaleKey','common.search','string');
/*!40000 ALTER TABLE `navigation_menu_item_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_items`
--

DROP TABLE IF EXISTS `navigation_menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_menu_items` (
  `navigation_menu_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `path` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT '',
  PRIMARY KEY (`navigation_menu_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Navigation menu items are single elements within a navigation menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_items`
--

LOCK TABLES `navigation_menu_items` WRITE;
/*!40000 ALTER TABLE `navigation_menu_items` DISABLE KEYS */;
INSERT INTO `navigation_menu_items` VALUES (1,0,NULL,'NMI_TYPE_USER_REGISTER'),(2,0,NULL,'NMI_TYPE_USER_LOGIN'),(3,0,NULL,'NMI_TYPE_USER_DASHBOARD'),(4,0,NULL,'NMI_TYPE_USER_DASHBOARD'),(5,0,NULL,'NMI_TYPE_USER_PROFILE'),(6,0,NULL,'NMI_TYPE_ADMINISTRATION'),(7,0,NULL,'NMI_TYPE_USER_LOGOUT'),(8,1,NULL,'NMI_TYPE_USER_REGISTER'),(9,1,NULL,'NMI_TYPE_USER_LOGIN'),(10,1,NULL,'NMI_TYPE_USER_DASHBOARD'),(11,1,NULL,'NMI_TYPE_USER_DASHBOARD'),(12,1,NULL,'NMI_TYPE_USER_PROFILE'),(13,1,NULL,'NMI_TYPE_ADMINISTRATION'),(14,1,NULL,'NMI_TYPE_USER_LOGOUT'),(15,1,NULL,'NMI_TYPE_CURRENT'),(16,1,NULL,'NMI_TYPE_ARCHIVES'),(17,1,NULL,'NMI_TYPE_ANNOUNCEMENTS'),(18,1,NULL,'NMI_TYPE_ABOUT'),(19,1,NULL,'NMI_TYPE_ABOUT'),(20,1,NULL,'NMI_TYPE_SUBMISSIONS'),(21,1,NULL,'NMI_TYPE_EDITORIAL_TEAM'),(22,1,NULL,'NMI_TYPE_PRIVACY'),(23,1,NULL,'NMI_TYPE_CONTACT'),(24,1,NULL,'NMI_TYPE_SEARCH');
/*!40000 ALTER TABLE `navigation_menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menus`
--

DROP TABLE IF EXISTS `navigation_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_menus` (
  `navigation_menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `area_name` varchar(255) DEFAULT '',
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`navigation_menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Navigation menus on the website are installed with the software as a default set, and can be customized.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menus`
--

LOCK TABLES `navigation_menus` WRITE;
/*!40000 ALTER TABLE `navigation_menus` DISABLE KEYS */;
INSERT INTO `navigation_menus` VALUES (1,0,'user','User Navigation Menu'),(2,1,'user','User Navigation Menu'),(3,1,'primary','Primary Navigation Menu');
/*!40000 ALTER TABLE `navigation_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `note_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contents` text DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  KEY `notes_user_id` (`user_id`),
  KEY `notes_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Notes allow users to annotate associated entities, such as submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_settings`
--

DROP TABLE IF EXISTS `notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_settings` (
  `notification_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) NOT NULL,
  `locale` varchar(14) DEFAULT NULL,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`notification_setting_id`),
  UNIQUE KEY `notification_settings_unique` (`notification_id`,`locale`,`setting_name`),
  KEY `notification_settings_notification_id` (`notification_id`),
  CONSTRAINT `notification_settings_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`notification_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about notifications, including localized properties.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_settings`
--

LOCK TABLES `notification_settings` WRITE;
/*!40000 ALTER TABLE `notification_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_subscription_settings`
--

DROP TABLE IF EXISTS `notification_subscription_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_subscription_settings` (
  `setting_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `context` bigint(20) DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`setting_id`),
  KEY `notification_subscription_settings_user_id` (`user_id`),
  KEY `notification_subscription_settings_context` (`context`),
  CONSTRAINT `notification_subscription_settings_context_foreign` FOREIGN KEY (`context`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `notification_subscription_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Which email notifications a user has chosen to unsubscribe from.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_subscription_settings`
--

LOCK TABLES `notification_subscription_settings` WRITE;
/*!40000 ALTER TABLE `notification_subscription_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_subscription_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notification_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `level` bigint(20) NOT NULL,
  `type` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `assoc_type` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `notifications_context_id` (`context_id`),
  KEY `notifications_user_id` (`user_id`),
  KEY `notifications_context_id_user_id` (`context_id`,`user_id`,`level`),
  KEY `notifications_context_id_level` (`context_id`,`level`),
  KEY `notifications_assoc` (`assoc_type`,`assoc_id`),
  KEY `notifications_user_id_level` (`user_id`,`level`),
  CONSTRAINT `notifications_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='User notifications created during certain operations.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_resumption_tokens`
--

DROP TABLE IF EXISTS `oai_resumption_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_resumption_tokens` (
  `oai_resumption_token_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `expire` bigint(20) NOT NULL,
  `record_offset` int(11) NOT NULL,
  `params` text DEFAULT NULL,
  PRIMARY KEY (`oai_resumption_token_id`),
  UNIQUE KEY `oai_resumption_tokens_unique` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='OAI resumption tokens are used to allow for pagination of large result sets into manageable pieces.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_resumption_tokens`
--

LOCK TABLES `oai_resumption_tokens` WRITE;
/*!40000 ALTER TABLE `oai_resumption_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_resumption_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_settings`
--

DROP TABLE IF EXISTS `plugin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_settings` (
  `plugin_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(80) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `setting_name` varchar(80) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`plugin_setting_id`),
  UNIQUE KEY `plugin_settings_unique` (`plugin_name`,`context_id`,`setting_name`),
  KEY `plugin_settings_plugin_name` (`plugin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about plugins, including localized properties. This table is frequently used to store plugin-specific configuration.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_settings`
--

LOCK TABLES `plugin_settings` WRITE;
/*!40000 ALTER TABLE `plugin_settings` DISABLE KEYS */;
INSERT INTO `plugin_settings` VALUES (1,'defaultthemeplugin',0,'enabled','1','bool'),(2,'usageeventplugin',0,'enabled','1','bool'),(3,'tinymceplugin',0,'enabled','1','bool'),(4,'acronplugin',0,'enabled','1','bool'),(5,'acronplugin',0,'crontab','[{\"className\":\"APP\\\\plugins\\\\importexport\\\\doaj\\\\DOAJInfoSender\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\ReviewReminder\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\StatisticsReport\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\SubscriptionExpiryReminder\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\DepositDois\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\RemoveUnvalidatedExpiredUsers\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\EditorialReminders\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\UpdateIPGeoDB\",\"frequency\":{\"day\":\"10\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\UsageStatsLoader\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\ProcessQueueJobs\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\RemoveFailedJobs\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\OpenAccessNotification\",\"frequency\":{\"hour\":24},\"args\":[]}]','object'),(6,'developedbyblockplugin',0,'enabled','0','bool'),(7,'developedbyblockplugin',0,'seq','0','int'),(8,'languagetoggleblockplugin',0,'enabled','1','bool'),(9,'languagetoggleblockplugin',0,'seq','4','int'),(10,'defaultthemeplugin',1,'enabled','1','bool'),(11,'tinymceplugin',1,'enabled','1','bool'),(12,'developedbyblockplugin',1,'enabled','0','bool'),(13,'developedbyblockplugin',1,'seq','0','int'),(14,'informationblockplugin',1,'enabled','1','bool'),(15,'informationblockplugin',1,'seq','7','int'),(16,'subscriptionblockplugin',1,'enabled','1','bool'),(17,'subscriptionblockplugin',1,'seq','2','int'),(18,'languagetoggleblockplugin',1,'enabled','1','bool'),(19,'languagetoggleblockplugin',1,'seq','4','int'),(20,'resolverplugin',1,'enabled','1','bool'),(21,'htmlarticlegalleyplugin',1,'enabled','1','bool'),(22,'googlescholarplugin',1,'enabled','1','bool'),(23,'lensgalleyplugin',1,'enabled','1','bool'),(24,'pdfjsviewerplugin',1,'enabled','1','bool'),(25,'webfeedplugin',1,'enabled','1','bool'),(26,'webfeedplugin',1,'displayPage','homepage','string'),(27,'webfeedplugin',1,'displayItems','1','bool'),(28,'webfeedplugin',1,'recentItems','30','int'),(29,'webfeedplugin',1,'includeIdentifiers','0','bool'),(30,'dublincoremetaplugin',1,'enabled','1','bool'),(31,'bootstrapthreethemeplugin',1,'enabled','0','bool'),(32,'bootstrapthreethemeplugin',1,'displayStats','none','string'),(33,'bootstrapthreethemeplugin',1,'bootstrapTheme','superhero','string'),(34,'defaultthemeplugin',1,'typography','notoSans','string'),(35,'defaultthemeplugin',1,'baseColour','#1E6292','string'),(36,'defaultthemeplugin',1,'showDescriptionInJournalIndex','false','string'),(37,'defaultthemeplugin',1,'useHomepageImageAsHeader','false','string'),(38,'defaultthemeplugin',1,'displayStats','none','string');
/*!40000 ALTER TABLE `plugin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_categories`
--

DROP TABLE IF EXISTS `publication_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication_categories` (
  `publication_category_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `publication_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`publication_category_id`),
  UNIQUE KEY `publication_categories_id` (`publication_id`,`category_id`),
  KEY `publication_categories_publication_id` (`publication_id`),
  KEY `publication_categories_category_id` (`category_id`),
  CONSTRAINT `publication_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE,
  CONSTRAINT `publication_categories_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Associates publications (and thus submissions) with categories.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_categories`
--

LOCK TABLES `publication_categories` WRITE;
/*!40000 ALTER TABLE `publication_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_galley_settings`
--

DROP TABLE IF EXISTS `publication_galley_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication_galley_settings` (
  `publication_galley_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `galley_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`publication_galley_setting_id`),
  UNIQUE KEY `publication_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  KEY `publication_galley_settings_galley_id` (`galley_id`),
  KEY `publication_galley_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `publication_galley_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about publication galleys, including localized content such as labels.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_galley_settings`
--

LOCK TABLES `publication_galley_settings` WRITE;
/*!40000 ALTER TABLE `publication_galley_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_galley_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_galleys`
--

DROP TABLE IF EXISTS `publication_galleys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication_galleys` (
  `galley_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `locale` varchar(14) DEFAULT NULL,
  `publication_id` bigint(20) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `remote_url` varchar(2047) DEFAULT NULL,
  `is_approved` smallint(6) NOT NULL DEFAULT 0,
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`galley_id`),
  KEY `publication_galleys_publication_id` (`publication_id`),
  KEY `publication_galleys_submission_file_id` (`submission_file_id`),
  KEY `publication_galleys_doi_id` (`doi_id`),
  KEY `publication_galleys_url_path` (`url_path`),
  CONSTRAINT `publication_galleys_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `publication_galleys_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  CONSTRAINT `publication_galleys_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Publication galleys are representations of a publication in a specific format, e.g. a PDF.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_galleys`
--

LOCK TABLES `publication_galleys` WRITE;
/*!40000 ALTER TABLE `publication_galleys` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_galleys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_settings`
--

DROP TABLE IF EXISTS `publication_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication_settings` (
  `publication_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `publication_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`publication_setting_id`),
  UNIQUE KEY `publication_settings_unique` (`publication_id`,`locale`,`setting_name`),
  KEY `publication_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  KEY `publication_settings_publication_id` (`publication_id`),
  CONSTRAINT `publication_settings_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about publications, including localized properties such as the title and abstract.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_settings`
--

LOCK TABLES `publication_settings` WRITE;
/*!40000 ALTER TABLE `publication_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publications` (
  `publication_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `access_status` bigint(20) DEFAULT 0,
  `date_published` date DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `primary_contact_id` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `submission_id` bigint(20) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `url_path` varchar(64) DEFAULT NULL,
  `version` bigint(20) DEFAULT NULL,
  `doi_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`publication_id`),
  KEY `publications_primary_contact_id` (`primary_contact_id`),
  KEY `publications_section_id` (`section_id`),
  KEY `publications_submission_id` (`submission_id`),
  KEY `publications_doi_id` (`doi_id`),
  KEY `publications_url_path` (`url_path`),
  CONSTRAINT `publications_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `authors` (`author_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Each publication is one version of a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queries`
--

DROP TABLE IF EXISTS `queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queries` (
  `query_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `closed` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`query_id`),
  KEY `queries_assoc_id` (`assoc_type`,`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Discussions, usually related to a submission, created by editors, authors and other editorial staff.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queries`
--

LOCK TABLES `queries` WRITE;
/*!40000 ALTER TABLE `queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_participants`
--

DROP TABLE IF EXISTS `query_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_participants` (
  `query_participant_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `query_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`query_participant_id`),
  UNIQUE KEY `query_participants_unique` (`query_id`,`user_id`),
  KEY `query_participants_query_id` (`query_id`),
  KEY `query_participants_user_id` (`user_id`),
  CONSTRAINT `query_participants_query_id_foreign` FOREIGN KEY (`query_id`) REFERENCES `queries` (`query_id`) ON DELETE CASCADE,
  CONSTRAINT `query_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='The users assigned to a discussion.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_participants`
--

LOCK TABLES `query_participants` WRITE;
/*!40000 ALTER TABLE `query_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `query_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queued_payments`
--

DROP TABLE IF EXISTS `queued_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queued_payments` (
  `queued_payment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `payment_data` text DEFAULT NULL,
  PRIMARY KEY (`queued_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Unfulfilled (queued) payments, i.e. payments that have not yet been completed via an online payment system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queued_payments`
--

LOCK TABLES `queued_payments` WRITE;
/*!40000 ALTER TABLE `queued_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `queued_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignments`
--

DROP TABLE IF EXISTS `review_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_assignments` (
  `review_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `reviewer_id` bigint(20) NOT NULL,
  `competing_interests` text DEFAULT NULL,
  `recommendation` smallint(6) DEFAULT NULL,
  `date_assigned` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `date_confirmed` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `date_acknowledged` datetime DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `date_response_due` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reminder_was_automatic` smallint(6) NOT NULL DEFAULT 0,
  `declined` smallint(6) NOT NULL DEFAULT 0,
  `cancelled` smallint(6) NOT NULL DEFAULT 0,
  `date_rated` datetime DEFAULT NULL,
  `date_reminded` datetime DEFAULT NULL,
  `quality` smallint(6) DEFAULT NULL,
  `review_round_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `review_method` smallint(6) NOT NULL DEFAULT 1,
  `round` smallint(6) NOT NULL DEFAULT 1,
  `step` smallint(6) NOT NULL DEFAULT 1,
  `review_form_id` bigint(20) DEFAULT NULL,
  `considered` smallint(6) DEFAULT NULL,
  `request_resent` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`review_id`),
  KEY `review_assignments_submission_id` (`submission_id`),
  KEY `review_assignments_reviewer_id` (`reviewer_id`),
  KEY `review_assignment_reviewer_round` (`review_round_id`,`reviewer_id`),
  KEY `review_assignments_form_id` (`review_form_id`),
  KEY `review_assignments_reviewer_review` (`reviewer_id`,`review_id`),
  CONSTRAINT `review_assignments_review_form_id_foreign` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`),
  CONSTRAINT `review_assignments_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`),
  CONSTRAINT `review_assignments_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `review_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Data about peer review assignments for all submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignments`
--

LOCK TABLES `review_assignments` WRITE;
/*!40000 ALTER TABLE `review_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_files`
--

DROP TABLE IF EXISTS `review_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_files` (
  `review_file_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_id` bigint(20) NOT NULL,
  `submission_file_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`review_file_id`),
  UNIQUE KEY `review_files_unique` (`review_id`,`submission_file_id`),
  KEY `review_files_review_id` (`review_id`),
  KEY `review_files_submission_file_id` (`submission_file_id`),
  CONSTRAINT `review_files_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `review_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of the submission files made available to each assigned reviewer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_files`
--

LOCK TABLES `review_files` WRITE;
/*!40000 ALTER TABLE `review_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_element_settings`
--

DROP TABLE IF EXISTS `review_form_element_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_form_element_settings` (
  `review_form_element_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_form_element_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`review_form_element_setting_id`),
  UNIQUE KEY `review_form_element_settings_unique` (`review_form_element_id`,`locale`,`setting_name`),
  KEY `review_form_element_settings_review_form_element_id` (`review_form_element_id`),
  CONSTRAINT `review_form_element_settings_review_form_element_id` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about review form elements, including localized content such as question text.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_element_settings`
--

LOCK TABLES `review_form_element_settings` WRITE;
/*!40000 ALTER TABLE `review_form_element_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_element_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_elements`
--

DROP TABLE IF EXISTS `review_form_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_form_elements` (
  `review_form_element_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `review_form_id` bigint(20) NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  `element_type` bigint(20) DEFAULT NULL,
  `required` smallint(6) DEFAULT NULL,
  `included` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`review_form_element_id`),
  KEY `review_form_elements_review_form_id` (`review_form_id`),
  CONSTRAINT `review_form_elements_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Each review form element represents a single question on a review form.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_elements`
--

LOCK TABLES `review_form_elements` WRITE;
/*!40000 ALTER TABLE `review_form_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_responses`
--

DROP TABLE IF EXISTS `review_form_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_form_responses` (
  `review_form_response_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_form_element_id` bigint(20) NOT NULL,
  `review_id` bigint(20) NOT NULL,
  `response_type` varchar(6) DEFAULT NULL,
  `response_value` text DEFAULT NULL,
  PRIMARY KEY (`review_form_response_id`),
  KEY `review_form_responses_review_form_element_id` (`review_form_element_id`),
  KEY `review_form_responses_review_id` (`review_id`),
  KEY `review_form_responses_unique` (`review_form_element_id`,`review_id`),
  CONSTRAINT `review_form_responses_review_form_element_id_foreign` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE,
  CONSTRAINT `review_form_responses_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Each review form response records a reviewer''s answer to a review form element associated with a peer review.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_responses`
--

LOCK TABLES `review_form_responses` WRITE;
/*!40000 ALTER TABLE `review_form_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_settings`
--

DROP TABLE IF EXISTS `review_form_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_form_settings` (
  `review_form_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_form_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`review_form_setting_id`),
  UNIQUE KEY `review_form_settings_unique` (`review_form_id`,`locale`,`setting_name`),
  KEY `review_form_settings_review_form_id` (`review_form_id`),
  CONSTRAINT `review_form_settings_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about review forms, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_settings`
--

LOCK TABLES `review_form_settings` WRITE;
/*!40000 ALTER TABLE `review_form_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_forms`
--

DROP TABLE IF EXISTS `review_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_forms` (
  `review_form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  `is_active` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`review_form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Review forms provide custom templates for peer reviews with several types of questions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_forms`
--

LOCK TABLES `review_forms` WRITE;
/*!40000 ALTER TABLE `review_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_round_files`
--

DROP TABLE IF EXISTS `review_round_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_round_files` (
  `review_round_file_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `review_round_id` bigint(20) NOT NULL,
  `stage_id` smallint(6) NOT NULL,
  `submission_file_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`review_round_file_id`),
  UNIQUE KEY `review_round_files_unique` (`submission_id`,`review_round_id`,`submission_file_id`),
  KEY `review_round_files_submission_id` (`submission_id`),
  KEY `review_round_files_review_round_id` (`review_round_id`),
  KEY `review_round_files_submission_file_id` (`submission_file_id`),
  CONSTRAINT `review_round_files_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  CONSTRAINT `review_round_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `review_round_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Records the files made available to reviewers for a round of reviews. These can be further customized on a per review basis with review_files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_round_files`
--

LOCK TABLES `review_round_files` WRITE;
/*!40000 ALTER TABLE `review_round_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_round_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_rounds`
--

DROP TABLE IF EXISTS `review_rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_rounds` (
  `review_round_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) DEFAULT NULL,
  `round` smallint(6) NOT NULL,
  `review_revision` bigint(20) DEFAULT NULL,
  `status` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`review_round_id`),
  UNIQUE KEY `review_rounds_submission_id_stage_id_round_pkey` (`submission_id`,`stage_id`,`round`),
  KEY `review_rounds_submission_id` (`submission_id`),
  CONSTRAINT `review_rounds_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Peer review assignments are organized into multiple rounds on a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_rounds`
--

LOCK TABLES `review_rounds` WRITE;
/*!40000 ALTER TABLE `review_rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_tasks`
--

DROP TABLE IF EXISTS `scheduled_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_tasks` (
  `scheduled_task_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `last_run` datetime DEFAULT NULL,
  PRIMARY KEY (`scheduled_task_id`),
  UNIQUE KEY `scheduled_tasks_unique` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='The last time each scheduled task was run.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_tasks`
--

LOCK TABLES `scheduled_tasks` WRITE;
/*!40000 ALTER TABLE `scheduled_tasks` DISABLE KEYS */;
INSERT INTO `scheduled_tasks` VALUES (1,'PKP\\task\\ReviewReminder','2025-02-21 01:49:59'),(2,'PKP\\task\\StatisticsReport','2025-02-21 01:49:59'),(3,'APP\\tasks\\SubscriptionExpiryReminder','2025-02-21 01:49:59'),(4,'PKP\\task\\DepositDois','2025-02-21 01:49:59'),(5,'PKP\\task\\RemoveUnvalidatedExpiredUsers','2025-02-21 01:49:59'),(6,'PKP\\task\\EditorialReminders','2025-02-21 01:49:59'),(7,'PKP\\task\\UpdateIPGeoDB','2025-02-21 01:49:59'),(8,'APP\\tasks\\UsageStatsLoader','2025-02-21 01:50:02'),(9,'PKP\\task\\ProcessQueueJobs','2025-02-21 01:50:04'),(10,'PKP\\task\\RemoveFailedJobs','2025-02-21 01:50:04'),(11,'APP\\tasks\\OpenAccessNotification','2025-02-21 01:50:04'),(12,'APP\\plugins\\importexport\\doaj\\DOAJInfoSender','2025-02-21 02:45:47');
/*!40000 ALTER TABLE `scheduled_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_settings`
--

DROP TABLE IF EXISTS `section_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_settings` (
  `section_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`section_setting_id`),
  UNIQUE KEY `section_settings_unique` (`section_id`,`locale`,`setting_name`),
  KEY `section_settings_section_id` (`section_id`),
  CONSTRAINT `section_settings_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about sections, including localized properties like section titles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_settings`
--

LOCK TABLES `section_settings` WRITE;
/*!40000 ALTER TABLE `section_settings` DISABLE KEYS */;
INSERT INTO `section_settings` VALUES (1,1,'es','title','Artículos'),(2,1,'es','abbrev','ART'),(3,1,'es','policy','Política de sección por defecto');
/*!40000 ALTER TABLE `section_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `section_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) NOT NULL,
  `review_form_id` bigint(20) DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT 0.00,
  `editor_restricted` smallint(6) NOT NULL DEFAULT 0,
  `meta_indexed` smallint(6) NOT NULL DEFAULT 0,
  `meta_reviewed` smallint(6) NOT NULL DEFAULT 1,
  `abstracts_not_required` smallint(6) NOT NULL DEFAULT 0,
  `hide_title` smallint(6) NOT NULL DEFAULT 0,
  `hide_author` smallint(6) NOT NULL DEFAULT 0,
  `is_inactive` smallint(6) NOT NULL DEFAULT 0,
  `abstract_word_count` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `sections_journal_id` (`journal_id`),
  KEY `sections_review_form_id` (`review_form_id`),
  CONSTRAINT `sections_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `sections_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of all sections into which submissions can be organized, forming the table of contents.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,NULL,0.00,0,1,1,0,0,0,0,NULL);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `ip_address` varchar(39) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created` bigint(20) NOT NULL DEFAULT 0,
  `last_used` bigint(20) NOT NULL DEFAULT 0,
  `remember` smallint(6) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  UNIQUE KEY `sessions_pkey` (`session_id`),
  KEY `sessions_user_id` (`user_id`),
  CONSTRAINT `sessions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Session data for logged-in users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('09nvqj88hv4274mbkjqhd3oim2',NULL,'43.133.139.6','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740116747,1740116747,0,'','www.revistasrelatic.org'),('13d9ejhlavjvvottf52q3sadh7',NULL,'43.157.170.13','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740103356,1740103356,0,'','www.revistasrelatic.org'),('1df2qrasmtf1dm6teu8e7fd84f',NULL,'66.249.70.171','Googlebot/2.1 (+http://www.google.com/bot.html)',1740117545,1740117545,0,'','www.revistasrelatic.org'),('2f18r0o1o7c7l67s68drvmmtkn',NULL,'43.157.168.43','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740121023,1740121023,0,'','revistasrelatic.org'),('3g4tgpnr54kvbf62qp72o2jceu',NULL,'43.157.209.67','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740109518,1740109518,0,'','revistasrelatic.org'),('58b6s575c73qs39lopsk3v4frg',NULL,'20.171.207.255','Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)',1740136039,1740136039,0,'','revistasrelatic.org'),('6504mmtdobvrd0bvromav3g2a8',NULL,'43.159.132.207','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740136146,1740136146,0,'','www.revistasrelatic.org'),('6u5vs175slmcmmdvphsf73m30j',1,'201.224.156.157','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36',1740135137,1740135489,1,'userId|i:1;username|s:5:\"admin\";csrf|a:2:{s:9:\"timestamp\";i:1740135489;s:5:\"token\";s:32:\"ef1bf239b4c0f7b53752e1ef8af2fedb\";}','www.revistasrelatic.org'),('81dhgufmcgse0qnim5mqa0j9hq',NULL,'43.153.87.54','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740107887,1740107887,0,'','www.revistasrelatic.org'),('8co35kjrkd7l2pft8up282ps9n',NULL,'157.245.109.238','Mozilla/5.0 (compatible)',1740132681,1740132681,0,'','mail.revistasrelatic.org'),('8jcud8oh63tvupak18ienhq0dd',1,'201.224.164.154','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/27.0 Chrome/125.0.0.0 Mobile Safari/537.36',1740102814,1740106047,1,'csrf|a:2:{s:9:\"timestamp\";i:1740106047;s:5:\"token\";s:32:\"a010ed851c7ea21c3198b4d8e727231d\";}userId|i:1;username|s:5:\"admin\";','www.revistasrelatic.org'),('b456c34vlf72k3venvfv0d9fcf',NULL,'20.171.207.255','Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)',1740110948,1740110948,0,'','revistasrelatic.org'),('c9hnaaib16er9goe9k1pmllt6q',NULL,'43.156.109.53','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740116020,1740116020,0,'csrf|a:2:{s:9:\"timestamp\";i:1740116020;s:5:\"token\";s:32:\"0d528baf55f59e438f53dd2c234954bd\";}','www.revistasrelatic.org'),('dsic79k9nbejdt7v2d340554ms',NULL,'124.156.157.91','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740108845,1740108845,0,'','www.revistasrelatic.org'),('e43f77pbaeul6hus7p0401ga5v',NULL,'43.157.251.48','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740111702,1740111702,0,'','revistasrelatic.org'),('eg32n8pc9p0lr7jrk1b1o1cee2',NULL,'43.135.144.81','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740115520,1740115520,0,'csrf|a:2:{s:9:\"timestamp\";i:1740115520;s:5:\"token\";s:32:\"b4d6b4e71bf4f3cdb21b16a76ed828c6\";}','www.revistasrelatic.org'),('g0dmrmvah2js38lc7gidksj1n1',NULL,'43.133.139.6','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740116751,1740116751,0,'','www.revistasrelatic.org'),('hqtn82qev6moug5j5cdor9u1t1',NULL,'43.153.85.46','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740113867,1740113867,0,'','www.revistasrelatic.org'),('jjbj448mlhjcllf43phkhjvc35',1,'201.224.164.154','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36',1740102592,1740102897,1,'userId|i:1;username|s:5:\"admin\";csrf|a:2:{s:9:\"timestamp\";i:1740102897;s:5:\"token\";s:32:\"86b79be5e0ec94f1fb85f3739902ce69\";}','www.revistasrelatic.org'),('k24pc7vuv4161mo3gpk33jdg52',NULL,'43.159.132.207','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740136146,1740136146,0,'','www.revistasrelatic.org'),('keddb3l12sfrp9m8e032pdagkg',NULL,'124.156.226.179','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740131039,1740131039,0,'','revistasrelatic.org'),('ld3hr8f3fsc9987gedff6eb9io',NULL,'43.130.16.140','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740107289,1740107289,0,'','www.revistasrelatic.org'),('li4jc2ojviegcqeeb8serqrgt1',NULL,'117.33.163.216','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740114822,1740114822,0,'','www.revistasrelatic.org'),('li4mqv23btut7pkbausn2fcmhg',NULL,'43.153.122.30','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740113798,1740113798,0,'csrf|a:2:{s:9:\"timestamp\";i:1740113799;s:5:\"token\";s:32:\"9b612f8b4c31f0a332d2ea88215062c3\";}','www.revistasrelatic.org'),('mkuojlvdur8f7dsi3dfiolpe9q',NULL,'43.157.158.178','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740126612,1740126612,0,'','www.revistasrelatic.org'),('mmhfe9lcnoqd4ill53psi79sb6',NULL,'43.157.170.13','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740103357,1740103357,0,'','www.revistasrelatic.org'),('nfk0bj71ddiibm9llcri7g92o3',NULL,'43.130.9.111','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740111078,1740111078,0,'','www.revistasrelatic.org'),('ngre9v2tee359mc5e1ibn0l531',NULL,'54.202.182.68','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36',1740131390,1740131390,0,'','revistasrelatic.org'),('oag5tnm41glqb92nd9b0hjs1cl',NULL,'66.249.70.171','Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.6943.126 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',1740114598,1740114598,0,'csrf|a:2:{s:9:\"timestamp\";i:1740114598;s:5:\"token\";s:32:\"bb5d925157e07b8a5045eb07741ccc5c\";}','www.revistasrelatic.org'),('olah9mm79i56qing3u3nrnj4qk',NULL,'157.245.109.238','Mozilla/5.0 (compatible)',1740132682,1740132682,0,'','mail.revistasrelatic.org'),('oo24ovfru0m4l226u8bist4ai2',NULL,'66.249.70.169','Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.6943.126 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',1740119599,1740119599,0,'csrf|a:2:{s:9:\"timestamp\";i:1740119599;s:5:\"token\";s:32:\"16cbf649414ca6f279b3e59a9daf8e0f\";}','www.revistasrelatic.org'),('qbls6ivrkdipl94moukgvqcnqc',NULL,'117.33.163.216','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740114819,1740114819,0,'','www.revistasrelatic.org'),('ql3g878ouvfi4ol4pap0nrf07v',NULL,'43.152.72.244','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740114931,1740114931,0,'csrf|a:2:{s:9:\"timestamp\";i:1740114931;s:5:\"token\";s:32:\"db5f0eebd45900fcace140214ab8f4a0\";}','www.revistasrelatic.org'),('sae345ktb92uvdok5uav54q3uq',NULL,'43.153.49.151','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740117351,1740117351,0,'csrf|a:2:{s:9:\"timestamp\";i:1740117351;s:5:\"token\";s:32:\"16045afe698eef0484c889cd741d8825\";}','www.revistasrelatic.org'),('ssub315saioc55f4saf51gfaru',NULL,'43.157.158.178','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1740126613,1740126613,0,'','www.revistasrelatic.org'),('ucodr0vggq7fe4pu9k4vofi1ch',NULL,'66.249.70.170','Googlebot/2.1 (+http://www.google.com/bot.html)',1740117143,1740117143,0,'','www.revistasrelatic.org');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `site_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `redirect` bigint(20) NOT NULL DEFAULT 0 COMMENT 'If not 0, redirect to the specified journal/conference/... site.',
  `primary_locale` varchar(14) NOT NULL COMMENT 'Primary locale for the site.',
  `min_password_length` smallint(6) NOT NULL DEFAULT 6,
  `installed_locales` varchar(1024) NOT NULL DEFAULT 'en' COMMENT 'Locales for which support has been installed.',
  `supported_locales` varchar(1024) DEFAULT NULL COMMENT 'Locales supported by the site (for hosted journals/conferences/...).',
  `original_style_file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A singleton table describing basic information about the site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (1,0,'es',6,'[\"es\"]','[\"es\"]',NULL);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings`
--

DROP TABLE IF EXISTS `site_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_settings` (
  `site_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`site_setting_id`),
  UNIQUE KEY `site_settings_unique` (`setting_name`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about the site, including localized properties such as its name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings`
--

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;
INSERT INTO `site_settings` VALUES (1,'contactEmail','es','israel.samuelsg@gmail.com'),(2,'contactName','es','Open Journal Systems'),(3,'compressStatsLogs','','0'),(4,'enableGeoUsageStats','','disabled'),(5,'enableInstitutionUsageStats','','0'),(6,'keepDailyUsageStats','','0'),(7,'isSiteSushiPlatform','','0'),(8,'isSushiApiPublic','','1'),(9,'disableSharedReviewerStatistics','','0'),(10,'themePluginPath','','default'),(11,'uniqueSiteId','','0CF31C56-9AC2-4E3E-BCC8-784BCEF9D4DA');
/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage_assignments`
--

DROP TABLE IF EXISTS `stage_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stage_assignments` (
  `stage_assignment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_assigned` datetime NOT NULL,
  `recommend_only` smallint(6) NOT NULL DEFAULT 0,
  `can_change_metadata` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`stage_assignment_id`),
  UNIQUE KEY `stage_assignment` (`submission_id`,`user_group_id`,`user_id`),
  KEY `stage_assignments_user_group_id` (`user_group_id`),
  KEY `stage_assignments_user_id` (`user_id`),
  KEY `stage_assignments_submission_id` (`submission_id`),
  CONSTRAINT `stage_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  CONSTRAINT `stage_assignments_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `stage_assignments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Who can access a submission while it is in the editorial workflow. Includes all editorial and author assignments. For reviewers, see review_assignments.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage_assignments`
--

LOCK TABLES `stage_assignments` WRITE;
/*!40000 ALTER TABLE `stage_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `stage_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_page_settings`
--

DROP TABLE IF EXISTS `static_page_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `static_page_settings` (
  `static_page_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `static_page_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`static_page_setting_id`),
  KEY `static_page_settings_static_page_id` (`static_page_id`),
  CONSTRAINT `static_page_settings_static_page_id` FOREIGN KEY (`static_page_id`) REFERENCES `static_pages` (`static_page_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_page_settings`
--

LOCK TABLES `static_page_settings` WRITE;
/*!40000 ALTER TABLE `static_page_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_page_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_pages`
--

DROP TABLE IF EXISTS `static_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `static_pages` (
  `static_page_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  PRIMARY KEY (`static_page_id`),
  KEY `static_pages_context_id` (`context_id`),
  CONSTRAINT `static_pages_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_pages`
--

LOCK TABLES `static_pages` WRITE;
/*!40000 ALTER TABLE `static_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subeditor_submission_group`
--

DROP TABLE IF EXISTS `subeditor_submission_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subeditor_submission_group` (
  `subeditor_submission_group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subeditor_submission_group_id`),
  UNIQUE KEY `section_editors_unique` (`context_id`,`assoc_id`,`assoc_type`,`user_id`,`user_group_id`),
  KEY `subeditor_submission_group_context_id` (`context_id`),
  KEY `subeditor_submission_group_user_id` (`user_id`),
  KEY `subeditor_submission_group_user_group_id` (`user_group_id`),
  KEY `subeditor_submission_group_assoc_id` (`assoc_id`,`assoc_type`),
  CONSTRAINT `section_editors_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `subeditor_submission_group_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `subeditor_submission_group_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Subeditor assignments to e.g. sections and categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subeditor_submission_group`
--

LOCK TABLES `subeditor_submission_group` WRITE;
/*!40000 ALTER TABLE `subeditor_submission_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `subeditor_submission_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_comments`
--

DROP TABLE IF EXISTS `submission_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_comments` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment_type` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `assoc_id` bigint(20) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `comment_title` text NOT NULL,
  `comments` text DEFAULT NULL,
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `viewable` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `submission_comments_submission_id` (`submission_id`),
  KEY `submission_comments_author_id` (`author_id`),
  CONSTRAINT `submission_comments_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_comments_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Comments on a submission, e.g. peer review comments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_comments`
--

LOCK TABLES `submission_comments` WRITE;
/*!40000 ALTER TABLE `submission_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_file_revisions`
--

DROP TABLE IF EXISTS `submission_file_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_file_revisions` (
  `revision_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `submission_file_id` bigint(20) unsigned NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`revision_id`),
  KEY `submission_file_revisions_submission_file_id` (`submission_file_id`),
  KEY `submission_file_revisions_file_id` (`file_id`),
  CONSTRAINT `submission_file_revisions_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_file_revisions_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Revisions map submission_file entries to files on the data store.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_file_revisions`
--

LOCK TABLES `submission_file_revisions` WRITE;
/*!40000 ALTER TABLE `submission_file_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_file_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_file_settings`
--

DROP TABLE IF EXISTS `submission_file_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_file_settings` (
  `submission_file_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `submission_file_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`submission_file_setting_id`),
  UNIQUE KEY `submission_file_settings_unique` (`submission_file_id`,`locale`,`setting_name`),
  KEY `submission_file_settings_submission_file_id` (`submission_file_id`),
  CONSTRAINT `submission_file_settings_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Localized data about submission files like published metadata.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_file_settings`
--

LOCK TABLES `submission_file_settings` WRITE;
/*!40000 ALTER TABLE `submission_file_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_file_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_files`
--

DROP TABLE IF EXISTS `submission_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_files` (
  `submission_file_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `file_id` bigint(20) unsigned NOT NULL,
  `source_submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `genre_id` bigint(20) DEFAULT NULL,
  `file_stage` bigint(20) NOT NULL,
  `direct_sales_price` varchar(255) DEFAULT NULL,
  `sales_type` varchar(255) DEFAULT NULL,
  `viewable` smallint(6) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uploader_user_id` bigint(20) DEFAULT NULL,
  `assoc_type` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`submission_file_id`),
  KEY `submission_files_submission_id` (`submission_id`),
  KEY `submission_files_file_id` (`file_id`),
  KEY `submission_files_genre_id` (`genre_id`),
  KEY `submission_files_uploader_user_id` (`uploader_user_id`),
  KEY `submission_files_stage_assoc` (`file_stage`,`assoc_type`,`assoc_id`),
  KEY `submission_files_source_submission_file_id` (`source_submission_file_id`),
  CONSTRAINT `submission_files_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE SET NULL,
  CONSTRAINT `submission_files_source_submission_file_id_foreign` FOREIGN KEY (`source_submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_uploader_user_id_foreign` FOREIGN KEY (`uploader_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='All files associated with a submission, such as those uploaded during submission, as revisions, or by copyeditors or layout editors for production.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_files`
--

LOCK TABLES `submission_files` WRITE;
/*!40000 ALTER TABLE `submission_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_keyword_list`
--

DROP TABLE IF EXISTS `submission_search_keyword_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_search_keyword_list` (
  `keyword_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyword_text` varchar(60) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  UNIQUE KEY `submission_search_keyword_text` (`keyword_text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of all keywords used in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_keyword_list`
--

LOCK TABLES `submission_search_keyword_list` WRITE;
/*!40000 ALTER TABLE `submission_search_keyword_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_keyword_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_object_keywords`
--

DROP TABLE IF EXISTS `submission_search_object_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_search_object_keywords` (
  `submission_search_object_keyword_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) NOT NULL,
  `keyword_id` bigint(20) NOT NULL,
  `pos` int(11) NOT NULL COMMENT 'Word position of the keyword in the object.',
  PRIMARY KEY (`submission_search_object_keyword_id`),
  UNIQUE KEY `submission_search_object_keywords_unique` (`object_id`,`pos`),
  KEY `submission_search_object_keywords_object_id` (`object_id`),
  KEY `submission_search_object_keywords_keyword_id` (`keyword_id`),
  CONSTRAINT `submission_search_object_keywords_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `submission_search_keyword_list` (`keyword_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_search_object_keywords_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `submission_search_objects` (`object_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Relationships between search objects and keywords in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_object_keywords`
--

LOCK TABLES `submission_search_object_keywords` WRITE;
/*!40000 ALTER TABLE `submission_search_object_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_object_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_objects`
--

DROP TABLE IF EXISTS `submission_search_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_search_objects` (
  `object_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `type` int(11) NOT NULL COMMENT 'Type of item. E.g., abstract, fulltext, etc.',
  `assoc_id` bigint(20) DEFAULT NULL COMMENT 'Optional ID of an associated record (e.g., a file_id)',
  PRIMARY KEY (`object_id`),
  KEY `submission_search_objects_submission_id` (`submission_id`),
  CONSTRAINT `submission_search_object_submission` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of all search objects indexed in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_objects`
--

LOCK TABLES `submission_search_objects` WRITE;
/*!40000 ALTER TABLE `submission_search_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_settings`
--

DROP TABLE IF EXISTS `submission_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submission_settings` (
  `submission_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`submission_setting_id`),
  UNIQUE KEY `submission_settings_unique` (`submission_id`,`locale`,`setting_name`),
  KEY `submission_settings_submission_id` (`submission_id`),
  CONSTRAINT `submission_settings_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Localized data about submissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_settings`
--

LOCK TABLES `submission_settings` WRITE;
/*!40000 ALTER TABLE `submission_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions` (
  `submission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `current_publication_id` bigint(20) DEFAULT NULL,
  `date_last_activity` datetime DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `stage_id` bigint(20) NOT NULL DEFAULT 1,
  `locale` varchar(14) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `submission_progress` varchar(50) NOT NULL DEFAULT 'start',
  `work_type` smallint(6) DEFAULT 0,
  PRIMARY KEY (`submission_id`),
  KEY `submissions_context_id` (`context_id`),
  KEY `submissions_publication_id` (`current_publication_id`),
  CONSTRAINT `submissions_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_publication_id` FOREIGN KEY (`current_publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='All submissions submitted to the context, including incomplete, declined and unpublished submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_type_settings`
--

DROP TABLE IF EXISTS `subscription_type_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_type_settings` (
  `subscription_type_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`subscription_type_setting_id`),
  UNIQUE KEY `subscription_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  KEY `subscription_type_settings_type_id` (`type_id`),
  CONSTRAINT `subscription_type_settings_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about subscription types, including localized properties such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_type_settings`
--

LOCK TABLES `subscription_type_settings` WRITE;
/*!40000 ALTER TABLE `subscription_type_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_type_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_types`
--

DROP TABLE IF EXISTS `subscription_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_types` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) NOT NULL,
  `cost` double(8,2) NOT NULL,
  `currency_code_alpha` varchar(3) NOT NULL,
  `duration` smallint(6) DEFAULT NULL,
  `format` smallint(6) NOT NULL,
  `institutional` smallint(6) NOT NULL DEFAULT 0,
  `membership` smallint(6) NOT NULL DEFAULT 0,
  `disable_public_display` smallint(6) NOT NULL,
  `seq` double(8,2) NOT NULL,
  PRIMARY KEY (`type_id`),
  KEY `subscription_types_journal_id` (`journal_id`),
  CONSTRAINT `subscription_types_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Subscription types represent the kinds of subscriptions that a user or institution may have, such as an annual subscription or a discounted subscription.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_types`
--

LOCK TABLES `subscription_types` WRITE;
/*!40000 ALTER TABLE `subscription_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `subscription_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type_id` bigint(20) NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1,
  `membership` varchar(40) DEFAULT NULL,
  `reference_number` varchar(40) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  KEY `subscriptions_journal_id` (`journal_id`),
  KEY `subscriptions_user_id` (`user_id`),
  KEY `subscriptions_type_id` (`type_id`),
  CONSTRAINT `subscriptions_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='A list of subscriptions, both institutional and individual, for journals that use subscription-based publishing.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temporary_files`
--

DROP TABLE IF EXISTS `temporary_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temporary_files` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `temporary_files_user_id` (`user_id`),
  CONSTRAINT `temporary_files_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Temporary files, e.g. where files are kept during an upload process before they are moved somewhere more appropriate.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temporary_files`
--

LOCK TABLES `temporary_files` WRITE;
/*!40000 ALTER TABLE `temporary_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `temporary_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_institution_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_institution_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_stats_institution_temporary_records` (
  `usage_stats_temp_institution_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `institution_id` bigint(20) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_institution_id`),
  UNIQUE KEY `usitr_load_id_line_number_institution_id` (`load_id`,`line_number`,`institution_id`),
  KEY `usi_institution_id` (`institution_id`),
  CONSTRAINT `usi_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Temporary stats for views and downloads from institutions based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_institution_temporary_records`
--

LOCK TABLES `usage_stats_institution_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_institution_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_institution_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_total_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_total_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_stats_total_temporary_records` (
  `usage_stats_temp_total_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `canonical_url` varchar(255) NOT NULL,
  `issue_id` bigint(20) DEFAULT NULL,
  `issue_galley_id` bigint(20) DEFAULT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) DEFAULT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_total_id`),
  KEY `usage_stats_total_temporary_records_issue_id` (`issue_id`),
  KEY `usage_stats_total_temporary_records_issue_galley_id` (`issue_galley_id`),
  KEY `usage_stats_total_temporary_records_context_id` (`context_id`),
  KEY `usage_stats_total_temporary_records_submission_id` (`submission_id`),
  KEY `usage_stats_total_temporary_records_representation_id` (`representation_id`),
  KEY `usage_stats_total_temporary_records_submission_file_id` (`submission_file_id`),
  KEY `ust_load_id_context_id_ip` (`load_id`,`context_id`,`ip`),
  CONSTRAINT `ust_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Temporary stats totals based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_total_temporary_records`
--

LOCK TABLES `usage_stats_total_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_total_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_total_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_unique_item_investigations_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_unique_item_investigations_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_stats_unique_item_investigations_temporary_records` (
  `usage_stats_temp_unique_item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_unique_item_id`),
  KEY `usii_context_id` (`context_id`),
  KEY `usii_submission_id` (`submission_id`),
  KEY `usii_representation_id` (`representation_id`),
  KEY `usii_submission_file_id` (`submission_file_id`),
  KEY `usii_load_id_context_id_ip` (`load_id`,`context_id`,`ip`),
  CONSTRAINT `usii_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Temporary stats on unique downloads based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_unique_item_investigations_temporary_records`
--

LOCK TABLES `usage_stats_unique_item_investigations_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_unique_item_investigations_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_unique_item_investigations_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_unique_item_requests_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_unique_item_requests_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usage_stats_unique_item_requests_temporary_records` (
  `usage_stats_temp_item_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint(20) NOT NULL,
  `context_id` bigint(20) NOT NULL,
  `submission_id` bigint(20) NOT NULL,
  `representation_id` bigint(20) DEFAULT NULL,
  `submission_file_id` bigint(20) unsigned DEFAULT NULL,
  `assoc_type` bigint(20) NOT NULL,
  `file_type` smallint(6) DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_item_id`),
  KEY `usir_context_id` (`context_id`),
  KEY `usir_submission_id` (`submission_id`),
  KEY `usir_representation_id` (`representation_id`),
  KEY `usir_submission_file_id` (`submission_file_id`),
  KEY `usir_load_id_context_id_ip` (`load_id`,`context_id`,`ip`),
  CONSTRAINT `usir_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Temporary stats on unique views based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_unique_item_requests_temporary_records`
--

LOCK TABLES `usage_stats_unique_item_requests_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_unique_item_requests_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_unique_item_requests_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_settings`
--

DROP TABLE IF EXISTS `user_group_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_settings` (
  `user_group_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_group_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`user_group_setting_id`),
  UNIQUE KEY `user_group_settings_unique` (`user_group_id`,`locale`,`setting_name`),
  KEY `user_group_settings_user_group_id` (`user_group_id`),
  CONSTRAINT `user_group_settings_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about user groups, including localized properties such as the name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_settings`
--

LOCK TABLES `user_group_settings` WRITE;
/*!40000 ALTER TABLE `user_group_settings` DISABLE KEYS */;
INSERT INTO `user_group_settings` VALUES (1,1,'es','name','Administrador/a del sitio'),(2,2,'','nameLocaleKey','default.groups.name.manager'),(3,2,'','abbrevLocaleKey','default.groups.abbrev.manager'),(4,2,'es','abbrev','GR'),(5,2,'es','name','Gestor/a de la revista'),(6,3,'','nameLocaleKey','default.groups.name.editor'),(7,3,'','abbrevLocaleKey','default.groups.abbrev.editor'),(8,3,'es','abbrev','ER'),(9,3,'es','name','Editor/a de la revista'),(10,4,'','nameLocaleKey','default.groups.name.productionEditor'),(11,4,'','abbrevLocaleKey','default.groups.abbrev.productionEditor'),(12,4,'es','abbrev','CoProd'),(13,4,'es','name','Coordinador/a de producción'),(14,5,'','nameLocaleKey','default.groups.name.sectionEditor'),(15,5,'','abbrevLocaleKey','default.groups.abbrev.sectionEditor'),(16,5,'es','abbrev','ESec'),(17,5,'es','name','Editor/a de sección'),(18,6,'','nameLocaleKey','default.groups.name.guestEditor'),(19,6,'','abbrevLocaleKey','default.groups.abbrev.guestEditor'),(20,6,'es','abbrev','EI'),(21,6,'es','name','Editor/a invitado/a'),(22,7,'','nameLocaleKey','default.groups.name.copyeditor'),(23,7,'','abbrevLocaleKey','default.groups.abbrev.copyeditor'),(24,7,'es','abbrev','CE'),(25,7,'es','name','Corrector/a de estilo'),(26,8,'','nameLocaleKey','default.groups.name.designer'),(27,8,'','abbrevLocaleKey','default.groups.abbrev.designer'),(28,8,'es','abbrev','Diseño'),(29,8,'es','name','Diseñador/a'),(30,9,'','nameLocaleKey','default.groups.name.funding'),(31,9,'','abbrevLocaleKey','default.groups.abbrev.funding'),(32,9,'es','abbrev','CF'),(33,9,'es','name','Coordinador/a de financiación'),(34,10,'','nameLocaleKey','default.groups.name.indexer'),(35,10,'','abbrevLocaleKey','default.groups.abbrev.indexer'),(36,10,'es','abbrev','DOC'),(37,10,'es','name','Documentalista'),(38,11,'','nameLocaleKey','default.groups.name.layoutEditor'),(39,11,'','abbrevLocaleKey','default.groups.abbrev.layoutEditor'),(40,11,'es','abbrev','MAQ'),(41,11,'es','name','Maquetador/a'),(42,12,'','nameLocaleKey','default.groups.name.marketing'),(43,12,'','abbrevLocaleKey','default.groups.abbrev.marketing'),(44,12,'es','abbrev','MV'),(45,12,'es','name','Coordinador/a de marketing y ventas'),(46,13,'','nameLocaleKey','default.groups.name.proofreader'),(47,13,'','abbrevLocaleKey','default.groups.abbrev.proofreader'),(48,13,'es','abbrev','CP'),(49,13,'es','name','Corrector/a de pruebas'),(50,14,'','nameLocaleKey','default.groups.name.author'),(51,14,'','abbrevLocaleKey','default.groups.abbrev.author'),(52,14,'es','abbrev','AU'),(53,14,'es','name','Autor/a'),(54,15,'','nameLocaleKey','default.groups.name.translator'),(55,15,'','abbrevLocaleKey','default.groups.abbrev.translator'),(56,15,'es','abbrev','Trad'),(57,15,'es','name','Traductor/a'),(58,16,'','nameLocaleKey','default.groups.name.externalReviewer'),(59,16,'','abbrevLocaleKey','default.groups.abbrev.externalReviewer'),(60,16,'es','abbrev','R'),(61,16,'es','name','Revisor/a'),(62,17,'','nameLocaleKey','default.groups.name.reader'),(63,17,'','abbrevLocaleKey','default.groups.abbrev.reader'),(64,17,'es','abbrev','Lect'),(65,17,'es','name','Lector/a'),(66,18,'','nameLocaleKey','default.groups.name.subscriptionManager'),(67,18,'','abbrevLocaleKey','default.groups.abbrev.subscriptionManager'),(68,18,'es','abbrev','GSus'),(69,18,'es','name','Gestor/a de suscripción');
/*!40000 ALTER TABLE `user_group_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_stage`
--

DROP TABLE IF EXISTS `user_group_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_stage` (
  `user_group_stage_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `user_group_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_group_stage_id`),
  UNIQUE KEY `user_group_stage_unique` (`context_id`,`user_group_id`,`stage_id`),
  KEY `user_group_stage_context_id` (`context_id`),
  KEY `user_group_stage_user_group_id` (`user_group_id`),
  KEY `user_group_stage_stage_id` (`stage_id`),
  CONSTRAINT `user_group_stage_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `user_group_stage_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Which stages of the editorial workflow the user_groups can access.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_stage`
--

LOCK TABLES `user_group_stage` WRITE;
/*!40000 ALTER TABLE `user_group_stage` DISABLE KEYS */;
INSERT INTO `user_group_stage` VALUES (1,1,3,1),(2,1,3,3),(3,1,3,4),(4,1,3,5),(5,1,4,4),(6,1,4,5),(7,1,5,1),(8,1,5,3),(9,1,5,4),(10,1,5,5),(11,1,6,1),(12,1,6,3),(13,1,6,4),(14,1,6,5),(15,1,7,4),(16,1,8,5),(17,1,9,1),(18,1,9,3),(19,1,10,5),(20,1,11,5),(21,1,12,4),(22,1,13,5),(23,1,14,1),(24,1,14,3),(25,1,14,4),(26,1,14,5),(27,1,15,1),(28,1,15,3),(29,1,15,4),(30,1,15,5),(31,1,16,3);
/*!40000 ALTER TABLE `user_group_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `user_group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `is_default` smallint(6) NOT NULL DEFAULT 0,
  `show_title` smallint(6) NOT NULL DEFAULT 1,
  `permit_self_registration` smallint(6) NOT NULL DEFAULT 0,
  `permit_metadata_edit` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_group_id`),
  KEY `user_groups_user_group_id` (`user_group_id`),
  KEY `user_groups_context_id` (`context_id`),
  KEY `user_groups_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='All defined user roles in a context, such as Author, Reviewer, Section Editor and Journal Manager.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,0,1,1,1,0,0),(2,1,16,1,1,0,1),(3,1,16,1,1,0,1),(4,1,16,1,1,0,1),(5,1,17,1,1,0,1),(6,1,17,1,1,0,0),(7,1,4097,1,1,0,0),(8,1,4097,1,1,0,0),(9,1,4097,1,1,0,0),(10,1,4097,1,1,0,0),(11,1,4097,1,1,0,0),(12,1,4097,1,1,0,0),(13,1,4097,1,1,0,0),(14,1,65536,1,1,1,0),(15,1,65536,1,1,0,0),(16,1,4096,1,1,1,0),(17,1,1048576,1,1,1,0),(18,1,2097152,1,1,0,0);
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_interests`
--

DROP TABLE IF EXISTS `user_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_interests` (
  `user_interest_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `controlled_vocab_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_interest_id`),
  UNIQUE KEY `u_e_pkey` (`user_id`,`controlled_vocab_entry_id`),
  KEY `user_interests_user_id` (`user_id`),
  KEY `user_interests_controlled_vocab_entry_id` (`controlled_vocab_entry_id`),
  CONSTRAINT `user_interests_controlled_vocab_entry_id_foreign` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE,
  CONSTRAINT `user_interests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Associates users with user interests (which are stored in the controlled vocabulary tables).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interests`
--

LOCK TABLES `user_interests` WRITE;
/*!40000 ALTER TABLE `user_interests` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_settings` (
  `user_setting_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`user_setting_id`),
  UNIQUE KEY `user_settings_unique` (`user_id`,`locale`,`setting_name`),
  KEY `user_settings_user_id` (`user_id`),
  KEY `user_settings_locale_setting_name_index` (`setting_name`,`locale`),
  CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='More data about users, including localized properties like their name and affiliation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` VALUES (1,1,'es','familyName','admin'),(2,1,'es','givenName','admin'),(3,1,'es','preferredPublicName','');
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_user_groups` (
  `user_user_group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_user_group_id`),
  UNIQUE KEY `user_user_groups_unique` (`user_group_id`,`user_id`),
  KEY `user_user_groups_user_group_id` (`user_group_id`),
  KEY `user_user_groups_user_id` (`user_id`),
  CONSTRAINT `user_user_groups_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `user_user_groups_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Maps users to their assigned user_groups.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_groups`
--

LOCK TABLES `user_user_groups` WRITE;
/*!40000 ALTER TABLE `user_user_groups` DISABLE KEYS */;
INSERT INTO `user_user_groups` VALUES (1,1,1),(2,2,1);
/*!40000 ALTER TABLE `user_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `url` varchar(2047) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `country` varchar(90) DEFAULT NULL,
  `locales` varchar(255) NOT NULL DEFAULT '[]',
  `gossip` text DEFAULT NULL,
  `date_last_email` datetime DEFAULT NULL,
  `date_registered` datetime NOT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_last_login` datetime DEFAULT NULL,
  `must_change_password` smallint(6) DEFAULT NULL,
  `auth_id` bigint(20) DEFAULT NULL,
  `auth_str` varchar(255) DEFAULT NULL,
  `disabled` smallint(6) NOT NULL DEFAULT 0,
  `disabled_reason` text DEFAULT NULL,
  `inline_help` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_username` (`username`),
  UNIQUE KEY `users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='All registered users, including authentication data and profile data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$nOCy3MGf8UtfpAJ/iTmIfuzGAbvsEKccSvJlBG0tf2ySOV0iCks3q','israel.samuelsg@gmail.com',NULL,NULL,NULL,NULL,NULL,'[]',NULL,NULL,'2025-02-21 01:49:51',NULL,'2025-02-21 10:52:22',NULL,NULL,NULL,0,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `version_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `major` int(11) NOT NULL DEFAULT 0 COMMENT 'Major component of version number, e.g. the 2 in OJS 2.3.8-0',
  `minor` int(11) NOT NULL DEFAULT 0 COMMENT 'Minor component of version number, e.g. the 3 in OJS 2.3.8-0',
  `revision` int(11) NOT NULL DEFAULT 0 COMMENT 'Revision component of version number, e.g. the 8 in OJS 2.3.8-0',
  `build` int(11) NOT NULL DEFAULT 0 COMMENT 'Build component of version number, e.g. the 0 in OJS 2.3.8-0',
  `date_installed` datetime NOT NULL,
  `current` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes.',
  `product_type` varchar(30) DEFAULT NULL COMMENT 'Describes the type of product this row describes, e.g. "plugins.generic" (for a generic plugin) or "core" for the application itself',
  `product` varchar(30) DEFAULT NULL COMMENT 'Uniquely identifies the product this version row describes, e.g. "ojs2" for OJS 2.x, "languageToggle" for the language toggle block plugin, etc.',
  `product_class_name` varchar(80) DEFAULT NULL COMMENT 'Specifies the class name associated with this product, for plugins, or the empty string where not applicable.',
  `lazy_load` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the row describes a lazy-load plugin; 0 otherwise',
  `sitewide` smallint(6) NOT NULL DEFAULT 0 COMMENT '1 iff the row describes a site-wide plugin; 0 otherwise',
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `versions_unique` (`product_type`,`product`,`major`,`minor`,`revision`,`build`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Describes the installation and upgrade version history for the application and all installed plugins.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` VALUES (1,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.metadata','dc11','',0,0),(2,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.blocks','developedBy','DevelopedByBlockPlugin',1,0),(3,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.blocks','information','InformationBlockPlugin',1,0),(4,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.blocks','makeSubmission','MakeSubmissionBlockPlugin',1,0),(5,1,1,0,0,'2025-02-21 01:49:52',1,'plugins.blocks','subscription','SubscriptionBlockPlugin',1,0),(6,1,0,1,0,'2025-02-21 01:49:52',1,'plugins.blocks','browse','BrowseBlockPlugin',1,0),(7,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.blocks','languageToggle','LanguageToggleBlockPlugin',1,0),(8,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.gateways','resolver','',0,0),(9,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','htmlArticleGalley','HtmlArticleGalleyPlugin',1,0),(10,1,1,0,0,'2025-02-21 01:49:52',1,'plugins.generic','googleScholar','GoogleScholarPlugin',1,0),(11,1,0,1,0,'2025-02-21 01:49:52',1,'plugins.generic','lensGalley','LensGalleyPlugin',1,0),(12,1,2,0,0,'2025-02-21 01:49:52',1,'plugins.generic','staticPages','StaticPagesPlugin',1,0),(13,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','driver','DRIVERPlugin',1,0),(14,1,3,4,8,'2025-02-21 01:49:52',1,'plugins.generic','orcidProfile','OrcidProfilePlugin',1,0),(15,3,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','crossref','',0,0),(16,1,0,1,0,'2025-02-21 01:49:52',1,'plugins.generic','pdfJsViewer','PdfJsViewerPlugin',1,0),(17,1,0,0,1,'2025-02-21 01:49:52',1,'plugins.generic','recommendByAuthor','RecommendByAuthorPlugin',1,1),(18,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','googleAnalytics','GoogleAnalyticsPlugin',1,0),(19,1,2,0,0,'2025-02-21 01:49:52',1,'plugins.generic','customBlockManager','CustomBlockManagerPlugin',1,0),(20,0,1,0,0,'2025-02-21 01:49:52',1,'plugins.generic','citationStyleLanguage','CitationStyleLanguagePlugin',1,0),(21,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','webFeed','WebFeedPlugin',1,0),(22,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','usageEvent','',0,0),(23,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','dublinCoreMeta','DublinCoreMetaPlugin',1,0),(24,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','announcementFeed','AnnouncementFeedPlugin',1,0),(25,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','tinymce','TinyMCEPlugin',1,0),(26,2,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','datacite','',0,0),(27,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.generic','recommendBySimilarity','RecommendBySimilarityPlugin',1,1),(28,1,3,0,0,'2025-02-21 01:49:52',1,'plugins.generic','acron','AcronPlugin',1,1),(29,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.importexport','native','',0,0),(30,1,1,0,0,'2025-02-21 01:49:52',1,'plugins.importexport','doaj','',0,0),(31,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.importexport','users','',0,0),(32,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.importexport','pubmed','',0,0),(33,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.oaiMetadataFormats','marc','',0,0),(34,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.oaiMetadataFormats','marcxml','',0,0),(35,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.oaiMetadataFormats','rfc1807','',0,0),(36,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.oaiMetadataFormats','dc','',0,0),(37,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.paymethod','manual','',0,0),(38,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.paymethod','paypal','',0,0),(39,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.pubIds','urn','URNPubIdPlugin',1,0),(40,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.reports','articles','',0,0),(41,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.reports','subscriptions','',0,0),(42,2,0,1,0,'2025-02-21 01:49:52',1,'plugins.reports','reviewReport','',0,0),(43,1,1,0,0,'2025-02-21 01:49:52',1,'plugins.reports','counterReport','',0,0),(44,1,0,0,0,'2025-02-21 01:49:52',1,'plugins.themes','default','DefaultThemePlugin',1,0),(45,3,4,0,8,'2025-02-21 01:49:44',1,'core','ojs2','',0,1),(46,3,4,0,3,'2025-02-21 02:45:46',1,'plugins.themes','bootstrap3','BootstrapThreeThemePlugin',1,0);
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-21  4:11:09
