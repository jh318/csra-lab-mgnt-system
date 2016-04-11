-- MySQL Script generated by MySQL Workbench
-- Wed Mar 23 10:25:53 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LCLSA_tech_lab_management_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LCLSA_tech_lab_management_system
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `LCLSA_tech_lab_management_system` ;
CREATE DATABASE IF NOT EXISTS `LCLSA_tech_lab_management_system` DEFAULT CHARACTER SET latin1 ;
USE `LCLSA_tech_lab_management_system` ;

-- -----------------------------------------------------
-- Table `LCLSA_tech_lab_management_system`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LCLSA_tech_lab_management_system`.`User` (
    `user_id` VARCHAR(20) NOT NULL,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name` VARCHAR(20) NOT NULL,
    `email` VARCHAR(30),
    `note` VARCHAR(50),
    `active` BOOLEAN NOT NULL DEFAULT TRUE,
    `role` ENUM('Admin', 'Student') NOT NULL DEFAULT 'Student',
    PRIMARY KEY (`user_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

-- -----------------------------------------------------
-- Table `LCLSA_tech_lab_management_system`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LCLSA_tech_lab_management_system`.`Inventory` (
    `available` BOOLEAN NOT NULL DEFAULT TRUE,
    `retired` BOOLEAN NOT NULL DEFAULT FALSE,
    `model_number` VARCHAR(70) NOT NULL,
    `serial_number` VARCHAR(70) NOT NULL,
    `item_type` ENUM('macbook', 'iphone') NOT NULL,
    `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_rented_by` VARCHAR(20) DEFAULT NULL,
    `taken_date` DATETIME DEFAULT NULL,
    `return_date` DATETIME DEFAULT NULL,
    PRIMARY KEY (`item_id`),
    CONSTRAINT `fk_Inventory_User` FOREIGN KEY (`item_rented_by`)
        REFERENCES `LCLSA_tech_lab_management_system`.`User` (`user_id`)
)  ENGINE=INNODB AUTO_INCREMENT=2005 DEFAULT CHARACTER SET=LATIN1;


-- -----------------------------------------------------
-- Table `LCLSA_tech_lab_management_system`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LCLSA_tech_lab_management_system`.`Ticket` (
    `ticketID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `assigned_to` VARCHAR(20) DEFAULT NULL,
    `created_for` VARCHAR(20) DEFAULT NULL,
    `description` VARCHAR(200),
    `date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`category` ENUM('damaged_item', 'lost_item', 'vm_setup', 'vm_upgrade', 'tours', 'training', 'miscellaneous' ) NOT NULL DEFAULT 'miscellaneous',

    `state` ENUM('Pending', 'Resolved') NOT NULL,
    `priority` ENUM('Low', 'Normal', 'High') NOT NULL,
    PRIMARY KEY (`ticketID`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

-- -----------------------------------------------------
-- Table `LCLSA_tech_lab_management_system`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LCLSA_tech_lab_management_system`.`History` (
    `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `item_id` INT UNSIGNED NOT NULL,
    `taken_date` DATETIME DEFAULT NULL,
    `return_date` DATETIME DEFAULT NULL,
    CONSTRAINT `fk_History_Item` FOREIGN KEY (`item_id`)
        REFERENCES `LCLSA_tech_lab_management_system`.`Inventory` (`item_id`)
)  ENGINE=INNODB AUTO_INCREMENT=2005 DEFAULT CHARACTER SET=LATIN1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `User` 	(`user_id`, `first_name`, 	`last_name`, 	`email`, 				`note`, 			`active`, `role`) VALUES
					("box",    'Dr.',			'Box',			'box@latech.edu', 		'likes birds', 		True, 'Admin'),
					("tch031", 'Tim',			'Hoff', 		'tch031@latech.edu',	'an awesome user', 	True, 'Admin'),
					("bjs049", 'Brandon',		'Serpas', 		'bjs049@latech.edu', 	'tech lab worker',	True, 'Admin'),
					("pdd009", 'Paul',			'Donaubauer', 	'pdd009@latech.edu', 	'system developer',	True, 'Student'),
					("old003", 'Former',		'User', 		'inactive@jeeves.com', 	'not active', 		False, 'Student'),
					("oldadm", 'Former', 		'Admin', 		'formerA@jenkins.com', 	'ask me anything', 	False, 'Admin');

INSERT INTO `Ticket` 	(`name`, `assigned_to`, `created_for`, `description`, `date_created`, `last_updated`, `state`, `priority`, `category`) VALUES
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 30 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 40 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 50 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'training'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 60 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 70 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 80 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 90 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 100 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 110 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 120 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 130 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 130 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 140 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 150 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'training'),						('Ticket 1', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 90 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 160 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 170 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 180 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 200 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 210 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),			('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 30 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 40 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 50 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'training'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 60 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 70 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 80 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 90 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 100 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 110 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 120 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 130 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1310 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1140 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1150 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'training'),						('Ticket 1', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 90 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1160 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1170 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1180 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 2100 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 2110 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),			('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 30 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 410 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 510 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'training'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 610 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 710 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'miscellaneous'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 810 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 910 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1100 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1110 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1120 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1130 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'tours'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1130 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1140 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1150 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'training'),						('Ticket 1', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 90 day), '2016-03-21 22:47:18', 'Pending', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1160 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'damaged_item'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1170 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1180 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 1190 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_upgrade'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 2100 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description',  DATE_SUB(NOW(), INTERVAL 2110 day), '2016-03-21 22:47:18', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "tch031", 'Sample Description', '2016-03-17 22:48:19', '2016-03-21 22:48:19', 'Pending', 'Normal', 'vm_setup'),
						('Ticket', "tch031", "tch031", 'Sample Description', '2016-03-11 22:48:19', '2016-03-21 22:48:19', 'Pending', 'High', 'lost_item'),
						('Ticket', "bjs049", "bjs049", 'Sample Description', '2016-03-15 22:48:19', '2016-03-21 22:48:19', 'Resolved', 'Low', 'vm_setup'),
						('Ticket', "bjs049", "pdd009", 'Sample Description', '2016-03-13 22:48:19', '2016-03-21 22:48:19', 'Resolved', 'Normal', 'tours'),
						('Ticket', "tch031", "pdd009", 'Sample Description', '2016-03-15 22:48:19', '2016-03-21 22:48:19', 'Resolved', 'High', 'vm_setup');

INSERT INTO `Inventory` (`available`, `item_rented_by`, `retired`, `model_number`, `serial_number`, `item_type`) VALUES
						(True, null, False, 'MDN00001', 'SN00001', 'iphone'),
						(True, null, False, 'MDN00002', 'SN00002', 'iphone'),
						(True, null, False, 'MDN00003', 'SN00003', 'macbook'),
                        (True, null, False, 'MDN00003', 'SN00003', 'macbook'),
						(True, null, False, 'MDN00003', 'SN00003', 'macbook'),
                        (True, null, False, 'MDN00003', 'SN00003', 'macbook'),
                        (True, null, False, 'MDN00003', 'SN00003', 'macbook');
						
INSERT INTO `Inventory` (`available`, `item_rented_by`, `retired`, `model_number`, `serial_number`, `item_type`, `taken_date`, `return_date`) VALUES
						(0, "bjs049", 1, 'MDN00004', 'SN00004', 'macbook', '2016-03-18 11:32:09', '2016-04-21 12:00:00'),
						(0, "tch031", 0, 'MDN00005', 'SN00005', 'iphone',  '2016-03-19 12:43:20', '2016-03-21 12:00:00');

​
Delimiter //
Create Trigger update_inventory_trigger 
BEFORE Update on `LCLSA_tech_lab_management_system`.`Inventory`
for each row
begin
	if (NEW.item_rented_by is null and OLD.item_rented_by is not null) then
		update History as H set H.return_date = current_timestamp where (H.item_id = new.item_id) AND (H.return_date is null);
	end if;
	
	if (NEW.item_rented_by is not null and OLD.item_rented_by is null) then
		insert into History(`item_id`,`taken_date`) values (new.item_id, current_timestamp);
	end if;	
	
	if (NEW.taken_date is null and NEW.item_rented_by is not null) then
		set NEW.taken_date = current_timestamp;
	end if;
end;//
Delimiter ;




SET @my_id = (SELECT item_id FROM LCLSA_tech_lab_management_system.Inventory LIMIT 1);

UPDATE Inventory 
SET 
    item_rented_by = 'box'
WHERE
    `item_id` = @my_id;
UPDATE Inventory 
SET 
    item_rented_by = NULL
WHERE
    `item_id` = @my_id;

UPDATE Inventory 
SET 
    item_rented_by = 'tch031'
WHERE
    `item_id` = @my_id;