SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Create database: `frontend`
--

CREATE DATABASE IF NOT EXISTS `frontend` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `frontend`;

DROP TABLE IF EXISTS `ci_sessions`;
DROP TABLE IF EXISTS `Order_recipe`;
DROP TABLE IF EXISTS `Recipe_supply`;
DROP TABLE IF EXISTS `Recipes`;
DROP TABLE IF EXISTS `Orders`;
--
-- Create tables
--

CREATE TABLE `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  KEY (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Recipes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unit` int NOT NULL,
  `picture` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `customer` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Order_recipe` (
  `order_id` int NOT NULL,
  `recipe_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `Order_recipe`
ADD PRIMARY KEY (`order_id`, `recipe_id`);

CREATE TABLE `Recipe_supply`(
  `recipe_id` int NOT NULL,
  `supply_id` int NOT NULL,
  `amount` decimal(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `Recipe_supply`
ADD PRIMARY KEY (`recipe_id`, `supply_id`);

--
-- Insert data into tables
--

INSERT INTO `Recipes` (`name`,`description`,`price`,`unit`,`picture`)
VALUES
<<<<<<< HEAD:data/frontend.sql
('Apple Coffee Cake', 'Almost every Sunday morning growing up, my father would make a huge apple coffee cake for us after church. We would hungrily watch him pour the batter into the pyrex baking dish, insert apple slices, and sprinkle with streusel topping. </br>Oh the magic of baking to young eyes! A half hour later the coffee cake would emerge from the oven, perfectly risen and crusted with brown sugar.', 3.25, 20, 'apple-coffee-cake.jpg'),
('Spice Paleo Pumpkin Muffins', 'Pumpkin pancakes and cinnamon rolls are well and good, but what about those of us who like something savory instead of sweet for our weekday breakfasts? These Paleo muffins prove that pumpkin plays just as well with cumin and paprika as it does with cinnamon and nutmeg. </br>These muffins make a great grab-and-go breakfast or a healthy afternoon snack. They are also grain-free and very nutritious!', 3.5, 35,'Spicy-Paleo-Pumpkin-Muffins.jpg'),
('Classic Buttermilk Waffles','Waffles are a serious business in my breakfast-loving household, and I recently set my sights on the mother of all maple-drenched ambitions: The Classic Buttermilk Waffle. This is such a simple and timeless breakfast that I figured it would be easy-peasy to come up with a good recipe.',2.75, 27,'Classic-Buttermilk-Waffles.jpg'),
('Key Lime Pie','Key limes are great if you can get them! They’re from the Florida Keys, where they now grow wild, and are smaller and more tart than our standard Persian limes, and with yellow centers and rinds.', 2.75, 25,'key-lime-pie.jpg'),
('Eggnog Pound Cake','If you do have some eggnog, here is a wonderful pound cake to make with it, a cake that celebrates all things eggnoggy (new word, just made it up). Like eggnog, it is well spiced with nutmeg, cinnamon, and allspice. It has flecks of sweetened dried cranberries and orange zest.',12,18,'eggnog-poundcake.jpg'),
('Banana Bread Granola','This Banana Bread Granola has all the warm comforting flavors of my favorite banana bread recipe (the one right here on Simply Recipes!), but it’s a little more suitable for weekday breakfasts.',9,20,'Banana-Bread-Granola.jpg'),
('Blackberry Muffins','The secret to making the best muffins is sour cream! Rich and tangy sour cream not only intensifies the flavor of the berries, but makes the muffins irresistibly tender and delicious.',5,17,'blackberry-muffins.jpg'),
('Perfect Cheesecake','It is a classic New York style cheesecake with a graham cracker crust and high sides. It is dense, rich, and light at the same time, and serves a small army. But watch out—just when you think you’ve made enough for your gathering, so many people will go back for seconds that you may be left without a piece!',23, 12,'perfect-cheesecake.jpg');
=======
('Apple Coffee Cake', 'Almost every Sunday morning growing up, my father would make a huge apple coffee cake for us after church. We would hungrily watch him pour the batter into the pyrex baking dish, insert apple slices, and sprinkle with streusel topping. </br>Oh the magic of baking to young eyes! A half hour later the coffee cake would emerge from the oven, perfectly risen and crusted with brown sugar.', 13.25, 20, 'apple-coffee-cake.jpg'),
('Spicy Paleo Pumpkin Muffins', 'Pumpkin pancakes and cinnamon rolls are well and good, but what about those of us who like something savory instead of sweet for our weekday breakfasts? These Paleo muffins prove that pumpkin plays just as well with cumin and paprika as it does with cinnamon and nutmeg. </br>These muffins make a great grab-and-go breakfast or a healthy afternoon snack. They are also grain-free and very nutritious!', 13.5, 35,'Spicy-Paleo-Pumpkin-Muffins.jpg'),
('Classic Buttermilk Waffles','Waffles are a serious business in my breakfast-loving household, and I recently set my sights on the mother of all maple-drenched ambitions: The Classic Buttermilk Waffle. This is such a simple and timeless breakfast that I figured it would be easy-peasy to come up with a good recipe.',12.75, 27,'Classic-Buttermilk-Waffles.jpg'),
('Key Lime Pie','Key limes are great if you can get them! They’re from the Florida Keys, where they now grow wild, and are smaller and more tart than our standard Persian limes, and with yellow centers and rinds.', 12.75, 25,'key-lime-pie.jpg'),
('Eggnog Pound Cake','If you do have some eggnog, here is a wonderful pound cake to make with it, a cake that celebrates all things eggnoggy (new word, just made it up). Like eggnog, it is well spiced with nutmeg, cinnamon, and allspice. It has flecks of sweetened dried cranberries and orange zest.',14.75,18,'eggnog-poundcake.jpg'),
('Banana Bread Granola','This Banana Bread Granola has all the warm comforting flavors of my favorite banana bread recipe (the one right here on Simply Recipes!), but it’s a little more suitable for weekday breakfasts.',13.75,20,'Banana-Bread-Granola.jpg'),
('Blackberry Muffins','The secret to making the best muffins is sour cream! Rich and tangy sour cream not only intensifies the flavor of the berries, but makes the muffins irresistibly tender and delicious.',13.5,17,'blackberry-muffins.jpg'),
('Perfect Cheesecake','It is a classic New York style cheesecake with a graham cracker crust and high sides. It is dense, rich, and light at the same time, and serves a small army. But watch out—just when you think you’ve made enough for your gathering, so many people will go back for seconds that you may be left without a piece!',14.5, 12,'perfect-cheesecake.jpg');
>>>>>>> 23a0189c84ffbca19505b018c46174476b3d8dc2:data/frontEndBakery.sql

INSERT INTO `Recipe_supply` (`recipe_id`, `supply_id`, `amount`)
VALUES
(1, 1, 280),
(1, 2, 10),
(1, 18, 4),
(1, 19, 50),
(1, 22, 5),
(1, 20, 140),
(1, 21, 2),
(1, 23, 235),
(1, 24, 1),
(2, 25, 350),
(2, 28, 100),
(2, 26, 230),
(2, 3, 10),
(2, 2, 15),
(2, 16,10),
(2, 17, 5),
(2, 18, 5),
(2, 21, 4),
(2, 15, 50),
(2, 14, 10),
(2, 13, 5),
(2, 19, 50),
(2, 12, 15),
(2, 11, 35),
(2, 10, 70),
(3, 1, 280),
(3, 19, 40),
(3, 3, 8),
(3, 2, 15),
(3, 18, 5),
(3, 21, 2),
(3, 9, 100),
(3, 20, 40),
(4, 6, 145),
(4, 20, 25),
(4, 19, 100),
(4, 8, 20),
(4, 21, 3),
(4, 7, 400),
(4, 5, 40),
(4, 4, 25),
(4, 27, 2),
(5, 29, 300),
(5, 30, 80),
(5, 31, 60),
(5, 1, 420),
(5, 2, 10),
(5, 18, 5),
(5, 32, 5),
(5, 22, 3),
(5, 33, 3),
(5, 20, 230),
(5, 19, 200),
(5, 21, 5),
(5, 34, 340),
(5, 35, 20),
(5, 36, 15),
(5, 27, 5),
(6, 20, 60),
(6, 19, 70),
(6, 27, 15),
(6, 37, 15),
(6, 38, 255),
(6, 39, 75),
(6, 18, 5),
(6, 41, 2),
(6, 40, 25),
(6, 22, 8),
(7, 1, 350),
(7, 2, 20),
(7, 3, 5),
(7, 18, 5),
(7, 22, 3),
(7, 21, 2),
(7, 42, 235),
(7, 23, 5),
(7, 19, 200),
(7, 27, 5),
(7, 20, 112),
(7, 43, 150),
(8, 44, 230),
(8, 19, 440),
(8, 18, 3),
(8, 20, 60),
(8, 45, 900),
(8, 27, 20),
(8, 21, 4),
(8, 46, 340),
(8, 42, 630),
(8, 37, 120);
