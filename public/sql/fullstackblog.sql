-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.2.3-MariaDB-log - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table fullstack.blogcategories
CREATE TABLE IF NOT EXISTS `blogcategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.blogcategories: ~0 rows (approximately)
/*!40000 ALTER TABLE `blogcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogcategories` ENABLE KEYS */;

-- Dumping structure for table fullstack.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `featuredImage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metaDescription` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blogs_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.blogs: ~0 rows (approximately)
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;

-- Dumping structure for table fullstack.blogtags
CREATE TABLE IF NOT EXISTS `blogtags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.blogtags: ~0 rows (approximately)
/*!40000 ALTER TABLE `blogtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogtags` ENABLE KEYS */;

-- Dumping structure for table fullstack.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `iconImage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.categories: ~0 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `categoryName`, `iconImage`, `created_at`, `updated_at`) VALUES
	(1, 'laravel', '/uploads/category/1614276679.jpg', '2021-02-25 18:11:23', '2021-02-25 18:11:23');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table fullstack.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table fullstack.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.migrations: ~9 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2021_02_19_130741_create_categories_table', 1),
	(5, '2021_02_19_130910_create_tags_table', 1),
	(6, '2021_02_19_131227_create_blogs_table', 1),
	(7, '2021_02_19_131242_create_blogtags_table', 1),
	(8, '2021_02_19_131300_create_blogcategories_table', 1),
	(9, '2021_02_24_174519_create_roles_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table fullstack.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table fullstack.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `roleName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAdmin` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `roleName`, `permission`, `isAdmin`, `created_at`, `updated_at`) VALUES
	(1, 'Admin', '[{"resourceName":"Home","read":true,"write":true,"update":true,"delete":true,"name":"/"},{"resourceName":"Role","read":true,"write":false,"update":false,"delete":false,"name":"role"},{"resourceName":"Assign Role","read":true,"write":true,"update":true,"delete":true,"name":"assignRole"},{"resourceName":"Admin User","read":true,"write":true,"update":true,"delete":true,"name":"adminUser"},{"resourceName":"Tag","read":true,"write":true,"update":true,"delete":true,"name":"tag"},{"resourceName":"Category","read":true,"write":true,"update":true,"delete":true,"name":"category"}]', 1, '2021-02-26 00:10:28', '2021-03-01 18:24:52'),
	(2, 'User', '[{"resourceName":"Home","read":true,"write":true,"update":true,"delete":true,"name":"/"},{"resourceName":"Role","read":false,"write":false,"update":false,"delete":false,"name":"role"},{"resourceName":"Assign Role","read":false,"write":false,"update":false,"delete":false,"name":"assignRole"},{"resourceName":"Admin User","read":false,"write":false,"update":false,"delete":false,"name":"adminUser"},{"resourceName":"Tag","read":true,"write":true,"update":false,"delete":false,"name":"tag"},{"resourceName":"Category","read":true,"write":true,"update":false,"delete":false,"name":"category"}]', 0, '2021-02-26 00:10:32', '2021-02-28 16:55:14'),
	(3, 'Editor', '[{"resourceName":"Home","read":true,"write":true,"update":true,"delete":false,"name":"/"},{"resourceName":"Role","read":false,"write":false,"update":false,"delete":false,"name":"role"},{"resourceName":"Assign Role","read":false,"write":false,"update":false,"delete":false,"name":"assignRole"},{"resourceName":"Admin User","read":false,"write":false,"update":false,"delete":false,"name":"adminUser"},{"resourceName":"Tag","read":true,"write":true,"update":true,"delete":false,"name":"tag"},{"resourceName":"Category","read":true,"write":true,"update":true,"delete":false,"name":"category"}]', 1, '2021-02-25 18:09:58', '2021-02-28 16:54:36'),
	(4, 'Modarator', '[{"resourceName":"Home","read":true,"write":true,"update":true,"delete":true,"name":"/"},{"resourceName":"Role","read":true,"write":true,"update":false,"delete":true,"name":"role"},{"resourceName":"Assign Role","read":true,"write":true,"update":false,"delete":true,"name":"assignRole"},{"resourceName":"Admin User","read":true,"write":false,"update":false,"delete":false,"name":"adminUser"},{"resourceName":"Tag","read":true,"write":false,"update":false,"delete":false,"name":"tag"},{"resourceName":"Category","read":true,"write":false,"update":false,"delete":false,"name":"category"}]', 1, '2021-02-25 19:25:18', '2021-03-01 18:23:56');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table fullstack.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tagName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.tags: ~2 rows (approximately)
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` (`id`, `tagName`, `created_at`, `updated_at`) VALUES
	(1, 'php', '2021-02-25 18:09:27', '2021-02-25 18:09:27'),
	(2, 'java', '2021-02-25 19:47:21', '2021-02-25 19:47:21'),
	(3, 'python', '2021-03-01 18:37:48', '2021-03-01 18:37:48');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;

-- Dumping structure for table fullstack.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fullName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `isActivated` tinyint(1) NOT NULL DEFAULT 0,
  `passwordResetCode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activationCode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `socialType` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table fullstack.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `fullName`, `email`, `password`, `role_id`, `isActivated`, `passwordResetCode`, `activationCode`, `socialType`, `created_at`, `updated_at`) VALUES
	(1, 'Ashanur', 'ashanour009@gmail.com', '$2y$10$17H7bVv8eTnABN03EVfLYOexR.1eo5bbaDccdVj/agBPaygb.mMVq', 1, 0, NULL, NULL, NULL, '2021-02-25 18:06:04', '2021-02-25 18:06:04'),
	(2, 'shojib', 'shojib@gmail.com', '$2y$10$QBJ4saXO7pKdUUDStR/bf./YEEZ0tmbkvv9u9WTg3VeQ2J9elD/be', 3, 0, NULL, NULL, NULL, '2021-02-25 18:37:36', '2021-02-25 18:37:36'),
	(3, 'sagor', 'sagor@gmail.com', '$2y$10$HIBBL2sVXgHzsFwRuKJnjOf0cHB8QB6RIUZaPh3UzzGJR8M1zkSrq', 1, 0, NULL, NULL, NULL, '2021-02-25 18:40:05', '2021-02-25 19:20:33');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
