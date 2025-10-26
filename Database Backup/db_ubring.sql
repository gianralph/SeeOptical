/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.27-log : Database - db_ubring
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_ubring` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_ubring`;

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
('f5c18213353b251d746113212952894b','i:1;',1732762477),
('f5c18213353b251d746113212952894b:timer','i:1732762477;',1732762477);

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
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `divisions` */

insert  into `divisions`(`id`,`division`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'OED/ODED','2024-10-17 11:39:00',NULL,NULL,NULL,'A'),
(2,'AFMD','2024-10-17 11:39:02',NULL,NULL,NULL,'A'),
(3,'PIMD','2024-10-17 11:39:05',NULL,NULL,NULL,'A'),
(4,'KMD','2024-10-17 11:39:07',NULL,NULL,NULL,'A'),
(5,'RDD','2024-10-17 11:39:07',NULL,NULL,NULL,'I'),
(6,'Regional Centers','2024-10-17 11:39:07',NULL,'2024-11-05 13:37:35',1,'A'),
(7,'Tests','2024-10-17 11:45:57',1,'2024-10-17 11:57:15',1,'I');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `employees` */

insert  into `employees`(`id`,`firstname`,`middlename`,`lastname`,`suffix`,`position`,`sectionid`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'Mary Lei','B','Bautista',NULL,'Administrative Officer IV',12,NULL,NULL,'2024-06-30 12:54:24',1,'A'),
(2,'Limuel','Belda','Villasor',NULL,'Administrative Officer III',12,'2024-06-12 13:39:26',1,'2024-06-12 13:39:26',1,'A'),
(3,'Liza','G','Battad',NULL,'Executive Director III',1,'2024-06-30 12:53:32',1,'2024-06-30 12:53:32',1,'A'),
(4,'Mark Bryan','Cabuena','Cuaresma',NULL,'CMT II',17,'2024-07-18 07:04:50',1,'2024-10-09 13:48:27',1,'A'),
(8,'Darrel Jed','Calica','Costales',NULL,NULL,NULL,'2024-10-26 23:51:57',NULL,'2024-10-26 23:51:57',1,'A'),
(9,NULL,NULL,NULL,NULL,NULL,NULL,'2024-10-27 12:06:12',NULL,'2024-10-27 12:06:12',1,'A'),
(10,'Mark Bryan',NULL,'Cuaresma',NULL,NULL,NULL,'2024-10-27 22:34:57',NULL,'2024-10-27 22:34:57',1,'A'),
(11,'Mary Lei',NULL,'Balajadia',NULL,NULL,NULL,'2024-10-27 22:34:57',NULL,'2024-10-27 22:34:57',1,'A'),
(12,'Alexis Joy','Martinez','Cuaresma',NULL,NULL,NULL,'2024-10-28 21:38:51',NULL,'2024-10-28 21:38:51',1,'A'),
(13,'test','test','Test',NULL,NULL,2,'2024-11-28 10:56:47',1,'2024-11-28 10:56:47',1,'A');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `jobs` */

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

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',1,'web','8f7d257bd8359aa0a07e127ad713a121a63bb7850ce97fc4b1e66cab20ae12f1','[\"*\"]','2024-11-28 10:45:19',NULL,'2024-11-28 10:43:58','2024-11-28 10:45:19'),
(2,'App\\Models\\User',1,'web','93d2be40018f60e1862715d313f74d687027986ffc59f96b3de141d2835ce024','[\"*\"]','2024-11-28 10:57:53',NULL,'2024-11-28 10:53:36','2024-11-28 10:57:53');

/*Table structure for table `sections` */

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(100) DEFAULT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `divisionid` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `divisionid` (`divisionid`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`divisionid`) REFERENCES `divisions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `sections` */

insert  into `sections`(`id`,`section`,`alias`,`divisionid`,`created_at`,`created_by`,`updated_at`,`updated_by`,`status`) values 
(1,'Office of the Executive Director',NULL,1,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(2,'Office of the Deputy Executive Director',NULL,1,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(3,'Internal Audit Section',NULL,1,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(4,'Accounting\r\n',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:56:32',1,'A'),
(5,'Budget',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(6,'Cash',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(7,'General Services Section',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(8,'Hostel',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(9,'Human Resource Management Section',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(10,'Manila Liaison Office',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(11,'Procurement',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(12,'Property and Supply',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(13,'Records',NULL,2,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(14,'PIMD',NULL,3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(15,'Planning and Policy Support Section',NULL,3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(16,'Manila Liaison Office',NULL,3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(17,'Information and Communication Technology Section','ICTS',3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(18,'Monitoring and Business Planning Support Section (MBPSS)',NULL,3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(19,'Operations',NULL,3,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(20,'KMD',NULL,4,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(21,'Learning Events Coordination Section',NULL,4,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(22,'Applied Communication Section\r\n',NULL,4,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(23,'Animal Breeding and Genomics Section',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:56:26',1,'A'),
(24,'Biosafety and Environment Section',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(25,'Cryo Bank Unit',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(26,'Cryo Bank Unit/ Animal Genetic Resources Section',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(27,'Gene Pool',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(28,'Gene Pool/ Livestock Biotechnology Research & Animal Facility\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(29,'Intecllectual Property and Technology Business Management/ Reproduction and Physiology Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(30,'Livestock Biotechbology Center\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(31,'Livestock Engineering Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(32,'National Dairy Business Hub\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(33,'OIC - Center Director - PCC at MMSU\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(34,'Operations',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(35,'Processing and Marketing Unit/ Carabao-based Enterprise Development Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(36,'Product Development & Innovation Unit\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(37,'Production Systems and Nutrition Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(38,'Reproduction and Physiology Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(39,'Reproduction and Physiology Section/ Semen Bank\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'A'),
(40,'Socio-Economics and Environmental Research Section\r\n',NULL,5,'2024-10-17 14:22:10',NULL,'2024-11-05 13:46:57',1,'A'),
(41,NULL,NULL,5,'2024-10-17 14:22:10',NULL,'2024-10-17 14:22:29',NULL,'I');

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
('ro8ngx2VdA1UozpKiQEzWfEi1Mmbvkfz8m9smcZ8',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YToyOntzOjY6Il90b2tlbiI7czo0MDoiVUtIUEY5UXhPaWtWTGNpa2syVHU5cjgwYnhQN1hYa3BNMWxINmJpSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1732762697);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employeeid` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `areaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `employeeid` (`employeeid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`employeeid`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`employeeid`,`email`,`email_verified_at`,`password`,`two_factor_secret`,`two_factor_recovery_codes`,`two_factor_confirmed_at`,`remember_token`,`created_at`,`updated_at`,`type`,`areaid`) values 
(1,'Administrator',4,'bryancua024@gmail.com',NULL,'$2y$12$1BfGxmluBvAjVXA5rAp91.inmSSNNhB.lESUhcc6NsuZ0vwFu9TjG',NULL,NULL,NULL,NULL,'2024-06-09 12:37:42','2024-10-19 15:05:56','Administrator',NULL),
(2,'DARREL JED C. COSTALES',8,'djedcostales@gmail.com',NULL,'$2y$12$xTYSSK1Vq80yuW8IXOdA1uAi/C07FgxKIDP250El9FdCXSSywvP3q',NULL,NULL,NULL,NULL,'2024-07-19 03:58:34','2024-10-28 21:33:00','User',NULL);

/* Function  structure for function  `getemployeename` */

/*!50003 DROP FUNCTION IF EXISTS `getemployeename` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getemployeename`(p_id INTEGER,p_format CHAR(5)) RETURNS text CHARSET latin1
BEGIN
    DECLARE fullname TEXT;
	
	IF p_format = 'fl' THEN
	SET fullname = (SELECT UPPER(CONCAT(e.firstname,' ', IF(e.middlename IS NULL OR TRIM(e.middlename ) = '','',CONCAT(LEFT(e.middlename,1),'. ')),e.lastname,IF(e.suffix IS NULL OR TRIM(e.suffix) = '','',CONCAT(' ',e.suffix))))
	FROM employees e
	WHERE e.id = p_id);
	ELSE
	SET fullname = (SELECT 
	CONCAT(
            e.lastname,
            IF(e.suffix IS NULL OR TRIM(e.suffix) = '','',CONCAT(' ',e.suffix))
            ,', ', e.firstname, ' ', 
            IF(e.middlename IS NULL OR TRIM(e.middlename) = '','',CONCAT(LEFT(e.middlename,1),'.')))
	FROM employees e
	WHERE e.id = p_id);
	END IF;
	
	
	RETURN fullname;

    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
