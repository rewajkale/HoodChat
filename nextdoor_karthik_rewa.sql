-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2016 at 01:46 AM
-- Server version: 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nextdoor`
--

-- --------------------------------------------------------

--
-- Table structure for table `block`
--

CREATE TABLE `block` (
  `block_id` int(11) NOT NULL,
  `block_name` varchar(30) NOT NULL,
  `hood_id` int(30) NOT NULL,
  `lon_west` double DEFAULT NULL,
  `lon_east` double DEFAULT NULL,
  `lat_south` double DEFAULT NULL,
  `lat_north` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `block`
--

INSERT INTO `block` (`block_id`, `block_name`, `hood_id`, `lon_west`, `lon_east`, `lat_south`, `lat_north`) VALUES
(1, 'behind_playgrund', 2, 10, 30, 10, 30),
(2, 'near_patel_store', 2, 30, 50, 20, 40),
(3, 'near_petrol_station', 1, 70, 100, 10, 50);

-- --------------------------------------------------------

--
-- Table structure for table `block_requests`
--

CREATE TABLE `block_requests` (
  `sender` int(30) NOT NULL,
  `receiver` int(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `block_requests`
--

INSERT INTO `block_requests` (`sender`, `receiver`, `status`, `time`) VALUES
(1, 3, 'P', '2016-01-11 22:40:57.561561');

-- --------------------------------------------------------

--
-- Table structure for table `cat_priority`
--

CREATE TABLE `cat_priority` (
  `category` varchar(30) NOT NULL,
  `priority` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cat_priority`
--

INSERT INTO `cat_priority` (`category`, `priority`) VALUES
('Crime', 1),
('Property', 2),
('Food', 4),
('Events', 3);

-- --------------------------------------------------------

--
-- Table structure for table `custom_visibility`
--

CREATE TABLE `custom_visibility` (
  `thread_id` int(30) NOT NULL,
  `receiver_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hood`
--

CREATE TABLE `hood` (
  `hood_id` int(11) NOT NULL,
  `hood_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hood`
--

INSERT INTO `hood` (`hood_id`, `hood_name`) VALUES
(1, 'BayRidge'),
(2, 'SunsetPark'),
(3, 'OzonePark');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `u_id` int(11) NOT NULL,
  `u_name` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`u_id`, `u_name`, `password`) VALUES
(1, 'Karthik', ''),
(2, 'Rewa', ''),
(3, 'Kristina', ''),
(4, 'Kashish', ''),
(5, 'Abhishek', ''),
(6, 'Vignesh', ''),
(7, 'Piyush_1', '');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `msg_id` int(30) NOT NULL,
  `u_id` int(30) NOT NULL,
  `thread_id` int(30) NOT NULL,
  `msg_body` text NOT NULL,
  `time_stamp` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`msg_id`, `u_id`, `thread_id`, `msg_body`, `time_stamp`) VALUES
(0, 1, 0, 'Today two people got killed', '2016-01-13 19:43:05.395068');

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE `relationships` (
  `sender` int(30) NOT NULL,
  `receiver` int(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `relationships`
--

INSERT INTO `relationships` (`sender`, `receiver`, `type`, `status`, `time`) VALUES
(5, 6, 'N', 'A', '2016-01-13 19:43:05.395068'),
(5, 4, 'F', 'A', '2016-01-13 21:28:17.395351');

-- --------------------------------------------------------

--
-- Table structure for table `thread`
--

CREATE TABLE `thread` (
  `thread_id` int(30) NOT NULL,
  `u_id` int(30) NOT NULL,
  `thread_title` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `creation_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `thread`
--

INSERT INTO `thread` (`thread_id`, `u_id`, `thread_title`, `category`, `creation_time`) VALUES
(0, 1, 'Crimes Today', 'Crime', '2016-01-13 19:43:05.395068');

-- --------------------------------------------------------

--
-- Table structure for table `thread_visibility`
--

CREATE TABLE `thread_visibility` (
  `thread_id` int(30) NOT NULL,
  `u_id` int(30) NOT NULL,
  `visibility_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `u_id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `address` varchar(60) NOT NULL,
  `apt` int(30) DEFAULT NULL,
  `block_id` int(30) NOT NULL,
  `block_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `last_login_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`u_id`, `email`, `first_name`, `last_name`, `gender`, `address`, `apt`, `block_id`, `block_accepted`, `last_login_time`) VALUES
(1, 'karthik.tvs@nyu.edu', 'Karthik', 'Tiruveedhi', 'M', '644 55th street', 1, 2, 0, '2016-01-11 22:34:55.977759'),
(2, 'rewa.kale@nyu.edu', 'Rewa', 'Kale', 'F', '446 Senator Street', 7, 1, 0, '2016-01-10 00:30:56.043165'),
(3, 'kristina@gmail.com', 'Kristina', 'Torres', 'F', '644 55th street', 0, 2, 1, '2016-01-11 22:35:08.194581'),
(4, 'kashish.dua@nyu.edu', 'Kashish', 'Dua', 'M', '446 Senator Street', 20, 1, 1, '2016-01-11 21:32:00.381471'),
(5, 'akadian@gmail.com', 'Abhishek', 'Kadian', 'M', '644 55th street', 1, 2, 1, '2016-01-13 19:49:54.832461'),
(6, 'vignesh.g@gmail.com', 'Vignesh', 'Gawahalli', 'M', '644 55th street', 1, 2, 1, '2016-01-13 19:50:00.249658'),
(7, 'pchaudhary@nyu.edu', 'Piyush', 'Chaudhary', 'M', '446 Senator Street', 20, 1, 0, '2016-01-13 19:11:58.358650');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `block`
--
ALTER TABLE `block`
  ADD PRIMARY KEY (`block_id`),
  ADD KEY `belongsTo` (`hood_id`);

--
-- Indexes for table `hood`
--
ALTER TABLE `hood`
  ADD PRIMARY KEY (`hood_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`u_id`),
  ADD UNIQUE KEY `u_name` (`u_name`);

--
-- Indexes for table `thread_visibility`
--
ALTER TABLE `thread_visibility`
  ADD UNIQUE KEY `thread_id` (`thread_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `block`
--
ALTER TABLE `block`
  MODIFY `block_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `hood`
--
ALTER TABLE `hood`
  MODIFY `hood_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `block`
--
ALTER TABLE `block`
  ADD CONSTRAINT `belongsTo` FOREIGN KEY (`hood_id`) REFERENCES `hood` (`hood_id`);

--
-- Constraints for table `thread_visibility`
--
ALTER TABLE `thread_visibility`
  ADD CONSTRAINT `visibleTo` FOREIGN KEY (`thread_id`) REFERENCES `thread` (`thread_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
