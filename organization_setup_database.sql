DROP DATABASE IF EXISTS `organization_setup_database`;
CREATE DATABASE `organization_setup_database`
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `organization_setup_database`;

-- users table
CREATE TABLE IF NOT EXISTS `users` (
  `users_id` char(36) NOT NULL DEFAULT (uuid()),
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `auth_source` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `employee_id` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  `group` varchar(200) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `password_hash` varchar(255) NOT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_admin` tinyint(1) DEFAULT NULL,
  `manager_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`users_id`)
);

-- roles
CREATE TABLE IF NOT EXISTS `roles` (
  `roles_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `permissions` json DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`roles_id`)
);

-- user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_roles_id` varchar(255) NOT NULL,
  `users_id` varchar(255) DEFAULT NULL,
  `roles_id` varchar(255) DEFAULT NULL,
  `assigned_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user_roles_id`)
);

-- refresh_tokens
CREATE TABLE IF NOT EXISTS `refresh_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` char(36) NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL,
  `is_revoked` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- organization_profile
CREATE TABLE IF NOT EXISTS `organization_profile` (
  `organization_id` char(36) NOT NULL DEFAULT(uuid()),
  `organization_name` varchar(200) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) NOT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`organization_id`)
);
