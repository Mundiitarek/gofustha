-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 16, 2026 at 06:11 PM
-- Server version: 8.4.8-cll-lve
-- PHP Version: 8.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smm2355_almarket`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int NOT NULL,
  `user_type` enum('admin','user','vendor','driver','system') COLLATE utf8mb4_unicode_ci DEFAULT 'system',
  `user_id` int DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `data` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON data',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_type`, `user_id`, `action`, `description`, `ip_address`, `user_agent`, `data`, `created_at`) VALUES
(1, 'user', 1, 'register', 'تسجيل حساب جديد', '81.245.111.195', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-16 15:59:22'),
(2, 'user', 1, 'login', 'تسجيل دخول', '81.245.111.195', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-16 15:59:22'),
(3, 'user', 2, 'register', 'تسجيل حساب جديد', '81.245.111.195', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-16 16:09:41'),
(4, 'user', 2, 'login', 'تسجيل دخول', '81.245.111.195', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', NULL, '2026-04-16 16:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'المنزل',
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `building` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apartment` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landmark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('super','manager','support') COLLATE utf8mb4_unicode_ci DEFAULT 'manager',
  `status` tinyint(1) DEFAULT '1',
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `phone`, `password_hash`, `role`, `status`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'المدير العام', '0500000000', '$2y$10$mPg3lhh5/Wy32wMg7QN1HuclZ/zfmQYXDGjTmHsbqp0zZyrRCGVdm', 'super', 1, NULL, '2026-04-14 02:31:13', '2026-04-16 11:06:53'),
(3, 'Muhand Tariq', '555555000', '$2y$10$GiG9sOTq.TAhQ2RUywxsy.pLAaFrm3N1c0G5PurrKn5NAquYBxVg2', 'super', 1, NULL, '2026-04-16 15:58:20', '2026-04-16 12:58:20');

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` int NOT NULL,
  `zone_id` int NOT NULL,
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `zone_id`, `name_ar`, `name_en`, `status`, `created_at`) VALUES
(1, 1, 'العليا', 'Olaya', 1, '2026-04-14 02:31:13'),
(2, 1, 'السليمانية', 'Sulimaniyah', 1, '2026-04-14 02:31:13'),
(3, 2, 'الملقا', 'Malqa', 1, '2026-04-14 02:31:13'),
(4, 2, 'النرجس', 'Narjis', 1, '2026-04-14 02:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int NOT NULL,
  `title_ar` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_en` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_ar` text COLLATE utf8mb4_unicode_ci,
  `description_en` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_type` enum('none','vendor','product','category','url','mart') COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `link_value` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` enum('food','mart','both') COLLATE utf8mb4_unicode_ci DEFAULT 'both',
  `position` enum('home_top','home_middle','mart_top','featured') COLLATE utf8mb4_unicode_ci DEFAULT 'home_top',
  `sort_order` int DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `session_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int NOT NULL,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `options` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON array of selected option IDs',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `vendor_id` int DEFAULT NULL COMMENT 'NULL يعني قسم عام للنظام',
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('food','mart','both') COLLATE utf8mb4_unicode_ci DEFAULT 'food',
  `sort_order` int DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `vendor_id`, `name_ar`, `name_en`, `icon`, `image`, `type`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'بيتزا', 'Pizza', '🍕', NULL, 'food', 0, 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(2, NULL, 'برجر', 'Burger', '🍔', NULL, 'food', 0, 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(3, NULL, 'مشروبات', 'Drinks', '🥤', NULL, 'both', 0, 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(4, NULL, 'مقاضي', 'Groceries', '🛒', NULL, 'mart', 0, 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(5, NULL, 'حلويات', 'Desserts', '🍰', NULL, 'both', 0, 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_fees`
--

CREATE TABLE `delivery_fees` (
  `id` int NOT NULL,
  `zone_id` int NOT NULL,
  `fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `min_order_for_free` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_fees`
--

INSERT INTO `delivery_fees` (`id`, `zone_id`, `fee`, `min_order_for_free`, `created_at`, `updated_at`) VALUES
(1, 1, 15.00, 100.00, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(2, 2, 20.00, 120.00, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(3, 3, 18.00, 100.00, '2026-04-14 02:31:13', '2026-04-14 02:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_type` enum('car','motorcycle','bicycle') COLLATE utf8mb4_unicode_ci DEFAULT 'motorcycle',
  `vehicle_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driving_license` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_id` int DEFAULT NULL,
  `is_online` tinyint(1) DEFAULT '0',
  `is_busy` tinyint(1) DEFAULT '0',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `last_location_update` datetime DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT '0.00',
  `rating_count` int DEFAULT '0',
  `total_deliveries` int DEFAULT '0',
  `total_earnings` decimal(10,2) DEFAULT '0.00',
  `status` enum('pending','approved','rejected','suspended') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `fcm_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `phone`, `password_hash`, `avatar`, `vehicle_type`, `vehicle_number`, `national_id`, `driving_license`, `zone_id`, `is_online`, `is_busy`, `latitude`, `longitude`, `last_location_update`, `rating`, `rating_count`, `total_deliveries`, `total_earnings`, `status`, `rejection_reason`, `fcm_token`, `created_at`, `updated_at`) VALUES
(1, 'محمد السالم', '0500000004', '$2y$10$9wjsmBYQ.hXMHXRwvZF6D.okWHsD8D/KSgOcDyyoSTcTNVWReulDi', NULL, 'motorcycle', '1234 ABC', NULL, NULL, 1, 1, 0, NULL, NULL, NULL, 0.00, 0, 0, 0.00, 'approved', NULL, NULL, '2026-04-16 14:03:02', '2026-04-16 11:03:02'),
(2, 'عبدو موتة', '555564444', '$2y$10$YBd8OsK/vHOsFAaFeli0HOklir/NFrNDhzdul0yfd/Bj1z7hjsJKq', NULL, 'motorcycle', '4444444444', NULL, NULL, 3, 0, 0, NULL, NULL, NULL, 0.00, 0, 0, 0.00, 'approved', NULL, NULL, '2026-04-16 16:09:09', '2026-04-16 13:09:09');

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_logs`
--

CREATE TABLE `loyalty_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `rule_id` int DEFAULT NULL,
  `points_earned` int DEFAULT '0',
  `points_redeemed` int DEFAULT '0',
  `discount_used` decimal(10,2) DEFAULT '0.00',
  `order_id` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_rules`
--

CREATE TABLE `loyalty_rules` (
  `id` int NOT NULL,
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orders_count` int NOT NULL,
  `points_reward` int NOT NULL DEFAULT '0',
  `discount_reward` decimal(10,2) DEFAULT '0.00',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT 'fixed',
  `free_delivery` tinyint(1) DEFAULT '0',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#FF6B35',
  `status` tinyint(1) DEFAULT '1',
  `period` enum('monthly','all_time') COLLATE utf8mb4_unicode_ci DEFAULT 'monthly',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loyalty_rules`
--

INSERT INTO `loyalty_rules` (`id`, `name_ar`, `name_en`, `orders_count`, `points_reward`, `discount_reward`, `discount_type`, `free_delivery`, `icon`, `color`, `status`, `period`, `created_at`, `updated_at`) VALUES
(1, 'برونزي', 'Bronze', 10, 100, 20.00, 'fixed', 0, NULL, '#FF6B35', 1, 'monthly', '2026-04-14 02:31:14', '2026-04-14 02:31:14'),
(2, 'فضي', 'Silver', 15, 200, 50.00, 'fixed', 1, NULL, '#FF6B35', 1, 'monthly', '2026-04-14 02:31:14', '2026-04-14 02:31:14'),
(3, 'ذهبي', 'Gold', 20, 500, 100.00, 'fixed', 1, NULL, '#FF6B35', 1, 'monthly', '2026-04-14 02:31:14', '2026-04-14 02:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `lucky_wheel_rewards`
--

CREATE TABLE `lucky_wheel_rewards` (
  `id` int NOT NULL,
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reward_type` enum('points','discount','free_delivery','product','cash') COLLATE utf8mb4_unicode_ci DEFAULT 'points',
  `reward_value` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `probability` decimal(5,2) NOT NULL COMMENT 'Percentage 0-100',
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#FF6B35',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 0xF09F8E81,
  `max_usage` int DEFAULT NULL,
  `used_count` int DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lucky_wheel_rewards`
--

INSERT INTO `lucky_wheel_rewards` (`id`, `name_ar`, `name_en`, `reward_type`, `reward_value`, `probability`, `color`, `icon`, `max_usage`, `used_count`, `status`, `created_at`) VALUES
(1, '100 نقطة', '100 Points', 'points', '100', 30.00, '#4CAF50', '⭐', NULL, 0, 1, '2026-04-14 02:31:14'),
(2, 'خصم 10%', '10% Discount', 'discount', '10', 20.00, '#2196F3', '💰', NULL, 0, 1, '2026-04-14 02:31:14'),
(3, 'توصيل مجاني', 'Free Delivery', 'free_delivery', 'free', 15.00, '#FF9800', '🚚', NULL, 0, 1, '2026-04-14 02:31:14'),
(4, '500 نقطة', '500 Points', 'points', '500', 10.00, '#9C27B0', '🌟', NULL, 0, 1, '2026-04-14 02:31:14'),
(5, 'خصم 50 ريال', '50 SAR Discount', 'discount', '50', 5.00, '#F44336', '💎', NULL, 0, 1, '2026-04-14 02:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL COMMENT 'NULL means for all',
  `user_type` enum('user','vendor','driver','admin') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_ar` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_en` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_ar` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_en` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'general',
  `reference_id` int DEFAULT NULL COMMENT 'order_id or other reference',
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON additional data',
  `is_read` tinyint(1) DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_ar` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_en` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_ar` text COLLATE utf8mb4_unicode_ci,
  `description_en` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `offer_type` enum('discount','buy_one_get_one','free_delivery','percentage') COLLATE utf8mb4_unicode_ci DEFAULT 'discount',
  `discount_value` decimal(10,2) DEFAULT '0.00',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT 'fixed',
  `min_order` decimal(10,2) DEFAULT '0.00',
  `max_discount` decimal(10,2) DEFAULT NULL,
  `vendor_id` int DEFAULT NULL COMMENT 'NULL means global offer',
  `category_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `usage_limit` int DEFAULT NULL,
  `usage_count` int DEFAULT '0',
  `user_limit` int DEFAULT '1',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `order_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `driver_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `address_snapshot` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON of address at order time',
  `subtotal` decimal(10,2) NOT NULL,
  `delivery_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `service_fee` decimal(10,2) DEFAULT '0.00',
  `discount` decimal(10,2) DEFAULT '0.00',
  `tip` decimal(10,2) DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL,
  `payment_method` enum('cash','card','wallet') COLLATE utf8mb4_unicode_ci DEFAULT 'cash',
  `payment_status` enum('pending','paid','failed','refunded') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `status` enum('new','accepted','preparing','on_way','delivered','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'new',
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci,
  `cancelled_by` enum('user','vendor','driver','admin') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `estimated_delivery` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_assignments`
--

CREATE TABLE `order_assignments` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `status` enum('pending','accepted','rejected','timeout') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `response_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `product_snapshot` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON of product details at order time',
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `options` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_logs`
--

CREATE TABLE `order_status_logs` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `changed_by` enum('system','user','vendor','driver','admin') COLLATE utf8mb4_unicode_ci DEFAULT 'system',
  `changed_by_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` int NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(1) DEFAULT '0',
  `verified` tinyint(1) DEFAULT '0',
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otp_codes`
--

INSERT INTO `otp_codes` (`id`, `phone`, `code`, `attempts`, `verified`, `expires_at`, `created_at`) VALUES
(1, '+966555555000', '400507', 1, 1, '2026-04-16 16:03:32', '2026-04-16 15:58:32'),
(2, '+966555564444', '676464', 1, 1, '2026-04-16 16:14:34', '2026-04-16 16:09:34');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `name_ar` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_ar` text COLLATE utf8mb4_unicode_ci,
  `description_en` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) DEFAULT NULL,
  `discount_start` datetime DEFAULT NULL,
  `discount_end` datetime DEFAULT NULL,
  `preparation_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `calories` int DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT '0',
  `is_available` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `vendor_id`, `category_id`, `name_ar`, `name_en`, `description_ar`, `description_en`, `image`, `price`, `discount_price`, `discount_start`, `discount_end`, `preparation_time`, `calories`, `is_featured`, `is_available`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'برجر كلاسيك', 'Classic Burger', 'لحم بقر طازج 180 جرام مع جبن شيدر وخس وطماطم وصوص سري', NULL, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=400&fit=crop&auto=format', 35.00, 29.00, NULL, NULL, '15 دقيقة', 520, 1, 1, 1, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(2, 1, NULL, 'دابل برجر', 'Double Burger', 'قرصتين لحم مع جبن مزدوج وبيكون وصوص BBQ مشوي', NULL, 'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=400&h=400&fit=crop&auto=format', 55.00, NULL, NULL, NULL, '20 دقيقة', 820, 1, 1, 2, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(3, 1, NULL, 'برجر دجاج مقرمش', 'Crispy Chicken Burger', 'دجاج مقلي مقرمش مع كول سلو وصوص حار', NULL, 'https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=400&h=400&fit=crop&auto=format', 40.00, 34.00, NULL, NULL, '15 دقيقة', 610, 0, 1, 3, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(4, 1, NULL, 'بطاطس مقلية كبيرة', 'Large Fries', 'بطاطس ذهبية مقرمشة مع صوص الكاتشاب والمايونيز', NULL, 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=400&fit=crop&auto=format', 15.00, NULL, NULL, NULL, '10 دقيقة', 380, 0, 1, 4, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(5, 1, NULL, 'ميلك شيك شوكولاتة', 'Chocolate Milkshake', 'مشروب كريمي بالشوكولاتة الداكنة مع كريمة مخفوقة', NULL, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&h=400&fit=crop&auto=format', 22.00, NULL, NULL, NULL, '5 دقيقة', 450, 0, 1, 5, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(6, 2, NULL, 'سلمون رول', 'Salmon Roll', '8 قطع سوشي بالسلمون الطازج والأفوكادو والجبن الكريمي', NULL, 'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&h=400&fit=crop&auto=format', 65.00, 55.00, NULL, NULL, '20 دقيقة', 320, 1, 1, 1, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(7, 2, NULL, 'ساشيمي مشكل', 'Mixed Sashimi', '12 شريحة من أجود أنواع الأسماك الطازجة يومياً', NULL, 'https://images.unsplash.com/photo-1534482421-64566f976cfa?w=400&h=400&fit=crop&auto=format', 90.00, NULL, NULL, NULL, '15 دقيقة', 280, 1, 1, 2, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(8, 2, NULL, 'كريسبي تونا رول', 'Crispy Tuna Roll', 'تونا طازجة مع أفوكادو وصوص سبايسي مايو فوق الرول', NULL, 'https://images.unsplash.com/photo-1562802378-063ec186a863?w=400&h=400&fit=crop&auto=format', 70.00, 60.00, NULL, NULL, '20 دقيقة', 360, 1, 1, 3, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(9, 2, NULL, 'ميسو سوب', 'Miso Soup', 'شوربة ميسو يابانية تقليدية مع التوفو والواكامي', NULL, 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&h=400&fit=crop&auto=format', 20.00, NULL, NULL, NULL, '5 دقيقة', 80, 0, 1, 4, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(10, 2, NULL, 'إيداماميه', 'Edamame', 'فول الصويا المسلوق مع رشة ملح البحر الياباني', NULL, 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400&h=400&fit=crop&auto=format', 18.00, NULL, NULL, NULL, '5 دقيقة', 120, 0, 1, 5, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(11, 3, NULL, 'تفاح أحمر مصري', 'Red Apple', 'تفاح أحمر طازج مباشر من المزرعة — الكيلو', NULL, 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400&h=400&fit=crop&auto=format', 12.00, 9.00, NULL, NULL, 'فوري', 95, 0, 1, 1, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(12, 3, NULL, 'موز طازج', 'Fresh Banana', 'موز أصفر ناضج — الكيلو', NULL, 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&h=400&fit=crop&auto=format', 8.00, NULL, NULL, NULL, 'فوري', 89, 0, 1, 2, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(13, 3, NULL, 'طماطم بلدي', 'Local Tomatoes', 'طماطم طازجة بلدي — الكيلو', NULL, 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400&h=400&fit=crop&auto=format', 7.00, NULL, NULL, NULL, 'فوري', 18, 0, 1, 3, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(14, 3, NULL, 'حليب كامل الدسم', 'Full Fat Milk', 'حليب طازج كامل الدسم — لتر', NULL, 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=400&fit=crop&auto=format', 15.00, NULL, NULL, NULL, 'فوري', 150, 0, 1, 4, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(15, 3, NULL, 'بيض بلدي', 'Farm Eggs', 'بيض بلدي طازج — كرتونة 30 بيضة', NULL, 'https://images.unsplash.com/photo-1569288052389-dac9b0ac9eac?w=400&h=400&fit=crop&auto=format', 35.00, 30.00, NULL, NULL, 'فوري', 70, 1, 1, 5, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(16, 4, NULL, 'بيتزا مارغريتا', 'Margherita Pizza', 'صلصة طماطم طازجة ومتسريلا وريحان — فرن حجري', NULL, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&h=400&fit=crop&auto=format', 55.00, 45.00, NULL, NULL, '25 دقيقة', 720, 1, 1, 1, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(17, 4, NULL, 'بيتزا بيبيروني', 'Pepperoni Pizza', 'بيبيروني إيطالي أصلي مع جبن متسريلا دبل', NULL, 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=400&fit=crop&auto=format', 70.00, NULL, NULL, NULL, '25 دقيقة', 890, 1, 1, 2, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(18, 4, NULL, 'بيتزا خضار', 'Veggie Pizza', 'فلفل وبصل وزيتون وفطر وطماطم كرزية وجبن', NULL, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=400&fit=crop&auto=format', 60.00, 50.00, NULL, NULL, '25 دقيقة', 650, 0, 1, 3, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(19, 4, NULL, 'باستا كاربونارا', 'Pasta Carbonara', 'سباغيتي مع صوص الكريمة والبيكون والجبن البارميزان', NULL, 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=400&h=400&fit=crop&auto=format', 50.00, NULL, NULL, NULL, '20 دقيقة', 680, 1, 1, 4, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(20, 4, NULL, 'تيراميسو', 'Tiramisu', 'حلى إيطالي كلاسيك بالقهوة والمسكربوني', NULL, 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&h=400&fit=crop&auto=format', 30.00, NULL, NULL, NULL, '5 دقيقة', 320, 1, 1, 5, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(21, 5, NULL, 'بول أكاي', 'Acai Bowl', 'أكاي مع موز وتوت وجرانولا وعسل طبيعي', NULL, 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=400&h=400&fit=crop&auto=format', 55.00, 48.00, NULL, NULL, '10 دقيقة', 380, 1, 1, 1, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(22, 5, NULL, 'سلطة سيزر دجاج', 'Chicken Caesar Salad', 'خس روماني مع دجاج مشوي وكروتون وصوص سيزر', NULL, 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=400&h=400&fit=crop&auto=format', 45.00, NULL, NULL, NULL, '10 دقيقة', 320, 1, 1, 2, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(23, 5, NULL, 'عصير أخضر ديتوكس', 'Green Detox Juice', 'سبانخ وخيار وليمون وزنجبيل وتفاح أخضر', NULL, 'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=400&h=400&fit=crop&auto=format', 30.00, 25.00, NULL, NULL, '5 دقيقة', 95, 1, 1, 3, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(24, 5, NULL, 'بروتين شيك فانيليا', 'Vanilla Protein Shake', 'بروتين واي مع حليب لوز وموز وفانيليا طبيعية', NULL, 'https://images.unsplash.com/photo-1553530666-ba11a90bb519?w=400&h=400&fit=crop&auto=format', 40.00, NULL, NULL, NULL, '5 دقيقة', 280, 0, 1, 4, '2026-04-14 04:05:41', '2026-04-14 04:05:41'),
(25, 5, NULL, 'أفوكادو توست', 'Avocado Toast', 'خبز سوردو مع أفوكادو طازج وبيض مسلوق وبذور الشيا', NULL, 'https://images.unsplash.com/photo-1541519227354-08fa5d50c820?w=400&h=400&fit=crop&auto=format', 38.00, 32.00, NULL, NULL, '10 دقيقة', 340, 1, 1, 5, '2026-04-14 04:05:41', '2026-04-14 04:05:41');

-- --------------------------------------------------------

--
-- Table structure for table `product_options`
--

CREATE TABLE `product_options` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_type` enum('size','extra','choice') COLLATE utf8mb4_unicode_ci DEFAULT 'extra',
  `price` decimal(10,2) DEFAULT '0.00',
  `is_required` tinyint(1) DEFAULT '0',
  `min_selection` int DEFAULT '0',
  `max_selection` int DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vendor_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `rated_by` enum('user','vendor','driver') COLLATE utf8mb4_unicode_ci NOT NULL,
  `rated_for` enum('user','vendor','driver','product') COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int DEFAULT NULL,
  `rating` tinyint(1) NOT NULL COMMENT '1-5 stars',
  `review` text COLLATE utf8mb4_unicode_ci,
  `is_anonymous` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `ratings`
--
DELIMITER $$
CREATE TRIGGER `update_driver_rating` AFTER INSERT ON `ratings` FOR EACH ROW BEGIN
    IF NEW.driver_id IS NOT NULL AND NEW.rated_for = 'driver' THEN
        UPDATE `drivers` 
        SET `rating` = (
            SELECT AVG(rating) FROM `ratings` 
            WHERE driver_id = NEW.driver_id AND rated_for = 'driver'
        ),
        `rating_count` = (
            SELECT COUNT(*) FROM `ratings` 
            WHERE driver_id = NEW.driver_id AND rated_for = 'driver'
        )
        WHERE id = NEW.driver_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_vendor_rating` AFTER INSERT ON `ratings` FOR EACH ROW BEGIN
    IF NEW.vendor_id IS NOT NULL AND NEW.rated_for = 'vendor' THEN
        UPDATE `vendors` 
        SET `rating` = (
            SELECT AVG(rating) FROM `ratings` 
            WHERE vendor_id = NEW.vendor_id AND rated_for = 'vendor'
        ),
        `rating_count` = (
            SELECT COUNT(*) FROM `ratings` 
            WHERE vendor_id = NEW.vendor_id AND rated_for = 'vendor'
        )
        WHERE id = NEW.vendor_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int NOT NULL,
  `report_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `reported_type` enum('vendor','driver','order','product') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reported_id` int NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachments` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON array of image paths',
  `status` enum('pending','investigating','resolved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci DEFAULT 'medium',
  `admin_response` text COLLATE utf8mb4_unicode_ci,
  `resolved_by` int DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `setting_group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'general',
  `setting_type` enum('text','textarea','number','boolean','json','image','color') COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_group`, `setting_type`, `description`, `updated_at`) VALUES
(1, 'app_name', 'سريع', 'general', 'text', 'اسم التطبيق', '2026-04-14 02:31:14'),
(2, 'app_name_en', 'Saree3', 'general', 'text', 'Application name in English', '2026-04-14 02:31:14'),
(3, 'currency', 'SAR', 'general', 'text', 'العملة', '2026-04-14 02:31:14'),
(4, 'currency_symbol', 'ر.س', 'general', 'text', 'رمز العملة', '2026-04-14 02:31:14'),
(5, 'service_fee', '5', 'fees', 'number', 'رسوم الخدمة', '2026-04-14 02:31:14'),
(6, 'tax_rate', '15', 'fees', 'number', 'نسبة الضريبة', '2026-04-14 02:31:14'),
(7, 'min_order_default', '50', 'fees', 'number', 'الحد الأدنى للطلب', '2026-04-14 02:31:14'),
(8, 'otp_provider', 'mock', 'sms', 'text', 'مزود خدمة الرسائل', '2026-04-14 02:31:14'),
(9, 'otp_expiry_minutes', '5', 'sms', 'number', 'مدة صلاحية OTP', '2026-04-14 02:31:14'),
(10, 'max_otp_attempts', '3', 'sms', 'number', 'الحد الأقصى لمحاولات OTP', '2026-04-14 02:31:14'),
(11, 'logo', '/assets/images/logo.png', 'branding', 'image', 'الشعار', '2026-04-14 02:31:14'),
(12, 'favicon', '/assets/images/favicon.ico', 'branding', 'image', 'الأيقونة', '2026-04-14 02:31:14'),
(13, 'primary_color', '#FF6B35', 'branding', 'color', 'اللون الرئيسي', '2026-04-14 02:31:14'),
(14, 'secondary_color', '#2E4053', 'branding', 'color', 'اللون الثانوي', '2026-04-14 02:31:14'),
(15, 'about_us_ar', 'عن سريع...', 'pages', 'textarea', 'من نحن', '2026-04-14 02:31:14'),
(16, 'terms_ar', 'الشروط والأحكام...', 'pages', 'textarea', 'الشروط والأحكام', '2026-04-14 02:31:14'),
(17, 'privacy_ar', 'سياسة الخصوصية...', 'pages', 'textarea', 'سياسة الخصوصية', '2026-04-14 02:31:14'),
(18, 'whatsapp_number', '966500000000', 'contact', 'text', 'رقم الواتساب', '2026-04-14 02:31:14'),
(19, 'email', 'info@saree3.com', 'contact', 'text', 'البريد الإلكتروني', '2026-04-14 02:31:14'),
(20, 'maintenance_mode', '0', 'system', 'boolean', 'وضع الصيانة', '2026-04-14 02:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `sms_logs`
--

CREATE TABLE `sms_logs` (
  `id` int NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'otp',
  `status` enum('pending','sent','failed') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `response` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_logs`
--

INSERT INTO `sms_logs` (`id`, `phone`, `message`, `type`, `status`, `response`, `created_at`) VALUES
(1, '+966555555000', 'رمز التحقق الخاص بك هو: 400507\nصالح لمدة 5 دقائق\nسريع', 'otp', 'pending', NULL, '2026-04-16 15:58:32'),
(2, '+966555564444', 'رمز التحقق الخاص بك هو: 676464\nصالح لمدة 5 دقائق\nسريع', 'otp', 'pending', NULL, '2026-04-16 16:09:34');

-- --------------------------------------------------------

--
-- Table structure for table `tips`
--

CREATE TABLE `tips` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` enum('percentage','fixed','custom') COLLATE utf8mb4_unicode_ci DEFAULT 'fixed',
  `status` enum('pending','paid','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `is_blocked` tinyint(1) DEFAULT '0',
  `block_reason` text COLLATE utf8mb4_unicode_ci,
  `total_orders` int DEFAULT '0',
  `total_spent` decimal(10,2) DEFAULT '0.00',
  `loyalty_points` int DEFAULT '0',
  `fcm_token` text COLLATE utf8mb4_unicode_ci,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `avatar`, `status`, `is_blocked`, `block_reason`, `total_orders`, `total_spent`, `loyalty_points`, `fcm_token`, `device_id`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'mh123456789', '+966555555000', NULL, 1, 0, NULL, 0, 0.00, 0, NULL, NULL, '2026-04-16 15:59:22', '2026-04-16 15:59:22', '2026-04-16 12:59:22'),
(2, 'admin', '+966555564444', NULL, 1, 0, NULL, 0, 0.00, 0, NULL, NULL, '2026-04-16 16:09:42', '2026-04-16 16:09:41', '2026-04-16 13:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `session_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_activity` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `session_token`, `device_id`, `device_name`, `ip_address`, `last_activity`, `created_at`) VALUES
(1, 1, 'ce2dcf4b3d4405dbe89eb55c1abac1a3', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Sa', '81.245.111.195', '2026-04-16 15:59:22', '2026-04-16 15:59:22'),
(2, 2, '72e93962b7960fc20cba61afd2f1df63', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Sa', '81.245.111.195', '2026-04-16 16:09:42', '2026-04-16 16:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_type` enum('restaurant','mart','both') COLLATE utf8mb4_unicode_ci DEFAULT 'restaurant',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `address` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `zone_id` int DEFAULT NULL,
  `min_order` decimal(10,2) DEFAULT '0.00',
  `delivery_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '30-45 دقيقة',
  `rating` decimal(3,2) DEFAULT '0.00',
  `rating_count` int DEFAULT '0',
  `is_open` tinyint(1) DEFAULT '1',
  `status` enum('pending','approved','rejected','suspended') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `commission_rate` decimal(5,2) DEFAULT '10.00',
  `fcm_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sort_order` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `phone`, `password_hash`, `business_name`, `business_type`, `logo`, `cover`, `description`, `address`, `latitude`, `longitude`, `zone_id`, `min_order`, `delivery_time`, `rating`, `rating_count`, `is_open`, `status`, `rejection_reason`, `commission_rate`, `fcm_token`, `created_at`, `updated_at`, `sort_order`) VALUES
(1, 'Ahmed Hassan', '01001234567', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_1', 'Burger House', 'restaurant', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&h=400&fit=crop&auto=format', 'أفضل برجر في المدينة — لحم طازج مشوي يومياً بتوابل سرية خاصة', 'شارع التحرير، الدور الأرضي، برج النيل', 30.06263000, 31.24967000, 1, 49.00, '20-30 دقيقة', 4.80, 312, 1, 'approved', NULL, 10.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 1),
(2, 'Mariam Youssef', '01112345678', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_2', 'Sushi Garden', 'restaurant', 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1611143669185-af224c5e3252?w=800&h=400&fit=crop&auto=format', 'سوشي ياباني أصيل — طازج يومياً مع أسماك مستوردة عالية الجودة', 'شارع البحر، الزمالك، القاهرة', 30.07045000, 31.21985000, 1, 80.00, '35-45 دقيقة', 4.90, 189, 1, 'approved', NULL, 12.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 2),
(3, 'Omar Farouk', '01223456789', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_3', 'Green Mart', 'mart', 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=400&fit=crop&auto=format', 'سوبرماركت طازج — خضار وفاكهة ومنتجات يومية بأسعار تنافسية', 'شارع الهرم، الجيزة، أمام النادي', 29.99200000, 31.14520000, 1, 30.00, '40-55 دقيقة', 4.60, 520, 1, 'approved', NULL, 8.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 3),
(4, 'Sara Emad', '01334567890', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_4', 'Pizza Palace', 'restaurant', 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&h=400&fit=crop&auto=format', 'بيتزا إيطالية حقيقية — فرن حجري وعجين مخمر 48 ساعة', 'ميدان روكسي، مصر الجديدة، القاهرة', 30.08470000, 31.32130000, 1, 60.00, '25-35 دقيقة', 4.70, 445, 1, 'approved', NULL, 10.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 4),
(5, 'Karim Adel', '01445678901', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_5', 'FreshBox', 'both', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1490818387583-1baba5e638af?w=800&h=400&fit=crop&auto=format', 'أكل صحي ومواد غذائية — وجبات دايت وسوبر فوود ومكملات طبيعية', 'شارع مكة، المهندسين، الجيزة', 30.05830000, 31.19720000, 2, 50.00, '30-40 دقيقة', 4.50, 280, 1, 'approved', NULL, 9.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 5),
(6, 'Yara Nabil', '01556789012', '$2y$12$KIXyB4rJ1N2eQwE.dHvS5.placeholder_hash_6', 'Night Diner', 'restaurant', 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=200&h=200&fit=crop&auto=format', 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=400&fit=crop&auto=format', 'مطعم ليلي متخصص في المشاوي والكبدة والسجق البلدي', 'شارع الألفي، وسط البلد، القاهرة', 30.05100000, 31.23890000, 1, 40.00, '30-45 دقيقة', 4.30, 97, 0, 'pending', NULL, 10.00, NULL, '2026-04-14 03:56:13', '2026-04-14 03:56:13', 6);

-- --------------------------------------------------------

--
-- Table structure for table `wheel_spins`
--

CREATE TABLE `wheel_spins` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `reward_id` int NOT NULL,
  `reward_snapshot` text COLLATE utf8mb4_unicode_ci,
  `is_claimed` tinyint(1) DEFAULT '0',
  `claimed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` int NOT NULL,
  `name_ar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `name_ar`, `name_en`, `city`, `status`, `created_at`, `updated_at`) VALUES
(1, 'وسط المدينة', 'Downtown', 'الرياض', 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(2, 'الشمال', 'North', 'الرياض', 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13'),
(3, 'الشرق', 'East', 'الرياض', 1, '2026-04-14 02:31:13', '2026-04-14 02:31:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_type`,`user_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_area` (`area_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_zone` (`zone_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_target` (`target`),
  ADD KEY `idx_position` (`position`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_session` (`session_id`),
  ADD KEY `idx_vendor` (`vendor_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cart` (`cart_id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `delivery_fees`
--
ALTER TABLE `delivery_fees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zone_id` (`zone_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_online` (`is_online`),
  ADD KEY `idx_zone` (`zone_id`);

--
-- Indexes for table `loyalty_logs`
--
ALTER TABLE `loyalty_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_rule` (`rule_id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `loyalty_rules`
--
ALTER TABLE `loyalty_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `lucky_wheel_rewards`
--
ALTER TABLE `lucky_wheel_rewards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_type` (`user_type`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_dates` (`start_date`,`end_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `fk_offers_category` (`category_id`),
  ADD KEY `fk_offers_product` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`),
  ADD KEY `fk_orders_address` (`address_id`);

--
-- Indexes for table `order_assignments`
--
ALTER TABLE `order_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `otp_codes`
--
ALTER TABLE `otp_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_phone` (`phone`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_available` (`is_available`),
  ADD KEY `idx_featured` (`is_featured`);

--
-- Indexes for table `product_options`
--
ALTER TABLE `product_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_rating` (`order_id`,`user_id`,`rated_by`,`rated_for`,`product_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_vendor` (`vendor_id`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_rated_by` (`rated_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `fk_ratings_product` (`product_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `report_number` (`report_number`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_reported` (`reported_type`,`reported_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `fk_reports_admin` (`resolved_by`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_group` (`setting_group`);

--
-- Indexes for table `sms_logs`
--
ALTER TABLE `sms_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_phone` (`phone`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `tips`
--
ALTER TABLE `tips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_driver` (`driver_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_blocked` (`is_blocked`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_token` (`session_token`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_zone` (`zone_id`);

--
-- Indexes for table `wheel_spins`
--
ALTER TABLE `wheel_spins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_reward` (`reward_id`),
  ADD KEY `idx_claimed` (`is_claimed`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `delivery_fees`
--
ALTER TABLE `delivery_fees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loyalty_logs`
--
ALTER TABLE `loyalty_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loyalty_rules`
--
ALTER TABLE `loyalty_rules`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lucky_wheel_rewards`
--
ALTER TABLE `lucky_wheel_rewards`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_assignments`
--
ALTER TABLE `order_assignments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otp_codes`
--
ALTER TABLE `otp_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `product_options`
--
ALTER TABLE `product_options`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sms_logs`
--
ALTER TABLE `sms_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tips`
--
ALTER TABLE `tips`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `wheel_spins`
--
ALTER TABLE `wheel_spins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `fk_addresses_area` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `areas`
--
ALTER TABLE `areas`
  ADD CONSTRAINT `fk_areas_zone` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_carts_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_fees`
--
ALTER TABLE `delivery_fees`
  ADD CONSTRAINT `fk_delivery_fees_zone` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loyalty_logs`
--
ALTER TABLE `loyalty_logs`
  ADD CONSTRAINT `fk_loyalty_logs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_loyalty_logs_rule` FOREIGN KEY (`rule_id`) REFERENCES `loyalty_rules` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_loyalty_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `fk_offers_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_offers_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_offers_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_orders_driver` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_orders_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`);

--
-- Constraints for table `order_assignments`
--
ALTER TABLE `order_assignments`
  ADD CONSTRAINT `fk_assignments_driver` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_assignments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  ADD CONSTRAINT `fk_status_logs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_products_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_options`
--
ALTER TABLE `product_options`
  ADD CONSTRAINT `fk_options_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_driver` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ratings_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ratings_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ratings_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ratings_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_admin` FOREIGN KEY (`resolved_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reports_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reports_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tips`
--
ALTER TABLE `tips`
  ADD CONSTRAINT `fk_tips_driver` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tips_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tips_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wheel_spins`
--
ALTER TABLE `wheel_spins`
  ADD CONSTRAINT `fk_spins_reward` FOREIGN KEY (`reward_id`) REFERENCES `lucky_wheel_rewards` (`id`),
  ADD CONSTRAINT `fk_spins_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
