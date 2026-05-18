CREATE SCHEMA `onlinestore` ;

CREATE TABLE `onlinestore`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `DOB` DATE NOT NULL,
  `gender` VARCHAR(5) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);

  CREATE TABLE `onlinestore`.`products` (
  `product_id` INT NOT NULL,
  `Product_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `category_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`));


  CREATE TABLE `onlinestore`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `total_amount` FLOAT NOT NULL,
  PRIMARY KEY (`order_id`));

  CREATE TABLE `onlinestore`.`order_items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `Price_at_purchase` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_item_id`));

  CREATE TABLE `onlinestore`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `amount` FLOAT NOT NULL,
  `payment_method` VARCHAR(15) NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`payment_id`));

CREATE TABLE `onlinestore`.`reviews` (
  `reviews_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `rating` VARCHAR(5) NOT NULL,
  `comment` VARCHAR(45) NOT NULL,
  `review_date` DATE NOT NULL,
  PRIMARY KEY (`reviews_id`));

CREATE TABLE `onlinestore`.`shipping` (
  `shipping_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `shipping_address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `pincode` INT NOT NULL,
  `shipped_date` DATE NOT NULL,
  `delivered_date` DATE NOT NULL,
  `shipping_status` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`shipping_id`));

ALTER TABLE `onlinestore`.`order` 
ADD INDEX `user_id_idx` (`user_id` ASC) VISIBLE;
;
ALTER TABLE `onlinestore`.`order` 
ADD CONSTRAINT `user_id`
  FOREIGN KEY (`user_id`)
  REFERENCES `onlinestore`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `onlinestore`.`order_items` 
ADD INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
ADD INDEX `product_id_idx` (`product_id` ASC) VISIBLE;
;
ALTER TABLE `onlinestore`.`order_items` 
ADD CONSTRAINT `order_id`
  FOREIGN KEY (`order_id`)
  REFERENCES `onlinestore`.`order` (`order_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `product_id`
  FOREIGN KEY (`product_id`)
  REFERENCES `onlinestore`.`products` (`product_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `onlinestore`.`payments` 
ADD INDEX `order_id_idx` (`order_id` ASC) VISIBLE;
;
ALTER TABLE `onlinestore`.`payments` 
ADD CONSTRAINT `order_id`
  FOREIGN KEY (`order_id`)
  REFERENCES `onlinestore`.`order` (`order_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('1', 'harsh', 'harshjain1234@gmail.com', '1234567890', '2004-07-17', 'M', '2024-08-16', '2024-09-16');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('2', 'khushi', 'kj2596@gmail.com', '7894561230', '2003-06-20', 'F', '2024-08-17', '2024-09-17');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('3', 'Apeksha', 'aj1254@gmail.com', '7418529630', '2006-09-09', 'F', '2024-08-18', '2024-09-18');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('4', 'Khyati', 'khyati7896@gmail.com', '1456237890', '2008-08-08', 'F', '2024-08-19', '2024-09-19');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('5', 'Narendra', 'nj4569@gmail.com', '7412589630', '2001-01-15', 'M', '2024-08-20', '2024-09-20');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('6', 'Mohit', 'mk8526@gmail.com', '4567891230', '2005-05-15', 'M', '2024-08-21', '2024-09-21');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('7', 'Aman', 'aman8964@gmail.com', '7894561230', '2006-06-18', 'M', '2024-08-22', '2024-09-22');
INSERT INTO `onlinestore`.`user` (`user_id`, `username`, `email`, `phone`, `DOB`, `gender`, `created_at`, `update_at`) VALUES ('8', 'Pranit', 'pranit4569@gmail.com', '1456789320', '2002-09-08', 'F', '2024-08-23', '2024-09-23');

