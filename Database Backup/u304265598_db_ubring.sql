/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.27-log : Database - u304265598_db_ubring
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`u304265598_db_ubring` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `u304265598_db_ubring`;

/*Table structure for table `allotments` */

DROP TABLE IF EXISTS `allotments`;

CREATE TABLE `allotments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fundid` int(11) DEFAULT NULL,
  `papid` int(11) DEFAULT NULL,
  `transmittalid` int(11) DEFAULT NULL,
  `initial_amount` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `expenselineitemid` int(11) DEFAULT NULL,
  `isreleased` tinyint(1) DEFAULT '0',
  `released_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `fundid` (`fundid`),
  KEY `papid` (`papid`),
  KEY `sectionid` (`sectionid`),
  KEY `expenselineitemid` (`expenselineitemid`),
  KEY `transmittalid` (`transmittalid`),
  CONSTRAINT `allotments_ibfk_1` FOREIGN KEY (`fundid`) REFERENCES `funds` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `allotments_ibfk_2` FOREIGN KEY (`papid`) REFERENCES `paps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `allotments_ibfk_3` FOREIGN KEY (`sectionid`) REFERENCES `sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `allotments_ibfk_4` FOREIGN KEY (`expenselineitemid`) REFERENCES `expenselineitems` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `allotments_ibfk_5` FOREIGN KEY (`transmittalid`) REFERENCES `transmittals` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `allotments` */

/*Table structure for table `cache` */

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache` */

insert  into `cache`(`key`,`value`,`expiration`) values 
('0ad240e5f03dd00ca70dd19cc367aefa','i:1;',1745543165),
('0ad240e5f03dd00ca70dd19cc367aefa:timer','i:1745543165;',1745543165),
('0b5ed025495008a307f6b06dd1e4cce2','i:1;',1737129301),
('0b5ed025495008a307f6b06dd1e4cce2:timer','i:1737129300;',1737129301),
('0ba3cba10d381b83e9ec10006fe28e04','i:1;',1747095641),
('0ba3cba10d381b83e9ec10006fe28e04:timer','i:1747095641;',1747095641),
('1a84e3b7682b94508c23c190560a7653','i:1;',1745543246),
('1a84e3b7682b94508c23c190560a7653:timer','i:1745543246;',1745543246),
('355fcd79684539eedb71992b060846c1','i:1;',1742288024),
('355fcd79684539eedb71992b060846c1:timer','i:1742288024;',1742288024),
('5c354b2f7f4c19df9c71e9011c8274ad','i:1;',1745326762),
('5c354b2f7f4c19df9c71e9011c8274ad:timer','i:1745326762;',1745326762),
('6d0ff2c92acb7d0b0b6ac961c39611e7','i:1;',1748788128),
('6d0ff2c92acb7d0b0b6ac961c39611e7:timer','i:1748788128;',1748788128),
('7a153ded2479f11b5afa34808540f9cd','i:1;',1748791333),
('7a153ded2479f11b5afa34808540f9cd:timer','i:1748791333;',1748791333),
('85f23f66d59e5b27df1ac91f8fd7ea5d','i:2;',1748791312),
('85f23f66d59e5b27df1ac91f8fd7ea5d:timer','i:1748791312;',1748791312),
('9ee77b9daf918a3c99f7ac126d2a3219','i:1;',1745543362),
('9ee77b9daf918a3c99f7ac126d2a3219:timer','i:1745543362;',1745543362),
('a83de35a03fc71dfba8cec03db7c0f69','i:1;',1742624554),
('a83de35a03fc71dfba8cec03db7c0f69:timer','i:1742624553;',1742624554),
('bed0dbda79c87e42d604ff81a4d12a63','i:1;',1741853835),
('bed0dbda79c87e42d604ff81a4d12a63:timer','i:1741853835;',1741853835),
('bryanbudget@gmail.com|127.0.0.1','i:2;',1748791312),
('bryanbudget@gmail.com|127.0.0.1:timer','i:1748791312;',1748791312),
('c525a5357e97fef8d3db25841c86da1a','i:2;',1739605155),
('c525a5357e97fef8d3db25841c86da1a:timer','i:1739605155;',1739605155),
('c6feb4fd5a924f6c8f8811ef4b229481','i:1;',1749004621),
('c6feb4fd5a924f6c8f8811ef4b229481:timer','i:1749004621;',1749004621),
('ca1abba521daa8165c40c16a9226f386','i:1;',1741588468),
('ca1abba521daa8165c40c16a9226f386:timer','i:1741588468;',1741588468),
('d5b88eed88df992c20f26189317b28fe','i:1;',1749004662),
('d5b88eed88df992c20f26189317b28fe:timer','i:1749004662;',1749004662),
('e97d823e80b065f1f35eca15db54007f','i:1;',1748793170),
('e97d823e80b065f1f35eca15db54007f:timer','i:1748793170;',1748793170),
('f5c18213353b251d746113212952894b','i:1;',1748668520),
('f5c18213353b251d746113212952894b:timer','i:1748668520;',1748668520),
('feeaacc813e6bb73b142610a0e210e41','i:1;',1747976468),
('feeaacc813e6bb73b142610a0e210e41:timer','i:1747976468;',1747976468),
('gianralphsdagan@gmail.com|127.0.0.1','i:1;',1742624557),
('gianralphsdagan@gmail.com|127.0.0.1:timer','i:1742624556;',1742624556),
('gianralphsdagan@gmail.com|192.168.10.118','i:1;',1745543246),
('gianralphsdagan@gmail.com|192.168.10.118:timer','i:1745543246;',1745543246);

/*Table structure for table `cache_locks` */

DROP TABLE IF EXISTS `cache_locks`;

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cache_locks` */

/*Table structure for table `divisions` */

DROP TABLE IF EXISTS `divisions`;

CREATE TABLE `divisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `division` varchar(100) DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `isregional` tinyint(1) DEFAULT '0',
  `status` char(1) DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `divisions_ibfk_1` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `divisions` */

insert  into `divisions`(`id`,`division`,`locationid`,`created_at`,`created_by`,`updated_at`,`updated_by`,`isregional`,`status`) values 
(1,'OED/ODED',1,'2024-10-17 11:39:00',NULL,NULL,NULL,0,'A'),
(2,'AFMD',1,'2024-10-17 11:39:02',NULL,'2025-02-19 12:08:50',3,0,'A'),
(3,'PIMD',1,'2024-10-17 11:39:05',NULL,NULL,NULL,0,'A'),
(4,'KMD',1,'2024-10-17 11:39:07',NULL,'2025-02-19 12:08:59',3,0,'A'),
(5,'RDD',1,'2024-10-17 11:39:07',NULL,NULL,NULL,0,'I');

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `sectionid` (`sectionid`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`sectionid`) REFERENCES `sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

/*Data for the table `employees` */

insert  into `employees`(`id`,`firstname`,`middlename`,`lastname`,`suffix`,`position`,`sectionid`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'Vlahdymir','L','Bambalan',NULL,'Administrative Officer IV',12,NULL,NULL,'2024-06-30 12:54:24',1,'I'),
(3,'Liza','G','Battad',NULL,'Executive Director III',1,'2024-06-30 12:53:32',1,'2024-06-30 12:53:32',1,'A'),
(4,'Mark Bryan','Cabuena','Cuaresma',NULL,'CMT II',17,'2024-07-18 07:04:50',1,'2024-10-09 13:48:27',1,'A'),
(8,'Darrel Jed','Calica','Costales',NULL,NULL,NULL,'2024-10-26 23:51:57',NULL,'2024-10-26 23:51:57',1,'A'),
(10,'Mark Bryan',NULL,'Cuaresma',NULL,NULL,NULL,'2024-10-27 22:34:57',NULL,'2024-10-27 22:34:57',1,'A'),
(14,'Gian Ralph','S','Dagan',NULL,'MCC',17,'2024-12-11 11:57:44',1,'2025-04-25 09:06:38',1,'A'),
(15,'Vlahd','L.','Bambalan',NULL,'User Position',12,'2024-12-12 13:23:51',3,'2025-02-16 12:51:22',3,'A'),
(17,'Joshua','Gelacio','Villanueva',NULL,'Head',2,'2025-03-10 14:32:04',1,'2025-05-26 12:35:48',26,'A');

/*Table structure for table `expenselineitems` */

DROP TABLE IF EXISTS `expenselineitems`;

CREATE TABLE `expenselineitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expenselineitem` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expensetypeid` int(11) DEFAULT NULL,
  `expensetypesubcategoryid` int(11) DEFAULT NULL,
  `uacscode` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `expenselineitems_ibfk_1` (`expensetypeid`),
  KEY `expensetypesubcategoryid` (`expensetypesubcategoryid`),
  CONSTRAINT `expenselineitems_ibfk_1` FOREIGN KEY (`expensetypeid`) REFERENCES `expensetypes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `expenselineitems_ibfk_2` FOREIGN KEY (`expensetypesubcategoryid`) REFERENCES `expensetypesubcategories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `expenselineitems` */

