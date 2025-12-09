DROP DATABASE IF EXISTS `timesheet_database`;
CREATE DATABASE `timesheet_database`
  /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `timesheet_database`;

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
  `roles_id` char(36) NOT NULL DEFAULT (uuid()),
  `name` varchar(100) NOT NULL,
  `description` text,
  `permissions` json DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`roles_id`)
);

-- user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_roles_id` char(36) NOT NULL DEFAULT (uuid()),
  `users_id` char(36) NOT NULL,
  `roles_id` char(36) NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
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

-- organisation
CREATE TABLE IF NOT EXISTS `organisation` (
  `organisation_id` char(36) NOT NULL DEFAULT (uuid()),
  `name` varchar(200) NOT NULL,
  `client_id` varchar(300) NOT NULL,
  `client_secret` varchar(300) NOT NULL,
  `redirect_uri` varchar(300) NOT NULL,
  `authority` varchar(300) NOT NULL,
  `scopes` varchar(300) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`organisation_id`)
);

-- accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `accounts_id` char(36) NOT NULL DEFAULT (uuid()),
  `organisation_id` char(36) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`accounts_id`)
);

-- projects
CREATE TABLE IF NOT EXISTS `projects` (
  `projects_id` char(36) NOT NULL DEFAULT (uuid()),
  `accounts_id` char(36) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text,
  `client_name` varchar(200) DEFAULT NULL,
  `project_code` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `budget` decimal(15,2) DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `is_billable` tinyint(1) DEFAULT '1',
  `total_billable_hours` varchar(100) DEFAULT NULL,
  `billable_hours_per_day` varchar(100) DEFAULT NULL,
  `total_non_billable_hours` varchar(100) DEFAULT NULL,
  `non_billable_hours_per_day` varchar(100) DEFAULT NULL,
  `total_timesheets` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`projects_id`)
);

-- project_bill_code
CREATE TABLE IF NOT EXISTS `project_bill_code` (
  `project_billable_id` char(36) NOT NULL DEFAULT (uuid()),
  `project_bill_codes` varchar(100) NOT NULL,
  `project_description` varchar(500) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`project_billable_id`)
);

-- project_assignments
CREATE TABLE IF NOT EXISTS `project_assignments` (
  `project_assignments_id` char(36) NOT NULL DEFAULT (uuid()),
  `pa_users_id` char(36) NOT NULL,
  `projects_id` char(36) NOT NULL,
  `project_billable_id` char(36) NOT NULL,
  `role_in_project` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_assignments_id`)
);

-- timesheet
CREATE TABLE IF NOT EXISTS `timesheet` (
  `timesheet_id` char(36) NOT NULL DEFAULT (uuid()),
  `projects_assignments_id` char(36) NOT NULL,
  `monday` decimal(10,1) DEFAULT NULL,
  `tuesday` decimal(10,1) DEFAULT NULL,
  `wednesday` decimal(10,1) DEFAULT NULL,
  `thursday` decimal(10,1) DEFAULT NULL,
  `friday` decimal(10,1) DEFAULT NULL,
  `saturday` decimal(10,1) DEFAULT NULL,
  `sunday` decimal(10,1) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_hours_worked` decimal(5,2) NOT NULL,
  `overtime_hours` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'draft',
  `rejected_reason` varchar(500) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `notes` text,
  `bill_code` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_approved` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`timesheet_id`)
);
