-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 12, 2024 at 02:21 AM
-- Server version: 8.0.34
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gonuguc_CryptoKoiN`
--

-- --------------------------------------------------------

--
-- Table structure for table `Crypto_coins`
--

CREATE TABLE `Crypto_coins` (
  `cryptocoin_id` int NOT NULL,
  `coin_id` varchar(30) DEFAULT NULL,
  `coin_symbol` varchar(30) DEFAULT NULL,
  `coin_name` varchar(255) DEFAULT NULL,
  `image_url` text,
  `current_price` decimal(30,2) DEFAULT NULL,
  `market_cap` decimal(30,2) DEFAULT NULL,
  `market_cap_rank` int DEFAULT NULL,
  `total_volume` decimal(20,2) DEFAULT NULL,
  `price_change_percentage_24h` decimal(10,2) DEFAULT NULL,
  `high_24h` decimal(10,2) DEFAULT NULL,
  `low_24h` decimal(10,2) DEFAULT NULL,
  `ath` decimal(10,2) DEFAULT NULL,
  `ath_change_percentage` decimal(10,2) DEFAULT NULL,
  `circulating_supply` decimal(20,2) DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT NULL,
  `price_change_24h` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Crypto_coins`
--

INSERT INTO `Crypto_coins` (`cryptocoin_id`, `coin_id`, `coin_symbol`, `coin_name`, `image_url`, `current_price`, `market_cap`, `market_cap_rank`, `total_volume`, `price_change_percentage_24h`, `high_24h`, `low_24h`, `ath`, `ath_change_percentage`, `circulating_supply`, `last_updated`, `price_change_24h`) VALUES
(1, 'bitcoin', 'btc', 'Bitcoin', 'https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400', 100814.00, 1996116446439.00, 1, 114282587663.00, 4.65, 101960.00, 95741.00, 103679.00, -2.73, 19794440.00, '2024-12-12 01:32:03', 4481.95),
(2, 'ethereum', 'eth', 'Ethereum', 'https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628', 3823.30, 460525398691.00, 2, 37092762341.00, 6.59, 3846.62, 3570.34, 4878.26, -21.57, 120444873.50, '2024-12-12 01:31:58', 236.30),
(3, 'binancecoin', 'bnb', 'BNB', 'https://coin-images.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970', 717.24, 104661146518.00, 6, 1941439458.00, 7.88, 718.30, 659.76, 788.84, -8.94, 145887575.79, '2024-12-12 01:32:03', 52.37),
(4, 'solana', 'sol', 'Solana', 'https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756', 227.34, 108897198120.00, 5, 7345472845.00, 6.19, 230.58, 212.28, 263.21, -13.45, 478878591.37, '2024-12-12 01:31:53', 13.25),
(5, 'tron', 'trx', 'TRON', 'https://coin-images.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193', 0.28, 24464095404.00, 11, 2288222743.00, 7.50, 0.29, 0.26, 0.43, -34.20, 86252894716.48, '2024-12-12 01:31:57', 0.02),
(6, 'the-open-network', 'ton', 'Toncoin', 'https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446', 6.44, 16423033805.00, 14, 441419545.00, 10.43, 6.44, 5.79, 8.25, -22.02, 2550896017.88, '2024-12-12 01:31:57', 0.61),
(7, 'cardano', 'ada', 'Cardano', 'https://coin-images.coingecko.com/coins/images/975/large/cardano.png?1696502090', 1.09, 38958713198.00, 9, 2327337052.00, 10.74, 1.11, 0.98, 3.09, -64.75, 35815138228.43, '2024-12-12 01:32:04', 0.11),
(8, 'avalanche-2', 'avax', 'Avalanche', 'https://coin-images.coingecko.com/coins/images/12559/large/Avalanche_Circle_RedWhite_Trans.png?1696512369', 49.05, 20075569155.00, 12, 916948464.00, 13.09, 49.10, 42.98, 144.96, -66.12, 409682808.03, '2024-12-12 01:32:02', 5.68),
(9, 'bitcoin-cash', 'bch', 'Bitcoin Cash', 'https://coin-images.coingecko.com/coins/images/780/large/bitcoin-cash-circle.png?1696501932', 545.94, 10817774838.00, 22, 609488410.00, 7.55, 550.26, 506.04, 3785.82, -85.54, 19800634.27, '2024-12-12 01:32:03', 38.31),
(10, 'sui', 'sui', 'Sui', 'https://coin-images.coingecko.com/coins/images/26375/large/sui-ocean-square.png?1727791290', 4.70, 13764312595.00, 18, 2537135986.00, 30.35, 4.71, 3.60, 4.70, -0.17, 2927660018.56, '2024-12-12 01:31:55', 1.10),
(11, 'near', 'near', 'NEAR Protocol', 'https://coin-images.coingecko.com/coins/images/10365/large/near.jpg?1696510367', 6.88, 8381572281.00, 28, 737612861.00, 10.33, 6.93, 6.18, 20.44, -66.26, 1217906155.00, '2024-12-12 01:32:00', 0.64),
(12, 'aptos', 'apt', 'Aptos', 'https://coin-images.coingecko.com/coins/images/26455/large/aptos_round.png?1696525528', 13.58, 7282872863.00, 29, 645988097.00, 20.41, 13.58, 11.23, 19.92, -31.90, 536374989.62, '2024-12-12 01:32:02', 2.30),
(13, 'internet-computer', 'icp', 'Internet Computer', 'https://coin-images.coingecko.com/coins/images/14495/large/Internet_Computer_logo.png?1696514180', 13.12, 6239219016.00, 31, 393283503.00, 14.05, 13.24, 11.41, 700.65, -98.12, 475589056.06, '2024-12-12 01:31:58', 1.62),
(14, 'monero', 'xmr', 'Monero', 'https://coin-images.coingecko.com/coins/images/69/large/monero_logo.png?1696501460', 203.54, 3758569229.00, 49, 127361315.00, 14.75, 206.84, 175.62, 542.33, -62.09, 18446744.07, '2024-12-12 01:32:00', 26.15),
(15, 'kaspa', 'kas', 'Kaspa', 'https://coin-images.coingecko.com/coins/images/25751/large/kaspa-icon-exchanges.png?1696524837', 0.16, 4146779123.00, 45, 226911372.00, 6.49, 0.17, 0.15, 0.21, -21.18, 25335885938.49, '2024-12-12 01:31:59', 0.01),
(16, 'filecoin', 'fil', 'Filecoin', 'https://coin-images.coingecko.com/coins/images/12817/large/filecoin.png?1696512609', 6.73, 4111194395.00, 46, 678983808.00, 11.93, 6.78, 5.97, 236.84, -97.15, 610806517.00, '2024-12-12 01:31:57', 0.72),
(17, 'crypto-com-chain', 'cro', 'Cronos', 'https://coin-images.coingecko.com/coins/images/7310/large/cro_token_logo.png?1696507599', 0.18, 4953657681.00, 38, 56816416.00, 8.77, 0.19, 0.17, 0.97, -81.03, 27134251917.69, '2024-12-12 01:32:03', 0.01),
(18, 'injective-protocol', 'inj', 'Injective', 'https://coin-images.coingecko.com/coins/images/12882/large/Secondary_Symbol.png?1696512670', 29.09, 2844361326.00, 63, 251019414.00, 9.87, 29.11, 26.25, 52.62, -44.71, 97727220.33, '2024-12-12 01:31:58', 2.61),
(19, 'fantom', 'ftm', 'Fantom', 'https://coin-images.coingecko.com/coins/images/4001/large/Fantom_round.png?1696504642', 1.26, 3547595290.00, 53, 514442164.00, 12.36, 1.27, 1.12, 3.46, -63.40, 2803634835.53, '2024-12-12 01:31:58', 0.14),
(20, 'hedera-hashgraph', 'hbar', 'Hedera', 'https://coin-images.coingecko.com/coins/images/3688/large/hbar.png?1696504364', 0.29, 11174911821.00, 21, 1595910541.00, 6.04, 0.31, 0.27, 0.57, -48.55, 38228257945.39, '2024-12-12 01:31:58', 0.02),
(21, 'cosmos', 'atom', 'Cosmos Hub', 'https://coin-images.coingecko.com/coins/images/1481/large/cosmos_hub.png?1696502525', 8.78, 3434195094.00, 54, 459253071.00, 13.85, 8.90, 7.64, 44.45, -80.19, 390688369.81, '2024-12-12 01:32:05', 1.07),
(22, 'mantra-dao', 'om', 'MANTRA', 'https://coin-images.coingecko.com/coins/images/12151/large/OM_Token.png?1696511991', 4.24, 4002685450.00, 48, 309165713.00, 8.70, 4.55, 3.88, 4.55, -6.47, 944073908.62, '2024-12-12 01:32:00', 0.34),
(23, 'sei-network', 'sei', 'Sei', 'https://coin-images.coingecko.com/coins/images/28205/large/Sei_Logo_-_Transparent.png?1696527207', 0.62, 2470914605.00, 68, 384640290.00, 15.49, 0.62, 0.53, 1.14, -45.52, 3982916666.00, '2024-12-12 01:31:53', 0.08),
(24, 'algorand', 'algo', 'Algorand', 'https://coin-images.coingecko.com/coins/images/4380/large/download.png?1696504978', 0.45, 3726566859.00, 50, 571233364.00, 10.01, 0.46, 0.40, 3.56, -87.43, 8312523467.45, '2024-12-12 01:32:01', 0.04),
(25, 'arweave', 'ar', 'Arweave', 'https://coin-images.coingecko.com/coins/images/4343/large/oRt6SiEN_400x400.jpg?1696504946', 23.61, 1546142476.00, 96, 281772067.00, 11.07, 23.94, 20.89, 89.24, -73.51, 65454185.54, '2024-12-12 01:32:01', 2.35),
(26, 'flow', 'flow', 'Flow', 'https://coin-images.coingecko.com/coins/images/13446/large/5f6294c0c7a8cda55cb1c936_Flow_Wordmark.png?1696513210', 0.98, 1518019790.00, 100, 124553696.00, 11.80, 0.98, 0.87, 42.40, -97.69, 1550566851.93, '2024-12-12 01:31:58', 0.10),
(27, 'coredaoorg', 'core', 'Core', 'https://coin-images.coingecko.com/coins/images/28938/large/file_589.jpg?1701868471', 1.29, 1194924421.00, 125, 72712142.00, 10.94, 1.32, 1.16, 6.14, -79.11, 928359688.54, '2024-12-12 01:32:03', 0.13),
(28, 'gala', 'gala', 'GALA', 'https://coin-images.coingecko.com/coins/images/12493/large/GALA_token_image_-_200PNG.png?1709725869', 0.05, 2207733113.00, 72, 659805994.00, 19.13, 0.05, 0.04, 0.82, -93.64, 41882105144.24, '2024-12-12 01:32:00', 0.01),
(29, 'ecash', 'xec', 'eCash', 'https://coin-images.coingecko.com/coins/images/16646/large/Logo_final-22.png?1696516207', 0.00, 890919265.00, 149, 54998520.00, 11.60, 0.00, 0.00, 0.00, -88.15, 19796507797584.00, '2024-12-12 01:32:04', 0.00),
(30, 'flare-networks', 'flr', 'Flare', 'https://coin-images.coingecko.com/coins/images/28624/large/FLR-icon200x200.png?1696527609', 0.03, 1616487523.00, 88, 31977903.00, 5.88, 0.03, 0.03, 0.15, -80.27, 54719761697.66, '2024-12-12 01:31:57', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `Transaction_History`
--

CREATE TABLE `Transaction_History` (
  `transaction_id` int NOT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `quantity` decimal(10,4) DEFAULT NULL,
  `price_at_transaction` decimal(10,3) DEFAULT NULL,
  `transaction_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `crypto_id` int DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Transaction_History`
--

INSERT INTO `Transaction_History` (`transaction_id`, `transaction_type`, `quantity`, `price_at_transaction`, `transaction_timestamp`, `user_id`, `crypto_id`, `total_amount`, `tax`) VALUES
(1, 'buy', 2.5000, 7000.000, '2024-11-20 09:30:00', 1, 3, 18025.00, 525.00),
(2, 'sell', 1.0000, 7200.000, '2024-11-20 15:00:00', 1, 3, 7416.00, 216.00),
(3, 'buy', 3.0000, 6800.000, '2024-11-21 10:45:00', 3, 5, 21012.00, 612.00),
(4, 'sell', 1.5000, 7000.000, '2024-11-21 14:15:00', 3, 5, 10815.00, 315.00),
(5, 'buy', 5.0000, 6000.000, '2024-11-21 16:00:00', 4, 2, 30900.00, 900.00),
(6, 'buy', 4.0000, 7100.000, '2024-11-22 09:00:00', 6, 7, 29252.00, 852.00),
(7, 'sell', 2.0000, 7300.000, '2024-11-22 11:45:00', 6, 7, 15038.00, 438.00),
(8, 'buy', 2.0000, 7500.000, '2024-11-23 08:30:00', 8, 4, 15450.00, 450.00),
(9, 'buy', 3.0000, 6800.000, '2024-11-23 10:15:00', 9, 1, 21012.00, 612.00),
(10, 'sell', 1.5000, 7000.000, '2024-11-23 13:00:00', 9, 1, 10815.00, 315.00),
(11, 'buy', 1.0000, 7700.000, '2024-11-24 09:00:00', 10, 8, 7931.00, 231.00),
(12, 'sell', 0.5000, 7900.000, '2024-11-24 11:30:00', 10, 8, 4068.50, 119.00),
(13, 'buy', 233.0000, 255.010, '2024-12-08 22:12:46', 3, 3, 61199.85, 1783.00),
(14, 'buy', 1.0000, 1.082, '2024-12-08 22:13:47', 3, 5, 1.11, 0.00),
(15, 'buy', 4.0000, 7.080, '2024-12-09 14:46:52', 3, 12, 29.17, 0.85),
(16, 'buy', 4.0000, 7.080, '2024-12-09 14:47:24', 3, 12, 29.17, 0.85),
(17, 'buy', 4.0000, 7.080, '2024-12-09 14:48:08', 3, 12, 29.17, 0.85),
(18, 'sell', 10.0000, 7.080, '2024-12-09 14:51:51', 3, 12, 68.68, 2.12),
(19, 'buy', 30.0000, 1.110, '2024-12-09 23:37:44', 3, 22, 34.30, 1.00),
(21, 'sell', 20.0000, 1.110, '2024-12-09 23:46:20', 3, 22, 21.53, 0.67),
(22, 'sell', 200.0000, 697.140, '2024-12-10 01:39:23', 3, 3, 135245.16, 4182.84),
(24, 'sell', 30.0000, 676.250, '2024-12-10 16:52:27', 3, 3, 19678.88, 608.62),
(25, 'sell', 3.0000, 0.280, '2024-12-11 20:42:16', 3, 5, 0.81, 0.03);

-- --------------------------------------------------------

--
-- Table structure for table `User_Activity`
--

CREATE TABLE `User_Activity` (
  `activity_id` int NOT NULL,
  `login_time` timestamp NULL DEFAULT NULL,
  `logout_time` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User_Activity`
--

INSERT INTO `User_Activity` (`activity_id`, `login_time`, `logout_time`, `user_id`) VALUES
(11, '2024-12-10 17:14:25', '2024-12-10 17:23:01', 2),
(10, '2024-12-10 16:52:03', '2024-12-10 17:14:20', 3),
(9, '2024-12-10 10:05:51', '2024-12-10 10:29:09', 3),
(8, '2024-12-10 01:33:30', '2024-12-10 01:33:30', 2),
(7, '2024-12-10 01:28:03', '2024-12-10 01:31:00', 3),
(6, '2024-12-10 01:14:50', '2024-12-10 01:15:12', 3),
(12, '2024-12-10 17:23:05', '2024-12-10 17:39:56', 3),
(13, '2024-12-10 17:40:01', '2024-12-10 17:40:05', 3),
(14, '2024-12-10 17:42:01', '2024-12-10 18:31:38', 3),
(15, '2024-12-10 18:33:29', '2024-12-10 18:33:44', 3),
(16, '2024-12-11 15:44:13', '2024-12-11 15:53:03', 3),
(17, '2024-12-11 18:49:26', '2024-12-11 18:52:57', 3);

-- --------------------------------------------------------

--
-- Table structure for table `User_data`
--

CREATE TABLE `User_data` (
  `user_id` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `wallet_balance` decimal(10,2) DEFAULT NULL,
  `referrals` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User_data`
--

INSERT INTO `User_data` (`user_id`, `username`, `email`, `password_hash`, `role`, `created_at`, `wallet_balance`, `referrals`) VALUES
(1, 'chandrakanth_naidu', 'gonuguc@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:27:07', 144487.33, 0),
(2, 'chandu', 'gonuguc@clarkson.edu', '3c7a71e1b859a94a35be988b0e7a633c', 'admin', '2024-11-20 22:27:07', 0.00, 1),
(3, 'srikanth', 'srikanthr@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:27:07', 678.93, 0),
(4, 'bhargav', 'bhargav@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:27:07', 1075.00, 0),
(5, 'kedharnath', 'kedharnath@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'admin', '2024-11-20 22:27:07', 0.00, 0),
(6, 'srikanth24', 'chandrakanthnaidu1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:03:00', 44.00, 0),
(7, 'srikanth11', 'chandrakanthnaidu104@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:05:19', 0.00, 0),
(8, 'srikanth18', 'chandrakanthnaidu10@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-20 22:05:43', 0.00, 0),
(9, 'srikanth14', 'chandrakanth04@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 08:23:33', 0.00, 0),
(10, 'chandu5', 'chaaidu1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 08:34:49', 0.00, 0),
(11, 'srikanth1234', 'chandraku1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 09:02:29', 0.00, 0),
(12, 'chandu15', 'chandraaidu1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 09:06:20', 0.00, 0),
(13, 'chandu12', 'chandrakanthnau1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 09:10:31', 0.00, 0),
(14, 'bhargaver', '604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 09:12:00', 0.00, 0),
(15, 'tylerconlon', 'tconlon@clarkson.edu', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-21 11:18:53', 0.00, 0),
(16, 'chandudrf', 'tdvkuebl@wfvg', '672f03a0e79b1d96c17fd7a405c6a434', 'user', '2024-11-21 11:20:20', 0.00, 0),
(17, 'chandu123', 'kanthnaidu1604@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-28 17:00:33', 0.00, 0),
(18, 'user18', 'user18@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-11-30 08:15:00', 2.00, 0),
(19, 'user19', 'user19@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-01 09:00:00', 1.00, 0),
(20, 'user20', 'user20@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-02 10:20:00', 3.00, 0),
(21, 'user21', 'user21@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-03 11:45:00', 0.00, 0),
(22, 'user22', 'user22@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-04 14:30:00', 1.00, 0),
(23, 'user23', 'user23@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-05 09:50:00', 2.00, 0),
(24, 'user24', 'user24@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-06 13:15:00', 0.00, 0),
(25, 'user25', 'user25@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-07 15:40:00', 3.00, 0),
(26, 'user26', 'user26@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-08 16:00:00', 1.00, 0),
(27, 'user27', 'user27@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-09 08:30:00', 0.00, 0),
(28, 'user28', 'user28@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-10 10:45:00', 2.00, 0),
(29, 'user29', 'user29@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-11 13:00:00', 1.00, 0),
(30, 'user30', 'user30@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-12 09:25:00', 0.00, 0),
(31, 'user31', 'user31@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-13 14:50:00', 3.00, 0),
(32, 'user32', 'user32@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-14 08:15:00', 0.00, 0),
(33, 'user33', 'user33@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-15 10:00:00', 1.00, 0),
(34, 'user34', 'user34@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-16 12:10:00', 2.00, 0),
(35, 'user35', 'user35@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-17 11:30:00', 3.00, 0),
(36, 'user36', 'user36@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-18 09:45:00', 0.00, 0),
(37, 'user37', 'user37@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-19 13:20:00', 1.00, 0),
(38, 'user38', 'user38@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-20 14:30:00', 2.00, 0),
(39, 'user39', 'user39@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-21 15:50:00', 0.00, 0),
(40, 'user40', 'user40@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-22 08:10:00', 3.00, 0),
(41, 'user41', 'user41@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-23 09:50:00', 1.00, 0),
(42, 'user42', 'user42@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-24 11:00:00', 2.00, 0),
(43, 'user43', 'user43@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-25 14:20:00', 0.00, 0),
(44, 'user44', 'user44@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-26 10:15:00', 1.00, 0),
(45, 'user45', 'user45@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-27 12:00:00', 0.00, 0),
(46, 'user46', 'user46@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-28 13:30:00', 3.00, 0),
(47, 'user47', 'user47@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-29 08:40:00', 1.00, 0),
(48, 'user48', 'user48@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-30 09:15:00', 2.00, 0),
(49, 'user49', 'user49@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-31 10:20:00', 0.00, 0),
(50, 'user50', 'user50@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2025-01-01 08:00:00', 1.00, 0),
(51, 'user51', 'user51@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2025-01-02 09:50:00', 3.00, 0),
(66, 'chandu13', 'naidu.chaaknth2013@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-09 13:55:51', 0.00, 0),
(64, 'chandu1332', 'naidu.chandraknth2013@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-09 13:54:39', 0.00, 0),
(57, 'srikanth12', 'naidu.chandrakanth2013@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-09 13:18:56', 0.00, 0),
(59, 'sreek', 'naidu.chandrakanth213@gmail.com', '3c7a71e1b859a94a35be988b0e7a633c', 'user', '2024-12-09 13:22:49', 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Wallet_Transaction_History`
--

CREATE TABLE `Wallet_Transaction_History` (
  `wallet_transaction_id` int NOT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `transaction_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Wallet_Transaction_History`
--

INSERT INTO `Wallet_Transaction_History` (`wallet_transaction_id`, `transaction_type`, `Amount`, `transaction_timestamp`, `user_id`) VALUES
(1, 'Deposit', 6000.00, '2024-10-20 08:15:00', 1),
(2, 'Deposit', 9000.00, '2024-10-21 10:45:00', 1),
(3, 'Deposit', 4000.00, '2024-10-22 11:30:00', 3),
(4, 'Withdraw', 7000.00, '2024-10-23 12:45:00', 4),
(5, 'Withdraw', 12000.00, '2024-10-24 14:00:00', 4),
(6, 'Deposit', 7500.00, '2024-10-25 09:15:00', 1),
(7, 'Withdraw', 3000.00, '2024-10-26 10:45:00', 3),
(8, 'Deposit', 5000.00, '2024-10-27 11:30:00', 4),
(9, 'Withdraw', 4500.00, '2024-10-28 12:45:00', 5),
(10, 'Deposit', 6000.00, '2024-10-29 14:00:00', 6),
(11, 'Withdraw', 8000.00, '2024-10-30 15:30:00', 7),
(12, 'Deposit', 2500.00, '2024-11-01 09:45:00', 8),
(13, 'Withdraw', 5000.00, '2024-11-02 10:30:00', 9),
(14, 'Deposit', 12000.00, '2024-11-03 11:15:00', 10),
(15, 'Withdraw', 7000.00, '2024-11-04 13:00:00', 1),
(16, 'Deposit', 4000.00, '2024-11-05 14:30:00', 3),
(17, 'Withdraw', 2000.00, '2024-11-06 15:45:00', 4),
(18, 'Deposit', 9000.00, '2024-11-07 16:30:00', 5),
(19, 'Withdraw', 3000.00, '2024-11-08 17:15:00', 6),
(20, 'Deposit', 11000.00, '2024-11-09 18:00:00', 7),
(21, 'Withdraw', 4000.00, '2024-11-10 19:15:00', 8),
(22, 'Deposit', 7500.00, '2024-11-11 20:00:00', 9),
(23, 'Withdraw', 6000.00, '2024-11-12 21:15:00', 10),
(24, 'Deposit', 10000.00, '2024-11-13 22:30:00', 1),
(25, 'Withdraw', 8500.00, '2024-11-14 23:45:00', 3),
(26, 'Withdraw', 961.00, '2024-12-10 10:37:28', 3),
(27, 'Withdraw', 24000.00, '2024-12-10 16:52:42', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Crypto_coins`
--
ALTER TABLE `Crypto_coins`
  ADD PRIMARY KEY (`cryptocoin_id`);

--
-- Indexes for table `Transaction_History`
--
ALTER TABLE `Transaction_History`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `User_Activity`
--
ALTER TABLE `User_Activity`
  ADD PRIMARY KEY (`activity_id`);

--
-- Indexes for table `User_data`
--
ALTER TABLE `User_data`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `Wallet_Transaction_History`
--
ALTER TABLE `Wallet_Transaction_History`
  ADD PRIMARY KEY (`wallet_transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Crypto_coins`
--
ALTER TABLE `Crypto_coins`
  MODIFY `cryptocoin_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `Transaction_History`
--
ALTER TABLE `Transaction_History`
  MODIFY `transaction_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `User_Activity`
--
ALTER TABLE `User_Activity`
  MODIFY `activity_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `User_data`
--
ALTER TABLE `User_data`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `Wallet_Transaction_History`
--
ALTER TABLE `Wallet_Transaction_History`
  MODIFY `wallet_transaction_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