insert  into `expenselineitems`(`id`,`expenselineitem`,`expensetypeid`,`expensetypesubcategoryid`,`uacscode`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'Basic Salary - Civilian',1,NULL,'5010101001','2024-12-16 23:26:44',3,'2025-05-12 13:34:15',1,'A'),
(2,'PERA - Civilian',1,NULL,'5010201001','2024-12-16 23:35:13',3,'2025-02-18 10:09:38',1,'A'),
(3,'sampdel',2,NULL,'1','2024-12-16 23:35:40',3,'2024-12-16 23:35:54',3,'I'),
(4,'sample civ',NULL,NULL,'1234567','2025-02-16 11:32:46',3,'2025-02-16 11:34:00',3,'I'),
(5,'Personal Economic Relief Allowance (PERA)',1,NULL,'5010201000','2025-02-18 10:11:21',1,'2025-02-18 10:11:21',NULL,'A'),
(6,'Representation Allowance (RA)',1,NULL,'5010202000','2025-02-18 02:17:03',3,NULL,NULL,'A'),
(7,'Transportation Allowance (TA)',1,NULL,'5010203000','2025-02-18 02:17:03',3,NULL,NULL,'A'),
(8,'Clothing/Uniform Allowance - Civilian',1,NULL,'5010204001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(9,'Laundry Allowance - Magna Carta Benefits for Science and Technology under R.A. 8439',1,NULL,'5010206003','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(10,'HP - Magna Carta Benefits FOR Science and Technology under R.A. 8439',1,NULL,'5010211004','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(11,'Bonus - Civilian',1,NULL,'5010214001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(12,'Cash Gift - Civilian',1,NULL,'5010215001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(13,'Mid-year Bonus - Civilian',1,NULL,'5010216001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(14,'Collective Negotiation Agreement Incentive - Civilian',1,NULL,'5010216001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(15,'Productivity Enhancement Incentive - Civilian',1,NULL,'5010299012','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(16,'Mid-year Bonus - Civilian',1,NULL,'5010299036','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(17,'Anniversary Bonus - Civilian',1,NULL,'5010299038','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(18,'Pag-IBIG - Civilian',1,NULL,'5010302001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(19,'PhilHealth - Civilian',1,NULL,'5010303001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(20,'ECIP - Civilian',1,NULL,'5010304001','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(21,'Lump-sum for Step Increments - Length of Service',1,NULL,'5010499010','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(22,'Loyalty Award - Civilian',1,NULL,'5010499015','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(23,'Other Personnel Benefits',1,NULL,'5010499099','2025-02-18 02:26:41',3,'2025-02-18 02:26:41',NULL,'A'),
(24,'sample',6,NULL,'1155','2025-02-19 11:36:11',3,'2025-03-12 14:18:13',3,'A'),
(25,'Training Expenses',2,NULL,'5020201002','2025-04-07 12:34:47',1,'2025-04-07 15:10:59',1,'A');

/*Table structure for table `expensetypes` */

DROP TABLE IF EXISTS `expensetypes`;

CREATE TABLE `expensetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expensetype` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acronym` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `expensetypes` */

insert  into `expensetypes`(`id`,`expensetype`,`acronym`,`created_by`,`created_at`,`updated_by`,`updated_at`,`status`) values 
(1,'Personnel Services','PS',3,'2024-12-16 22:43:38',3,'2024-12-16 22:44:37','A'),
(2,'Maintenance and Other Operating Expenses','MOOE',3,'2024-12-16 22:44:59',3,'2024-12-16 22:46:09','A'),
(6,'Capital Outlay','CO',1,'2025-02-18 10:06:55',NULL,'2025-02-18 10:06:55','A');

/*Table structure for table `expensetypesubcategories` */

DROP TABLE IF EXISTS `expensetypesubcategories`;

CREATE TABLE `expensetypesubcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscategory` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `expensetypesubcategories` */

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `funds` */

DROP TABLE IF EXISTS `funds`;

CREATE TABLE `funds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fund` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `approvedbudget` double DEFAULT NULL,
  `initial_amount` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `iscontinuing` tinyint(1) DEFAULT '0',
  `fundyear` year(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `funds_ibfk_1` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `funds` */

/*Table structure for table `job_batches` */

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `job_batches` */

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jobs` */

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) DEFAULT NULL,
  `acronym` varchar(30) DEFAULT NULL,
  `centerchief` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `centerchief` (`centerchief`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`centerchief`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `locations` */

insert  into `locations`(`id`,`location`,`acronym`,`centerchief`,`status`,`created_by`,`created_at`,`updated_by`,`updated_at`) values 
(1,'PCC at CLSU','CLSU',3,'A',NULL,NULL,NULL,NULL),
(2,'PCC at VSU','VSU',3,'A',NULL,NULL,NULL,NULL),
(3,'NHQ','NHQ',NULL,'A',NULL,NULL,NULL,NULL);

/*Table structure for table `message_seen_status` */

DROP TABLE IF EXISTS `message_seen_status`;

CREATE TABLE `message_seen_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `receiver_id` int(20) DEFAULT NULL,
  `seen_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_seen_status_ibfk_2` (`message_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `message_seen_status_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `message_seen_status_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=884 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `message_seen_status` */

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `employeeid` bigint(20) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiverid` bigint(20) DEFAULT NULL,
  `importancelevel` int(10) DEFAULT NULL,
  `expirydate` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `locationid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sectionid` (`sectionid`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sectionid`) REFERENCES `sections` (`id`),
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `messages` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2024_05_28_065032_add_two_factor_columns_to_users_table',1),
(5,'2024_05_28_065100_create_personal_access_tokens_table',1);

/*Table structure for table `modificationitems` */

DROP TABLE IF EXISTS `modificationitems`;

CREATE TABLE `modificationitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modificationid` int(11) DEFAULT NULL,
  `papid` int(11) DEFAULT NULL,
  `expenseid` int(11) DEFAULT NULL,
  `expenselineitemid` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `issource` tinyint(1) DEFAULT '0',
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `modificationid` (`modificationid`),
  KEY `papid` (`papid`),
  KEY `expenseid` (`expenseid`),
  KEY `expenselineitemid` (`expenselineitemid`),
  CONSTRAINT `modificationitems_ibfk_1` FOREIGN KEY (`modificationid`) REFERENCES `modifications` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modificationitems_ibfk_2` FOREIGN KEY (`papid`) REFERENCES `paps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modificationitems_ibfk_3` FOREIGN KEY (`expenseid`) REFERENCES `expensetypes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modificationitems_ibfk_4` FOREIGN KEY (`expenselineitemid`) REFERENCES `expenselineitems` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `modificationitems` */

/*Table structure for table `modifications` */

DROP TABLE IF EXISTS `modifications`;

CREATE TABLE `modifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serialnumber` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `fundid` int(11) DEFAULT NULL,
  `datefrom` datetime DEFAULT NULL,
  `dateto` datetime DEFAULT NULL,
  `legalbasis` text COLLATE utf8mb4_unicode_ci,
  `preparedby` int(11) DEFAULT NULL,
  `approvedby` int(11) DEFAULT NULL,
  `systemapprover` int(11) DEFAULT NULL,
  `systemdateapproved` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `isapproved` tinyint(1) DEFAULT '0',
  `dateapproved` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fundid` (`fundid`),
  KEY `sectionid` (`sectionid`),
  KEY `datefrom` (`datefrom`),
  KEY `dateto` (`dateto`),
  KEY `sectionid_2` (`sectionid`),
  KEY `created_at` (`created_at`),
  KEY `locationid` (`locationid`),
  KEY `preparedby` (`preparedby`),
  KEY `approvedby` (`approvedby`),
  KEY `dateapproved` (`dateapproved`),
  CONSTRAINT `modifications_ibfk_1` FOREIGN KEY (`fundid`) REFERENCES `funds` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modifications_ibfk_2` FOREIGN KEY (`sectionid`) REFERENCES `sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modifications_ibfk_3` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modifications_ibfk_6` FOREIGN KEY (`preparedby`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `modifications_ibfk_7` FOREIGN KEY (`approvedby`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `modifications` */

/*Table structure for table `obligationparticularpayments` */

DROP TABLE IF EXISTS `obligationparticularpayments`;

CREATE TABLE `obligationparticularpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obligationrequestparticularid` int(11) DEFAULT NULL,
  `dateofpayment` datetime DEFAULT NULL,
  `dvnumber` varchar(50) DEFAULT NULL,
  `referencenumber` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `obligationrequestparticularid` (`obligationrequestparticularid`),
  CONSTRAINT `obligationparticularpayments_ibfk_1` FOREIGN KEY (`obligationrequestparticularid`) REFERENCES `obligationrequestparticulars` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `obligationparticularpayments` */

/*Table structure for table `obligationpayments` */

DROP TABLE IF EXISTS `obligationpayments`;

CREATE TABLE `obligationpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obligationrequestid` int(11) DEFAULT NULL,
  `dvnumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checknumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofcheck` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `obligationrequestid` (`obligationrequestid`),
  CONSTRAINT `obligationpayments_ibfk_1` FOREIGN KEY (`obligationrequestid`) REFERENCES `obligationrequests` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `obligationpayments` */

/*Table structure for table `obligationrequestparticulars` */

DROP TABLE IF EXISTS `obligationrequestparticulars`;

CREATE TABLE `obligationrequestparticulars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `obligationrequestid` int(11) DEFAULT NULL,
  `particular` text COLLATE utf8mb4_unicode_ci,
  `papid` int(11) DEFAULT NULL,
  `expenselineitemid` int(11) DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `papid` (`papid`),
  KEY `expenselineitemid` (`expenselineitemid`),
  KEY `obligationrequestid` (`obligationrequestid`),
  KEY `sectionid` (`sectionid`),
  CONSTRAINT `obligationrequestparticulars_ibfk_1` FOREIGN KEY (`papid`) REFERENCES `paps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequestparticulars_ibfk_2` FOREIGN KEY (`expenselineitemid`) REFERENCES `expenselineitems` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequestparticulars_ibfk_3` FOREIGN KEY (`obligationrequestid`) REFERENCES `obligationrequests` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequestparticulars_ibfk_4` FOREIGN KEY (`sectionid`) REFERENCES `sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `obligationrequestparticulars` */

/*Table structure for table `obligationrequests` */

DROP TABLE IF EXISTS `obligationrequests`;

CREATE TABLE `obligationrequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serialnumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serialsuffix` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateofrequest` datetime DEFAULT NULL,
  `fundid` int(11) DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `sectionid` int(11) DEFAULT NULL,
  `payeeid` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `orsstatuslistid` int(11) DEFAULT NULL,
  `certifieda` int(11) DEFAULT NULL,
  `certifiedb` int(11) DEFAULT NULL,
  `datecertifieda` datetime DEFAULT NULL,
  `datecertifiedb` datetime DEFAULT NULL,
  `cancelledby` bigint(20) DEFAULT NULL COMMENT 'user id',
  `datecancelled` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `isapproved` tinyint(1) DEFAULT '0',
  `dateapproved` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orsstatuslistid` (`orsstatuslistid`),
  KEY `fundid` (`fundid`),
  KEY `payeeid` (`payeeid`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `obligationrequests_ibfk_1` FOREIGN KEY (`orsstatuslistid`) REFERENCES `orsstatuslists` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequests_ibfk_2` FOREIGN KEY (`fundid`) REFERENCES `funds` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequests_ibfk_3` FOREIGN KEY (`payeeid`) REFERENCES `payees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `obligationrequests_ibfk_4` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `obligationrequests` */

/*Table structure for table `orsstatuslists` */

DROP TABLE IF EXISTS `orsstatuslists`;

CREATE TABLE `orsstatuslists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orsstatuslist` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `orsstatuslists` */

insert  into `orsstatuslists`(`id`,`orsstatuslist`,`created_by`,`created_at`,`updated_by`,`updated_at`,`status`) values 
(1,'Earmarked',NULL,NULL,NULL,NULL,'A'),
(2,'Obligated',NULL,NULL,3,'2024-12-24 00:33:27','A'),
(3,NULL,3,'2024-12-24 00:30:01',3,'2024-12-24 00:31:17','I'),
(4,'obligated1',3,'2024-12-24 00:30:53',1,'2025-02-18 11:44:43','I'),
(5,'earn',3,'2025-02-16 11:36:05',3,'2025-02-16 11:38:07','I');

/*Table structure for table `paps` */

DROP TABLE IF EXISTS `paps`;

CREATE TABLE `paps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pap` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acronym` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uacscode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `paps` */

insert  into `paps`(`id`,`pap`,`acronym`,`uacscode`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(6,'General management and supervision','GASS','12345533','2024-12-16 22:19:07',3,'2024-12-16 22:19:19',3,'A'),
(7,'Formulation, Monitoring and Evaluation of Plans, Programs and Projects','FMPPP','002','2024-12-16 22:19:55',3,'2024-12-16 22:19:55',NULL,'A'),
(8,'Intensification of the National Upgrading Program','INUP',NULL,'2025-02-16 10:22:52',3,'2025-02-16 10:23:29',3,'I'),
(9,'Carabao-Based Enterprise Development\r\n','CBED',NULL,'2025-02-16 10:22:55',3,'2025-02-16 10:23:06',3,'I'),
(10,'Knowledge Management and Support Services\r\n','KMSS',NULL,NULL,NULL,NULL,NULL,'A'),
(11,'Research and Development','RD',NULL,NULL,NULL,NULL,NULL,'A'),
(12,'Animal Genetic Resource Conservation and Utilization\r\n','AGRCU\r\n',NULL,NULL,NULL,NULL,NULL,'A'),
(13,'Herd Build-up of Genetically-Improved Dairy Buffalos of the Philippine Carabao Center','CHB',NULL,NULL,NULL,NULL,NULL,'A'),
(14,'Intensified Community Based Dairy Enterprise Development\r\n','PL480',NULL,NULL,NULL,NULL,NULL,'A');

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

/*Table structure for table `payees` */

DROP TABLE IF EXISTS `payees`;

CREATE TABLE `payees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payee` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payeecode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `payees` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',1,'web','8f7d257bd8359aa0a07e127ad713a121a63bb7850ce97fc4b1e66cab20ae12f1','[\"*\"]','2024-11-28 10:45:19',NULL,'2024-11-28 10:43:58','2024-11-28 10:45:19'),
(2,'App\\Models\\User',1,'web','93d2be40018f60e1862715d313f74d687027986ffc59f96b3de141d2835ce024','[\"*\"]','2024-11-28 10:57:53',NULL,'2024-11-28 10:53:36','2024-11-28 10:57:53'),
(3,'App\\Models\\User',1,'web','c1143654b7a839d59535ba665c2ab33cf06002021c61cc10b277a39111b9317e','[\"*\"]','2024-12-11 11:46:23',NULL,'2024-12-11 11:44:18','2024-12-11 11:46:23'),
(4,'App\\Models\\User',3,'web','f58f6339b8d1e447eb2f4c1dea13bd44e315e844450f360a6193baba56d9cfb4','[\"*\"]','2024-12-11 11:58:49',NULL,'2024-12-11 11:58:32','2024-12-11 11:58:49'),
(5,'App\\Models\\User',3,'web','c685ffb5aa2240b865fae8b56a76973e4a2910bb18dda43036642667b42f1ad5','[\"*\"]','2024-12-12 13:21:18',NULL,'2024-12-12 13:21:07','2024-12-12 13:21:18'),
(6,'App\\Models\\User',4,'web','3601d9514514da725bbe3a0ea35e6be6cf4b40016f16de602723f7ebecb07294','[\"*\"]','2024-12-12 13:34:34',NULL,'2024-12-12 13:29:06','2024-12-12 13:34:34'),
(7,'App\\Models\\User',5,'web','31c1c017cb491fd70e641768a5b034631c51779aec00f579f48db08d56c0430e','[\"*\"]','2024-12-12 15:54:37',NULL,'2024-12-12 13:30:11','2024-12-12 15:54:37'),
(8,'App\\Models\\User',5,'web','d8a19bc1d24a9e99b297319c11713f3fcd6de3f36c1b35e8743eb69f7bf5702e','[\"*\"]','2024-12-12 15:57:05',NULL,'2024-12-12 13:34:58','2024-12-12 15:57:05'),
(9,'App\\Models\\User',4,'web','c482cd2d0de7c77482bca4d59cc419bdd105631adc18fdb9cd68275510714bde','[\"*\"]','2024-12-12 16:19:53',NULL,'2024-12-12 15:55:07','2024-12-12 16:19:53'),
(10,'App\\Models\\User',4,'web','8798f7a7339b284b0166da2435127ea4dcdb5d9074e2bf72d0846c0545a4cd0b','[\"*\"]','2024-12-12 20:41:23',NULL,'2024-12-12 20:40:32','2024-12-12 20:41:23'),
(11,'App\\Models\\User',5,'web','fca91585e0f015f0c86e661ed0478e889245db4453d5ce9233d709e50b0ab6f3','[\"*\"]',NULL,NULL,'2024-12-12 20:40:44','2024-12-12 20:40:44'),
(12,'App\\Models\\User',5,'web','710a85113f29d7b14f1eb4f74cf0b934df8d55cf074e85202a79be35f84f8129','[\"*\"]',NULL,NULL,'2024-12-12 20:40:47','2024-12-12 20:40:47'),
(13,'App\\Models\\User',5,'web','a34783e49712c57e1980b9a96323043543276dd308e7df8a763413d1de2caa68','[\"*\"]','2024-12-12 21:06:06',NULL,'2024-12-12 21:05:29','2024-12-12 21:06:06'),
(14,'App\\Models\\User',4,'web','82d5f7162375df8fcd744edc41fd3ae7d07e68cb2e4a9f3a28791029d76e6ddf','[\"*\"]','2024-12-12 21:12:56',NULL,'2024-12-12 21:06:08','2024-12-12 21:12:56'),
(15,'App\\Models\\User',4,'web','a96c59b56cd48fe2fb4539e62f89bfb6db2cffe4aee5a3e03c6353cd7788123f','[\"*\"]','2024-12-15 00:07:22',NULL,'2024-12-14 23:57:50','2024-12-15 00:07:22'),
(16,'App\\Models\\User',3,'web','bf1779ccaa977b64f266b8888669fe9d542e1ddea59f0cffaebb0e02ff823087','[\"*\"]',NULL,NULL,'2024-12-15 21:52:55','2024-12-15 21:52:55'),
(17,'App\\Models\\User',3,'web','a238c7bad58470852b7ab2eb6a480f87bff01a9667a6bd7d56d12e854c9e5eae','[\"*\"]',NULL,NULL,'2024-12-16 21:25:39','2024-12-16 21:25:39'),
(18,'App\\Models\\User',5,'web','8dc22e9c18fc186021b9d178adeaca05910ccbcabb361cbb28e79f327341dbd7','[\"*\"]','2024-12-23 13:36:59',NULL,'2024-12-23 13:36:47','2024-12-23 13:36:59'),
(19,'App\\Models\\User',4,'web','3cec01f76bf9098c8ba27677f4086aa7a1a689f9ce989ec977441f18abdfc59b','[\"*\"]','2024-12-23 13:58:09',NULL,'2024-12-23 13:38:06','2024-12-23 13:58:09'),
(20,'App\\Models\\User',5,'web','2645ea6334ec0f77130dca869009c829e4a0dd9460094a18495c70590452f243','[\"*\"]','2024-12-23 13:39:03',NULL,'2024-12-23 13:38:51','2024-12-23 13:39:03'),
(21,'App\\Models\\User',5,'web','5d04df9bdac60ada14ee475cf36f20740921b3c6f67fd568e993912c95c36252','[\"*\"]','2024-12-23 22:34:27',NULL,'2024-12-23 21:30:12','2024-12-23 22:34:27'),
(22,'App\\Models\\User',3,'web','9119f92fd7a4e736d17b895d906120de5792d8170a03bb4ac2941624d87795c7','[\"*\"]',NULL,NULL,'2024-12-24 00:08:28','2024-12-24 00:08:28'),
(23,'App\\Models\\User',3,'web','9748e0b7da5d7daf32793c27e1870143f76dff3a2eb27cebbf8714e4e7667c8e','[\"*\"]','2024-12-24 00:08:56',NULL,'2024-12-24 00:08:34','2024-12-24 00:08:56'),
(24,'App\\Models\\User',5,'web','16200249142d2017ed69e9f2d52bf3918f03451c297f6440560fab353c03486a','[\"*\"]',NULL,NULL,'2024-12-24 09:07:44','2024-12-24 09:07:44'),
(25,'App\\Models\\User',5,'web','cd58fa77cb2074a9dfb1e334b401c28078b46a915a54e67eececf1293636847d','[\"*\"]',NULL,NULL,'2024-12-24 09:07:46','2024-12-24 09:07:46'),
(26,'App\\Models\\User',5,'web','c8e9c79be30bd7fda37bb22cb5e88ca1594a2574feb246650c63384939ded96f','[\"*\"]',NULL,NULL,'2024-12-24 09:08:40','2024-12-24 09:08:40'),
(27,'App\\Models\\User',5,'web','7d0b9fbd2043c90f8767619280f2fd6a977609576e1b1e3371a0192457fd26d0','[\"*\"]',NULL,NULL,'2024-12-24 09:08:43','2024-12-24 09:08:43'),
(28,'App\\Models\\User',5,'web','4d35f6995c1d086687e2f8769496d8143cf1bfcae88d2e58e65503bff194ed66','[\"*\"]','2024-12-24 09:11:34',NULL,'2024-12-24 09:11:02','2024-12-24 09:11:34'),
(29,'App\\Models\\User',5,'web','c2725c5712b82eb9e4c9cdd3e86cefcef1eceedd87ea76493b9a9062537b1122','[\"*\"]','2024-12-25 23:24:07',NULL,'2024-12-25 23:23:30','2024-12-25 23:24:07'),
(30,'App\\Models\\User',5,'web','b1ebea11afb425ce929ed00c00ec83b58dbd690a857e6f7745e49a708462d6e1','[\"*\"]','2024-12-27 01:58:57',NULL,'2024-12-26 23:25:36','2024-12-27 01:58:57'),
(31,'App\\Models\\User',5,'web','2d5a17dd8da12b71d8bfb2b69daa830b343f18be7415b209e27a49d3c1802fe4','[\"*\"]','2024-12-27 14:40:28',NULL,'2024-12-27 14:40:08','2024-12-27 14:40:28'),
(32,'App\\Models\\User',5,'web','3eccb87ad8dcdd0e7ea53e12f6ed8b280573c9689ef13c366c84a996fcf03915','[\"*\"]','2024-12-28 23:07:23',NULL,'2024-12-28 18:27:40','2024-12-28 23:07:23'),
(33,'App\\Models\\User',4,'web','c2c8a8c202a1668584bcf4dd866c1f1f1108495a228f104952a5b6819f8f4a1b','[\"*\"]','2024-12-29 20:20:48',NULL,'2024-12-28 19:53:53','2024-12-29 20:20:48'),
(34,'App\\Models\\User',5,'web','99fae42f854e5bc4e7c56b863420ed7ff00b4980f00930a325a6feb327afdfaa','[\"*\"]','2024-12-28 22:27:18',NULL,'2024-12-28 21:44:45','2024-12-28 22:27:18'),
(35,'App\\Models\\User',5,'web','c9a569688d5a8f50c34ce2d9f3122eee7354f3fd7dfbbfb0eed0e3f3e28d8a95','[\"*\"]','2024-12-29 20:20:03',NULL,'2024-12-29 19:18:30','2024-12-29 20:20:03'),
(36,'App\\Models\\User',5,'web','a071f2c9ae132988fd3ec4540ec181f4bb0ec3d939766932dace120c4268697d','[\"*\"]','2024-12-29 21:49:07',NULL,'2024-12-29 20:21:09','2024-12-29 21:49:07'),
(37,'App\\Models\\User',3,'web','eb5170ad2207022008eb6ad60f7cb89b1c39a894029f5cea823ff043988cd2e1','[\"*\"]','2024-12-30 08:01:34',NULL,'2024-12-29 22:17:56','2024-12-30 08:01:34'),
(38,'App\\Models\\User',3,'web','b271e5e62d38cd937dc7aa802e087ff1ee7a5915b5d046b3c6c07bb72a8f9dec','[\"*\"]','2024-12-30 10:34:23',NULL,'2024-12-30 08:01:40','2024-12-30 10:34:23'),
(39,'App\\Models\\User',5,'web','e3d47fbc01bc505eeb2aad7e1e8a6c6d9924fa68cfc490a8a7b112bf9fd41cd4','[\"*\"]','2024-12-30 23:01:07',NULL,'2024-12-30 21:53:56','2024-12-30 23:01:07'),
(40,'App\\Models\\User',4,'web','16824b613ab667e6fc9d407458f43e71ec46258f559ec58eff1663d5736de193','[\"*\"]','2024-12-30 23:05:35',NULL,'2024-12-30 23:04:53','2024-12-30 23:05:35'),
(41,'App\\Models\\User',3,'web','04c2a530e93be3e482e34945aa9afcc7de67510879aadc61bc9d5ac36ef82257','[\"*\"]','2025-01-01 19:50:39',NULL,'2025-01-01 19:13:58','2025-01-01 19:50:39'),
(42,'App\\Models\\User',3,'web','e4e3023b000ad12153cdb95db9c47069901e7f76024f0a15117a3bdd023c5ecf','[\"*\"]','2025-01-01 22:30:44',NULL,'2025-01-01 19:58:05','2025-01-01 22:30:44'),
(43,'App\\Models\\User',3,'web','d3e060589a50ad81d6847ee0f7581c2af982b053715fc1d5d7374eee041acfba','[\"*\"]','2025-01-01 22:36:20',NULL,'2025-01-01 22:34:34','2025-01-01 22:36:20'),
(44,'App\\Models\\User',3,'web','8cd919fdb1a718c87d92eb91973c5258a3ab37c433b237634a7ead872a634036','[\"*\"]','2025-01-02 08:21:15',NULL,'2025-01-02 08:20:11','2025-01-02 08:21:15'),
(45,'App\\Models\\User',5,'web','ce425e788ed0b774270c6253a1aa68db42b0572a121f516c5c9f5815c7a7d194','[\"*\"]','2025-01-02 08:21:13',NULL,'2025-01-02 08:20:57','2025-01-02 08:21:13'),
(46,'App\\Models\\User',5,'web','ec392bcf74a470a147a4b0734ad629aa7ab53b0950fea8564882a18197ccc6e7','[\"*\"]','2025-01-02 23:25:53',NULL,'2025-01-02 22:49:59','2025-01-02 23:25:53'),
(47,'App\\Models\\User',5,'web','0784aadda3a83d7dd76d7cbeeafb2870bd1194e7ee3cf0bef03b51a3a88bebd5','[\"*\"]','2025-01-03 03:01:38',NULL,'2025-01-02 23:27:24','2025-01-03 03:01:38'),
(48,'App\\Models\\User',3,'web','e652d7d5e88078d3e93ccd84abb21e1e4d2a3edb1fe27d1ec2bfae2b083d3b25','[\"*\"]','2025-01-03 11:05:49',NULL,'2025-01-03 08:50:59','2025-01-03 11:05:49'),
(49,'App\\Models\\User',3,'web','8e8805b93b974f02f5348fc6026233db089774fa9b4cdd8badaa163de9feed9b','[\"*\"]',NULL,NULL,'2025-01-03 14:28:45','2025-01-03 14:28:45'),
(50,'App\\Models\\User',5,'web','097ca49f5d0ba286c77921c112b15f676d4cef5007f98d8b0b188f34476ad2fb','[\"*\"]','2025-01-04 14:17:06',NULL,'2025-01-04 12:23:24','2025-01-04 14:17:06'),
(51,'App\\Models\\User',5,'web','d031222a0eb325f4eb9ccaa27931e9856ea3d85868bf1010e1075d1c2873cc10','[\"*\"]','2025-01-04 15:35:11',NULL,'2025-01-04 15:31:41','2025-01-04 15:35:11'),
(52,'App\\Models\\User',5,'web','f0d1a63c2f59f903d94eb8ecda80b351cfe9f6785a86f426c287c43817c2eaf5','[\"*\"]','2025-01-04 18:26:14',NULL,'2025-01-04 17:29:35','2025-01-04 18:26:14'),
(53,'App\\Models\\User',3,'web','0c5b6bba80a1b142bf94a2b5420b908bd5b39b0368e46432ca985ddfcc945558','[\"*\"]',NULL,NULL,'2025-01-04 21:22:16','2025-01-04 21:22:16'),
(54,'App\\Models\\User',3,'web','0c01129b071978ec770aeb8054be5dc6fb6ec9f1632aede4fce01fc26ea06020','[\"*\"]','2025-01-05 23:51:03',NULL,'2025-01-05 19:44:19','2025-01-05 23:51:03'),
(55,'App\\Models\\User',3,'web','79da820b2a5078a5b323e9920d2fdadb6113946969f7eb57cede0484192afab2','[\"*\"]','2025-01-06 10:23:57',NULL,'2025-01-06 09:16:17','2025-01-06 10:23:57'),
(56,'App\\Models\\User',3,'web','8ac66b9b332f4fbec94ae2a905c518306fe62bb486f7b6a7d9c9e4385dd6fd3a','[\"*\"]','2025-01-06 13:47:01',NULL,'2025-01-06 13:23:16','2025-01-06 13:47:01'),
(57,'App\\Models\\User',3,'web','ffca9c6dc6c2f73e40d972f19ff7578b56a02007bbdb8bc42c4c6e0d6582f777','[\"*\"]','2025-01-06 23:32:01',NULL,'2025-01-06 22:08:24','2025-01-06 23:32:01'),
(58,'App\\Models\\User',5,'web','fdd70bd0fb2f628cf1c5bd7dc1a9f5d896cd34cdef23f1e2f9b6b758883150c4','[\"*\"]','2025-01-07 00:07:26',NULL,'2025-01-06 22:21:36','2025-01-07 00:07:26'),
(59,'App\\Models\\User',5,'web','bc65f5e5392637ebf6db2761cbec0e9026c8e6cc4ee4c2773feb668891903e66','[\"*\"]','2025-01-07 00:39:48',NULL,'2025-01-07 00:05:03','2025-01-07 00:39:48'),
(60,'App\\Models\\User',5,'web','0fe5575cff8f7a3b9a82dde20f2c99db67e24ca122db024d0933b6724e984a5d','[\"*\"]','2025-01-07 03:34:22',NULL,'2025-01-07 02:02:57','2025-01-07 03:34:22'),
(61,'App\\Models\\User',5,'web','a80da42b26a7dce5478a9b16e64ed1f5ed34dcc7e71dbca84cb52e4ac4bc2e9f','[\"*\"]',NULL,NULL,'2025-01-07 03:25:08','2025-01-07 03:25:08'),
(62,'App\\Models\\User',5,'web','bbf1499b8ad5f106a50d72c319b58c54fac97c6a7122f2baffc719c7abf494d2','[\"*\"]',NULL,NULL,'2025-01-07 03:25:11','2025-01-07 03:25:11'),
(63,'App\\Models\\User',5,'web','4c56886ee3136e2d2197e68378623ce9336b9b3110ef9979c1e531e570b1f9d9','[\"*\"]','2025-01-07 03:34:55',NULL,'2025-01-07 03:34:07','2025-01-07 03:34:55'),
(64,'App\\Models\\User',5,'web','e54e1ef9d9425a21a703f6edd3dbd506505ad4dd36cfe6355e87ff3ccb65607e','[\"*\"]','2025-01-07 03:53:02',NULL,'2025-01-07 03:37:03','2025-01-07 03:53:02'),
(65,'App\\Models\\User',3,'web','d09c0772b710680cd510abb82423095f8acbc20d24234cb12647b63a66a481c4','[\"*\"]',NULL,NULL,'2025-01-07 10:03:38','2025-01-07 10:03:38'),
(66,'App\\Models\\User',3,'web','e8b74249320b32ee28234abf35e840e47b0c24b88d4c1af6f67ea771d11ca8a3','[\"*\"]',NULL,NULL,'2025-01-07 10:03:39','2025-01-07 10:03:39'),
(67,'App\\Models\\User',3,'web','59433901c841d1589ba777fe89f2fba7384747cf64d353ad9b4f3e8e8f86ffbb','[\"*\"]','2025-01-07 10:44:25',NULL,'2025-01-07 10:03:59','2025-01-07 10:44:25'),
(68,'App\\Models\\User',3,'web','d5a0ed46fc80625d4cb80f06ad6d13729797c8ec4ea8f7a263b5ebd3c4e8ebb2','[\"*\"]','2025-01-07 13:23:28',NULL,'2025-01-07 13:10:59','2025-01-07 13:23:28'),
(69,'App\\Models\\User',5,'web','e5d4ba87813b6d95bfd4cd30e21acb33b31a44e7108a7429784b14a3bdf6cde1','[\"*\"]','2025-01-08 03:56:53',NULL,'2025-01-08 03:56:21','2025-01-08 03:56:53'),
(70,'App\\Models\\User',1,'web','3332814b2432e6a2ee69a48e092f66c763ea6c4e36f1c1ba1e02e5c0398abb3f','[\"*\"]','2025-01-09 11:26:29',NULL,'2025-01-09 10:51:51','2025-01-09 11:26:29'),
(71,'App\\Models\\User',3,'web','fc864c8f5b9fff1a1159446228b71002b19178939f9edd262fd6e4a359e31498','[\"*\"]','2025-01-09 20:59:17',NULL,'2025-01-09 18:33:21','2025-01-09 20:59:17'),
(72,'App\\Models\\User',3,'web','415343d4c2a4cc7a8d19a96ad1b93f54e81eeec2f572287334bd390f16bc151b','[\"*\"]','2025-01-10 14:17:34',NULL,'2025-01-10 08:27:45','2025-01-10 14:17:34'),
(73,'App\\Models\\User',3,'web','7002ec27b209dbef3e6ce71800cc37e9f54731d0ae4418d9293fde0b79ee9e1b','[\"*\"]','2025-01-10 14:24:28',NULL,'2025-01-10 13:55:58','2025-01-10 14:24:28'),
(74,'App\\Models\\User',3,'web','08ddfbacc19b12a38ceb69059eded5f7048226fc54ac6ab62356ec561256428c','[\"*\"]','2025-01-11 01:27:48',NULL,'2025-01-10 21:08:53','2025-01-11 01:27:48'),
(75,'App\\Models\\User',3,'web','c7357ec8a0550b6e6360450e2ee6a896db93d7aebd054313acb8d252bc4f412b','[\"*\"]','2025-01-12 14:12:08',NULL,'2025-01-12 12:28:49','2025-01-12 14:12:08'),
(76,'App\\Models\\User',3,'web','14323b30a4c0f7455052054ed544e9b8010652428522dfaba4b5a15e3899fe3b','[\"*\"]','2025-01-12 23:11:59',NULL,'2025-01-12 18:38:45','2025-01-12 23:11:59'),
(77,'App\\Models\\User',5,'web','5c17f84baba7e9833e717f204900c5c89ef9faa55ba67ccaebafa91dc3b2ac52','[\"*\"]','2025-01-13 00:34:16',NULL,'2025-01-12 18:44:43','2025-01-13 00:34:16'),
(78,'App\\Models\\User',3,'web','3959127f7beaad3e9413ef1672d0a8dac8fe120053ec155e64d6111ce66a8111','[\"*\"]','2025-01-13 08:44:40',NULL,'2025-01-13 08:44:29','2025-01-13 08:44:40'),
(79,'App\\Models\\User',3,'web','9626fd50fb80b5bd4252d5e293f8f71ee9e8d9aec473d13e990fd8f93ee2cbc3','[\"*\"]','2025-01-13 15:42:57',NULL,'2025-01-13 14:58:14','2025-01-13 15:42:57'),
(80,'App\\Models\\User',3,'web','0a6403071a91bfebd0a948bd4db46b9595a1a039e962f5e109b148d45915e6b3','[\"*\"]','2025-01-13 15:48:43',NULL,'2025-01-13 15:46:58','2025-01-13 15:48:43'),
(81,'App\\Models\\User',5,'web','d0287569d49b225712afbd7bd4eadb2918f122f5161c2fe3508164c5199e7228','[\"*\"]','2025-01-17 23:44:11',NULL,'2025-01-13 17:42:17','2025-01-17 23:44:11'),
(82,'App\\Models\\User',3,'web','780b5f32f4f2f215afda8931bb94817649e735472c52d10793431c96ef7f9ca1','[\"*\"]','2025-01-13 23:23:11',NULL,'2025-01-13 21:33:49','2025-01-13 23:23:11'),
(83,'App\\Models\\User',5,'web','03971e2ad4384de91eda82ef7d86980543507d53a680e46e98ee5a3016af2cf8','[\"*\"]','2025-01-14 02:50:31',NULL,'2025-01-14 01:37:07','2025-01-14 02:50:31'),
(84,'App\\Models\\User',3,'web','09d6ced231a98364adb84535f01512a32069b6bb7439d3f735fc87cc419313a1','[\"*\"]','2025-01-14 11:56:43',NULL,'2025-01-14 08:03:36','2025-01-14 11:56:43'),
(85,'App\\Models\\User',3,'web','be7f560888c089f68c03ac5f25de2709a4704eb1677201242d6c0f0e8a1cb591','[\"*\"]','2025-01-14 14:03:37',NULL,'2025-01-14 11:57:58','2025-01-14 14:03:37'),
(86,'App\\Models\\User',5,'web','6892e042d67da95a4015d7b01b9481c13a731514160e3e7a171929f6ab86c292','[\"*\"]','2025-01-15 23:49:50',NULL,'2025-01-15 20:11:21','2025-01-15 23:49:50'),
(87,'App\\Models\\User',3,'web','16ba33c570bc2947aadb3b4ba73049c7c2a90ff2c332df66f37c521aa9975b37','[\"*\"]','2025-01-15 21:49:03',NULL,'2025-01-15 20:16:16','2025-01-15 21:49:03'),
(88,'App\\Models\\User',5,'web','7ec4d99959d17405c8ded2714a106cd17b26e73547bf41680fe3f32847ddcdfa','[\"*\"]','2025-01-17 21:31:51',NULL,'2025-01-17 20:35:07','2025-01-17 21:31:51'),
(89,'App\\Models\\User',5,'web','7506c5a7529f88b893d9a64e91f0154a9cf3e74b71678398fa5893554c3f840f','[\"*\"]','2025-01-18 00:00:41',NULL,'2025-01-17 23:43:37','2025-01-18 00:00:41'),
(90,'App\\Models\\User',4,'web','6041ba00b4e49c65027d82081cd88cc0db1c7bdcf0a886a55e53203ff334a46a','[\"*\"]',NULL,NULL,'2025-01-17 23:45:58','2025-01-17 23:45:58'),
(91,'App\\Models\\User',4,'web','d53dfdb55336360484d2097f98fa7fff3675d0f4e14ebab96ea8ea8c31e1a8e7','[\"*\"]','2025-01-20 00:32:40',NULL,'2025-01-17 23:53:46','2025-01-20 00:32:40'),
(92,'App\\Models\\User',3,'web','6f73740dcfb3138f1cae7ae62ed296a44985eb437560394e20f502dfb713524e','[\"*\"]','2025-01-19 14:43:08',NULL,'2025-01-19 14:42:38','2025-01-19 14:43:08'),
(93,'App\\Models\\User',3,'web','04c31f1e239e19e77721aea40c4c14669be03e25a01e0bebd18d0c715ee42d98','[\"*\"]','2025-01-19 16:35:49',NULL,'2025-01-19 15:13:27','2025-01-19 16:35:49'),
(94,'App\\Models\\User',3,'web','fa70ab029cd24fb27d6d88c1e4a7369025e1b47d6f705a10d10aafdb5b6463af','[\"*\"]','2025-01-19 21:45:12',NULL,'2025-01-19 19:44:09','2025-01-19 21:45:12'),
(95,'App\\Models\\User',5,'web','5597b520f3e71d43c48b3b53650d59d4bed10268cef1f27449e90f830b74ec86','[\"*\"]',NULL,NULL,'2025-01-19 21:06:24','2025-01-19 21:06:24'),
(96,'App\\Models\\User',5,'web','b2d1a6c2be5abd568b1713d322264504e7b4af4b95bfcb39e64a0fe6b46b8a9a','[\"*\"]',NULL,NULL,'2025-01-19 21:06:26','2025-01-19 21:06:26'),
(97,'App\\Models\\User',5,'web','7000dc467cb14e429d992c4607259240e4f5bf21efec1353779c9e039e61373b','[\"*\"]',NULL,NULL,'2025-01-19 21:07:03','2025-01-19 21:07:03'),
(98,'App\\Models\\User',5,'web','fd68df0e45b4b60305aa723816810a52f5a86bb9389eedc1f6e8e3aabafe54e6','[\"*\"]',NULL,NULL,'2025-01-19 21:07:06','2025-01-19 21:07:06'),
(99,'App\\Models\\User',5,'web','c75b7141dda8c03d37538d343d77959fbd82de7a081bc04fa8adc2efdc8cc034','[\"*\"]','2025-01-20 00:41:42',NULL,'2025-01-20 00:37:18','2025-01-20 00:41:42'),
(100,'App\\Models\\User',3,'web','a85fb5a12cf94a021247c82a666d7d104da2761672a5b7c2080fb01562307daa','[\"*\"]','2025-01-20 07:25:24',NULL,'2025-01-20 07:22:36','2025-01-20 07:25:24'),
(101,'App\\Models\\User',5,'web','877b397deb8d447b1e2f870f8d75f4b26d60d1045ea4c3fc6cc12e333b73dfa7','[\"*\"]','2025-01-20 22:50:05',NULL,'2025-01-20 20:21:54','2025-01-20 22:50:05'),
(102,'App\\Models\\User',5,'web','f1af50ad41190fbc36c3b1a8a2b06d42a8a849dcc8a04dd691d63aa5515e5b8d','[\"*\"]','2025-01-21 23:02:38',NULL,'2025-01-21 20:53:39','2025-01-21 23:02:38'),
(103,'App\\Models\\User',3,'web','e5e26e4d2347f7661fafc27462561e19d5c7b9a0545996f1fd53180a25e298f0','[\"*\"]','2025-01-22 09:32:37',NULL,'2025-01-22 08:43:58','2025-01-22 09:32:37'),
(104,'App\\Models\\User',3,'web','f53e1311c6ea9e0c6dd32a563bd105f51b7557f0c887da733a1557064ebbc873','[\"*\"]','2025-01-22 13:46:17',NULL,'2025-01-22 09:41:22','2025-01-22 13:46:17'),
(105,'App\\Models\\User',3,'web','66dfcfcec47450cc4b8192ab6d03b537e5e2b8d5f5c1951a98c8e6b102e96030','[\"*\"]','2025-01-22 14:50:00',NULL,'2025-01-22 13:41:39','2025-01-22 14:50:00'),
(106,'App\\Models\\User',5,'web','43dc0089c5cf83b1cf014f3532cd59b0d1921d3ab7e0c9591a6066e0a64ea9ab','[\"*\"]','2025-01-25 23:32:04',NULL,'2025-01-22 20:49:12','2025-01-25 23:32:04'),
(107,'App\\Models\\User',3,'web','348bff21147da72bbe20635d31312c80b7de64dee9ec55fa2b35087d0c718400','[\"*\"]','2025-01-22 23:13:49',NULL,'2025-01-22 21:00:49','2025-01-22 23:13:49'),
(108,'App\\Models\\User',3,'web','721f67dfb9169b88671f6e6f9fb071d06b067a52f192e497a2394b92695f22ef','[\"*\"]','2025-01-23 08:05:05',NULL,'2025-01-23 08:04:49','2025-01-23 08:05:05'),
(109,'App\\Models\\User',3,'web','75ede9439d3afb50bd823560efc4af4a4496c5a3c491e0208932080b8dc00be3','[\"*\"]','2025-01-23 09:55:52',NULL,'2025-01-23 08:05:40','2025-01-23 09:55:52'),
(110,'App\\Models\\User',3,'web','0dd1edc0e30b6d0e9eb370811c38372519397943d713d616cad7944ac6bea92a','[\"*\"]','2025-01-23 15:47:14',NULL,'2025-01-23 12:02:58','2025-01-23 15:47:14'),
(111,'App\\Models\\User',3,'web','c79008598550c38a7ad4f45bd783aa967a49bb553dcc3ab33eda1c0c2b21ad9b','[\"*\"]','2025-01-24 00:02:58',NULL,'2025-01-23 21:19:32','2025-01-24 00:02:58'),
(112,'App\\Models\\User',5,'web','0dd85b9861bbb24b7d21641f760cc895d35801edc79871c065b2787a05dcf637','[\"*\"]','2025-01-23 22:14:01',NULL,'2025-01-23 21:56:25','2025-01-23 22:14:01'),
(113,'App\\Models\\User',3,'web','2d5d0cd73e90ad074e4c43849800e536bb59240a7b6e01f21c79b5f03215f4e0','[\"*\"]','2025-01-24 08:55:47',NULL,'2025-01-24 07:13:40','2025-01-24 08:55:47'),
(114,'App\\Models\\User',3,'web','4698bc6e7aa73a1e0663ccb1c91d068680a27a7e07cd3b1c7ec07d56233177c4','[\"*\"]','2025-01-24 10:13:26',NULL,'2025-01-24 09:26:00','2025-01-24 10:13:26'),
(115,'App\\Models\\User',3,'web','21d9a65c9b308f560d58ae586b4bb42a4031e846b5bee26ce4c46717deafccce','[\"*\"]','2025-01-24 15:21:17',NULL,'2025-01-24 13:18:49','2025-01-24 15:21:17'),
(116,'App\\Models\\User',5,'web','22297af3e396a11dcc8d65e7747130c09cf4c1b136c1a85a8cf2d2a8038d969c','[\"*\"]','2025-01-25 21:02:26',NULL,'2025-01-25 20:51:40','2025-01-25 21:02:26'),
(117,'App\\Models\\User',3,'web','ebc6d85e82969df9aa90a247c51c7f1c4e9cf512db94d95e555c0e6c2eed901c','[\"*\"]','2025-01-27 11:52:16',NULL,'2025-01-27 09:44:24','2025-01-27 11:52:16'),
(118,'App\\Models\\User',3,'web','da5986fc8aef1ee1c4120c65db5cd1c51434934f96d7e71062347b554c108291','[\"*\"]','2025-01-28 10:22:56',NULL,'2025-01-28 08:27:59','2025-01-28 10:22:56'),
(119,'App\\Models\\User',3,'web','d875cec94516a46b918c1002ae3fd8f46a7ef979c8974874116569bcfd87cb90','[\"*\"]','2025-01-28 13:51:05',NULL,'2025-01-28 13:44:29','2025-01-28 13:51:05'),
(120,'App\\Models\\User',3,'web','5d1ac378fc6db2777c80d7593ff5167d8416db21d1d5ba34b3cd469f28ed387c','[\"*\"]','2025-01-28 13:52:30',NULL,'2025-01-28 13:52:16','2025-01-28 13:52:30'),
(121,'App\\Models\\User',5,'web','4ee19586dc1ae772e06f87986f86e08fb7acd1315c3976d42d99493ab43a0314','[\"*\"]','2025-01-28 23:13:27',NULL,'2025-01-28 22:22:37','2025-01-28 23:13:27'),
(122,'App\\Models\\User',3,'web','769d4b79521b2aff06cf7c44e1a458dfbfdd34e4f8767d48623e9a35043e34d3','[\"*\"]','2025-01-31 09:41:21',NULL,'2025-01-31 09:40:17','2025-01-31 09:41:21'),
(123,'App\\Models\\User',5,'web','7a969d7febd1b37ae466c8ddb44f8a4efebcb736bf8751325978f82614040d42','[\"*\"]','2025-02-01 21:46:20',NULL,'2025-02-01 21:41:12','2025-02-01 21:46:20'),
(124,'App\\Models\\User',5,'web','360817c9e2928d4c72cef6d053d6f5e6ea012899b9ea5255c8e0087dfb34c3f2','[\"*\"]','2025-02-01 22:02:56',NULL,'2025-02-01 21:48:36','2025-02-01 22:02:56'),
(125,'App\\Models\\User',5,'web','944eb8d5edd2014fc3304d00953784ef4dd4035a47170ab846b9064e859a3a49','[\"*\"]','2025-02-03 22:07:48',NULL,'2025-02-03 21:38:57','2025-02-03 22:07:48'),
(126,'App\\Models\\User',3,'web','f4fb69b8149418ca6331d2536b97ea880ba2e816ef964d5d76c5ef3910f1c3dd','[\"*\"]','2025-02-03 23:09:10',NULL,'2025-02-03 22:05:30','2025-02-03 23:09:10'),
(127,'App\\Models\\User',3,'web','50eb15ae576862fb5c843eb2835d75e388aaa6aab4808673ec4981b99110ed34','[\"*\"]','2025-02-04 10:01:10',NULL,'2025-02-04 07:13:02','2025-02-04 10:01:10'),
(128,'App\\Models\\User',3,'web','b399e3c1fda21f3b26c33c4a4947a14f9037128d6577ce67b52509d1dc1ae7c9','[\"*\"]','2025-02-05 09:00:33',NULL,'2025-02-05 08:16:12','2025-02-05 09:00:33'),
(129,'App\\Models\\User',3,'web','61fea0c08521ffb426e167c65a3f8c3efe1f03fbf28268a78d5707e2f8e552e9','[\"*\"]','2025-02-05 14:48:42',NULL,'2025-02-05 13:04:51','2025-02-05 14:48:42'),
(130,'App\\Models\\User',5,'web','06277ba027be34415b7e2de2685ef05c989abee388c152614603c6fb4b14d855','[\"*\"]','2025-02-06 00:08:07',NULL,'2025-02-05 23:53:26','2025-02-06 00:08:07'),
(131,'App\\Models\\User',5,'web','a39c43bc846b1063862b838bb2893f68c4c0495c752b7f65d71b85140a50d005','[\"*\"]','2025-02-06 19:39:51',NULL,'2025-02-06 19:24:25','2025-02-06 19:39:51'),
(132,'App\\Models\\User',5,'web','23a794ff4f122b516717ae140ad9ca19280d1553c357bb899598162a5c293ecd','[\"*\"]','2025-02-06 22:15:59',NULL,'2025-02-06 20:05:28','2025-02-06 22:15:59'),
(133,'App\\Models\\User',3,'web','94a53d880398193fae1a911b02a35584d7eb6ccc667f9cd2500c61c677459f4e','[\"*\"]','2025-02-06 22:19:13',NULL,'2025-02-06 21:32:49','2025-02-06 22:19:13'),
(134,'App\\Models\\User',3,'web','e7c2bca2b14d196e8655082da1f394fab47b1271ff2497e8567b9bc404b91088','[\"*\"]','2025-02-07 13:04:08',NULL,'2025-02-07 07:20:26','2025-02-07 13:04:08'),
(135,'App\\Models\\User',5,'web','3496b68f970704b0a82741d343172f57c49b9d2dae1e17a82305f7f3a2485620','[\"*\"]','2025-02-07 23:00:52',NULL,'2025-02-07 22:34:50','2025-02-07 23:00:52'),
(136,'App\\Models\\User',3,'web','8f6a89972c60ca32d8fa7d4039d11cdd45f6de79c1bff0820f57e0607de363c6','[\"*\"]','2025-02-08 14:01:29',NULL,'2025-02-08 10:25:27','2025-02-08 14:01:29'),
(137,'App\\Models\\User',3,'web','d52bafcae45704b217d8f57df96e2a9679d851cd2a0c5cd2c6e435fd44458d15','[\"*\"]','2025-02-08 16:33:57',NULL,'2025-02-08 16:11:07','2025-02-08 16:33:57'),
(138,'App\\Models\\User',3,'web','a0dca1cc5878e61f66477e05f2c86faf7dc365da6d3861f5bea554853b9857fd','[\"*\"]','2025-02-08 22:11:40',NULL,'2025-02-08 20:53:18','2025-02-08 22:11:40'),
(139,'App\\Models\\User',5,'web','a48017649fd31584e56b56620e75fee8c418abde4cbc29abc3803e6a00935955','[\"*\"]','2025-02-08 23:32:01',NULL,'2025-02-08 22:29:44','2025-02-08 23:32:01'),
(140,'App\\Models\\User',3,'web','728f52e877c30ba9e5034329dc6d8ba43d0c0808c7abea304fa2dcb4d1dd7da8','[\"*\"]','2025-02-09 14:53:02',NULL,'2025-02-09 09:46:47','2025-02-09 14:53:02'),
(141,'App\\Models\\User',5,'web','5505697492ba6a62edef61298a21ccf9fde64d6759176a96ab579f46b18afabc','[\"*\"]','2025-02-11 17:17:54',NULL,'2025-02-11 17:16:18','2025-02-11 17:17:54'),
(142,'App\\Models\\User',5,'web','4e770c1118d42a6c3e080dfee109d8749d63455e14ad4d964ceaa353fd56910a','[\"*\"]',NULL,NULL,'2025-02-11 17:22:34','2025-02-11 17:22:34'),
(143,'App\\Models\\User',5,'web','0a5ebe8b3f8d6e1d4dac92616971b9aa3257202e099ac91a2904496c8e3d1565','[\"*\"]','2025-02-11 21:43:19',NULL,'2025-02-11 17:23:04','2025-02-11 21:43:19'),
(144,'App\\Models\\User',3,'web','72df9ab9c4004adb1e910d437048d76a462d9256102c95559e0da85de2d13d2c','[\"*\"]','2025-02-12 13:37:12',NULL,'2025-02-12 13:21:32','2025-02-12 13:37:12'),
(145,'App\\Models\\User',3,'web','12d247b59e10693a2c0a51b90a15a9017ed738d11f10afbaea0b689fa746327c','[\"*\"]','2025-02-12 15:56:31',NULL,'2025-02-12 13:39:18','2025-02-12 15:56:31'),
(146,'App\\Models\\User',3,'web','2cc101d5ed68a816f2460225ffceb87af17a413f6f9b42901b1c1b2c7e96eb07','[\"*\"]','2025-02-12 22:57:14',NULL,'2025-02-12 19:58:39','2025-02-12 22:57:14'),
(147,'App\\Models\\User',3,'web','1b9f25365d3d6cf360c624e5ae5f0e80dd1768092bacef9389e8c2881fbe9878','[\"*\"]','2025-02-13 09:05:51',NULL,'2025-02-13 07:20:20','2025-02-13 09:05:51'),
(148,'App\\Models\\User',5,'web','b58b3d5948f4a1f9b3cfee6bf07877a7595a5b5ae0f04524dd719d54b029cefe','[\"*\"]','2025-02-13 23:04:55',NULL,'2025-02-13 22:26:43','2025-02-13 23:04:55'),
(149,'App\\Models\\User',5,'web','56a94075012e961f25e4a8a1d2a2d1f318b254f37898aa1366bbe81778853b32','[\"*\"]','2025-02-15 00:17:13',NULL,'2025-02-13 23:20:36','2025-02-15 00:17:13'),
(150,'App\\Models\\User',5,'web','ca67f7966ecb9cfb89843f46ba1e7b33bd781a5adccad14df726c6bef5ae49d8','[\"*\"]','2025-02-14 23:54:29',NULL,'2025-02-14 22:26:53','2025-02-14 23:54:29'),
(151,'App\\Models\\User',3,'web','6e3ff3ecb97b541598ded4f2cfcfe423b4e87c7658289f942c233a7f90b09f19','[\"*\"]','2025-02-15 13:48:02',NULL,'2025-02-15 08:59:05','2025-02-15 13:48:02'),
(152,'App\\Models\\User',5,'web','9d8fca59ae245ae032992912b0fc5b8b17902da95c3dc80b98ccfa9b12234f29','[\"*\"]','2025-02-15 13:40:26',NULL,'2025-02-15 13:38:02','2025-02-15 13:40:26'),
(153,'App\\Models\\User',5,'web','0cae5fd9844dd2d7b757c38aed949ddbeaa1b2287460f33e769c3cb9ae43297f','[\"*\"]','2025-02-15 14:23:19',NULL,'2025-02-15 13:40:55','2025-02-15 14:23:19'),
(154,'App\\Models\\User',3,'web','afb156a6c29e3a2637d4b0fb9c066f7f4d36fd3dfe82c55f2b5dc0217cc03cf1','[\"*\"]','2025-02-15 16:54:55',NULL,'2025-02-15 13:57:37','2025-02-15 16:54:55'),
(155,'App\\Models\\User',5,'web','ae2620e6cc842c70ced51183b2e6ddd0510c70aa4b30b9c649d2e336585605c2','[\"*\"]','2025-02-15 15:50:49',NULL,'2025-02-15 15:39:02','2025-02-15 15:50:49'),
(156,'App\\Models\\User',3,'web','b1e9598189fdeec8f9aad26307201f6ea20425b08dc3715a3529b48ba776eb35','[\"*\"]','2025-02-15 19:29:46',NULL,'2025-02-15 19:02:26','2025-02-15 19:29:46'),
(157,'App\\Models\\User',3,'web','37e3554b3c56614f0e0882ac954790bb2acb8b0f342b235c0c91ed4e78ffabc6','[\"*\"]','2025-02-16 14:00:03',NULL,'2025-02-16 08:12:54','2025-02-16 14:00:03'),
(158,'App\\Models\\User',3,'web','defca414696842532bfbfc464000a74ae15a9714c201c2dee9e01a6f5cce59d0','[\"*\"]','2025-02-16 14:37:27',NULL,'2025-02-16 14:00:49','2025-02-16 14:37:27'),
(159,'App\\Models\\User',3,'web','cbc44bfea85a0b0d7820eed0eddbf3198a720507167ba9a5c2ff32846349c44f','[\"*\"]','2025-02-17 14:07:05',NULL,'2025-02-17 13:11:50','2025-02-17 14:07:05'),
(160,'App\\Models\\User',1,'web','75b941308f0b0c813518ea58cdb46509f58d0251509a5d737b424795e1565db4','[\"*\"]','2025-02-18 11:25:48',NULL,'2025-02-18 09:47:11','2025-02-18 11:25:48'),
(161,'App\\Models\\User',1,'web','a6e8d86cc261788bb30d568bc687585e0eee586ec5658549e4a5a6f23cc4a19f','[\"*\"]','2025-02-18 11:35:32',NULL,'2025-02-18 11:26:10','2025-02-18 11:35:32'),
(162,'App\\Models\\User',3,'web','be8ca5ae355efdb04dae6ba0a120b25e75220014cfcb84bee6433aac5844e40c','[\"*\"]','2025-02-18 16:03:02',NULL,'2025-02-18 14:30:51','2025-02-18 16:03:02'),
(163,'App\\Models\\User',3,'web','070df6107616fcc2812ce3d5932f13c527f381505c33d542e219123b8357bf68','[\"*\"]','2025-02-18 22:26:22',NULL,'2025-02-18 22:10:46','2025-02-18 22:26:22'),
(164,'App\\Models\\User',3,'web','69fcb538e5363a5808872f3ca552af61b55beb2e1a38464f3dd38c2696ea5905','[\"*\"]','2025-02-19 12:14:56',NULL,'2025-02-19 09:44:26','2025-02-19 12:14:56'),
(165,'App\\Models\\User',1,'web','b3c86ef934b7c926d962a27cdd5d44ede33dcb1b9429eb2df767a055a19ff098','[\"*\"]','2025-02-19 14:23:59',NULL,'2025-02-19 14:23:31','2025-02-19 14:23:59'),
(166,'App\\Models\\User',3,'web','e33e6b0184b9503d1ad6e5e7f95ece53c27a9a3475a9d40ac2fd90b03807dd00','[\"*\"]','2025-02-19 15:19:27',NULL,'2025-02-19 14:50:52','2025-02-19 15:19:27'),
(167,'App\\Models\\User',3,'web','0a68adb650f2f9f8e5cfeab828bca8200414b575e24d5c106b9fb56145856ce0','[\"*\"]','2025-02-19 19:48:09',NULL,'2025-02-19 18:43:10','2025-02-19 19:48:09'),
(168,'App\\Models\\User',1,'web','d5affbb79eb7b10bcac8397f871a8852dd2b3a77f99e0b019533dd93378ec71c','[\"*\"]','2025-02-19 21:40:30',NULL,'2025-02-19 21:38:10','2025-02-19 21:40:30'),
(169,'App\\Models\\User',3,'web','5d51eba993dd6ffd85a746b5ede9b31dd97f65a561aca6047ac96a420251aed4','[\"*\"]','2025-02-20 13:31:17',NULL,'2025-02-20 09:04:14','2025-02-20 13:31:17'),
(170,'App\\Models\\User',3,'web','b0fbba04b0e88a9b810ce7d94ac274aba35c9666f2fdb7b34c62ed7acb4b8643','[\"*\"]','2025-02-20 14:32:56',NULL,'2025-02-20 13:31:30','2025-02-20 14:32:56'),
(171,'App\\Models\\User',1,'web','dcdcfa958b84800b1da7a90f157156abeb6e1fcb14bf49192e22898487283337','[\"*\"]','2025-02-28 11:47:54',NULL,'2025-02-28 11:44:47','2025-02-28 11:47:54'),
(172,'App\\Models\\User',1,'web','5279092c6f41cc531e78dd9ef256a9a8747db1b573c0e0d8f7a6a4e946b9fa5b','[\"*\"]','2025-02-28 13:24:38',NULL,'2025-02-28 13:24:17','2025-02-28 13:24:38'),
(173,'App\\Models\\User',3,'web','ccc960c38344fd24d49aec2536a97f8ddd29ae05fd128dbbfe17573730eda335','[\"*\"]','2025-03-03 22:02:05',NULL,'2025-03-03 22:01:58','2025-03-03 22:02:05'),
(174,'App\\Models\\User',3,'web','87a28c9a7edbc32a8860d3f6692d5ce3706126350d4bc85cc3ccbe8f01809a0e','[\"*\"]','2025-03-04 09:27:39',NULL,'2025-03-04 07:30:42','2025-03-04 09:27:39'),
(175,'App\\Models\\User',3,'web','7231620d9d0bc4648b8742502e8ef21a86c04e1e692bb0dada906bfe5619e061','[\"*\"]','2025-03-04 07:44:12',NULL,'2025-03-04 07:40:14','2025-03-04 07:44:12'),
(176,'App\\Models\\User',3,'web','c0f212b99c83c2479c14d3253764a6ab61da3451b276a586d3ca3bd63cf7cddb','[\"*\"]','2025-03-04 22:09:17',NULL,'2025-03-04 20:57:45','2025-03-04 22:09:17'),
(177,'App\\Models\\User',3,'web','3792a2d265e937b1441c0e7d273bafafc1341961042411fd78b43583a55a9e94','[\"*\"]','2025-03-05 08:44:21',NULL,'2025-03-05 07:24:20','2025-03-05 08:44:21'),
(178,'App\\Models\\User',3,'web','02b15ac01ac9b8e19599ec61da385316b824006f5c2764201989fae26e00b61c','[\"*\"]','2025-03-05 14:49:01',NULL,'2025-03-05 14:42:02','2025-03-05 14:49:01'),
(179,'App\\Models\\User',3,'web','5ecf329601b65f4bf15af8b7af2ecfd2ac6b889d45ac598baf94f7021863be0d','[\"*\"]','2025-03-05 22:44:54',NULL,'2025-03-05 19:54:25','2025-03-05 22:44:54'),
(180,'App\\Models\\User',3,'web','aac912ef2cb192cdbf4bff777ad380a6134e6e65f137d6b6017689d0e5a2cf77','[\"*\"]','2025-03-07 15:28:46',NULL,'2025-03-06 08:00:23','2025-03-07 15:28:46'),
(181,'App\\Models\\User',1,'web','db2ecaab1640497431c5ae21c61675251e311b2df203cb51ad8b9492c2e3e690','[\"*\"]','2025-03-10 14:30:45',NULL,'2025-03-10 14:30:45','2025-03-10 14:30:45'),
(182,'App\\Models\\User',26,'web','5030ae73a520972d41cabce0aedad87cd1b88a71ee2b15afdc6615d229833ba4','[\"*\"]','2025-03-10 14:47:00',NULL,'2025-03-10 14:33:28','2025-03-10 14:47:00'),
(183,'App\\Models\\User',3,'web','ddd444657e2ad7b46b7ed4ccb372f6471d4b1ae45ef2a21a05cd5c0038a9125d','[\"*\"]','2025-03-11 09:24:15',NULL,'2025-03-10 14:48:46','2025-03-11 09:24:15'),
(184,'App\\Models\\User',1,'web','6540f1862fd5153080ed026393481dad1b651919b081ab196c36fdfbaa061f16','[\"*\"]','2025-03-10 15:18:25',NULL,'2025-03-10 15:18:23','2025-03-10 15:18:25'),
(185,'App\\Models\\User',3,'web','01c3815ed8db631aef23e373636b4efb557a0399b9fdb1ef5d8b6d2917b0a75c','[\"*\"]','2025-03-13 08:48:56',NULL,'2025-03-11 11:10:47','2025-03-13 08:48:56'),
(186,'App\\Models\\User',26,'web','ac40b8ca841e37cc6606d6c94ad5905c3ae3ac796f084890b9b8b08cc437eb41','[\"*\"]','2025-03-13 16:18:44',NULL,'2025-03-13 16:16:15','2025-03-13 16:18:44'),
(187,'App\\Models\\User',3,'web','16536ffcc62565ec3a3bb72fe9a6160f87233f0fcf75fa872515992bb8b3f272','[\"*\"]','2025-03-17 14:53:40',NULL,'2025-03-17 13:42:22','2025-03-17 14:53:40'),
(188,'App\\Models\\User',3,'web','f9466ec9bde5d7f8e3ff7c73e3ef02755cd47f23034b5f338491163bd0fd686d','[\"*\"]','2025-03-18 10:16:30',NULL,'2025-03-18 10:05:37','2025-03-18 10:16:30'),
(189,'App\\Models\\User',1,'web','24780e873367a623025dc76d37040bb9ddcbf83ed2b356f325c16ced79b2dc8b','[\"*\"]','2025-03-18 10:43:36',NULL,'2025-03-18 10:35:43','2025-03-18 10:43:36'),
(190,'App\\Models\\User',1,'web','b3d04e18b8a3c7177616f410f8609ba086d34d2bde2f0845d13dba07140b8b36','[\"*\"]','2025-03-18 16:54:22',NULL,'2025-03-18 16:52:43','2025-03-18 16:54:22'),
(191,'App\\Models\\User',3,'web','b3f4f09d6f827e1d92e2490a859098673b64cf10708115572ccba38a98e1f25f','[\"*\"]','2025-03-22 15:16:22',NULL,'2025-03-22 14:22:06','2025-03-22 15:16:22'),
(192,'App\\Models\\User',3,'web','c99ae683ed0c2eabb4f1047a2761bdeb14896e13c02c44eaea9766fda4f880ab','[\"*\"]',NULL,NULL,'2025-03-26 22:09:39','2025-03-26 22:09:39'),
(193,'App\\Models\\User',3,'web','6f1e4051caf975773e39e3b5d7c9a072b3a1137c1fc4993e072ce54d2613e1b4','[\"*\"]',NULL,NULL,'2025-03-26 22:10:09','2025-03-26 22:10:09'),
(194,'App\\Models\\User',3,'web','724f5fa58b5108a49ae7d3a18cea32c66ce6147656f95b8c1db3bdae514413e1','[\"*\"]','2025-03-26 22:10:41',NULL,'2025-03-26 22:10:29','2025-03-26 22:10:41'),
(195,'App\\Models\\User',3,'web','39361ea1c6a2735abe945ac820e95c1fe98e3e6025e33cd43a972e6b08a9d76a','[\"*\"]',NULL,NULL,'2025-03-30 10:12:40','2025-03-30 10:12:40'),
(196,'App\\Models\\User',3,'web','5d669c47b159476b22f605ebc6bc734d28e57ebe7c42076cd8e1ba55f65de691','[\"*\"]',NULL,NULL,'2025-03-30 10:12:41','2025-03-30 10:12:41'),
(197,'App\\Models\\User',3,'web','7028639fd765b9327b9bd433cba9ef4437481dabd00e2b080e645b3645e1758c','[\"*\"]','2025-03-30 10:25:25',NULL,'2025-03-30 10:13:05','2025-03-30 10:25:25'),
(198,'App\\Models\\User',1,'web','041d59c5edd1f16bf375450a0d2ff7467277e031541176d0b8284a11f110f2e1','[\"*\"]','2025-04-07 09:16:56',NULL,'2025-04-07 09:04:34','2025-04-07 09:16:56'),
(199,'App\\Models\\User',1,'web','b87f36586124136e9452cb08b7ce88dd6f7332aca3973f43ba894d557c23f423','[\"*\"]','2025-04-07 13:03:58',NULL,'2025-04-07 12:18:25','2025-04-07 13:03:58'),
(200,'App\\Models\\User',1,'web','a79aaab8efa13264c128c8db74aca4afe17a9a274b0381ad40723999523c0a74','[\"*\"]','2025-04-07 13:05:59',NULL,'2025-04-07 13:05:01','2025-04-07 13:05:59'),
(201,'App\\Models\\User',1,'web','a606061811d0bf26a4b492afb432559b301514b170b0f5634bba955a55a8c5c8','[\"*\"]','2025-04-07 13:07:46',NULL,'2025-04-07 13:06:37','2025-04-07 13:07:46'),
(202,'App\\Models\\User',1,'web','2a8fdf42b465907a066ca49001da4deaacb63645b68601eb7b6f4a3d60eefc96','[\"*\"]','2025-04-07 13:08:54',NULL,'2025-04-07 13:08:02','2025-04-07 13:08:54'),
(203,'App\\Models\\User',3,'web','0e877be6d1344418006b9ffbfec47552a5b87aad94a4362a504079bee2628bda','[\"*\"]','2025-04-07 15:09:59',NULL,'2025-04-07 13:09:11','2025-04-07 15:09:59'),
(204,'App\\Models\\User',1,'web','6ca08ebb9c1bc1dd92a4d413f3051e509e12a8a958285d3465035fd1203ad8f3','[\"*\"]','2025-04-07 15:26:19',NULL,'2025-04-07 15:10:10','2025-04-07 15:26:19'),
(205,'App\\Models\\User',1,'web','f5cbf5ee05dab813459515ff610a100ef7fa27dc50f1688fad4bfa037af34c38','[\"*\"]','2025-04-07 22:42:11',NULL,'2025-04-07 21:31:09','2025-04-07 22:42:11'),
(206,'App\\Models\\User',1,'web','8c556615c0e8a35f32d684fa6438729b95afc714a8e456b6cb65a4bcd57e70f0','[\"*\"]','2025-04-13 22:59:54',NULL,'2025-04-13 21:27:20','2025-04-13 22:59:54'),
(207,'App\\Models\\User',1,'web','afa0385ba7750315f269ad56a8b0f48354a26c36788b1895dc8a9d372b8eef93','[\"*\"]','2025-04-14 14:12:47',NULL,'2025-04-14 14:01:23','2025-04-14 14:12:47'),
(208,'App\\Models\\User',1,'web','f3309ea32c68ff2480ffd42b0428f1471271a74127b7d83b2916f430772994da','[\"*\"]','2025-04-14 14:16:44',NULL,'2025-04-14 14:13:26','2025-04-14 14:16:44'),
(209,'App\\Models\\User',1,'web','529d27f1f038361f341775d8705eca325ff8f0119ddacf4253399de4b73e9942','[\"*\"]','2025-04-14 15:14:38',NULL,'2025-04-14 15:14:31','2025-04-14 15:14:38'),
(210,'App\\Models\\User',1,'web','88cb4c2a0835ea53678350fe4a31acfb667b9f13cf88d239ed01a77a3e512fb1','[\"*\"]','2025-04-22 16:29:52',NULL,'2025-04-22 16:15:17','2025-04-22 16:29:52'),
(211,'App\\Models\\User',1,'web','dab607498fed3e9d93c9bea002fb61520d888306f84d7e0a81115535788fcbee','[\"*\"]','2025-04-22 21:04:57',NULL,'2025-04-22 20:28:08','2025-04-22 21:04:57'),
(212,'App\\Models\\User',27,'web','92e6d22fe1e21e8b85abbd06d8bf78c329e3c82afcfb6331476b05b8cd928318','[\"*\"]','2025-04-22 20:31:40',NULL,'2025-04-22 20:31:23','2025-04-22 20:31:40'),
(213,'App\\Models\\User',27,'web','16384d0aaee5825a2c8a850517fde74dd0ad7ab17e10cc927f88a6b2ca830857','[\"*\"]','2025-04-22 20:35:48',NULL,'2025-04-22 20:32:20','2025-04-22 20:35:48'),
(214,'App\\Models\\User',27,'web','e2844943bb6acea33199e55ba278d4de488a831e4a1c68c520af53323236822c','[\"*\"]','2025-04-22 20:36:46',NULL,'2025-04-22 20:36:10','2025-04-22 20:36:46'),
(215,'App\\Models\\User',27,'web','12241f40fa49ac3c78ac703da763a30bd86f30d08d4cae12e677f2ff2574934c','[\"*\"]','2025-04-22 20:37:07',NULL,'2025-04-22 20:37:01','2025-04-22 20:37:07'),
(216,'App\\Models\\User',27,'web','129bc6c7c71c190f08504860d27e819da38d0568c32e8eb5706d1d268915d08c','[\"*\"]','2025-04-22 20:49:57',NULL,'2025-04-22 20:37:32','2025-04-22 20:49:57'),
(217,'App\\Models\\User',27,'web','d8de49012074ed0463f82bf1e26761134c965e144c865a06ad02fe8bc6ab7d2e','[\"*\"]','2025-04-22 20:56:02',NULL,'2025-04-22 20:50:14','2025-04-22 20:56:02'),
(218,'App\\Models\\User',27,'web','e8e8379e512153fe46aa391cdf52687e7791048aed4dd20ee7b2fe687fee4055','[\"*\"]','2025-04-22 20:57:36',NULL,'2025-04-22 20:57:17','2025-04-22 20:57:36'),
(219,'App\\Models\\User',27,'web','ba0a49f37e3a82e84dbe0642e53c6db21f570da301f30e0ac9a17f17b13d9103','[\"*\"]','2025-04-22 21:08:24',NULL,'2025-04-22 20:58:21','2025-04-22 21:08:24'),
(220,'App\\Models\\User',1,'web','da6e1aa6e76b4088b7ea6eab0e509dae6391c3b372dee9d87af6251316f6da68','[\"*\"]','2025-04-22 22:01:52',NULL,'2025-04-22 21:18:38','2025-04-22 22:01:52'),
(221,'App\\Models\\User',1,'web','688fc1a5958110ddd533436c7ff634de0aa09405b4dc21c0dc29f8843e99968c','[\"*\"]','2025-04-23 08:00:04',NULL,'2025-04-23 07:55:56','2025-04-23 08:00:04'),
(222,'App\\Models\\User',1,'web','02fd5f0143bd2ef2432ae1c7ef152e580caadf164ee8abe71ba260f0997f024c','[\"*\"]','2025-04-23 08:23:04',NULL,'2025-04-23 08:07:40','2025-04-23 08:23:04'),
(223,'App\\Models\\User',1,'web','871256ca99e36c01c53936770c696142a165a03cc199a3829d855d5139bfda45','[\"*\"]','2025-04-25 09:00:54',NULL,'2025-04-25 08:35:59','2025-04-25 09:00:54'),
(224,'App\\Models\\User',1,'web','56fe7de23e1c37a901c556345f5ae4100c53ba9a0fba4d30466b52b335a2773b','[\"*\"]','2025-04-25 09:17:52',NULL,'2025-04-25 09:05:04','2025-04-25 09:17:52'),
(225,'App\\Models\\User',3,'web','2c483d94605e8bb4f90bbc42608c189dcbc068ab2cf542caf4f144457e28d0f4','[\"*\"]','2025-04-25 09:07:19',NULL,'2025-04-25 09:06:37','2025-04-25 09:07:19'),
(226,'App\\Models\\User',3,'web','b726f2d48c31d7282889e863f0f86cfad6d8a5a3d4ea473889d556d4b17c384f','[\"*\"]','2025-04-25 09:19:21',NULL,'2025-04-25 09:08:22','2025-04-25 09:19:21'),
(227,'App\\Models\\User',1,'web','6f6a473ededd4e6ae7f08e7e956a73081d6de192e33b089571ec6e21c2c126e2','[\"*\"]','2025-04-27 22:27:44',NULL,'2025-04-27 22:26:23','2025-04-27 22:27:44'),
(228,'App\\Models\\User',1,'web','874e311037b7b6e0daa24bd90fa8b362c7a5c7c501912e873af3bb2709cf605e','[\"*\"]','2025-04-28 08:32:27',NULL,'2025-04-28 08:21:33','2025-04-28 08:32:27'),
(229,'App\\Models\\User',1,'web','1ebde072408d11ceb6ad22627a598bcf0e0f8d7bf3238d87f4052de9b8d438b6','[\"*\"]','2025-04-28 11:40:53',NULL,'2025-04-28 08:33:18','2025-04-28 11:40:53'),
(230,'App\\Models\\User',3,'web','17b295614ef4e7819fdfa49129be489cd143e068f2cb3f93b9207d574c6b3fd1','[\"*\"]','2025-04-28 11:42:04',NULL,'2025-04-28 11:41:12','2025-04-28 11:42:04'),
(231,'App\\Models\\User',1,'web','4411a03e35b80046d1619c177fd9995aa8df0ebe9091f7eae268377388faf4ae','[\"*\"]','2025-04-28 13:30:41',NULL,'2025-04-28 11:41:49','2025-04-28 13:30:41'),
(232,'App\\Models\\User',1,'web','0b10634b1c8a27e987bc3dca5ccd026a24a376b64a4bb0f8251e1697d53e30f8','[\"*\"]','2025-04-28 16:44:00',NULL,'2025-04-28 16:06:53','2025-04-28 16:44:00'),
(233,'App\\Models\\User',1,'web','ed81535be745bb2af2d84ec90a38939bbaef9bb1bb598b5031215cabeb7e2380','[\"*\"]','2025-04-28 22:01:08',NULL,'2025-04-28 22:00:55','2025-04-28 22:01:08'),
(234,'App\\Models\\User',1,'web','91128f6338817e1507b10573f28f9f6e4ef65a518bfec0f1d38994a3695f2a83','[\"*\"]','2025-04-29 14:40:38',NULL,'2025-04-29 14:40:10','2025-04-29 14:40:38'),
(235,'App\\Models\\User',1,'web','36e2d5736ab10d70036ed7f7139c483baf7389b74e3d74d0232c3a1c8fd82fa4','[\"*\"]','2025-04-29 14:44:27',NULL,'2025-04-29 14:42:17','2025-04-29 14:44:27'),
(236,'App\\Models\\User',1,'web','1f898e0b49a2bfe081a14cbd4ffd1520d7576f6361350786f88645b09e9e83be','[\"*\"]','2025-04-29 16:13:11',NULL,'2025-04-29 15:38:53','2025-04-29 16:13:11'),
(237,'App\\Models\\User',1,'web','7da7ef45cb944483e7d5d4f41ed3ecb3e942d4a81b8fbb1de5df03688910499f','[\"*\"]','2025-04-30 15:01:05',NULL,'2025-04-30 13:10:05','2025-04-30 15:01:05'),
(238,'App\\Models\\User',1,'web','5edee1a9fabdc365777b5541e52570591c94fb753273074e3880e2b1ac2432c0','[\"*\"]','2025-04-30 15:11:37',NULL,'2025-04-30 15:11:31','2025-04-30 15:11:37'),
(239,'App\\Models\\User',1,'web','ce0b95f0b456acf0ff3b5ffc31c86b1f52d6b5e17d0d1f8805b9660f3eb66f7a','[\"*\"]','2025-05-12 18:42:45',NULL,'2025-05-12 08:59:41','2025-05-12 18:42:45'),
(240,'App\\Models\\User',1,'web','f0411b8ee8ed005f603f386e1fac2fbce78adaa658a1452c5770b05db62541bd','[\"*\"]','2025-05-12 21:58:17',NULL,'2025-05-12 21:37:27','2025-05-12 21:58:17'),
(241,'App\\Models\\User',1,'web','97346d1d110fa537c0a255370e27f723529d90e27fc929500eb00c24a81002ec','[\"*\"]','2025-05-12 21:59:20',NULL,'2025-05-12 21:58:31','2025-05-12 21:59:20'),
(242,'App\\Models\\User',1,'web','5e5a42c25b065db8810ed8d80fd0491af8cc9054f0558bea88e81750b71b0cca','[\"*\"]','2025-05-12 22:33:36',NULL,'2025-05-12 21:59:29','2025-05-12 22:33:36'),
(243,'App\\Models\\User',1,'web','99ae76df6f0714e42b392741a6cfc9f003523817a2dc1eece1cdb103a59b7abb','[\"*\"]','2025-05-13 11:59:57',NULL,'2025-05-13 07:40:33','2025-05-13 11:59:57'),
(244,'App\\Models\\User',3,'web','d802bb537104fb53189f37b9e37d4221caba3aa32d45a3add840fd391aa84029','[\"*\"]','2025-05-13 08:23:42',NULL,'2025-05-13 08:19:40','2025-05-13 08:23:42'),
(245,'App\\Models\\User',1,'web','6e6790f5d9a36fa8d3e6e74e7a3612fd91746c30fa643e83f120726203d1266e','[\"*\"]','2025-05-13 16:48:55',NULL,'2025-05-13 16:36:36','2025-05-13 16:48:55'),
(246,'App\\Models\\User',26,'web','298b9cf4c345b51a935425cd348b0c00dc066ab329adb8f9702189db7139b715','[\"*\"]','2025-05-13 16:48:56',NULL,'2025-05-13 16:38:59','2025-05-13 16:48:56'),
(247,'App\\Models\\User',1,'web','f3812c253017e835f839f5e9653b0bbe77f8a05b9b360126d6eb9f8e8d3897f2','[\"*\"]','2025-05-13 20:21:49',NULL,'2025-05-13 19:50:06','2025-05-13 20:21:49'),
(248,'App\\Models\\User',1,'web','69a7eec608a29f33b9c18ce02d6cd5b9d44eb22c8f9e75401af685ca2b12264b','[\"*\"]','2025-05-14 07:28:57',NULL,'2025-05-14 07:23:45','2025-05-14 07:28:57'),
(249,'App\\Models\\User',1,'web','f554d10b6d2079acd095f506f3d612adf65d15681c3f7574f42a97acff5ac527','[\"*\"]','2025-05-14 07:30:45',NULL,'2025-05-14 07:29:03','2025-05-14 07:30:45'),
(250,'App\\Models\\User',26,'web','5b5d1e94f13214fb26197ef02ebe48b81e9e9b04e243d8a403588b077f5ff597','[\"*\"]','2025-05-14 07:33:33',NULL,'2025-05-14 07:31:09','2025-05-14 07:33:33'),
(251,'App\\Models\\User',1,'web','c6a55cf156d2a93d5a8547e103b3ecdbdb15465be965cb46282fe14e27336919','[\"*\"]','2025-05-14 07:34:20',NULL,'2025-05-14 07:33:52','2025-05-14 07:34:20'),
(252,'App\\Models\\User',1,'web','c698e4b3e425a7855969367261d31a77e8796aa291b48c7e4babc399942d514e','[\"*\"]','2025-05-14 07:54:37',NULL,'2025-05-14 07:54:31','2025-05-14 07:54:37'),
(253,'App\\Models\\User',1,'web','53c608918b0af4d4f19ccbba3ee7c4ebe36e4b6e557fe51251637ebdd44bf960','[\"*\"]','2025-05-14 07:55:26',NULL,'2025-05-14 07:55:20','2025-05-14 07:55:26'),
(254,'App\\Models\\User',26,'web','93b16494b9a254c0f4c8b41a2eb511bc2b816d49cf585d4064937946adbf2b34','[\"*\"]','2025-05-14 12:01:39',NULL,'2025-05-14 11:43:02','2025-05-14 12:01:39'),
(255,'App\\Models\\User',1,'web','4e1f3025d64e92e46c5a77f8c18b633d790fda20b7d46720b7e648a777dd712a','[\"*\"]','2025-05-14 12:10:29',NULL,'2025-05-14 11:57:43','2025-05-14 12:10:29'),
(256,'App\\Models\\User',26,'web','688e8046ed05c4bd3fa58b81cd6a4d4deb3e6db6d9465ec601565faa2f10484a','[\"*\"]','2025-05-14 12:35:31',NULL,'2025-05-14 12:03:07','2025-05-14 12:35:31'),
(257,'App\\Models\\User',1,'web','e094c16247927b6a27078018b8d1067cb78e2e03fdffde511c20e6c9e925ac24','[\"*\"]',NULL,NULL,'2025-05-16 11:32:38','2025-05-16 11:32:38'),
(258,'App\\Models\\User',1,'web','b44d91f806f54a4e6b97aeeed786cbc8b52244fe2667c1d825051883120fd8b3','[\"*\"]','2025-05-16 11:39:47',NULL,'2025-05-16 11:32:44','2025-05-16 11:39:47'),
(259,'App\\Models\\User',26,'web','d7175c4fbd71456280be1fcf7b5156607d8118ef86bfcb5e953b989900cd1c4b','[\"*\"]','2025-05-16 11:40:02',NULL,'2025-05-16 11:39:55','2025-05-16 11:40:02'),
(260,'App\\Models\\User',1,'web','f08348c7c91ec53b9855aa1482bae0f715a21188e4baaa21129aa92f001a2ec8','[\"*\"]','2025-05-16 14:52:37',NULL,'2025-05-16 14:49:54','2025-05-16 14:52:37'),
(261,'App\\Models\\User',26,'web','172451b5079088070c5ddd6257833fe22434d74e9d11e787a987580a1815dd45','[\"*\"]','2025-05-16 16:47:24',NULL,'2025-05-16 14:52:52','2025-05-16 16:47:24'),
(262,'App\\Models\\User',26,'web','c79e624e71ad9762d0b647e48e7f17571297e4469d658c72f26973383e4d67f1','[\"*\"]','2025-05-16 16:55:47',NULL,'2025-05-16 16:48:14','2025-05-16 16:55:47'),
(263,'App\\Models\\User',1,'web','f0528616a0cc5048b0c649ebe6df3c2578ab74f3a61481941a29102e8461d355','[\"*\"]','2025-05-17 05:58:47',NULL,'2025-05-17 05:58:45','2025-05-17 05:58:47'),
(264,'App\\Models\\User',1,'web','780bf42d94b0178d8418a8d5aa8633593a9cfba7a58d45252fed53d1cf95a2cc','[\"*\"]','2025-05-17 05:59:22',NULL,'2025-05-17 05:59:19','2025-05-17 05:59:22'),
(265,'App\\Models\\User',1,'web','dfae0f67840529f26bfc459afdd87a079e50e4bf6ac22beb7d074aa3cb25842f','[\"*\"]','2025-05-17 06:30:56',NULL,'2025-05-17 05:59:45','2025-05-17 06:30:56'),
(266,'App\\Models\\User',1,'web','259de3d64dad971942780929a57b34a79786653081901b2777680ac3f964947d','[\"*\"]','2025-05-17 11:31:59',NULL,'2025-05-17 06:31:49','2025-05-17 11:31:59'),
(267,'App\\Models\\User',1,'web','03e3eddc17d03204f6924cf0e75ca9370f72a6f6ea282cf54c35ee817e113479','[\"*\"]','2025-05-17 18:38:04',NULL,'2025-05-17 13:59:26','2025-05-17 18:38:04'),
(268,'App\\Models\\User',1,'web','461606ac8c82f110b580ec1842ca5dcf5dfc1796d587f0e1120ba0ad91966ee6','[\"*\"]','2025-05-18 01:47:11',NULL,'2025-05-18 00:20:47','2025-05-18 01:47:11'),
(269,'App\\Models\\User',26,'web','dcbefff9a72c9d02090c9c52f3bfc54410b3fba34ddd98e91fd76d17762dcb8b','[\"*\"]','2025-05-18 02:24:22',NULL,'2025-05-18 01:47:25','2025-05-18 02:24:22'),
(270,'App\\Models\\User',26,'web','9848182b88bf001c38addff2cd74566d898b6f7b2b187a61f58caef00dade2a8','[\"*\"]','2025-05-18 08:17:18',NULL,'2025-05-18 02:24:31','2025-05-18 08:17:18'),
(271,'App\\Models\\User',26,'web','9528c181493641202d5f9e4368201ee08188df0f72dc5bb80ec6d7fae8edc019','[\"*\"]','2025-05-20 08:00:52',NULL,'2025-05-19 23:43:16','2025-05-20 08:00:52'),
(272,'App\\Models\\User',26,'web','db65446f7b1cc18b93077fd68cb97b4f937747a216cb81003e9a4e289c9c8501','[\"*\"]','2025-05-21 09:30:05',NULL,'2025-05-20 13:12:21','2025-05-21 09:30:05'),
(273,'App\\Models\\User',26,'web','fba14a5ed6201fb89defaf2aee2f968a4935ef02709132e420db9f161f3b03bf','[\"*\"]','2025-05-21 16:02:11',NULL,'2025-05-21 09:30:18','2025-05-21 16:02:11'),
(274,'App\\Models\\User',26,'web','1428d09f738a5693244efc89c59d48d4b7d4352d8de4ba2dfa218c41ac7b03d1','[\"*\"]','2025-05-22 09:46:33',NULL,'2025-05-21 16:07:36','2025-05-22 09:46:33'),
(275,'App\\Models\\User',26,'web','835f401f8777160332848b82a263a9b0cb5686bd5851255c25ad769229153039','[\"*\"]','2025-05-22 16:43:28',NULL,'2025-05-22 09:49:35','2025-05-22 16:43:28'),
(276,'App\\Models\\User',26,'web','8d918c1373df690b7b57da272529adfc75a5b3173008de8d652b927007dfd348','[\"*\"]','2025-05-23 10:09:09',NULL,'2025-05-23 09:29:25','2025-05-23 10:09:09'),
(277,'App\\Models\\User',26,'web','0ee82ccb52f5d2f0744a8154100fb8f64f3b23905340dedf191eff382d42c90f','[\"*\"]','2025-05-23 10:11:23',NULL,'2025-05-23 10:11:08','2025-05-23 10:11:23'),
(278,'App\\Models\\User',26,'web','1c016d4fb98abf871da1c4b352e78ea2968416711d6c6221bd2fc290e3c8d9c1','[\"*\"]','2025-05-23 12:58:00',NULL,'2025-05-23 10:12:14','2025-05-23 12:58:00'),
(279,'App\\Models\\User',28,'web','55c5238a7dc6a2fe08344b99ebbbd97b9e713934bb42f1f0f4319ec5b4aa1416','[\"*\"]','2025-05-23 13:00:12',NULL,'2025-05-23 13:00:08','2025-05-23 13:00:12'),
(280,'App\\Models\\User',26,'web','56d3de3b227aff5cd3c757b8989eede57cc757e492e19d9f0ae0a6babeaeee70','[\"*\"]','2025-05-23 17:01:21',NULL,'2025-05-23 13:00:27','2025-05-23 17:01:21'),
(281,'App\\Models\\User',26,'web','82da64fb5415658786fedbc41d3bc50ab31803c4d50033f6d746e803a49d9d1d','[\"*\"]','2025-05-23 23:35:59',NULL,'2025-05-23 22:00:34','2025-05-23 23:35:59'),
(282,'App\\Models\\User',26,'web','9e754227950ff0a10bf9f3f4e09981c90f8752f81d1794676d6f384fba98a344','[\"*\"]','2025-05-26 09:26:03',NULL,'2025-05-26 08:59:50','2025-05-26 09:26:03'),
(283,'App\\Models\\User',26,'web','fed5f69385d89954ca00e614f875916fb54362e7454dcf075c69c3fb707c4b41','[\"*\"]','2025-05-26 10:32:59',NULL,'2025-05-26 09:27:10','2025-05-26 10:32:59'),
(284,'App\\Models\\User',26,'web','6df6f5c8933129810d64e60c8d10aee942b63856ebc6881886423d81cf740114','[\"*\"]','2025-05-26 10:47:44',NULL,'2025-05-26 10:33:35','2025-05-26 10:47:44'),
(285,'App\\Models\\User',26,'web','66bf555e9d32fb98ba8709df85205e00712090837617648540e3329f734a03d6','[\"*\"]','2025-05-26 10:51:02',NULL,'2025-05-26 10:48:39','2025-05-26 10:51:02'),
(286,'App\\Models\\User',26,'web','d4a90c1494eb26c17c2d91654bee1b0ac1f68a937f5ef75b54e42d80d5dec991','[\"*\"]','2025-05-26 13:36:45',NULL,'2025-05-26 10:53:17','2025-05-26 13:36:45'),
(287,'App\\Models\\User',26,'web','71b54ea2943f0cf5a2252e4bdf328cb76fef187f4512c6526decfdbef3cd5165','[\"*\"]','2025-05-27 14:26:03',NULL,'2025-05-27 13:56:31','2025-05-27 14:26:03'),
(288,'App\\Models\\User',26,'web','6b4759caee56fbb7a090473915056c81e6aa6292ee7ca318d5c9f62dd565a378','[\"*\"]','2025-05-27 16:00:38',NULL,'2025-05-27 14:40:14','2025-05-27 16:00:38'),
(289,'App\\Models\\User',1,'web','68057b1971d901436a6fa4865b7c714d85da9ae628f500d42b6c9d91fd1de281','[\"*\"]','2025-05-27 21:55:21',NULL,'2025-05-27 20:22:05','2025-05-27 21:55:21'),
(290,'App\\Models\\User',26,'web','fa8a3e07fe761a8bc25df0d2c9eaff6f2e702389fdc359dd1bf8ad6de6828c09','[\"*\"]','2025-05-28 10:49:48',NULL,'2025-05-28 09:33:46','2025-05-28 10:49:48'),
(291,'App\\Models\\User',26,'web','3fb591a483c632608145d493c0eb282b8d6dd36e85ca6be11bc54a9d6bb22fdf','[\"*\"]','2025-05-28 13:26:40',NULL,'2025-05-28 10:50:10','2025-05-28 13:26:40'),
(292,'App\\Models\\User',26,'web','374f0cd673f35f836ea88fc7187c2c93663e79a59f73b1e8dadba99fb9213ab8','[\"*\"]','2025-05-28 13:29:45',NULL,'2025-05-28 13:26:47','2025-05-28 13:29:45'),
(293,'App\\Models\\User',26,'web','36870ced2c65a310048ab5b8b0a25dd156ed9ddc27ba37bcedf3a491fc62ffca','[\"*\"]','2025-05-28 13:36:03',NULL,'2025-05-28 13:33:32','2025-05-28 13:36:03'),
(294,'App\\Models\\User',26,'web','aeba766681645b46e0536ffd39e896909f1ba121893c07ef4313cce20ab63942','[\"*\"]','2025-05-28 13:51:19',NULL,'2025-05-28 13:36:40','2025-05-28 13:51:19'),
(295,'App\\Models\\User',26,'web','af6ef23115a859a4d323bac5b1bda37d22190c35c75075891016bf60c265caf2','[\"*\"]','2025-05-28 13:54:38',NULL,'2025-05-28 13:54:12','2025-05-28 13:54:38'),
(296,'App\\Models\\User',26,'web','0261c93abe1c984c4649926fa96e2317c74851cbc972a7f2f9f66a74edf4d7e1','[\"*\"]','2025-05-28 15:06:59',NULL,'2025-05-28 13:54:58','2025-05-28 15:06:59'),
(297,'App\\Models\\User',26,'web','0460254c69657e71244a334f83f31c66174b3ca109f53fd56a5092771bafffb1','[\"*\"]','2025-05-29 10:05:37',NULL,'2025-05-29 08:09:45','2025-05-29 10:05:37'),
(298,'App\\Models\\User',26,'web','4534f9a54ce1778a0814413fa1330b314c89e0396fd0634922ead137ad3da483','[\"*\"]','2025-05-31 13:09:22',NULL,'2025-05-31 13:09:15','2025-05-31 13:09:22'),
(299,'App\\Models\\User',26,'web','5c4a8a16cf2a582d35a4933d11220a123ce4210f2148ac7021b9e2c3885576ac','[\"*\"]','2025-05-31 13:14:09',NULL,'2025-05-31 13:09:31','2025-05-31 13:14:09'),
(300,'App\\Models\\User',1,'web','1fe2fdf56a96e83aa169261763bf7c5a37681157083040cbb43736cfd239fe56','[\"*\"]','2025-05-31 13:17:04',NULL,'2025-05-31 13:14:20','2025-05-31 13:17:04'),
(301,'App\\Models\\User',26,'web','d4c9e424ed8da2ec065ed50c53acb987358ad8c8b7d0a6f82d6e3e09694e8486','[\"*\"]','2025-05-31 15:42:37',NULL,'2025-05-31 13:17:15','2025-05-31 15:42:37'),
(302,'App\\Models\\User',26,'web','30c01040fe03648fbe34358f453a43a76cd2842e053ca79774dddd7712490ed8','[\"*\"]','2025-06-01 00:49:50',NULL,'2025-06-01 00:33:26','2025-06-01 00:49:50'),
(303,'App\\Models\\User',26,'web','629a469b452d6f4ad0f5c80854761e39630215a11120a402eb37978057f33e9f','[\"*\"]','2025-06-01 11:08:45',NULL,'2025-06-01 08:48:32','2025-06-01 11:08:45'),
(304,'App\\Models\\User',26,'web','c34928fd25e6827420cd172c9bb72a641597740cfb00b342f5f37eea52313019','[\"*\"]','2025-06-01 22:24:51',NULL,'2025-06-01 20:48:53','2025-06-01 22:24:51'),
(305,'App\\Models\\User',30,'web','666345e0ce35e7f0329ed52e9571d2c3d3c8d08f13da419f7a9b39ee51bdb2e9','[\"*\"]','2025-06-01 22:26:32',NULL,'2025-06-01 22:26:10','2025-06-01 22:26:32'),
(306,'App\\Models\\User',26,'web','133ff1f1c8cef7909616a4735646955da92610395d4f722c00d749f4aa09af8e','[\"*\"]','2025-06-01 22:27:55',NULL,'2025-06-01 22:27:48','2025-06-01 22:27:55'),
(307,'App\\Models\\User',33,'web','22834a546f77be18c46470f1697db198ef732d80f841d7c2b38bed3d4a9ace3a','[\"*\"]','2025-06-01 22:29:21',NULL,'2025-06-01 22:28:46','2025-06-01 22:29:21'),
(308,'App\\Models\\User',30,'web','05c0375fc670579401156e1fe6f169538d684959e64f5c9cb980d786c1a2f628','[\"*\"]','2025-06-01 22:34:16',NULL,'2025-06-01 22:30:16','2025-06-01 22:34:16'),
(309,'App\\Models\\User',33,'web','3e2594fffce9c804288d9f27cb5f1ebb82ada924d48f4fbd70ba9111706f3efe','[\"*\"]','2025-06-01 22:42:48',NULL,'2025-06-01 22:36:01','2025-06-01 22:42:48'),
(310,'App\\Models\\User',30,'web','8cbeb392b22727baa17d18077f38edd8af5a3b68e4e3512f3f2181115084b16f','[\"*\"]','2025-06-01 23:51:27',NULL,'2025-06-01 22:43:21','2025-06-01 23:51:27'),
(311,'App\\Models\\User',31,'web','0ea6a897cc74f6bc4a085b8397c6b413059799f6d5a25613009ead4b77bd58f2','[\"*\"]','2025-06-01 23:13:42',NULL,'2025-06-01 22:50:29','2025-06-01 23:13:42'),
(312,'App\\Models\\User',33,'web','0dc8b7b4a25ad349958bcda4a0bfeab5f98a0b6d5bd171dfd6bf6cd05dbe5f0d','[\"*\"]','2025-06-01 23:16:31',NULL,'2025-06-01 23:16:18','2025-06-01 23:16:31'),
(313,'App\\Models\\User',33,'web','5916fa8a03bf1bbd252a309fb3ea44a40f43e29053995204ac29e8e58dfeddb1','[\"*\"]','2025-06-01 23:20:18',NULL,'2025-06-01 23:17:03','2025-06-01 23:20:18'),
(314,'App\\Models\\User',31,'web','a5c973f9d83a094b16220cf41366ced26bd68aabef1770e886f3ea096e2994cc','[\"*\"]','2025-06-01 23:48:41',NULL,'2025-06-01 23:21:13','2025-06-01 23:48:41'),
(315,'App\\Models\\User',32,'web','f2c128dfba7ce84880bebb2e2e57dafd8a005e7adbfcecbf48df74fb774688b6','[\"*\"]','2025-06-02 00:00:13',NULL,'2025-06-01 23:51:49','2025-06-02 00:00:13'),
(316,'App\\Models\\User',33,'web','39e39fc5a4f8996b8e696b69d9f89898d170265b19e559223401bdaf26a46eb0','[\"*\"]','2025-06-02 10:55:25',NULL,'2025-06-02 10:47:50','2025-06-02 10:55:25'),
(317,'App\\Models\\User',30,'web','bee41f51cf072a1913269d89dff969ea2bde195af0dadf0f0cab2a4d8245eeee','[\"*\"]','2025-06-04 10:35:42',NULL,'2025-06-04 10:04:26','2025-06-04 10:35:42'),
(318,'App\\Models\\User',30,'web','7c557790c853c2a957e1ec13f0f352943af84f586da7f14095450163bcec7f34','[\"*\"]','2025-06-04 10:36:35',NULL,'2025-06-04 10:36:00','2025-06-04 10:36:35'),
(319,'App\\Models\\User',33,'web','f8c015e2557f2f52531daa946535e1f6dd9376bebf66e2cb195dc5e662f7da37','[\"*\"]','2025-06-04 10:36:59',NULL,'2025-06-04 10:36:41','2025-06-04 10:36:59');

/*Table structure for table `sections` */

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(100) DEFAULT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `divisionid` int(11) DEFAULT NULL,
  `acronym` varchar(20) DEFAULT NULL,
  `sectionheadid` int(11) DEFAULT NULL COMMENT 'employeeid',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `divisionid` (`divisionid`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`divisionid`) REFERENCES `divisions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

/*Data for the table `sections` */

insert  into `sections`(`id`,`section`,`alias`,`divisionid`,`acronym`,`sectionheadid`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'Office of the Executive Director',NULL,1,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(2,'Office of the Deputy Executive Director',NULL,1,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(3,'Internal Audit Section',NULL,1,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(4,'Accounting\r\n',NULL,2,'ACCT',NULL,'2024-10-17 14:22:10',NULL,'2025-05-12 09:02:47',1,'A'),
(5,'Budget',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(6,'Cash',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(7,'General Services Section',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(8,'Hostel',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(9,'Human Resource Management Section',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(10,'Manila Liaison Office',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(11,'Procurement',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(12,'Property and Supply',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(13,'Records',NULL,2,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(14,'PIMD',NULL,3,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(15,'Planning and Policy Support Section',NULL,3,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(16,'Manila Liaison Office',NULL,3,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(17,'Information and Communication Technology Section','ICTS',3,'ICTS',10,'2024-10-17 14:22:10',NULL,'2025-05-12 21:59:02',1,'A'),
(18,'Monitoring and Business Planning Support Section (MBPSS)',NULL,3,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(19,'Operations',NULL,3,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(20,'KMD',NULL,4,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(21,'Learning Events Coordination Section',NULL,4,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(22,'Applied Communication Section\r\n',NULL,4,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(23,'Animal Breeding and Genomics Section',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:56:26',1,'A'),
(24,'Biosafety and Environment Section',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(25,'Cryo Bank Unit',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(26,'Cryo Bank Unit/ Animal Genetic Resources Section',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(27,'Gene Pool',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(28,'Gene Pool/ Livestock Biotechnology Research & Animal Facility\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(29,'Intecllectual Property and Technology Business Management/ Reproduction and Physiology Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(30,'Livestock Biotechbology Center\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(31,'Livestock Engineering Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(32,'National Dairy Business Hub\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(33,'OIC - Center Director - PCC at MMSU\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(34,'Operations',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(35,'Processing and Marketing Unit/ Carabao-based Enterprise Development Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(36,'Product Development & Innovation Unit\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(37,'Production Systems and Nutrition Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(38,'Reproduction and Physiology Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(39,'Reproduction and Physiology Section/ Semen Bank\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(40,'Socio-Economics and Environmental Research Section\r\n',NULL,5,NULL,NULL,'2024-10-17 14:22:10',NULL,'2024-11-05 13:46:57',1,'A');

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sessions` */

insert  into `sessions`(`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) values 
('1sLoLHOdVhABOufNkntWWznOtRKcLFjLj77kOcut',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiTjFqSlFhNUNnSmFlV1p2aWlIcjFJTzY0Q3prN1hRZDZNbjE4clgySSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814352),
('5x1nsUCTBGVJgybEzYyvbYEWM3ZK38gAaod0cQFF',33,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoia3plcFI1czFYamxaVW5LaVNSV2NlWnNrYmRSeXhjT0tDdTdsVlNjMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MzM7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkakk4dUJudHF6MFBIRDdlNktvNjBrLkV5UDZucFhZU3IzWmxzRmdHcGYwN2RwZzBFZVd4Ti4iO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvc3VtbWFyeSI7fX0=',1748832925),
('ajUYlutKJUAMCX3x7HO7uiYJINIDKVBRup25JrZm',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiSlhqdndpYlh0Vm5sWjh6NXVoYk9YaFVWaXFoc0dQdU5JamNNeG9YdSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1748788101),
('AvxRNHq42QaKN0wWIUwvRCzTF6YlriNDxwzpodKN',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoibzI2bGRPeUY1UkF1bGloSDV0VHk4MDdDNWJaMVFaRzNRVUV4bHFBNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814351),
('CNRX4KpVyAUPAhMxO56yE1D2N24DGSaHdY7WS4iw',32,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNGF6bUNpR2ZsOTA1VFpmTWU2YXhDd0VQN2tTakZwNUNKVmJ2bDhOVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MzI7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkbmxGRlVKdzlRQ2Y5c2hucGYzU2JrLjB5NDAwMVlxTExNTkJIYjJqdG14cTVjY0xrUWxSM0siO30=',1748793607),
('dliJgfcmJX34Hhqb4awxzLhNSrHV1hkua7mC49CU',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiZnlFU2dwanZQMWFlOEFpRkw2bE56RFBOMEp4cXgzcU5Xa1VLNUZ6SiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814350),
('DQmkUNiS1PldmAnWT9DIHluYdI6RosG6ZKu3NCvI',30,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTjdSZFBCa1M3TE9yYUlOQmhwME5LcFh1TmRsYzdwNjR4UzdhRVlIOCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MzA7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkVzdrUDVyUGE4TFdlYmREa3VjWFVYZUMyZ0h1bkguenJMT0dZRlRybnliSklKbjlrQXdMNlMiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvb2JsaWdhdGlvbnJlcXVlc3RzIjt9fQ==',1748793083),
('h3SgExAA6S729MqvBpLfQmAvFYrIPiEW3MS4KrBd',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNVQ1T3pCMm84dlg4OVNEang4OXh5ZHRhYUZhMFBmQ0U0TkU1eldWMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3N1bW1hcnkiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2xvZ2luIjt9fQ==',1748814399),
('jrqefuhkXGxdyYpl4YFKGi4ulTNfXiQ1w6ZRmKkR',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiOEhFdDVYcURhVGF0eFhhOERxQjVKSllWQ2x2RUZaZ0hCWmRzSjNQaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1748832394),
('Jxw84i7xZw0SboDgtMbQZfMId84A5mWUFlyfEWMc',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiNWlXenBCM0RGSVNmd2ZnaktyV09lTE9FNVFER1hGWXcxbk8xMEpiRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814352),
('NCcDKoUsng12rtWrc5xMLazqGjRte2lNYvOWMRBT',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoicGNacnJ2b1BLR3U0SG5MRXdZMjFDQURPN0hDbmVsRTRnTGFNdGhLYSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fX0=',1748832394),
('Q8qZrMFcLYSKq2Dn94bNnUTcMJUL46MGt7E6F368',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiZ0owYllybjlPUEtGc0NBTkttUzJIQnhuajVUZUw4SndIRzBVMzR0TiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814350),
('smlCrCEIC8G5MUxeCm6UxDjRTj2INPF84UFkFTZG',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiMlQxaUdOY0ZZQ2xTTVg5TktYMFl5WEdDT1ZsVE51Y1VqSFlSSzJNcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1749002432),
('T4FWhix95mMdHVYeaQePy4yJDh5p0Ib6AdbmVq3t',33,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQUdwVEpScmUwd3FOT0s0dlJiQkhXWHZPZTlZdlFMZlBXSWJ3UHZmQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MzM7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkakk4dUJudHF6MFBIRDdlNktvNjBrLkV5UDZucFhZU3IzWmxzRmdHcGYwN2RwZzBFZVd4Ti4iO30=',1749004617),
('VIOxTz5BHZGD34PZt0qOOQXcdV1glT93lF1Acjae',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoibUhqZnNUcGFNWFhJV2VwYVV5bkYyYlVBYlV5WXFvcURyNG5kU2NYdCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814351),
('Z1F5CyDRKM8hVT8ELVoEK24mkHc6IxSbgdyoWHry',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaFJaaGdZZHFzb1h0NkhlMlVrZTh4Y3c1U3AwdlBkSUFya0U5R3hJNyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO319',1748814401),
('zCEDJFLxT6JO5d9MPuoKrwR9doOFVeJwqjOlwoVX',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiMXJHVnFNRHR0Ym5Qbk5pSFlZdGV1eFJ0dng2dnVRTDVERDc5V285USI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319fQ==',1748814351);

/*Table structure for table `signatories` */

DROP TABLE IF EXISTS `signatories`;

CREATE TABLE `signatories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `employeeid` int(11) DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employeeid` (`employeeid`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `signatories_ibfk_1` FOREIGN KEY (`employeeid`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `signatories_ibfk_2` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `signatories` */

insert  into `signatories`(`id`,`alias`,`description`,`employeeid`,`locationid`,`status`,`created_at`,`created_by`,`updated_at`,`updated_by`) values 
(1,'ED','Executive Director III',3,1,'A',NULL,NULL,'2025-04-25 08:58:48',1),
(2,'BO','Budget Officer',17,1,'A',NULL,NULL,'2025-04-25 08:58:31',1);

/*Table structure for table `transmittals` */

DROP TABLE IF EXISTS `transmittals`;

CREATE TABLE `transmittals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmittaldate` datetime DEFAULT NULL,
  `serialnumber` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `transmittals` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employeeid` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `areaid` int(11) DEFAULT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `allowmodificationapproval` tinyint(1) DEFAULT '0',
  `allowobligationapproval` tinyint(1) DEFAULT '0',
  `locationid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `employeeid` (`employeeid`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`employeeid`) REFERENCES `employees` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`employeeid`,`email`,`email_verified_at`,`password`,`type`,`areaid`,`two_factor_secret`,`two_factor_recovery_codes`,`two_factor_confirmed_at`,`remember_token`,`created_at`,`updated_at`,`allowmodificationapproval`,`allowobligationapproval`,`locationid`) values 
(1,'MARK BRYAN C. CUARESMA',4,'bryancua024@gmail.com',NULL,'$2y$12$1BfGxmluBvAjVXA5rAp91.inmSSNNhB.lESUhcc6NsuZ0vwFu9TjG','Centef Chief',NULL,NULL,NULL,NULL,NULL,'2024-06-09 12:37:42','2025-05-14 07:28:55',0,0,1),
(30,'MARK BRYAN C. CUARESMA',4,'bryanenduser@gmail.com',NULL,'$2y$12$W7kP5rPa8LWebdDkucXUXeC2gHunH.zrLOGYFTrnybJIJn9kAwL6S','End-user',NULL,NULL,NULL,NULL,NULL,'2025-06-01 22:25:21','2025-06-01 22:25:21',0,0,1),
(31,'MARK BRYAN C. CUARESMA',4,'bryanbudgetoffice@gmail.com',NULL,'$2y$12$.HOFfq/79GpecN9DvLAdweKvfESDchQX9g/1gL885sdTBZgt.5NjK','Budget Office',NULL,NULL,NULL,NULL,NULL,'2025-06-01 22:25:35','2025-06-01 22:25:35',0,0,1),
(32,'MARK BRYAN C. CUARESMA',4,'bryancenterchief@gmail.com',NULL,'$2y$12$nlFFUJw9QCf9shnpf3Sbk.0y4001YqLLMNBHb2jtmxq5ccLkQlR3K','Center Chief',NULL,NULL,NULL,NULL,NULL,'2025-06-01 22:25:57','2025-06-01 22:25:57',0,0,1),
(33,'MARK BRYAN C. CUARESMA',4,'bryanadministrator@gmail.com',NULL,'$2y$12$jI8uBntqz0PHD7e6Ko60k.EyP6npXYSr3ZlsFgGpf07dpg0EeWxN.','Administrator',NULL,NULL,NULL,NULL,NULL,'2025-06-01 22:28:13','2025-06-01 22:28:13',0,0,1);

/* Trigger structure for table `modifications` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `b4insertmodifications` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `b4insertmodifications` BEFORE INSERT ON `modifications` FOR EACH ROW BEGIN
DECLARE maxserial VARCHAR(50);
	
	DECLARE startdate DATETIME;
	DECLARE enddate DATETIME;
	SET startdate = DATE_FORMAT(NOW(),'%Y-%m-01 00:00:00');
	SET enddate = DATE_FORMAT(LAST_DAY(NOW()),'%Y-%m-%d 23:59:59');
	
	
	set maxserial = (SELECT IFNULL(RIGHT(MAX(serialnumber),4),0) + 1 
	FROM `modifications` 
	WHERE created_at 
	BETWEEN startdate AND enddate AND serialnumber LIKE '%-%'
	and fundid = NEW.fundid and locationid = NEW.locationid);
	
	SET NEW.serialnumber = CONCAT(DATE_FORMAT(NOW(),'%Y-%m-'),LPAD(maxserial,4,'0'));
	
    
    END */$$


DELIMITER ;

/* Trigger structure for table `obligationrequests` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `b4insertobligations` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `b4insertobligations` BEFORE INSERT ON `obligationrequests` FOR EACH ROW BEGIN
DECLARE maxserial VARCHAR(50);
	
	
	
	SET maxserial = (SELECT IFNULL(RIGHT(MAX(serialnumber),4),0) + 1 FROM `obligationrequests` 
	WHERE serialnumber LIKE '%-%' and fundid = NEW.fundid and locationid= New.locationid and DATE_FORMAT(dateofrequest,'%Y-%m') = date_FORMAT(NEW.dateofrequest,'%Y-%m'));
	
	SET NEW.serialnumber = CONCAT(DATE_FORMAT(NOW(),'%Y-%m-'),LPAD(maxserial,4,'0'));
	
    
    END */$$


DELIMITER ;

/* Function  structure for function  `getallotmentamountperfundsectiondate` */

/*!50003 DROP FUNCTION IF EXISTS `getallotmentamountperfundsectiondate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getallotmentamountperfundsectiondate`(p_fundid INT(11),p_date DATETIME,p_sectionid INT(11)) RETURNS double
BEGIN
	DECLARE amt DOUBLE;
    	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');
    
	SELECT 
	SUM(amount) into amt
	FROM `allotments` 
	WHERE fundid  = p_fundid and sectionid = p_sectionid
	AND allotments.`status` = 'A' AND created_at  <= p_date;
	
	
	return amt;
	
    END */$$
DELIMITER ;

/* Function  structure for function  `getallotmentobligationtotal` */

/*!50003 DROP FUNCTION IF EXISTS `getallotmentobligationtotal` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getallotmentobligationtotal`(p_papid int(11),p_expenselineitemid int(11),p_sectionid int(11),p_fundid int(11)) RETURNS double
BEGIN

declare total double;
    
 SELECT SUM(IFNULL(obligationrequestparticulars.amount,0)) into total 
FROM `obligationrequestparticulars` 
LEFT JOIN `obligationrequests` ON obligationrequestparticulars.`obligationrequestid` = obligationrequests.`id`
WHERE papid=p_papid AND expenselineitemid = p_expenselineitemid  AND obligationrequestparticulars.sectionid = p_sectionid AND fundid = p_fundid
AND obligationrequestparticulars.`status` = 'A' AND obligationrequests.`status` = 'A';
return total;
    END */$$
DELIMITER ;

/* Function  structure for function  `getemployeename` */

/*!50003 DROP FUNCTION IF EXISTS `getemployeename` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getemployeename`(p_id INT, p_format CHAR(5)) RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
    DECLARE fullname TEXT;
    
    IF p_format = 'fl' THEN
        SET fullname = (
            SELECT UPPER(CONCAT(
                e.firstname, ' ',
                IF(e.middlename IS NULL OR TRIM(e.middlename) = '', '', CONCAT(LEFT(e.middlename, 1), '. ')),
                e.lastname,
                IF(e.suffix IS NULL OR TRIM(e.suffix) = '', '', CONCAT(' ', e.suffix))
            ))
            FROM employees e
            WHERE e.id = p_id
        );
    ELSE
        SET fullname = (
            SELECT CONCAT(
                e.lastname,
                IF(e.suffix IS NULL OR TRIM(e.suffix) = '', '', CONCAT(' ', e.suffix)),
                ', ', e.firstname, ' ',
                IF(e.middlename IS NULL OR TRIM(e.middlename) = '', '', CONCAT(LEFT(e.middlename, 1), '.'))
            )
            FROM employees e
            WHERE e.id = p_id
        );
    END IF;
    
    RETURN fullname;
END */$$
DELIMITER ;

/* Function  structure for function  `getfunddisbursedamount` */

/*!50003 DROP FUNCTION IF EXISTS `getfunddisbursedamount` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` FUNCTION `getfunddisbursedamount`(p_fundid int(11)) RETURNS double
BEGIN
declare amt double;
set amt  =0;
	SELECT SUM(a.amount) into amt
	FROM obligationpayments a
	LEFT JOIN obligationrequests b ON a.obligationrequestid = b.id
	WHERE a.status = 'A' AND b.status = 'A'
	AND fundid=p_fundid;
return amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getfunddisbursedamountperdate` */

/*!50003 DROP FUNCTION IF EXISTS `getfunddisbursedamountperdate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getfunddisbursedamountperdate`(p_fundid INT(11),p_date DATETIME) RETURNS double
BEGIN
	DECLARE amt DOUBLE;
	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');	
	set amt  =0;
	
		SELECT SUM(a.amount) INTO amt
		FROM obligationpayments a
		LEFT JOIN obligationrequests b ON a.obligationrequestid = b.id
		WHERE a.status = 'A' AND b.status = 'A'
		AND fundid=p_fundid
		AND a.dateofcheck <= p_date;
	
		
	return amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getfundutilization` */

/*!50003 DROP FUNCTION IF EXISTS `getfundutilization` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` FUNCTION `getfundutilization`(p_fundid int(11)) RETURNS double
BEGIN
    
    declare amt double;
    
    SELECT SUM(a.`amount`) into amt FROM obligationrequestparticulars a 
LEFT JOIN  obligationrequests b ON a.`obligationrequestid` = b.id
WHERE a.`status` = 'A' AND b.`status` = 'A'
AND b.`fundid` = p_fundid 
GROUP BY (b.fundid);
return amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getfundutilizationperdate` */

/*!50003 DROP FUNCTION IF EXISTS `getfundutilizationperdate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getfundutilizationperdate`(p_fundid int(11),p_date datetime) RETURNS double
BEGIN
	DECLARE amt DOUBLE;
	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');
	
	SELECT SUM(a.`amount`) INTO amt FROM obligationrequestparticulars a 
	LEFT JOIN  obligationrequests b ON a.`obligationrequestid` = b.id
	WHERE a.`status` = 'A' AND b.`status` = 'A'
	AND b.`fundid` = p_fundid AND dateofrequest <= p_date
	and b.datecertifiedb is not null
	GROUP BY (b.fundid);
	
	
	
	RETURN amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getobligationamountperfundsectiondate` */

/*!50003 DROP FUNCTION IF EXISTS `getobligationamountperfundsectiondate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getobligationamountperfundsectiondate`(p_fundid int(11),p_date datetime,p_sectionid int(11)) RETURNS double
BEGIN
	declare amt double;
    	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');
	SELECT 
	SUM(obligationrequestparticulars.amount) into amt
	FROM `obligationrequestparticulars` 
	LEFT JOIN `obligationrequests` ON obligationrequestparticulars.`obligationrequestid` = `obligationrequests`.`id`
	WHERE obligationrequests.`fundid`= p_fundid
	AND obligationrequestparticulars.`status` = 'A' AND obligationrequests.`dateofrequest`  <= p_date
	and obligationrequestparticulars.`sectionid` = p_sectionid;
	return amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getobligationamountpersectionandfund` */

/*!50003 DROP FUNCTION IF EXISTS `getobligationamountpersectionandfund` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getobligationamountpersectionandfund`(p_fundid int(11),p_date datetime,p_sectionid int(11)) RETURNS double
BEGIN
	declare amt double;
    	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');
	SELECT 
	SUM(obligationrequestparticulars.amount) into amt
	FROM `obligationrequestparticulars` 
	LEFT JOIN `obligationrequests` ON obligationrequestparticulars.`obligationrequestid` = `obligationrequests`.`id`
	WHERE obligationrequests.`fundid`= p_fundid
	AND obligationrequestparticulars.`status` = 'A' AND obligationrequests.`dateofrequest`  <= p_date
	and obligationrequestparticulars.`sectionid` = p_sectionid;
	return amt;
    END */$$
DELIMITER ;

/* Function  structure for function  `getusernamebyid` */

/*!50003 DROP FUNCTION IF EXISTS `getusernamebyid` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `getusernamebyid`(emp_id INT) RETURNS varchar(255) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
    DECLARE user_name VARCHAR(255);
    SELECT name INTO user_name FROM users WHERE employeeid = emp_id LIMIT 1;
    RETURN user_name;
END */$$
DELIMITER ;

/* Function  structure for function  `getutilizationperfundpap` */

/*!50003 DROP FUNCTION IF EXISTS `getutilizationperfundpap` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` FUNCTION `getutilizationperfundpap`(p_fundid int(11),p_papid int(11)) RETURNS double
BEGIN
    
declare totalamount double;
set totalamount = 0;
SELECT SUM(a.`amount`) into totalamount FROM obligationrequestparticulars a 
LEFT JOIN  obligationrequests b ON a.`obligationrequestid` = b.id
LEFT JOIN paps c ON a.`papid` = c.`id`
WHERE a.`status` = 'A' AND b.`status` = 'A'
AND b.`fundid` = p_fundid AND a.`papid` = p_papid
GROUP BY (papid);
return totalamount;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_fundallotment` */

/*!50003 DROP FUNCTION IF EXISTS `get_fundallotment` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_fundallotment`(p_fundid int(11)) RETURNS double
BEGIN
declare allotmentvalue double;
SELECT SUM(allotments.`amount`) into allotmentvalue from allotments where fundid = p_fundid and status='A';
    
return allotmentvalue;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_fundallotmentperfundandpap` */

/*!50003 DROP FUNCTION IF EXISTS `get_fundallotmentperfundandpap` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_fundallotmentperfundandpap`(p_fundid int(11),p_papid int(11)) RETURNS double
BEGIN
	declare returnvalue double;
	select SUM(amount) INTO returnvalue from allotments  where fundid=p_fundid and papid=p_papid and status= 'A';
	return returnvalue;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_funddisbursements` */

/*!50003 DROP FUNCTION IF EXISTS `get_funddisbursements` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_funddisbursements`(p_fundid INT(11)) RETURNS double
BEGIN
DECLARE returnvalue DOUBLE;
SELECT SUM(a.amount) INTO returnvalue FROM `obligationpayments` a 
LEFT JOIN `obligationrequests` b ON a.obligationrequestid = b.id
WHERE a.status = 'A' AND b.status = 'A'
AND b.fundid = p_fundid;
RETURN returnvalue;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_funddisbursementsv1` */

/*!50003 DROP FUNCTION IF EXISTS `get_funddisbursementsv1` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_funddisbursementsv1`(p_fundid int(11)) RETURNS double
BEGIN
    
    declare total double;
    
    select SUM(a.amount) into total
    from `obligationparticularpayments` a 
    left join `obligationrequestparticulars` b on a.`obligationrequestparticularid` = b.id
    left join `obligationrequests` c on b.`obligationrequestid` = c.id
    where a.status = 'A' and b.status = 'A' and c.status = 'A'
    and c.fundid = p_fundid;
    
    return total;

    END */$$
DELIMITER ;

/* Function  structure for function  `get_fundobligationamount` */

/*!50003 DROP FUNCTION IF EXISTS `get_fundobligationamount` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_fundobligationamount`(p_fundid INT(11)) RETURNS double
BEGIN
DECLARE returnvalue DOUBLE;
Select SUM(b.amount) into returnvalue from `obligationrequests` a 
left join `obligationrequestparticulars` b on a.id = b.`obligationrequestid`
where a.status = 'A' and b.status = 'A'
and a.fundid = p_fundid;
return returnvalue;
    END */$$
DELIMITER ;

/* Function  structure for function  `get_obligationtotalamount` */

/*!50003 DROP FUNCTION IF EXISTS `get_obligationtotalamount` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `get_obligationtotalamount`(p_obligationid int(11)) RETURNS double
BEGIN
    
    
    
    return (SELECT SUM(IFNULL(amount,0)) from `obligationrequestparticulars` where status='A' and obligationrequestid =p_obligationid );
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getallfundvalues` */

/*!50003 DROP PROCEDURE IF EXISTS  `getallfundvalues` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` PROCEDURE `getallfundvalues`()
BEGIN
	SELECT 
	SUM(Report.fundamount) AS fundamount,
	SUM(Report.obligated) AS obligated,
	SUM(Report.disbursed) AS disbursed,
	(SUM(Report.fundamount) - SUM(Report.obligated)) AS unlobligated,
	(SUM(Report.obligated) / SUM(Report.fundamount) )   AS utilizationrate,
	(SUM(Report.disbursed)/SUM(Report.obligated))	AS disbursementrate
	 FROM (
	
	SELECT 
	a.`fund` AS fundname,
	a.amount AS fundamount,
	getfundutilization(a.`id`) AS obligated,
	getfunddisbursedamount(a.id) AS disbursed
		
	FROM funds a
	WHERE a.status = 'A'
	GROUP BY (a.`id`)
	) AS Report;
	
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getdashboardfundtotals` */

/*!50003 DROP PROCEDURE IF EXISTS  `getdashboardfundtotals` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getdashboardfundtotals`(p_fundid varchar(100),p_date datetime)
BEGIN
	
	SET p_date = DATE_FORMAT(p_date,'%Y-%m-%d 23:59:59');	
	
	SELECT 
	Report.*,
	(Report.fundamount - Report.obligated) AS unlobligated,
	(Report.obligated / Report.fundamount)   AS utilizationrate,
	(Report.disbursed/ Report.obligated)	AS disbursementrate
	 FROM (
	
	SELECT 
	a.fund AS fundname,
	a.amount AS fundamount,
	getfundutilizationperdate(a.id,p_date) AS obligated,
	getfunddisbursedamountperdate(a.id,p_date) AS disbursed
		
	FROM funds a
	WHERE a.id = (p_fundid)
	GROUP BY (a.id)
	
	) AS Report;
	
	
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getdashboardutilizationrateperregionalcenter` */

/*!50003 DROP PROCEDURE IF EXISTS  `getdashboardutilizationrateperregionalcenter` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` PROCEDURE `getdashboardutilizationrateperregionalcenter`()
BEGIN
	
	
	   
/*    
utilization  = utilization/allotment    
*/
    
SELECT Report.id,Report.section, Report.totalutilization as utilizationrate  
/*IFNULL(Report.totalutilization/Report.totalallotments,0) AS utilizationrate */
FROM (
SELECT 
a.id,
a.`section`,
(SELECT IFNULL(SUM(IFNULL(aa.amount,0)),0) 
FROM obligationrequestparticulars aa 
LEFT JOIN  obligationrequests bb ON aa.`obligationrequestid` = bb.id
WHERE 
bb.sectionid = a.id
AND aa.`status` = 'A' 
AND bb.`status` = 'A')  AS totalutilization,
(SELECT IFNULL(SUM(IFNULL(amount,0)),0) FROM allotments WHERE sectionid=a.id AND STATUS='A') AS totalallotments
FROM sections a
LEFT JOIN divisions b ON a.`divisionid` = b.`id`
WHERE b.isregional = 1
AND a.`status` = 'A') AS Report;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getfundclustervaluesgroupbypap` */

/*!50003 DROP PROCEDURE IF EXISTS  `getfundclustervaluesgroupbypap` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` PROCEDURE `getfundclustervaluesgroupbypap`(p_fundid int(11))
BEGIN
Select Report.*,
(Report.allotment - Report.utilization)  AS unobligatedallotment,
0 AS unobligatedobligation,
(Report.utilization/Report.allotment) AS utilizationrate,
0 AS disbursementrate
FROM (
SELECT 
a.id as fundid,
a.fund AS fundname,
c.pap AS pap,
SUM(b.amount) AS allotment,
SUM(`getutilizationperfundpap`(a.id,b.papid)) AS utilization,
0 AS disbursement
FROM funds a
LEFT JOIN allotments b ON a.id = b.fundid
LEFT JOIN paps c ON b.papid = c.id
WHERE a.status= 'A'
AND b.status = 'A'
and a.id = p_fundid
GROUP BY (b.papid)
) as Report;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getindividualfundvalues` */

/*!50003 DROP PROCEDURE IF EXISTS  `getindividualfundvalues` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` PROCEDURE `getindividualfundvalues`(p_fundid INT(11))
BEGIN
	SELECT 
	Report.*,
	(Report.fundamount - Report.obligated) AS unlobligated,
	(Report.obligated / Report.fundamount)   AS utilizationrate,
	(Report.disbursed/ Report.obligated)	AS disbursementrate
	 FROM (
	
	SELECT 
	a.`fund` AS fundname,
	a.amount AS fundamount,
	getfundutilization(a.`id`) AS obligated,
	getfunddisbursedamount(a.id) AS disbursed
		
	FROM funds a
	WHERE a.id = p_fundid
	GROUP BY (a.`id`)
	
	) AS Report;
	
	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getobligationlist` */

/*!50003 DROP PROCEDURE IF EXISTS  `getobligationlist` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getobligationlist`(p_fundids text)
BEGIN
SELECT 
a.dateofrequest,
CONCAT(a.serialnumber,' ',IFNULL(a.serialsuffix,'')) AS serialnumber,
d.fund,
e.payee,
getemployeename(a.certifieda,'lf') AS requestor,
getemployeename(a.certifiedb,'lf') AS approver,
f.orsstatuslist AS orsstatuslist,
b.particular,
IFNULL(g.acronym,g.section) AS section,
IFNULL(h.acronym,h.pap) AS pap,
i.expenselineitem AS expenselineitem,
b.amount,
SUM(c.amount) totalpaid


FROM obligationrequests a 
LEFT JOIN obligationrequestparticulars b ON a.id = b.obligationrequestid AND b.status = 'A'
LEFT JOIN obligationparticularpayments c ON b.id = c.obligationrequestparticularid AND c.status = 'A'
LEFT JOIN funds d ON a.fundid = d.id
LEFT JOIN payees e ON a.payeeid = e.id
LEFT JOIN orsstatuslists f ON a.orsstatuslistid = f.id
LEFT JOIN sections g ON b.sectionid = g.id
LEFT JOIN paps h ON b.papid = h.id
LEFT JOIN expenselineitems i ON b.expenselineitemid = i.id

WHERE a.status = 'A'
/*AND a.fundid IN (p_fundids)*/
and FIND_IN_SET(a.fundid, p_fundids)

GROUP BY (b.id);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getobligationlistv1` */

/*!50003 DROP PROCEDURE IF EXISTS  `getobligationlistv1` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `getobligationlistv1`(p_fundids TEXT)
BEGIN
	
	  SET @sql = CONCAT(
        'SELECT 
        b.id,
a.dateofrequest,
CONCAT(a.serialnumber," ",IFNULL(a.serialsuffix,"")) AS serialnumber,
d.fund,
e.payee,
getemployeename(a.certifieda,"lf") AS requestor,
getemployeename(a.certifiedb,"lf") AS approver,
f.orsstatuslist AS orsstatuslist,
b.particular,
IFNULL(g.acronym,g.section) AS section,
IFNULL(h.acronym,h.pap) AS pap,
i.expenselineitem AS expenselineitem,
b.amount,
SUM(c.amount) totalpaid


FROM obligationrequests a 
LEFT JOIN obligationrequestparticulars b ON a.id = b.obligationrequestid AND b.status = "A"
LEFT JOIN obligationparticularpayments c ON b.id = c.obligationrequestparticularid AND c.status = "A"
LEFT JOIN funds d ON a.fundid = d.id
LEFT JOIN payees e ON a.payeeid = e.id
LEFT JOIN orsstatuslists f ON a.orsstatuslistid = f.id
LEFT JOIN sections g ON b.sectionid = g.id
LEFT JOIN paps h ON b.papid = h.id
LEFT JOIN expenselineitems i ON b.expenselineitemid = i.id',

 ' WHERE a.status = "A" and b.id is not null AND a.fundid IN (', p_fundids, ') ',
        'GROUP BY b.id'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    
    

	END */$$
DELIMITER ;

/* Procedure structure for procedure `getselectedfundvalues` */

/*!50003 DROP PROCEDURE IF EXISTS  `getselectedfundvalues` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`u304265598_root_ubring`@`%` PROCEDURE `getselectedfundvalues`(p_fundids text)
BEGIN
	SELECT 
	Report.*,
	(Report.fundamount - Report.obligated) AS unlobligated,
	(Report.obligated / Report.fundamount)   AS utilizationrate,
	(Report.disbursed/ Report.obligated)	AS disbursementrate
	 FROM (
	
	SELECT 
	a.`fund` AS fundname,
	a.amount AS fundamount,
	getfundutilization(a.`id`) AS obligated,
	getfunddisbursedamount(a.id) AS disbursed
		
	FROM funds a
	WHERE a.id in (p_fundids)
	GROUP BY (a.`id`)
	
	) AS Report;
	
	
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
