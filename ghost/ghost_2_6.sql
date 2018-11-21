# ************************************************************
# Sequel Pro SQL dump
# Version 4529
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.22)
# Database: ghost
# Generation Time: 2018-11-20 21:24:00 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table accesstokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accesstokens`;

CREATE TABLE `accesstokens` (
  `id` varchar(24) NOT NULL,
  `token` varchar(191) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `issued_by` varchar(24) DEFAULT NULL,
  `expires` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accesstokens_token_unique` (`token`),
  KEY `accesstokens_user_id_foreign` (`user_id`),
  KEY `accesstokens_client_id_foreign` (`client_id`),
  CONSTRAINT `accesstokens_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `accesstokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table api_keys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_keys`;

CREATE TABLE `api_keys` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `role_id` varchar(24) DEFAULT NULL,
  `integration_id` varchar(24) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `last_seen_version` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_secret_unique` (`secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table app_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_fields`;

CREATE TABLE `app_fields` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'html',
  `app_id` varchar(24) NOT NULL,
  `relatable_id` varchar(24) NOT NULL,
  `relatable_type` varchar(50) NOT NULL DEFAULT 'posts',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_fields_app_id_foreign` (`app_id`),
  CONSTRAINT `app_fields_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table app_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_settings`;

CREATE TABLE `app_settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `app_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_settings_key_unique` (`key`),
  KEY `app_settings_app_id_foreign` (`app_id`),
  CONSTRAINT `app_settings_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table apps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `apps`;

CREATE TABLE `apps` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `version` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'inactive',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apps_name_unique` (`name`),
  UNIQUE KEY `apps_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table brute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `brute`;

CREATE TABLE `brute` (
  `key` varchar(191) NOT NULL,
  `firstRequest` bigint(20) NOT NULL,
  `lastRequest` bigint(20) NOT NULL,
  `lifetime` bigint(20) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `brute` WRITE;
/*!40000 ALTER TABLE `brute` DISABLE KEYS */;

INSERT INTO `brute` (`key`, `firstRequest`, `lastRequest`, `lifetime`, `count`)
VALUES
	('oHUubZQTM66eOWJCFaoi+8dO/eXPG5zwBOW8P5YAuKM=',1542196535788,1542196535788,1542200135796,1);

/*!40000 ALTER TABLE `brute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table client_trusted_domains
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_trusted_domains`;

CREATE TABLE `client_trusted_domains` (
  `id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `trusted_domain` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_trusted_domains_client_id_foreign` (`client_id`),
  CONSTRAINT `client_trusted_domains_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `redirection_uri` varchar(2000) DEFAULT NULL,
  `client_uri` varchar(2000) DEFAULT NULL,
  `auth_uri` varchar(2000) DEFAULT NULL,
  `logo` varchar(2000) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'development',
  `type` varchar(50) NOT NULL DEFAULT 'ua',
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_name_unique` (`name`),
  UNIQUE KEY `clients_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;

INSERT INTO `clients` (`id`, `uuid`, `name`, `slug`, `secret`, `redirection_uri`, `client_uri`, `auth_uri`, `logo`, `status`, `type`, `description`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5bebfe67b1a9c511638ce010','c7b4275a-fc3f-4247-a3ab-6b353a409ad0','Ghost Admin','ghost-admin','14cf1314ae3b',NULL,NULL,NULL,NULL,'enabled','ua',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce011','9bebc22b-0f4a-41b5-9734-c5e932684125','Ghost Frontend','ghost-frontend','7f81acfd6c00',NULL,NULL,NULL,NULL,'enabled','ua',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce012','aa35a3d0-5708-4c3d-a7fd-d4f46e09c700','Ghost Scheduler','ghost-scheduler','cedd87fab08c',NULL,NULL,NULL,NULL,'enabled','web',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce013','736fcad7-8cbb-4db5-a88e-0684c218c2ba','Ghost Backup','ghost-backup','3e3e7327a016',NULL,NULL,NULL,NULL,'enabled','web',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1');

/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table integrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `integrations`;

CREATE TABLE `integrations` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `icon_image` varchar(2000) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `integrations_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table invites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `invites`;

CREATE TABLE `invites` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `token` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `expires` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invites_token_unique` (`token`),
  UNIQUE KEY `invites_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `version` varchar(70) NOT NULL,
  `currentVersion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_name_version_unique` (`name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `name`, `version`, `currentVersion`)
VALUES
	(1,'1-create-tables.js','init','2.6'),
	(2,'2-create-fixtures.js','init','2.6'),
	(3,'1-post-excerpt.js','1.3','2.6'),
	(4,'1-codeinjection-post.js','1.4','2.6'),
	(5,'1-og-twitter-post.js','1.5','2.6'),
	(6,'1-add-backup-client.js','1.7','2.6'),
	(7,'1-add-permissions-redirect.js','1.9','2.6'),
	(8,'1-custom-template-post.js','1.13','2.6'),
	(9,'2-theme-permissions.js','1.13','2.6'),
	(10,'1-add-webhooks-table.js','1.18','2.6'),
	(11,'1-webhook-permissions.js','1.19','2.6'),
	(12,'1-remove-settings-keys.js','1.20','2.6'),
	(13,'1-add-contributor-role.js','1.21','2.6'),
	(14,'1-multiple-authors-DDL.js','1.22','2.6'),
	(15,'1-multiple-authors-DML.js','1.22','2.6'),
	(16,'1-update-koenig-beta-html.js','1.25','2.6'),
	(17,'2-demo-post.js','1.25','2.6'),
	(18,'1-rename-amp-column.js','2.0','2.6'),
	(19,'2-update-posts.js','2.0','2.6'),
	(20,'3-remove-koenig-labs.js','2.0','2.6'),
	(21,'4-permalink-setting.js','2.0','2.6'),
	(22,'5-remove-demo-post.js','2.0','2.6'),
	(23,'6-replace-fixture-posts.js','2.0','2.6'),
	(24,'1-add-sessions-table.js','2.2','2.6'),
	(25,'2-add-integrations-and-api-key-tables.js','2.2','2.6'),
	(26,'3-insert-admin-integration-role.js','2.2','2.6'),
	(27,'4-insert-integration-and-api-key-permissions.js','2.2','2.6'),
	(28,'5-add-mobiledoc-revisions-table.js','2.2','2.6'),
	(29,'1-add-webhook-columns.js','2.3','2.6'),
	(30,'2-add-webhook-edit-permission.js','2.3','2.6'),
	(31,'1-add-webhook-permission-roles.js','2.6','2.6');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations_lock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations_lock`;

CREATE TABLE `migrations_lock` (
  `lock_key` varchar(191) NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `acquired_at` datetime DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  UNIQUE KEY `migrations_lock_lock_key_unique` (`lock_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `migrations_lock` WRITE;
/*!40000 ALTER TABLE `migrations_lock` DISABLE KEYS */;

INSERT INTO `migrations_lock` (`lock_key`, `locked`, `acquired_at`, `released_at`)
VALUES
	('km01',0,'2018-11-14 10:52:15','2018-11-14 10:52:29');

/*!40000 ALTER TABLE `migrations_lock` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mobiledoc_revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mobiledoc_revisions`;

CREATE TABLE `mobiledoc_revisions` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `mobiledoc` longtext,
  `created_at_ts` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mobiledoc_revisions_post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `object_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;

INSERT INTO `permissions` (`id`, `name`, `object_type`, `action_type`, `object_id`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5bebfe67b1a9c511638ce01a','Export database','db','exportContent',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce01b','Import database','db','importContent',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce01c','Delete all content','db','deleteAllContent',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce01d','Send mail','mail','send',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce01e','Browse notifications','notification','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce01f','Add notifications','notification','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce020','Delete notifications','notification','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce021','Browse posts','post','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce022','Read posts','post','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce023','Edit posts','post','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce024','Add posts','post','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce025','Delete posts','post','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce026','Browse settings','setting','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce027','Read settings','setting','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce028','Edit settings','setting','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce029','Generate slugs','slug','generate',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02a','Browse tags','tag','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02b','Read tags','tag','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02c','Edit tags','tag','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02d','Add tags','tag','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02e','Delete tags','tag','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce02f','Browse themes','theme','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce030','Edit themes','theme','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce031','Activate themes','theme','activate',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce032','Upload themes','theme','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce033','Download themes','theme','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce034','Delete themes','theme','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce035','Browse users','user','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce036','Read users','user','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce037','Edit users','user','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce038','Add users','user','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce039','Delete users','user','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03a','Assign a role','role','assign',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03b','Browse roles','role','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03c','Browse clients','client','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03d','Read clients','client','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03e','Edit clients','client','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce03f','Add clients','client','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce040','Delete clients','client','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce041','Browse subscribers','subscriber','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce042','Read subscribers','subscriber','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce043','Edit subscribers','subscriber','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce044','Add subscribers','subscriber','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce045','Delete subscribers','subscriber','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce046','Browse invites','invite','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce047','Read invites','invite','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce048','Edit invites','invite','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce049','Add invites','invite','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04a','Delete invites','invite','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04b','Download redirects','redirect','download',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04c','Upload redirects','redirect','upload',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04d','Add webhooks','webhook','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04e','Edit webhooks','webhook','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce04f','Delete webhooks','webhook','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce050','Browse integrations','integration','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce051','Read integrations','integration','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce052','Edit integrations','integration','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce053','Add integrations','integration','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce054','Delete integrations','integration','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce055','Browse API keys','api_key','browse',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce056','Read API keys','api_key','read',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce057','Edit API keys','api_key','edit',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce058','Add API keys','api_key','add',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce059','Delete API keys','api_key','destroy',NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1');

/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table permissions_apps
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions_apps`;

CREATE TABLE `permissions_apps` (
  `id` varchar(24) NOT NULL,
  `app_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table permissions_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions_roles`;

CREATE TABLE `permissions_roles` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `permissions_roles` WRITE;
/*!40000 ALTER TABLE `permissions_roles` DISABLE KEYS */;

INSERT INTO `permissions_roles` (`id`, `role_id`, `permission_id`)
VALUES
	('5bebfe6cb1a9c511638ce069','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01a'),
	('5bebfe6cb1a9c511638ce06a','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01b'),
	('5bebfe6cb1a9c511638ce06b','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01c'),
	('5bebfe6cb1a9c511638ce06c','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01d'),
	('5bebfe6cb1a9c511638ce06d','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01e'),
	('5bebfe6cb1a9c511638ce06e','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce01f'),
	('5bebfe6cb1a9c511638ce06f','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce020'),
	('5bebfe6cb1a9c511638ce070','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce021'),
	('5bebfe6cb1a9c511638ce071','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce022'),
	('5bebfe6cb1a9c511638ce072','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce023'),
	('5bebfe6cb1a9c511638ce073','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce024'),
	('5bebfe6cb1a9c511638ce074','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce025'),
	('5bebfe6cb1a9c511638ce075','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce026'),
	('5bebfe6cb1a9c511638ce076','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce027'),
	('5bebfe6cb1a9c511638ce077','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce028'),
	('5bebfe6cb1a9c511638ce078','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce029'),
	('5bebfe6cb1a9c511638ce079','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02a'),
	('5bebfe6cb1a9c511638ce07a','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02b'),
	('5bebfe6cb1a9c511638ce07b','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02c'),
	('5bebfe6cb1a9c511638ce07c','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02d'),
	('5bebfe6cb1a9c511638ce07d','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02e'),
	('5bebfe6cb1a9c511638ce07e','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce02f'),
	('5bebfe6cb1a9c511638ce07f','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce030'),
	('5bebfe6cb1a9c511638ce080','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce031'),
	('5bebfe6cb1a9c511638ce081','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce032'),
	('5bebfe6cb1a9c511638ce082','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce033'),
	('5bebfe6cb1a9c511638ce083','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce034'),
	('5bebfe6cb1a9c511638ce084','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce035'),
	('5bebfe6cb1a9c511638ce085','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce036'),
	('5bebfe6cb1a9c511638ce086','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce037'),
	('5bebfe6cb1a9c511638ce087','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce038'),
	('5bebfe6cb1a9c511638ce088','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce039'),
	('5bebfe6cb1a9c511638ce089','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03a'),
	('5bebfe6cb1a9c511638ce08a','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03b'),
	('5bebfe6cb1a9c511638ce08b','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03c'),
	('5bebfe6cb1a9c511638ce08c','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03d'),
	('5bebfe6cb1a9c511638ce08d','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03e'),
	('5bebfe6cb1a9c511638ce08e','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce03f'),
	('5bebfe6cb1a9c511638ce08f','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce040'),
	('5bebfe6cb1a9c511638ce090','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce041'),
	('5bebfe6cb1a9c511638ce091','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce042'),
	('5bebfe6cb1a9c511638ce092','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce043'),
	('5bebfe6cb1a9c511638ce093','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce044'),
	('5bebfe6cb1a9c511638ce094','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce045'),
	('5bebfe6cb1a9c511638ce095','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce046'),
	('5bebfe6cb1a9c511638ce096','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce047'),
	('5bebfe6cb1a9c511638ce097','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce048'),
	('5bebfe6cb1a9c511638ce098','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce049'),
	('5bebfe6cb1a9c511638ce099','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04a'),
	('5bebfe6cb1a9c511638ce09a','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04b'),
	('5bebfe6cb1a9c511638ce09b','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04c'),
	('5bebfe6cb1a9c511638ce09c','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04d'),
	('5bebfe6cb1a9c511638ce09d','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04e'),
	('5bebfe6cb1a9c511638ce09e','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce04f'),
	('5bebfe6cb1a9c511638ce09f','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce050'),
	('5bebfe6cb1a9c511638ce0a0','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce051'),
	('5bebfe6cb1a9c511638ce0a1','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce052'),
	('5bebfe6cb1a9c511638ce0a2','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce053'),
	('5bebfe6cb1a9c511638ce0a3','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce054'),
	('5bebfe6cb1a9c511638ce0a4','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce055'),
	('5bebfe6cb1a9c511638ce0a5','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce056'),
	('5bebfe6cb1a9c511638ce0a6','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce057'),
	('5bebfe6cb1a9c511638ce0a7','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce058'),
	('5bebfe6cb1a9c511638ce0a8','5bebfe67b1a9c511638ce014','5bebfe67b1a9c511638ce059'),
	('5bebfe6cb1a9c511638ce0a9','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce01d'),
	('5bebfe6cb1a9c511638ce0aa','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce01e'),
	('5bebfe6cb1a9c511638ce0ab','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce01f'),
	('5bebfe6cb1a9c511638ce0ac','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce020'),
	('5bebfe6cb1a9c511638ce0ad','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce021'),
	('5bebfe6cb1a9c511638ce0ae','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce022'),
	('5bebfe6cb1a9c511638ce0af','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce023'),
	('5bebfe6cb1a9c511638ce0b0','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce024'),
	('5bebfe6cb1a9c511638ce0b1','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce025'),
	('5bebfe6cb1a9c511638ce0b2','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce026'),
	('5bebfe6cb1a9c511638ce0b3','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce027'),
	('5bebfe6cb1a9c511638ce0b4','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce028'),
	('5bebfe6cb1a9c511638ce0b5','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce029'),
	('5bebfe6cb1a9c511638ce0b6','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02a'),
	('5bebfe6cb1a9c511638ce0b7','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02b'),
	('5bebfe6cb1a9c511638ce0b8','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02c'),
	('5bebfe6cb1a9c511638ce0b9','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02d'),
	('5bebfe6cb1a9c511638ce0ba','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02e'),
	('5bebfe6cb1a9c511638ce0bb','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce02f'),
	('5bebfe6cb1a9c511638ce0bc','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce030'),
	('5bebfe6cb1a9c511638ce0bd','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce031'),
	('5bebfe6cb1a9c511638ce0be','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce032'),
	('5bebfe6cb1a9c511638ce0bf','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce033'),
	('5bebfe6cb1a9c511638ce0c0','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce034'),
	('5bebfe6cb1a9c511638ce0c1','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce035'),
	('5bebfe6cb1a9c511638ce0c2','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce036'),
	('5bebfe6cb1a9c511638ce0c3','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce037'),
	('5bebfe6cb1a9c511638ce0c4','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce038'),
	('5bebfe6cb1a9c511638ce0c5','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce039'),
	('5bebfe6cb1a9c511638ce0c6','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03a'),
	('5bebfe6cb1a9c511638ce0c7','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03b'),
	('5bebfe6cb1a9c511638ce0c8','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03c'),
	('5bebfe6cb1a9c511638ce0c9','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03d'),
	('5bebfe6cb1a9c511638ce0ca','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03e'),
	('5bebfe6cb1a9c511638ce0cb','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce03f'),
	('5bebfe6cb1a9c511638ce0cc','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce040'),
	('5bebfe6cb1a9c511638ce0cd','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce041'),
	('5bebfe6cb1a9c511638ce0ce','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce042'),
	('5bebfe6cb1a9c511638ce0cf','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce043'),
	('5bebfe6cb1a9c511638ce0d0','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce044'),
	('5bebfe6cb1a9c511638ce0d1','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce045'),
	('5bebfe6cb1a9c511638ce0d2','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce046'),
	('5bebfe6cb1a9c511638ce0d3','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce047'),
	('5bebfe6cb1a9c511638ce0d4','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce048'),
	('5bebfe6cb1a9c511638ce0d5','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce049'),
	('5bebfe6cb1a9c511638ce0d6','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04a'),
	('5bebfe6cb1a9c511638ce0d7','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04b'),
	('5bebfe6cb1a9c511638ce0d8','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04c'),
	('5bebfe6cb1a9c511638ce0d9','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04d'),
	('5bebfe6cb1a9c511638ce0da','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04e'),
	('5bebfe6cb1a9c511638ce0db','5bebfe67b1a9c511638ce019','5bebfe67b1a9c511638ce04f'),
	('5bebfe6cb1a9c511638ce0dc','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce021'),
	('5bebfe6cb1a9c511638ce0dd','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce022'),
	('5bebfe6cb1a9c511638ce0de','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce023'),
	('5bebfe6cb1a9c511638ce0df','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce024'),
	('5bebfe6cb1a9c511638ce0e0','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce025'),
	('5bebfe6cb1a9c511638ce0e1','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce026'),
	('5bebfe6cb1a9c511638ce0e2','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce027'),
	('5bebfe6cb1a9c511638ce0e3','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce029'),
	('5bebfe6cb1a9c511638ce0e4','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02a'),
	('5bebfe6cb1a9c511638ce0e5','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02b'),
	('5bebfe6cb1a9c511638ce0e6','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02c'),
	('5bebfe6cb1a9c511638ce0e7','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02d'),
	('5bebfe6cb1a9c511638ce0e8','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02e'),
	('5bebfe6cb1a9c511638ce0e9','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce035'),
	('5bebfe6cb1a9c511638ce0ea','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce036'),
	('5bebfe6cb1a9c511638ce0eb','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce037'),
	('5bebfe6cb1a9c511638ce0ec','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce038'),
	('5bebfe6cb1a9c511638ce0ed','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce039'),
	('5bebfe6cb1a9c511638ce0ee','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03a'),
	('5bebfe6cb1a9c511638ce0ef','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03b'),
	('5bebfe6cb1a9c511638ce0f0','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03c'),
	('5bebfe6cb1a9c511638ce0f1','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03d'),
	('5bebfe6cb1a9c511638ce0f2','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03e'),
	('5bebfe6cb1a9c511638ce0f3','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce03f'),
	('5bebfe6cb1a9c511638ce0f4','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce040'),
	('5bebfe6db1a9c511638ce0f5','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce044'),
	('5bebfe6db1a9c511638ce0f6','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce046'),
	('5bebfe6db1a9c511638ce0f7','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce047'),
	('5bebfe6db1a9c511638ce0f8','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce048'),
	('5bebfe6db1a9c511638ce0f9','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce049'),
	('5bebfe6db1a9c511638ce0fa','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce04a'),
	('5bebfe6db1a9c511638ce0fb','5bebfe67b1a9c511638ce015','5bebfe67b1a9c511638ce02f'),
	('5bebfe6db1a9c511638ce0fc','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce021'),
	('5bebfe6db1a9c511638ce0fd','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce022'),
	('5bebfe6db1a9c511638ce0fe','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce024'),
	('5bebfe6db1a9c511638ce0ff','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce026'),
	('5bebfe6db1a9c511638ce100','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce027'),
	('5bebfe6db1a9c511638ce101','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce029'),
	('5bebfe6db1a9c511638ce102','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce02a'),
	('5bebfe6db1a9c511638ce103','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce02b'),
	('5bebfe6db1a9c511638ce104','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce02d'),
	('5bebfe6db1a9c511638ce105','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce035'),
	('5bebfe6db1a9c511638ce106','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce036'),
	('5bebfe6db1a9c511638ce107','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce03b'),
	('5bebfe6db1a9c511638ce108','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce03c'),
	('5bebfe6db1a9c511638ce109','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce03d'),
	('5bebfe6db1a9c511638ce10a','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce03e'),
	('5bebfe6db1a9c511638ce10b','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce03f'),
	('5bebfe6db1a9c511638ce10c','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce040'),
	('5bebfe6db1a9c511638ce10d','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce044'),
	('5bebfe6db1a9c511638ce10e','5bebfe67b1a9c511638ce016','5bebfe67b1a9c511638ce02f'),
	('5bebfe6db1a9c511638ce10f','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce021'),
	('5bebfe6db1a9c511638ce110','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce022'),
	('5bebfe6db1a9c511638ce111','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce024'),
	('5bebfe6db1a9c511638ce112','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce026'),
	('5bebfe6db1a9c511638ce113','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce027'),
	('5bebfe6db1a9c511638ce114','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce029'),
	('5bebfe6db1a9c511638ce115','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce02a'),
	('5bebfe6db1a9c511638ce116','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce02b'),
	('5bebfe6db1a9c511638ce117','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce035'),
	('5bebfe6db1a9c511638ce118','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce036'),
	('5bebfe6db1a9c511638ce119','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce03b'),
	('5bebfe6db1a9c511638ce11a','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce03c'),
	('5bebfe6db1a9c511638ce11b','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce03d'),
	('5bebfe6db1a9c511638ce11c','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce03e'),
	('5bebfe6db1a9c511638ce11d','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce03f'),
	('5bebfe6db1a9c511638ce11e','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce040'),
	('5bebfe6db1a9c511638ce11f','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce044'),
	('5bebfe6db1a9c511638ce120','5bebfe67b1a9c511638ce017','5bebfe67b1a9c511638ce02f');

/*!40000 ALTER TABLE `permissions_roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table permissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `permissions_users`;

CREATE TABLE `permissions_users` (
  `id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `title` varchar(2000) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `mobiledoc` longtext,
  `html` longtext,
  `comment_id` varchar(50) DEFAULT NULL,
  `plaintext` longtext,
  `feature_image` varchar(2000) DEFAULT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `page` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT 'draft',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `author_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `published_by` varchar(24) DEFAULT NULL,
  `custom_excerpt` varchar(2000) DEFAULT NULL,
  `codeinjection_head` text,
  `codeinjection_foot` text,
  `og_image` varchar(2000) DEFAULT NULL,
  `og_title` varchar(300) DEFAULT NULL,
  `og_description` varchar(500) DEFAULT NULL,
  `twitter_image` varchar(2000) DEFAULT NULL,
  `twitter_title` varchar(300) DEFAULT NULL,
  `twitter_description` varchar(500) DEFAULT NULL,
  `custom_template` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`id`, `uuid`, `title`, `slug`, `mobiledoc`, `html`, `comment_id`, `plaintext`, `feature_image`, `featured`, `page`, `status`, `locale`, `visibility`, `meta_title`, `meta_description`, `author_id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `published_at`, `published_by`, `custom_excerpt`, `codeinjection_head`, `codeinjection_foot`, `og_image`, `og_title`, `og_description`, `twitter_image`, `twitter_title`, `twitter_description`, `custom_template`)
VALUES
	('5bebfe6bb1a9c511638ce05b','b0c2b0ff-6ab9-4459-85de-f8dc9fc7c654','Creating a custom theme','themes','{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"image\",{\"src\":\"https://static.ghost.org/v1.0.0/images/marketplace.jpg\",\"caption\":\"Anyone can write a completely custom Ghost theme with some solid knowledge of HTML and CSS\"}]],\"markups\":[[\"a\",[\"href\",\"http://marketplace.ghost.org\"]],[\"code\"],[\"a\",[\"href\",\"https://github.com/TryGhost/Casper\"]],[\"a\",[\"href\",\"https://themes.ghost.org/v2.0.0/docs\"]],[\"strong\"],[\"a\",[\"href\",\"https://forum.ghost.org/c/themes\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Ghost comes with a beautiful default theme called Casper, which is designed to be a clean, readable publication layout and can be adapted for most purposes. However, Ghost can also be completely themed to suit your needs. Rather than just giving you a few basic settings which act as a poor proxy for code, we just let you write code.\"]]],[1,\"p\",[[0,[],0,\"There are a huge range of both free and premium pre-built themes which you can get from the \"],[0,[0],1,\"Ghost Theme Marketplace\"],[0,[],0,\", or you can create your own from scratch.\"]]],[10,0],[1,\"p\",[[0,[],0,\"Ghost themes are written with a templating language called handlebars, which has a set of dynamic helpers to insert your data into template files. For example: \"],[0,[1],1,\"{{author.name}}\"],[0,[],0,\" outputs the name of the current author.\"]]],[1,\"p\",[[0,[],0,\"The best way to learn how to write your own Ghost theme is to have a look at \"],[0,[2],1,\"the source code for Casper\"],[0,[],0,\", which is heavily commented and should give you a sense of how everything fits together.\"]]],[3,\"ul\",[[[0,[1],1,\"default.hbs\"],[0,[],0,\" is the main template file, all contexts will load inside this file unless specifically told to use a different template.\"]],[[0,[1],1,\"post.hbs\"],[0,[],0,\" is the file used in the context of viewing a post.\"]],[[0,[1],1,\"index.hbs\"],[0,[],0,\" is the file used in the context of viewing the home page.\"]],[[0,[],0,\"and so on\"]]]],[1,\"p\",[[0,[],0,\"We\'ve got \"],[0,[3],1,\"full and extensive theme documentation\"],[0,[],0,\" which outlines every template file, context and helper that you can use.\"]]],[1,\"p\",[[0,[],0,\"If you want to chat with other people making Ghost themes to get any advice or help, there\'s also a \"],[0,[4],1,\"themes\"],[0,[],0,\" section on our \"],[0,[5],1,\"public Ghost forum\"],[0,[],0,\".\"]]]]}','<p>Ghost comes with a beautiful default theme called Casper, which is designed to be a clean, readable publication layout and can be adapted for most purposes. However, Ghost can also be completely themed to suit your needs. Rather than just giving you a few basic settings which act as a poor proxy for code, we just let you write code.</p><p>There are a huge range of both free and premium pre-built themes which you can get from the <a href=\"http://marketplace.ghost.org\">Ghost Theme Marketplace</a>, or you can create your own from scratch.</p><figure class=\"kg-card kg-image-card\"><img src=\"https://static.ghost.org/v1.0.0/images/marketplace.jpg\" class=\"kg-image\"><figcaption>Anyone can write a completely custom Ghost theme with some solid knowledge of HTML and CSS</figcaption></figure><p>Ghost themes are written with a templating language called handlebars, which has a set of dynamic helpers to insert your data into template files. For example: <code>{{author.name}}</code> outputs the name of the current author.</p><p>The best way to learn how to write your own Ghost theme is to have a look at <a href=\"https://github.com/TryGhost/Casper\">the source code for Casper</a>, which is heavily commented and should give you a sense of how everything fits together.</p><ul><li><code>default.hbs</code> is the main template file, all contexts will load inside this file unless specifically told to use a different template.</li><li><code>post.hbs</code> is the file used in the context of viewing a post.</li><li><code>index.hbs</code> is the file used in the context of viewing the home page.</li><li>and so on</li></ul><p>We\'ve got <a href=\"https://themes.ghost.org/v2.0.0/docs\">full and extensive theme documentation</a> which outlines every template file, context and helper that you can use.</p><p>If you want to chat with other people making Ghost themes to get any advice or help, there\'s also a <strong>themes</strong> section on our <a href=\"https://forum.ghost.org/c/themes\">public Ghost forum</a>.</p>','5bebfe6bb1a9c511638ce05b','Ghost comes with a beautiful default theme called Casper, which is designed to\nbe a clean, readable publication layout and can be adapted for most purposes.\nHowever, Ghost can also be completely themed to suit your needs. Rather than\njust giving you a few basic settings which act as a poor proxy for code, we just\nlet you write code.\n\nThere are a huge range of both free and premium pre-built themes which you can\nget from the Ghost Theme Marketplace [http://marketplace.ghost.org], or you can\ncreate your own from scratch.\n\nAnyone can write a completely custom Ghost theme with some solid knowledge of\nHTML and CSSGhost themes are written with a templating language called\nhandlebars, which has a set of dynamic helpers to insert your data into template\nfiles. For example: {{author.name}}  outputs the name of the current author.\n\nThe best way to learn how to write your own Ghost theme is to have a look at \nthe\nsource code for Casper [https://github.com/TryGhost/Casper], which is heavily\ncommented and should give you a sense of how everything fits together.\n\n * default.hbs  is the main template file, all contexts will load inside this\n   file unless specifically told to use a different template.\n * post.hbs  is the file used in the context of viewing a post.\n * index.hbs  is the file used in the context of viewing the home page.\n * and so on\n\nWe\'ve got full and extensive theme documentation\n[https://themes.ghost.org/v2.0.0/docs]  which outlines every template file,\ncontext and helper that you can use.\n\nIf you want to chat with other people making Ghost themes to get any advice or\nhelp, there\'s also a themes  section on our public Ghost forum\n[https://forum.ghost.org/c/themes].','https://static.ghost.org/v2.0.0/images/creating-a-custom-theme.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:27','1','2018-11-14 10:52:27','1','2018-11-14 10:52:27','1','Ghost comes with a beautiful default theme called Casper, which is designed to be a clean, readable publication layout and can be easily adapted for most purposes.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce05d','e8884297-4fc9-44eb-a503-71783904819d','Apps & integrations','apps-integrations','{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"markdown\",{\"markdown\":\"<script src=\\\"https://zapier.com/apps/embed/widget.js?services=Ghost&container=true&limit=8\\\"></script>\\n\"}]],\"markups\":[[\"a\",[\"href\",\"https://zapier.com\"]],[\"strong\"],[\"a\",[\"href\",\"https://themes.ghost.org\"]],[\"em\"],[\"a\",[\"href\",\"https://help.ghost.org/article/15-disqus\"]],[\"a\",[\"href\",\"https://help.ghost.org/article/35-discourse\"]],[\"a\",[\"href\",\"https://help.ghost.org/article/89-mathjax\"]],[\"a\",[\"href\",\"https://prismjs.com/\"]],[\"a\",[\"href\",\"https://www.google.com/forms/\"]],[\"a\",[\"href\",\"https://www.typeform.com/\"]],[\"a\",[\"href\",\"https://api.ghost.org\"]],[\"a\",[\"href\",\"/themes/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"There are three primary ways to work with third-party services in Ghost: using Zapier, editing your theme, or using the Ghost API.\"]]],[1,\"h1\",[[0,[],0,\"Zapier\"]]],[1,\"p\",[[0,[],0,\"You can connect your Ghost site to over 1,000 external services using the official integration with \"],[0,[0],1,\"Zapier\"],[0,[],0,\".\"]]],[1,\"p\",[[0,[],0,\"Zapier sets up automations with Triggers and Actions, which allows you to create and customise a wide range of connected applications.\"]]],[1,\"blockquote\",[[0,[1],1,\"Example\"],[0,[],0,\": When someone new subscribes to a newsletter on a Ghost site (Trigger) then the contact information is automatically pushed into MailChimp (Action).\"]]],[1,\"p\",[[0,[1],1,\"Here are the most popular Ghost<>Zapier automation templates:\"],[0,[],0,\" \"]]],[10,0],[1,\"h1\",[[0,[],0,\"Editing your theme\"]]],[1,\"p\",[[0,[],0,\"One of the biggest advantages of using Ghost over centralised platforms is that you have total control over the front end of your site. Either customise your existing theme, or create a new theme from scratch with our \"],[0,[2],1,\"Theme SDK\"],[0,[],0,\". \"]]],[1,\"p\",[[0,[],0,\"You can integrate \"],[0,[3],1,\"any\"],[0,[],0,\" front end code into a Ghost theme without restriction, and it will work just fine. No restrictions!\"]]],[1,\"p\",[[0,[1],1,\"Here are some common examples\"],[0,[],0,\":\"]]],[3,\"ul\",[[[0,[],0,\"Include comments on a Ghost blog with \"],[0,[4],1,\"Disqus\"],[0,[],0,\" or \"],[0,[5],1,\"Discourse\"]],[[0,[],0,\"Implement \"],[0,[6],1,\"MathJAX\"],[0,[],0,\" with a little bit of JavaScript\"]],[[0,[],0,\"Add syntax highlighting to your code snippets using \"],[0,[7],1,\"Prism.js\"]],[[0,[],0,\"Integrate any dynamic forms from \"],[0,[8],1,\"Google\"],[0,[],0,\" or \"],[0,[9],1,\"Typeform\"],[0,[],0,\" to capture data\"]],[[0,[],0,\"Just about anything which uses JavaScript, APIs and Markup.\"]]]],[1,\"h1\",[[0,[],0,\"Using the Public API\"]]],[1,\"p\",[[0,[],0,\"Ghost itself is driven by a set of core APIs, and so you can access the Public Ghost JSON API from external webpages or applications in order to pull data and display it in other places.\"]]],[1,\"blockquote\",[[0,[],0,\"The Ghost API is \"],[0,[10],1,\"thoroughly documented\"],[0,[],0,\" and straightforward to work with for developers of almost any level. \"]]],[1,\"p\",[[0,[],0,\"Alright, the last post in our welcome-series! If you\'re curious about creating your own Ghost theme from scratch, here are \"],[0,[11],1,\"some more details\"],[0,[],0,\" on how that works.\"]]]]}','<p>There are three primary ways to work with third-party services in Ghost: using Zapier, editing your theme, or using the Ghost API.</p><h1 id=\"zapier\">Zapier</h1><p>You can connect your Ghost site to over 1,000 external services using the official integration with <a href=\"https://zapier.com\">Zapier</a>.</p><p>Zapier sets up automations with Triggers and Actions, which allows you to create and customise a wide range of connected applications.</p><blockquote><strong>Example</strong>: When someone new subscribes to a newsletter on a Ghost site (Trigger) then the contact information is automatically pushed into MailChimp (Action).</blockquote><p><strong>Here are the most popular Ghost&lt;&gt;Zapier automation templates:</strong> </p><script src=\"https://zapier.com/apps/embed/widget.js?services=Ghost&container=true&limit=8\"></script>\n<h1 id=\"editing-your-theme\">Editing your theme</h1><p>One of the biggest advantages of using Ghost over centralised platforms is that you have total control over the front end of your site. Either customise your existing theme, or create a new theme from scratch with our <a href=\"https://themes.ghost.org\">Theme SDK</a>. </p><p>You can integrate <em>any</em> front end code into a Ghost theme without restriction, and it will work just fine. No restrictions!</p><p><strong>Here are some common examples</strong>:</p><ul><li>Include comments on a Ghost blog with <a href=\"https://help.ghost.org/article/15-disqus\">Disqus</a> or <a href=\"https://help.ghost.org/article/35-discourse\">Discourse</a></li><li>Implement <a href=\"https://help.ghost.org/article/89-mathjax\">MathJAX</a> with a little bit of JavaScript</li><li>Add syntax highlighting to your code snippets using <a href=\"https://prismjs.com/\">Prism.js</a></li><li>Integrate any dynamic forms from <a href=\"https://www.google.com/forms/\">Google</a> or <a href=\"https://www.typeform.com/\">Typeform</a> to capture data</li><li>Just about anything which uses JavaScript, APIs and Markup.</li></ul><h1 id=\"using-the-public-api\">Using the Public API</h1><p>Ghost itself is driven by a set of core APIs, and so you can access the Public Ghost JSON API from external webpages or applications in order to pull data and display it in other places.</p><blockquote>The Ghost API is <a href=\"https://api.ghost.org\">thoroughly documented</a> and straightforward to work with for developers of almost any level. </blockquote><p>Alright, the last post in our welcome-series! If you\'re curious about creating your own Ghost theme from scratch, here are <a href=\"/themes/\">some more details</a> on how that works.</p>','5bebfe6cb1a9c511638ce05d','There are three primary ways to work with third-party services in Ghost: using\nZapier, editing your theme, or using the Ghost API.\n\nZapier\nYou can connect your Ghost site to over 1,000 external services using the\nofficial integration with Zapier [https://zapier.com].\n\nZapier sets up automations with Triggers and Actions, which allows you to create\nand customise a wide range of connected applications.\n\nExample: When someone new subscribes to a newsletter on a Ghost site (Trigger)\nthen the contact information is automatically pushed into MailChimp (Action).\nHere are the most popular Ghost<>Zapier automation templates:  \n\nEditing your theme\nOne of the biggest advantages of using Ghost over centralised platforms is that\nyou have total control over the front end of your site. Either customise your\nexisting theme, or create a new theme from scratch with our Theme SDK\n[https://themes.ghost.org]. \n\nYou can integrate any  front end code into a Ghost theme without restriction,\nand it will work just fine. No restrictions!\n\nHere are some common examples:\n\n * Include comments on a Ghost blog with Disqus\n   [https://help.ghost.org/article/15-disqus]  or Discourse\n   [https://help.ghost.org/article/35-discourse]\n * Implement MathJAX [https://help.ghost.org/article/89-mathjax]  with a little\n   bit of JavaScript\n * Add syntax highlighting to your code snippets using Prism.js\n   [https://prismjs.com/]\n * Integrate any dynamic forms from Google [https://www.google.com/forms/]  or \n   Typeform [https://www.typeform.com/]  to capture data\n * Just about anything which uses JavaScript, APIs and Markup.\n\nUsing the Public API\nGhost itself is driven by a set of core APIs, and so you can access the Public\nGhost JSON API from external webpages or applications in order to pull data and\ndisplay it in other places.\n\nThe Ghost API is thoroughly documented [https://api.ghost.org]  and\nstraightforward to work with for developers of almost any level. Alright, the\nlast post in our welcome-series! If you\'re curious about creating your own Ghost\ntheme from scratch, here are some more details [/themes/]  on how that works.','https://static.ghost.org/v2.0.0/images/app-integrations.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','There are three primary ways to work with third-party services in Ghost: using Zapier, editing your theme, or using the Ghost API.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce05f','4fd68753-f294-47ee-9357-9da00acee601','Organising your content','organising-content','{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}]],\"cards\":[],\"markups\":[[\"strong\"],[\"code\"],[\"em\"],[\"a\",[\"href\",\"https://themes.ghost.org/v2.0.0/docs\"]],[\"a\",[\"href\",\"http://yaml.org/spec/1.2/spec.html\",\"rel\",\"noreferrer nofollow noopener\"]],[\"a\",[\"href\",\"https://docs.ghost.org/docs/dynamic-routing\"]],[\"a\",[\"href\",\"/apps-integrations/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Ghost has a flexible organisational taxonomy called\"],[0,[0],1,\" tags\"],[0,[],0,\" which can be used to configure your site structure using \"],[0,[0],1,\"dynamic routing\"],[0,[],0,\". \"]]],[1,\"h1\",[[0,[],0,\"Basic Tagging\"]]],[1,\"p\",[[0,[],0,\"You can think of tags like Gmail labels. By tagging posts with one or more keyword, you can organise articles into buckets of related content.\"]]],[1,\"p\",[[0,[],0,\"When you create content for your publication you can assign tags to help differentiate between categories of content. \"]]],[1,\"p\",[[0,[],0,\"For example you may tag some content with  News and other content with Podcast, which would create two distinct categories of content listed on \"],[0,[1],1,\"/tag/news/\"],[0,[],0,\" and \"],[0,[1],1,\"/tag/weather/\"],[0,[],0,\", respectively.\"]]],[1,\"p\",[[0,[],0,\"If you tag a post with both \"],[0,[1],1,\"News\"],[0,[],0,\" \"],[0,[2],1,\"and\"],[0,[],0,\" \"],[0,[1],1,\"Weather\"],[0,[],0,\" - then it appears in both sections. Tag archives are like dedicated home-pages for each category of content that you have. They have their own pages, their own RSS feeds, and can support their own cover images and meta data.\"]]],[1,\"h1\",[[0,[],0,\"The primary tag\"]]],[1,\"p\",[[0,[],0,\"Inside the Ghost editor, you can drag and drop tags into a specific order. The first tag in the list is always given the most importance, and some themes will only display the primary tag (the first tag in the list) by default. \"]]],[1,\"blockquote\",[[0,[2,0],1,\"News\"],[0,[],1,\", Technology, Startup\"]]],[1,\"p\",[[0,[],0,\"So you can add the most important tag which you want to show up in your theme, but also add related tags which are less important.\"]]],[1,\"h1\",[[0,[],0,\"Private tags\"]]],[1,\"p\",[[0,[],0,\"Sometimes you may want to assign a post a specific tag, but you don\'t necessarily want that tag appearing in the theme or creating an archive page. In Ghost, hashtags are private and can be used for special styling.\"]]],[1,\"p\",[[0,[],0,\"For example, if you sometimes publish posts with video content - you might want your theme to adapt and get rid of the sidebar for these posts, to give more space for an embedded video to fill the screen. In this case, you could use private tags to tell your theme what to do.\"]]],[1,\"blockquote\",[[0,[2,0],1,\"News\"],[0,[],1,\", #video\"]]],[1,\"p\",[[0,[],0,\"Here, the theme would assign the post publicly displayed tags of News - but it would also keep a private record of the post being tagged with #video. In your theme, you could then look for private tags conditionally and give them special formatting. \"]]],[1,\"blockquote\",[[0,[2],0,\"You can find documentation for theme development techniques like this and many more over on Ghost\'s extensive \"],[0,[3],1,\"theme documentation\"],[0,[],1,\".\"]]],[1,\"h1\",[[0,[],0,\"Dynamic Routing\"]]],[1,\"p\",[[0,[],0,\"Dynamic routing gives you the ultimate freedom to build a custom publication to suit your needs. Routes are rules that map URL patterns to your content and templates. \"]]],[1,\"p\",[[0,[],0,\"For example, you may not want content tagged with \"],[0,[1],1,\"News\"],[0,[],0,\" to exist on: \"],[0,[1],1,\"example.com/tag/news\"],[0,[],0,\". Instead, you want it to exist on \"],[0,[1],1,\"example.com/news\"],[0,[],0,\" . \"]]],[1,\"p\",[[0,[],0,\"In this case you can use dynamic routes to create customised collections of content on your site. It\'s also possible to use multiple templates in your theme to render each content type differently.\"]]],[1,\"p\",[[0,[],0,\"There are lots of use cases for dynamic routing with Ghost, here are a few common examples: \"]]],[3,\"ul\",[[[0,[],0,\"Setting a custom home page with its own template\"]],[[0,[],0,\"Having separate content hubs for blog and podcast, that render differently, and have custom RSS feeds to support two types of content\"]],[[0,[],0,\"Creating a founders column as a unique view, by filtering content created by specific authors\"]],[[0,[],0,\"Including dates in permalinks for your posts\"]],[[0,[],0,\"Setting posts to have a URL relative to their primary tag like \"],[0,[1],1,\"example.com/europe/story-title/\"],[1,[],0,0]]]],[1,\"blockquote\",[[0,[2],0,\"Dynamic routing can be configured in Ghost using \"],[0,[4],1,\"YAML\"],[0,[],0,\" files. Read our dynamic routing \"],[0,[5],1,\"documentation\"],[0,[],1,\" for further details.\"]]],[1,\"p\",[[0,[],0,\"You can further customise your site using \"],[0,[6],1,\"Apps & Integrations\"],[0,[],0,\".\"]]]]}','<p>Ghost has a flexible organisational taxonomy called<strong> tags</strong> which can be used to configure your site structure using <strong>dynamic routing</strong>. </p><h1 id=\"basic-tagging\">Basic Tagging</h1><p>You can think of tags like Gmail labels. By tagging posts with one or more keyword, you can organise articles into buckets of related content.</p><p>When you create content for your publication you can assign tags to help differentiate between categories of content. </p><p>For example you may tag some content with  News and other content with Podcast, which would create two distinct categories of content listed on <code>/tag/news/</code> and <code>/tag/weather/</code>, respectively.</p><p>If you tag a post with both <code>News</code> <em>and</em> <code>Weather</code> - then it appears in both sections. Tag archives are like dedicated home-pages for each category of content that you have. They have their own pages, their own RSS feeds, and can support their own cover images and meta data.</p><h1 id=\"the-primary-tag\">The primary tag</h1><p>Inside the Ghost editor, you can drag and drop tags into a specific order. The first tag in the list is always given the most importance, and some themes will only display the primary tag (the first tag in the list) by default. </p><blockquote><em><strong>News</strong>, Technology, Startup</em></blockquote><p>So you can add the most important tag which you want to show up in your theme, but also add related tags which are less important.</p><h1 id=\"private-tags\">Private tags</h1><p>Sometimes you may want to assign a post a specific tag, but you don\'t necessarily want that tag appearing in the theme or creating an archive page. In Ghost, hashtags are private and can be used for special styling.</p><p>For example, if you sometimes publish posts with video content - you might want your theme to adapt and get rid of the sidebar for these posts, to give more space for an embedded video to fill the screen. In this case, you could use private tags to tell your theme what to do.</p><blockquote><em><strong>News</strong>, #video</em></blockquote><p>Here, the theme would assign the post publicly displayed tags of News - but it would also keep a private record of the post being tagged with #video. In your theme, you could then look for private tags conditionally and give them special formatting. </p><blockquote><em>You can find documentation for theme development techniques like this and many more over on Ghost\'s extensive <a href=\"https://themes.ghost.org/v2.0.0/docs\">theme documentation</a>.</em></blockquote><h1 id=\"dynamic-routing\">Dynamic Routing</h1><p>Dynamic routing gives you the ultimate freedom to build a custom publication to suit your needs. Routes are rules that map URL patterns to your content and templates. </p><p>For example, you may not want content tagged with <code>News</code> to exist on: <code>example.com/tag/news</code>. Instead, you want it to exist on <code>example.com/news</code> . </p><p>In this case you can use dynamic routes to create customised collections of content on your site. It\'s also possible to use multiple templates in your theme to render each content type differently.</p><p>There are lots of use cases for dynamic routing with Ghost, here are a few common examples: </p><ul><li>Setting a custom home page with its own template</li><li>Having separate content hubs for blog and podcast, that render differently, and have custom RSS feeds to support two types of content</li><li>Creating a founders column as a unique view, by filtering content created by specific authors</li><li>Including dates in permalinks for your posts</li><li>Setting posts to have a URL relative to their primary tag like <code>example.com/europe/story-title/</code><br></li></ul><blockquote><em>Dynamic routing can be configured in Ghost using <a href=\"http://yaml.org/spec/1.2/spec.html\" rel=\"noreferrer nofollow noopener\">YAML</a> files. Read our dynamic routing <a href=\"https://docs.ghost.org/docs/dynamic-routing\">documentation</a> for further details.</em></blockquote><p>You can further customise your site using <a href=\"/apps-integrations/\">Apps &amp; Integrations</a>.</p>','5bebfe6cb1a9c511638ce05f','Ghost has a flexible organisational taxonomy called  tags  which can be used to\nconfigure your site structure using dynamic routing. \n\nBasic Tagging\nYou can think of tags like Gmail labels. By tagging posts with one or more\nkeyword, you can organise articles into buckets of related content.\n\nWhen you create content for your publication you can assign tags to help\ndifferentiate between categories of content. \n\nFor example you may tag some content with  News and other content with Podcast,\nwhich would create two distinct categories of content listed on /tag/news/  and \n/tag/weather/, respectively.\n\nIf you tag a post with both News  and  Weather  - then it appears in both\nsections. Tag archives are like dedicated home-pages for each category of\ncontent that you have. They have their own pages, their own RSS feeds, and can\nsupport their own cover images and meta data.\n\nThe primary tag\nInside the Ghost editor, you can drag and drop tags into a specific order. The\nfirst tag in the list is always given the most importance, and some themes will\nonly display the primary tag (the first tag in the list) by default. \n\nNews, Technology, StartupSo you can add the most important tag which you want to\nshow up in your theme, but also add related tags which are less important.\n\nPrivate tags\nSometimes you may want to assign a post a specific tag, but you don\'t\nnecessarily want that tag appearing in the theme or creating an archive page. In\nGhost, hashtags are private and can be used for special styling.\n\nFor example, if you sometimes publish posts with video content - you might want\nyour theme to adapt and get rid of the sidebar for these posts, to give more\nspace for an embedded video to fill the screen. In this case, you could use\nprivate tags to tell your theme what to do.\n\nNews, #videoHere, the theme would assign the post publicly displayed tags of\nNews - but it would also keep a private record of the post being tagged with\n#video. In your theme, you could then look for private tags conditionally and\ngive them special formatting. \n\nYou can find documentation for theme development techniques like this and many\nmore over on Ghost\'s extensive theme documentation\n[https://themes.ghost.org/v2.0.0/docs].Dynamic Routing\nDynamic routing gives you the ultimate freedom to build a custom publication to\nsuit your needs. Routes are rules that map URL patterns to your content and\ntemplates. \n\nFor example, you may not want content tagged with News  to exist on: \nexample.com/tag/news. Instead, you want it to exist on example.com/news  . \n\nIn this case you can use dynamic routes to create customised collections of\ncontent on your site. It\'s also possible to use multiple templates in your theme\nto render each content type differently.\n\nThere are lots of use cases for dynamic routing with Ghost, here are a few\ncommon examples: \n\n * Setting a custom home page with its own template\n * Having separate content hubs for blog and podcast, that render differently,\n   and have custom RSS feeds to support two types of content\n * Creating a founders column as a unique view, by filtering content created by\n   specific authors\n * Including dates in permalinks for your posts\n * Setting posts to have a URL relative to their primary tag like \n   example.com/europe/story-title/\n   \n\nDynamic routing can be configured in Ghost using YAML\n[http://yaml.org/spec/1.2/spec.html]  files. Read our dynamic routing \ndocumentation [https://docs.ghost.org/docs/dynamic-routing]  for further\ndetails.You can further customise your site using Apps & Integrations\n[/apps-integrations/].','https://static.ghost.org/v2.0.0/images/organising-your-content.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:29','1','Ghost has a flexible organisational taxonomy called tags which can be used to configure your site structure using dynamic routing.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce061','9b661715-db67-4a63-ac6a-7a2422886f2b','Managing admin settings','admin-settings','{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[[\"image\",{\"src\":\"https://static.ghost.org/v1.0.0/images/private.png\"}],[\"hr\",{}]],\"markups\":[[\"a\",[\"href\",\"/ghost/settings/general/\"]],[\"em\"],[\"strong\"],[\"a\",[\"href\",\"https://ghost.org/pricing/\"]],[\"a\",[\"href\",\"/organising-content/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"There are a couple of things to do next while you\'re getting set up:\"]]],[1,\"h1\",[[0,[],0,\"Make your site private\"]]],[1,\"p\",[[0,[],0,\"If you\'ve got a publication that you don\'t want the world to see yet because it\'s not ready to launch, you can hide your Ghost site behind a basic shared pass-phrase.\"]]],[1,\"p\",[[0,[],0,\"You can toggle this preference on at the bottom of Ghost\'s \"],[0,[0],1,\"General Settings\"],[0,[],0,\":\"]]],[10,0],[1,\"p\",[[0,[],0,\"Ghost will give you a short, randomly generated pass-phrase which you can share with anyone who needs access to the site while you\'re working on it. While this setting is enabled, all search engine optimisation features will be switched off to help keep your site under the radar.\"]]],[1,\"p\",[[0,[],0,\"Do remember though, this is \"],[0,[1],1,\"not\"],[0,[],0,\" secure authentication. You shouldn\'t rely on this feature for protecting important private data. It\'s just a simple, shared pass-phrase for some very basic privacy.\"]]],[10,1],[1,\"h1\",[[0,[],0,\"Invite your team \"]]],[1,\"p\",[[0,[],0,\"Ghost has a number of different user roles for your team:\"]]],[1,\"p\",[[0,[2],1,\"Contributors\"],[1,[],0,0],[0,[],0,\"This is the base user level in Ghost. Contributors can create and edit their own draft posts, but they are unable to edit drafts of others or publish posts. Contributors are \"],[0,[2],1,\"untrusted\"],[0,[],0,\" users with the most basic access to your publication.\"]]],[1,\"p\",[[0,[2],1,\"Authors\"],[1,[],0,1],[0,[],0,\"Authors are the 2nd user level in Ghost. Authors can write, edit  and publish their own posts. Authors are \"],[0,[2],1,\"trusted\"],[0,[],0,\" users. If you don\'t trust users to be allowed to publish their own posts, they should be set as Contributors.\"]]],[1,\"p\",[[0,[2],1,\"Editors\"],[1,[],0,2],[0,[],0,\"Editors are the 3rd user level in Ghost. Editors can do everything that an Author can do, but they can also edit and publish the posts of others - as well as their own. Editors can also invite new Contributors+Authors to the site.\"]]],[1,\"p\",[[0,[2],1,\"Administrators\"],[1,[],0,3],[0,[],0,\"The top user level in Ghost is Administrator. Again, administrators can do everything that Authors and Editors can do, but they can also edit all site settings and data, not just content. Additionally, administrators have full access to invite, manage or remove any other user of the site.\"],[1,[],0,4],[1,[],0,5],[0,[2],1,\"The Owner\"],[1,[],0,6],[0,[],0,\"There is only ever one owner of a Ghost site. The owner is a special user which has all the same permissions as an Administrator, but with two exceptions: The Owner can never be deleted. And in some circumstances the owner will have access to additional special settings if applicable. For example: billing details, if using \"],[0,[3,2],2,\"Ghost(Pro)\"],[0,[],0,\".\"]]],[1,\"blockquote\",[[0,[1],1,\"It\'s a good idea to ask all of your users to fill out their user profiles, including bio and social links. These will populate rich structured data for posts and generally create more opportunities for themes to fully populate their design.\"]]],[1,\"p\",[[0,[],0,\"Next up: \"],[0,[4],1,\"Organising your content\"],[0,[],0,\" \"]]]]}','<p>There are a couple of things to do next while you\'re getting set up:</p><h1 id=\"make-your-site-private\">Make your site private</h1><p>If you\'ve got a publication that you don\'t want the world to see yet because it\'s not ready to launch, you can hide your Ghost site behind a basic shared pass-phrase.</p><p>You can toggle this preference on at the bottom of Ghost\'s <a href=\"/ghost/settings/general/\">General Settings</a>:</p><figure class=\"kg-card kg-image-card\"><img src=\"https://static.ghost.org/v1.0.0/images/private.png\" class=\"kg-image\"></figure><p>Ghost will give you a short, randomly generated pass-phrase which you can share with anyone who needs access to the site while you\'re working on it. While this setting is enabled, all search engine optimisation features will be switched off to help keep your site under the radar.</p><p>Do remember though, this is <em>not</em> secure authentication. You shouldn\'t rely on this feature for protecting important private data. It\'s just a simple, shared pass-phrase for some very basic privacy.</p><hr><h1 id=\"invite-your-team\">Invite your team </h1><p>Ghost has a number of different user roles for your team:</p><p><strong>Contributors</strong><br>This is the base user level in Ghost. Contributors can create and edit their own draft posts, but they are unable to edit drafts of others or publish posts. Contributors are <strong>untrusted</strong> users with the most basic access to your publication.</p><p><strong>Authors</strong><br>Authors are the 2nd user level in Ghost. Authors can write, edit  and publish their own posts. Authors are <strong>trusted</strong> users. If you don\'t trust users to be allowed to publish their own posts, they should be set as Contributors.</p><p><strong>Editors</strong><br>Editors are the 3rd user level in Ghost. Editors can do everything that an Author can do, but they can also edit and publish the posts of others - as well as their own. Editors can also invite new Contributors+Authors to the site.</p><p><strong>Administrators</strong><br>The top user level in Ghost is Administrator. Again, administrators can do everything that Authors and Editors can do, but they can also edit all site settings and data, not just content. Additionally, administrators have full access to invite, manage or remove any other user of the site.<br><br><strong>The Owner</strong><br>There is only ever one owner of a Ghost site. The owner is a special user which has all the same permissions as an Administrator, but with two exceptions: The Owner can never be deleted. And in some circumstances the owner will have access to additional special settings if applicable. For example: billing details, if using <a href=\"https://ghost.org/pricing/\"><strong>Ghost(Pro)</strong></a>.</p><blockquote><em>It\'s a good idea to ask all of your users to fill out their user profiles, including bio and social links. These will populate rich structured data for posts and generally create more opportunities for themes to fully populate their design.</em></blockquote><p>Next up: <a href=\"/organising-content/\">Organising your content</a> </p>','5bebfe6cb1a9c511638ce061','There are a couple of things to do next while you\'re getting set up:\n\nMake your site private\nIf you\'ve got a publication that you don\'t want the world to see yet because\nit\'s not ready to launch, you can hide your Ghost site behind a basic shared\npass-phrase.\n\nYou can toggle this preference on at the bottom of Ghost\'s General Settings\n[/ghost/settings/general/]:\n\nGhost will give you a short, randomly generated pass-phrase which you can share\nwith anyone who needs access to the site while you\'re working on it. While this\nsetting is enabled, all search engine optimisation features will be switched off\nto help keep your site under the radar.\n\nDo remember though, this is not  secure authentication. You shouldn\'t rely on\nthis feature for protecting important private data. It\'s just a simple, shared\npass-phrase for some very basic privacy.\n\n\n--------------------------------------------------------------------------------\n\nInvite your team \nGhost has a number of different user roles for your team:\n\nContributors\nThis is the base user level in Ghost. Contributors can create and edit their own\ndraft posts, but they are unable to edit drafts of others or publish posts.\nContributors are untrusted  users with the most basic access to your\npublication.\n\nAuthors\nAuthors are the 2nd user level in Ghost. Authors can write, edit  and publish\ntheir own posts. Authors are trusted  users. If you don\'t trust users to be\nallowed to publish their own posts, they should be set as Contributors.\n\nEditors\nEditors are the 3rd user level in Ghost. Editors can do everything that an\nAuthor can do, but they can also edit and publish the posts of others - as well\nas their own. Editors can also invite new Contributors+Authors to the site.\n\nAdministrators\nThe top user level in Ghost is Administrator. Again, administrators can do\neverything that Authors and Editors can do, but they can also edit all site\nsettings and data, not just content. Additionally, administrators have full\naccess to invite, manage or remove any other user of the site.\n\nThe Owner\nThere is only ever one owner of a Ghost site. The owner is a special user which\nhas all the same permissions as an Administrator, but with two exceptions: The\nOwner can never be deleted. And in some circumstances the owner will have access\nto additional special settings if applicable. For example: billing details, if\nusing Ghost(Pro) [https://ghost.org/pricing/].\n\nIt\'s a good idea to ask all of your users to fill out their user profiles,\nincluding bio and social links. These will populate rich structured data for\nposts and generally create more opportunities for themes to fully populate their\ndesign.Next up: Organising your content [/organising-content/]','https://static.ghost.org/v2.0.0/images/admin-settings.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:30','1','There are a couple of things to do next while you\'re getting set up: making your site private and inviting your team.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce063','930e8596-a055-4c4e-abc1-2bf7d8b87c41','Publishing options','publishing-options','{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"code\",{\"code\":\"{\\n    \\\"@context\\\": \\\"https://schema.org\\\",\\n    \\\"@type\\\": \\\"Article\\\",\\n    \\\"publisher\\\": {\\n        \\\"@type\\\": \\\"Organization\\\",\\n        \\\"name\\\": \\\"Publishing options\\\",\\n        \\\"logo\\\": \\\"https://static.ghost.org/ghost-logo.svg\\\"\\n    },\\n    \\\"author\\\": {\\n        \\\"@type\\\": \\\"Person\\\",\\n        \\\"name\\\": \\\"Ghost\\\",\\n        \\\"url\\\": \\\"http://demo.ghost.io/author/ghost/\\\",\\n        \\\"sameAs\\\": []\\n    },\\n    \\\"headline\\\": \\\"Publishing options\\\",\\n    \\\"url\\\": \\\"http://demo.ghost.io/publishing-options\\\",\\n    \\\"datePublished\\\": \\\"2018-08-08T11:44:00.000Z\\\",\\n    \\\"dateModified\\\": \\\"2018-08-09T12:06:21.000Z\\\",\\n    \\\"keywords\\\": \\\"Getting Started\\\",\\n    \\\"description\\\": \\\"The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.\\\",\\n    }\\n}\\n    \"}]],\"markups\":[[\"a\",[\"href\",\"https://schema.org/\"]],[\"a\",[\"href\",\"https://search.google.com/structured-data/testing-tool\",\"rel\",\"noreferrer nofollow noopener\"]],[\"strong\"],[\"a\",[\"href\",\"/ghost/settings/code-injection/\"]],[\"a\",[\"href\",\"/admin-settings/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page. \"]]],[1,\"blockquote\",[[0,[],0,\"Access the post settings menu in the top right hand corner of the editor. \"]]],[1,\"h2\",[[0,[],0,\"Post feature image\"]]],[1,\"p\",[[0,[],0,\"Insert your post feature image from the very top of the post settings menu. Consider resizing or optimising your image first to ensure it\'s an appropriate size.\"]]],[1,\"h2\",[[0,[],0,\"Structured data & SEO\"]]],[1,\"p\",[[0,[],0,\"Customise your social media sharing cards for Facebook and Twitter, enabling you to add custom images, titles and descriptions for social media.\"]]],[1,\"p\",[[0,[],0,\"There’s no need to hard code your meta data. You can set your meta title and description using the post settings tool, which has a handy character guide and SERP preview. \"]]],[1,\"p\",[[0,[],0,\"Ghost will automatically implement structured data for your publication using JSON-LD to further optimise your content.\"]]],[10,0],[1,\"p\",[[0,[],0,\"You can test that the structured data \"],[0,[0],1,\"schema\"],[0,[],0,\" on your site is working as it should using \"],[0,[1],1,\"Google’s structured data tool\"],[0,[],0,\". \"]]],[1,\"h2\",[[0,[],0,\"Code Injection\"]]],[1,\"p\",[[0,[],0,\"This tool allows you to inject code on a per post or page basis, or across your entire site. This means you can modify CSS, add unique tracking codes, or add other scripts to the head or foot of your publication without making edits to your theme files. \"]]],[1,\"p\",[[0,[2],1,\"To add code site-wide\"],[0,[],0,\", use the code injection tool \"],[0,[3],1,\"in the main admin menu\"],[0,[],0,\". This is useful for adding a Facebook Pixel, a Google Analytics tracking code, or to start tracking with any other analytics tool.\"]]],[1,\"p\",[[0,[2],1,\"To add code to a post or page\"],[0,[],0,\", use the code injection tool within the post settings menu. This is useful if you want to add art direction, scripts or styles that are only applicable to one post or page. \"]]],[1,\"p\",[[0,[],0,\"From here, you might be interested in managing some more specific \"],[0,[4],1,\"admin settings\"],[0,[],0,\"!\"]]]]}','<p>The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page. </p><blockquote>Access the post settings menu in the top right hand corner of the editor. </blockquote><h2 id=\"post-feature-image\">Post feature image</h2><p>Insert your post feature image from the very top of the post settings menu. Consider resizing or optimising your image first to ensure it\'s an appropriate size.</p><h2 id=\"structured-data-seo\">Structured data &amp; SEO</h2><p>Customise your social media sharing cards for Facebook and Twitter, enabling you to add custom images, titles and descriptions for social media.</p><p>There’s no need to hard code your meta data. You can set your meta title and description using the post settings tool, which has a handy character guide and SERP preview. </p><p>Ghost will automatically implement structured data for your publication using JSON-LD to further optimise your content.</p><pre><code>{\n    \"@context\": \"https://schema.org\",\n    \"@type\": \"Article\",\n    \"publisher\": {\n        \"@type\": \"Organization\",\n        \"name\": \"Publishing options\",\n        \"logo\": \"https://static.ghost.org/ghost-logo.svg\"\n    },\n    \"author\": {\n        \"@type\": \"Person\",\n        \"name\": \"Ghost\",\n        \"url\": \"http://demo.ghost.io/author/ghost/\",\n        \"sameAs\": []\n    },\n    \"headline\": \"Publishing options\",\n    \"url\": \"http://demo.ghost.io/publishing-options\",\n    \"datePublished\": \"2018-08-08T11:44:00.000Z\",\n    \"dateModified\": \"2018-08-09T12:06:21.000Z\",\n    \"keywords\": \"Getting Started\",\n    \"description\": \"The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.\",\n    }\n}\n    </code></pre><p>You can test that the structured data <a href=\"https://schema.org/\">schema</a> on your site is working as it should using <a href=\"https://search.google.com/structured-data/testing-tool\" rel=\"noreferrer nofollow noopener\">Google’s structured data tool</a>. </p><h2 id=\"code-injection\">Code Injection</h2><p>This tool allows you to inject code on a per post or page basis, or across your entire site. This means you can modify CSS, add unique tracking codes, or add other scripts to the head or foot of your publication without making edits to your theme files. </p><p><strong>To add code site-wide</strong>, use the code injection tool <a href=\"/ghost/settings/code-injection/\">in the main admin menu</a>. This is useful for adding a Facebook Pixel, a Google Analytics tracking code, or to start tracking with any other analytics tool.</p><p><strong>To add code to a post or page</strong>, use the code injection tool within the post settings menu. This is useful if you want to add art direction, scripts or styles that are only applicable to one post or page. </p><p>From here, you might be interested in managing some more specific <a href=\"/admin-settings/\">admin settings</a>!</p>','5bebfe6cb1a9c511638ce063','The Ghost editor has everything you need to fully optimise your content. This is\nwhere you can add tags and authors, feature a post, or turn a post into a page. \n\nAccess the post settings menu in the top right hand corner of the editor. Post\nfeature image\nInsert your post feature image from the very top of the post settings menu.\nConsider resizing or optimising your image first to ensure it\'s an appropriate\nsize.\n\nStructured data & SEO\nCustomise your social media sharing cards for Facebook and Twitter, enabling you\nto add custom images, titles and descriptions for social media.\n\nThere’s no need to hard code your meta data. You can set your meta title and\ndescription using the post settings tool, which has a handy character guide and\nSERP preview. \n\nGhost will automatically implement structured data for your publication using\nJSON-LD to further optimise your content.\n\n{\n    \"@context\": \"https://schema.org\",\n    \"@type\": \"Article\",\n    \"publisher\": {\n        \"@type\": \"Organization\",\n        \"name\": \"Publishing options\",\n        \"logo\": \"https://static.ghost.org/ghost-logo.svg\"\n    },\n    \"author\": {\n        \"@type\": \"Person\",\n        \"name\": \"Ghost\",\n        \"url\": \"http://demo.ghost.io/author/ghost/\",\n        \"sameAs\": []\n    },\n    \"headline\": \"Publishing options\",\n    \"url\": \"http://demo.ghost.io/publishing-options\",\n    \"datePublished\": \"2018-08-08T11:44:00.000Z\",\n    \"dateModified\": \"2018-08-09T12:06:21.000Z\",\n    \"keywords\": \"Getting Started\",\n    \"description\": \"The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.\",\n    }\n}\n    \n\nYou can test that the structured data schema [https://schema.org/]  on your site\nis working as it should using Google’s structured data tool\n[https://search.google.com/structured-data/testing-tool]. \n\nCode Injection\nThis tool allows you to inject code on a per post or page basis, or across your\nentire site. This means you can modify CSS, add unique tracking codes, or add\nother scripts to the head or foot of your publication without making edits to\nyour theme files. \n\nTo add code site-wide, use the code injection tool in the main admin menu\n[/ghost/settings/code-injection/]. This is useful for adding a Facebook Pixel, a\nGoogle Analytics tracking code, or to start tracking with any other analytics\ntool.\n\nTo add code to a post or page, use the code injection tool within the post\nsettings menu. This is useful if you want to add art direction, scripts or\nstyles that are only applicable to one post or page. \n\nFrom here, you might be interested in managing some more specific admin settings\n[/admin-settings/]!','https://static.ghost.org/v2.0.0/images/publishing-options.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:31','1','The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce065','ebac8f3e-a64c-4881-8486-acd4391735b5','Writing posts with Ghost ✍️','the-editor','{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"image\",{\"src\":\"https://static.ghost.org/v2.0.0/images/formatting-editor-demo.gif\"}],[\"code\",{\"code\":\"<header class=\\\"site-header outer\\\">\\n    <div class=\\\"inner\\\">\\n        {{> \\\"site-nav\\\"}}\\n    </div>\\n</header>\"}],[\"image\",{\"src\":\"https://static.ghost.org/v2.0.0/images/using-images-demo.gif\"}]],\"markups\":[[\"strong\"],[\"code\"],[\"a\",[\"href\",\"/publishing-options/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Ghost has a powerful visual editor with familiar formatting options, as well as the ability to seamlessly add dynamic content. \"]]],[1,\"p\",[[0,[],0,\"Select the text to add formatting, headers or create links, or use Markdown shortcuts to do the work for you - if that\'s your thing. \"]]],[10,0],[1,\"h2\",[[0,[],0,\"Rich editing at your fingertips\"]]],[1,\"p\",[[0,[],0,\"The editor can also handle rich media objects, called \"],[0,[0],1,\"cards\"],[0,[],0,\". \"]]],[1,\"p\",[[0,[],0,\"You can insert a card either by clicking the  \"],[0,[1],1,\"+\"],[0,[],0,\"  button on a new line, or typing  \"],[0,[1],1,\"/\"],[0,[],0,\"  on a new line to search for a particular card. This allows you to efficiently insert\"],[0,[0],1,\" images\"],[0,[],0,\", \"],[0,[0],1,\"markdown\"],[0,[],0,\", \"],[0,[0],1,\"html\"],[0,[],0,\" and \"],[0,[0],1,\"embeds\"],[0,[],0,\".\"]]],[1,\"p\",[[0,[0],1,\"For Example\"],[0,[],0,\":\"]]],[3,\"ul\",[[[0,[],0,\"Insert a video from YouTube directly into your content by pasting the URL \"]],[[0,[],0,\"Create unique content like a button or content opt-in using the HTML card\"]],[[0,[],0,\"Need to share some code? Embed code blocks directly \"]]]],[10,1],[1,\"h1\",[[0,[],0,\"Working with images in posts\"]]],[1,\"p\",[[0,[],0,\"You can add images to your posts in many ways:\"]]],[3,\"ul\",[[[0,[],0,\"Upload from your computer\"]],[[0,[],0,\"Click and drag an image into the browser\"]],[[0,[],0,\"Paste directly into the editor from your clipboard\"]],[[0,[],0,\"Insert using a URL\"]]]],[1,\"p\",[[0,[],0,\"Once inserted you can blend images beautifully into your content at different sizes and add captions wherever needed.\"]]],[10,2],[1,\"p\",[[0,[],0,\"The post settings menu and publishing options can be found in the top right hand corner. For more advanced tips on post settings check out the \"],[0,[2],1,\"publishing options\"],[0,[],0,\" post!\"]]],[1,\"p\",[]]]}','<p>Ghost has a powerful visual editor with familiar formatting options, as well as the ability to seamlessly add dynamic content. </p><p>Select the text to add formatting, headers or create links, or use Markdown shortcuts to do the work for you - if that\'s your thing. </p><figure class=\"kg-card kg-image-card\"><img src=\"https://static.ghost.org/v2.0.0/images/formatting-editor-demo.gif\" class=\"kg-image\"></figure><h2 id=\"rich-editing-at-your-fingertips\">Rich editing at your fingertips</h2><p>The editor can also handle rich media objects, called <strong>cards</strong>. </p><p>You can insert a card either by clicking the  <code>+</code>  button on a new line, or typing  <code>/</code>  on a new line to search for a particular card. This allows you to efficiently insert<strong> images</strong>, <strong>markdown</strong>, <strong>html</strong> and <strong>embeds</strong>.</p><p><strong>For Example</strong>:</p><ul><li>Insert a video from YouTube directly into your content by pasting the URL </li><li>Create unique content like a button or content opt-in using the HTML card</li><li>Need to share some code? Embed code blocks directly </li></ul><pre><code>&lt;header class=\"site-header outer\"&gt;\n    &lt;div class=\"inner\"&gt;\n        {{&gt; \"site-nav\"}}\n    &lt;/div&gt;\n&lt;/header&gt;</code></pre><h1 id=\"working-with-images-in-posts\">Working with images in posts</h1><p>You can add images to your posts in many ways:</p><ul><li>Upload from your computer</li><li>Click and drag an image into the browser</li><li>Paste directly into the editor from your clipboard</li><li>Insert using a URL</li></ul><p>Once inserted you can blend images beautifully into your content at different sizes and add captions wherever needed.</p><figure class=\"kg-card kg-image-card\"><img src=\"https://static.ghost.org/v2.0.0/images/using-images-demo.gif\" class=\"kg-image\"></figure><p>The post settings menu and publishing options can be found in the top right hand corner. For more advanced tips on post settings check out the <a href=\"/publishing-options/\">publishing options</a> post!</p>','5bebfe6cb1a9c511638ce065','Ghost has a powerful visual editor with familiar formatting options, as well as\nthe ability to seamlessly add dynamic content. \n\nSelect the text to add formatting, headers or create links, or use Markdown\nshortcuts to do the work for you - if that\'s your thing. \n\nRich editing at your fingertips\nThe editor can also handle rich media objects, called cards. \n\nYou can insert a card either by clicking the+   button on a new line, or typing/ \n  on a new line to search for a particular card. This allows you to efficiently\ninsert  images, markdown, html  and embeds.\n\nFor Example:\n\n * Insert a video from YouTube directly into your content by pasting the URL \n * Create unique content like a button or content opt-in using the HTML card\n * Need to share some code? Embed code blocks directly \n\n<header class=\"site-header outer\">\n    <div class=\"inner\">\n        {{> \"site-nav\"}}\n    </div>\n</header>\n\nWorking with images in posts\nYou can add images to your posts in many ways:\n\n * Upload from your computer\n * Click and drag an image into the browser\n * Paste directly into the editor from your clipboard\n * Insert using a URL\n\nOnce inserted you can blend images beautifully into your content at different\nsizes and add captions wherever needed.\n\nThe post settings menu and publishing options can be found in the top right hand\ncorner. For more advanced tips on post settings check out the publishing options\n[/publishing-options/]  post!','https://static.ghost.org/v2.0.0/images/writing-posts-with-ghost.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:32','1','Getting started with the editor is simple, with familiar formatting options in a functional toolbar and the ability to add dynamic content seamlessly.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	('5bebfe6cb1a9c511638ce067','dbc0ea73-4402-4dc9-8f5f-4532d2512bde','Welcome to Ghost1','welcome','{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://ghost.org/downloads/\"]],[\"a\",[\"href\",\"https://ghost.org/pricing\"]],[\"a\",[\"href\",\"https://github.com/TryGhost\"]],[\"a\",[\"href\",\"/the-editor/\"]],[\"em\"]],\"sections\":[[1,\"p\",[[0,[],0,\"? Welcome, it\'s great to have you here.\"]]],[1,\"p\",[[0,[],0,\"We know that first impressions are important, so we\'ve populated your new site with some initial \"],[0,[0],1,\"getting started\"],[0,[],0,\" posts that will help you get familiar with everything in no time. This is the first one!\"]]],[1,\"p\",[[0,[0],1,\"A few things you should know upfront\"],[0,[],0,\":\"]]],[3,\"ol\",[[[0,[],0,\"Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That\'s who it works best for. \"]],[[0,[],0,\"The entire platform can be modified and customised to suit your needs. It\'s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. \"]],[[0,[],0,\"For the best experience we recommend downloading the \"],[0,[1],1,\"Ghost Desktop App\"],[0,[],0,\" for your computer, which is the best way to access your Ghost site on a desktop device. \"]]]],[1,\"p\",[[0,[],0,\"Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our \"],[0,[2],1,\"Ghost(Pro)\"],[0,[],0,\" service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing.\"]]],[1,\"p\",[[0,[],0,\"The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source \"],[0,[3],1,\"community\"],[0,[],0,\".\"]]],[1,\"h2\",[[0,[],0,\"Next up, the editor\"]]],[1,\"p\",[[0,[],0,\"The main thing you\'ll want to read about next is probably: \"],[0,[4],1,\"the Ghost editor\"],[0,[],0,\". This is where the good stuff happens.\"]]],[1,\"blockquote\",[[0,[5],0,\"By the way, once you\'re done reading, you can simply delete the default \"],[0,[0],1,\"Ghost\"],[0,[],1,\" user from your team to remove all of these introductory posts! \"]]]]}','<p>? Welcome, it\'s great to have you here.</p><p>We know that first impressions are important, so we\'ve populated your new site with some initial <strong>getting started</strong> posts that will help you get familiar with everything in no time. This is the first one!</p><p><strong>A few things you should know upfront</strong>:</p><ol><li>Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That\'s who it works best for. </li><li>The entire platform can be modified and customised to suit your needs. It\'s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. </li><li>For the best experience we recommend downloading the <a href=\"https://ghost.org/downloads/\">Ghost Desktop App</a> for your computer, which is the best way to access your Ghost site on a desktop device. </li></ol><p>Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our <a href=\"https://ghost.org/pricing\">Ghost(Pro)</a> service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing.</p><p>The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source <a href=\"https://github.com/TryGhost\">community</a>.</p><h2 id=\"next-up-the-editor\">Next up, the editor</h2><p>The main thing you\'ll want to read about next is probably: <a href=\"/the-editor/\">the Ghost editor</a>. This is where the good stuff happens.</p><blockquote><em>By the way, once you\'re done reading, you can simply delete the default <strong>Ghost</strong> user from your team to remove all of these introductory posts! </em></blockquote>','5bebfe6cb1a9c511638ce067','? Welcome, it\'s great to have you here.\n\nWe know that first impressions are important, so we\'ve populated your new site\nwith some initial getting started  posts that will help you get familiar with\neverything in no time. This is the first one!\n\nA few things you should know upfront:\n\n 1. Ghost is designed for ambitious, professional publishers who want to\n    actively build a business around their content. That\'s who it works best\n    for. \n 2. The entire platform can be modified and customised to suit your needs. It\'s\n    very powerful, but does require some knowledge of code. Ghost is not\n    necessarily a good platform for beginners or people who just want a simple\n    personal blog. \n 3. For the best experience we recommend downloading the Ghost Desktop App\n    [https://ghost.org/downloads/]  for your computer, which is the best way to\n    access your Ghost site on a desktop device. \n\nGhost is made by an independent non-profit organisation called the Ghost\nFoundation. We are 100% self funded by revenue from our Ghost(Pro)\n[https://ghost.org/pricing]  service, and every penny we make is re-invested\ninto funding further development of free, open source technology for modern\npublishing.\n\nThe version of Ghost you are looking at right now would not have been made\npossible without generous contributions from the open source community\n[https://github.com/TryGhost].\n\nNext up, the editor\nThe main thing you\'ll want to read about next is probably: the Ghost editor\n[/the-editor/]. This is where the good stuff happens.\n\nBy the way, once you\'re done reading, you can simply delete the default Ghost \nuser from your team to remove all of these introductory posts!','https://static.ghost.org/v2.0.0/images/welcome-to-ghost.jpg',0,0,'published',NULL,'public',NULL,NULL,'5951f5fca366002ebd5dbef7','2018-11-14 10:52:28','1','2018-11-14 10:52:28','1','2018-11-14 10:52:33','1','Welcome, it\'s great to have you here.\nWe know that first impressions are important, so we\'ve populated your new site with some initial getting started posts that will help you get familiar with everything in no time.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table posts_authors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts_authors`;

CREATE TABLE `posts_authors` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `author_id` varchar(24) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_authors_post_id_foreign` (`post_id`),
  KEY `posts_authors_author_id_foreign` (`author_id`),
  CONSTRAINT `posts_authors_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `posts_authors_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `posts_authors` WRITE;
/*!40000 ALTER TABLE `posts_authors` DISABLE KEYS */;

INSERT INTO `posts_authors` (`id`, `post_id`, `author_id`, `sort_order`)
VALUES
	('5bebfe6cb1a9c511638ce05c','5bebfe6bb1a9c511638ce05b','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce05e','5bebfe6cb1a9c511638ce05d','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce060','5bebfe6cb1a9c511638ce05f','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce062','5bebfe6cb1a9c511638ce061','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce064','5bebfe6cb1a9c511638ce063','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce066','5bebfe6cb1a9c511638ce065','5951f5fca366002ebd5dbef7',0),
	('5bebfe6cb1a9c511638ce068','5bebfe6cb1a9c511638ce067','5951f5fca366002ebd5dbef7',0);

/*!40000 ALTER TABLE `posts_authors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table posts_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts_tags`;

CREATE TABLE `posts_tags` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `tag_id` varchar(24) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_tags_post_id_foreign` (`post_id`),
  KEY `posts_tags_tag_id_foreign` (`tag_id`),
  CONSTRAINT `posts_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `posts_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `posts_tags` WRITE;
/*!40000 ALTER TABLE `posts_tags` DISABLE KEYS */;

INSERT INTO `posts_tags` (`id`, `post_id`, `tag_id`, `sort_order`)
VALUES
	('5bebfe6db1a9c511638ce121','5bebfe6bb1a9c511638ce05b','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce122','5bebfe6cb1a9c511638ce05d','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce123','5bebfe6cb1a9c511638ce05f','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce124','5bebfe6cb1a9c511638ce061','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce125','5bebfe6cb1a9c511638ce063','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce126','5bebfe6cb1a9c511638ce065','5bebfe67b1a9c511638ce00f',0),
	('5bebfe6db1a9c511638ce127','5bebfe6cb1a9c511638ce067','5bebfe67b1a9c511638ce00f',0);

/*!40000 ALTER TABLE `posts_tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table refreshtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `refreshtokens`;

CREATE TABLE `refreshtokens` (
  `id` varchar(24) NOT NULL,
  `token` varchar(191) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `expires` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refreshtokens_token_unique` (`token`),
  KEY `refreshtokens_user_id_foreign` (`user_id`),
  KEY `refreshtokens_client_id_foreign` (`client_id`),
  CONSTRAINT `refreshtokens_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `refreshtokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5bebfe67b1a9c511638ce014','Administrator','Administrators','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce015','Editor','Editors','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce016','Author','Authors','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce017','Contributor','Contributors','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce018','Owner','Blog Owner','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1'),
	('5bebfe67b1a9c511638ce019','Admin Integration','External Apps','2018-11-14 10:52:23','1','2018-11-14 10:52:23','1');

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table roles_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles_users`;

CREATE TABLE `roles_users` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;

INSERT INTO `roles_users` (`id`, `role_id`, `user_id`)
VALUES
	('5bebfe6bb1a9c511638ce05a','5bebfe67b1a9c511638ce016','5951f5fca366002ebd5dbef7'),
	('5bebfe6db1a9c511638ce128','5bebfe67b1a9c511638ce018','1');

/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(24) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `session_data` varchar(2000) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sessions_session_id_unique` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;


/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'core',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5bebfe8eb05d25116a4fe0a3','db_hash','2ec19f29-ab47-487b-87d3-7b4e74ec5748','core','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0a4','next_update_check','1542492274','core','2018-11-14 10:53:02','1','2018-11-16 22:04:34','1'),
	('5bebfe8eb05d25116a4fe0a5','notifications','[]','core','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0a6','session_secret','e9529772c97ec9511180f7db75b2d1e30aa9cb36d4ce186df4cc597dbeadcde8','core','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0a7','title','Jay','blog','2018-11-14 10:53:02','1','2018-11-14 11:55:34','1'),
	('5bebfe8eb05d25116a4fe0a8','description','Thoughts, stories and ideas.','blog','2018-11-14 10:53:02','1','2018-11-14 11:55:34','1'),
	('5bebfe8eb05d25116a4fe0a9','logo','https://static.ghost.org/v1.0.0/images/ghost-logo.svg','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0aa','cover_image','https://static.ghost.org/v1.0.0/images/blog-cover.jpg','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0ab','icon','','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0ac','default_locale','en','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0ad','active_timezone','Etc/UTC','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0ae','force_i18n','true','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0af','permalinks','/:slug/','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b0','amp','true','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b1','ghost_head','','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b2','ghost_foot','','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b3','facebook','ghost','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b4','twitter','tryghost','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b5','labs','{\"publicAPI\": true}','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b6','navigation','[{\"label\":\"Home\", \"url\":\"/\"},{\"label\":\"Tag\", \"url\":\"/tag/getting-started/\"}, {\"label\":\"Author\", \"url\":\"/author/ghost/\"},{\"label\":\"Help\", \"url\":\"https://help.ghost.org\"}]','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b7','slack','[{\"url\":\"\"}]','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b8','unsplash','{\"isActive\": true}','blog','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0b9','active_theme','casper','theme','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0ba','active_apps','[]','app','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0bb','installed_apps','[]','app','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0bc','is_private','false','private','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0bd','password','','private','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1'),
	('5bebfe8eb05d25116a4fe0be','public_hash','999058237a39cf82001da460229ccf','private','2018-11-14 10:53:02','1','2018-11-14 10:53:02','1');

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table subscribers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subscribers`;

CREATE TABLE `subscribers` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `post_id` varchar(24) DEFAULT NULL,
  `subscribed_url` varchar(2000) DEFAULT NULL,
  `subscribed_referrer` varchar(2000) DEFAULT NULL,
  `unsubscribed_url` varchar(2000) DEFAULT NULL,
  `unsubscribed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text,
  `feature_image` varchar(2000) DEFAULT NULL,
  `parent_id` varchar(191) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;

INSERT INTO `tags` (`id`, `name`, `slug`, `description`, `feature_image`, `parent_id`, `visibility`, `meta_title`, `meta_description`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5bebfe67b1a9c511638ce00f','Getting Started','getting-started',NULL,NULL,NULL,'public',NULL,NULL,'2018-11-14 10:52:23','1','2018-11-14 10:52:23','1');

/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `ghost_auth_access_token` varchar(32) DEFAULT NULL,
  `ghost_auth_id` varchar(24) DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(191) NOT NULL,
  `profile_image` varchar(2000) DEFAULT NULL,
  `cover_image` varchar(2000) DEFAULT NULL,
  `bio` text,
  `website` varchar(2000) DEFAULT NULL,
  `location` text,
  `facebook` varchar(2000) DEFAULT NULL,
  `twitter` varchar(2000) DEFAULT NULL,
  `accessibility` text,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `tour` text,
  `last_seen` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_slug_unique` (`slug`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `slug`, `ghost_auth_access_token`, `ghost_auth_id`, `password`, `email`, `profile_image`, `cover_image`, `bio`, `website`, `location`, `facebook`, `twitter`, `accessibility`, `status`, `locale`, `visibility`, `meta_title`, `meta_description`, `tour`, `last_seen`, `created_at`, `created_by`, `updated_at`, `updated_by`)
VALUES
	('5951f5fca366002ebd5dbef7','Ghost','ghost',NULL,NULL,'$2a$10$ggcffevq3/oeJIA4JhzJ4.HBN16C6KnBF43x/egnXOZkwiBLbL.','ghost-author@example.com','https://static.ghost.org/v2.0.0/images/ghost.png',NULL,'You can delete this user to remove all the welcome posts','https://ghost.org','The Internet','ghost','tryghost',NULL,'active',NULL,'public',NULL,NULL,NULL,NULL,'2018-11-14 10:52:25','1','2018-11-14 10:52:25','1');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table webhooks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webhooks`;

CREATE TABLE `webhooks` (
  `id` varchar(24) NOT NULL,
  `event` varchar(50) NOT NULL,
  `target_url` varchar(2000) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `secret` varchar(191) DEFAULT NULL,
  `api_version` varchar(50) NOT NULL DEFAULT 'v2',
  `integration_id` varchar(24) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'available',
  `last_triggered_at` datetime DEFAULT NULL,
  `last_triggered_status` varchar(50) DEFAULT NULL,
  `last_triggered_error` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
