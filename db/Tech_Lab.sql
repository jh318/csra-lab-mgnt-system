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
    `role` ENUM('Admin', 'Student', 'SuperAdmin') NOT NULL DEFAULT 'Student',
    PRIMARY KEY (`user_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;

-- -----------------------------------------------------
-- Table `LCLSA_tech_lab_management_system`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LCLSA_tech_lab_management_system`.`Inventory` (
    `retired` BOOLEAN NOT NULL DEFAULT FALSE,
    `model_number` VARCHAR(70) NOT NULL,
    `serial_number` VARCHAR(70) NOT NULL,
    `item_type` ENUM('macbook', 'iphone') NOT NULL,
    `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_rented_by` VARCHAR(20) DEFAULT NULL,
    `taken_date` DATETIME DEFAULT NULL,
    `return_date` DATETIME DEFAULT NULL,
    `last_notified` DATETIME DEFAULT NULL,
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

INSERT INTO `User`  (`user_id`,   `first_name`, `last_name`,    `email`,                `note`,                 `active`, `role`) VALUES
                    ('asr020',    'Abhaya',     'Rawal',        'asr020@latech.edu',    'tech lab worker',      True,     'Admin'),
                    ("bjs049",    'Brandon',    'Serpas',       'bjs049@latech.edu',    'tech lab worker',      True,     'Admin'),
                    ("swk006",    'Skyler',     'King',         'swk006@latech.edu',    'csra lab worker',      True,     'Admin'),
                    ("tch031",    'Timothy',    'Hoff',         'tch031@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ('mwe016',    'Menglan',    'Wen',          'mwe016@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("cmh073",    'Carlos',     'Harris',       'cmh073@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("yab003",    'Yorel',      'Baker',        'yab003@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("jkh031",    'John',       'Hawley',       'jkh031@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("nnw003",    'Nicole',     'Nwoha',        'nnw003@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("pdd009",    'Paul',       'Donaubauer',   'pdd009@latech.edu',    'system developer',     True,     'SuperAdmin'),
                    ("box",       'Dr.',        'Box',          'box@latech.edu',       'likes birds',          True,     'Admin');

#  `category` ENUM('damaged_item', 'lost_item', 'vm_setup', 'vm_upgrade', 'tours', 'training', 'miscellaneous' ) NOT NULL DEFAULT 'miscellaneous',
#  `state` ENUM('Pending', 'Resolved') NOT NULL,
#  `priority` ENUM('Low', 'Normal', 'High') NOT NULL,

INSERT INTO `Ticket`  (`name`, `assigned_to`, `created_for`, `description`, `date_created`, `last_updated`, `state`, `priority`, `category`) VALUES
            ('Microsoft IOT Workshop',      "bjs049", "box",    'Can you arrange the lab for 25 seats for the Microsoft IOT training?',                           '2016-04-25 08:30:18',            '2016-04-26 08:03:18',            'Resolved', 'Normal', 'tours'),
            ('CSRA Lab Planning Meeting',   "asr020", "box",    'Planing meeting for upcoming year CSRA Lab usage',                                               '2016-04-20 11:19:18',            '2016-04-22 12:05:18',            'Resolved', 'High',   'tours'),
            ('Setup OS VMs',                "swk006", "box",    'Setup VMs for my operating systems class, see email.',                                           '2016-03-18 16:43:18',            DATE_SUB(NOW(), INTERVAL 11 day), 'Resolved', 'High',   'vm_setup'),
            ('Setup AppWorks™ VMs',         "swk006", "box",    'I need 6 AppWorks™ VMs and a tenate space for the senior capstone class, call me for details.',  DATE_SUB(NOW(), INTERVAL 60 day), DATE_SUB(NOW(), INTERVAL 60 day), 'Resolved', 'High',   'vm_setup'),
            ('Need a VM',                   "swk006", "tch031", 'I need an ubuntu box to deploy a sbt play app',                                                  DATE_SUB(NOW(), INTERVAL 20 day), DATE_SUB(NOW(), INTERVAL 14 day), 'Resolved', 'Normal', 'vm_setup'),
            ('Need sudo',                   "swk006", "tch031", 'I need to be added to the sudoers list on my vm please.',                                        DATE_SUB(NOW(), INTERVAL 14 day), DATE_SUB(NOW(), INTERVAL 13 day), 'Resolved', 'Normal', 'vm_upgrade'),
            ('Dell KACE Training',          "bjs049", "box",    'Schedule a training session for Monday at noon',                                                 DATE_SUB(NOW(), INTERVAL 27 day), DATE_SUB(NOW(), INTERVAL 27 day), 'Pending',  'Low',    'training'),
            ('Bad news',                    "asr020", "box",    'The hook wasnt strong enough and your picture fell.',                                           '2016-04-01 08:47:18',            '2016-04-01 12:17:18',             'Resolved', 'Low',    'damaged_item'),
            ('Order hooks',                 "bjs049", "box",    'Order hooks from amazon for picutres',                                                          '2016-04-01 10:47:18',            '2016-04-04 14:24:54',             'Resolved', 'Low',    'miscellaneous'),
            ('DreamSpark information ',     "bjs049", "box",    'Please get detailed info and how to get it subscribed for us',                                  '2016-03-31 10:47:18',            '2016-04-04 14:24:54',             'Resolved', 'Low',    'miscellaneous');

INSERT INTO `Inventory` (`item_rented_by`, `retired`, `model_number`, `serial_number`, `item_type`) VALUES
            (null, False, 'MDN00001', 'SN00001', 'iphone'),
            (null, False, 'MDN00002', 'SN00002', 'iphone'),
            (null, False, 'MDN00003', 'SN00003', 'macbook'),
            (null, False, 'MDN00003', 'SN00003', 'macbook'),
            (null, False, 'MDN00003', 'SN00003', 'macbook'),
            (null, False, 'MDN00003', 'SN00003', 'macbook'),
            (null, False, 'MDN00003', 'SN00003', 'macbook');
            
INSERT INTO `Inventory` (`item_rented_by`, `retired`, `model_number`, `serial_number`, `item_type`, `taken_date`, `return_date`) VALUES
            ("bjs049", 1, 'MDN00004', 'SN00004', 'macbook', '2016-03-18 11:32:09', '2016-04-21 12:00:00'),
            ("tch031", 0, 'MDN00005', 'SN00005', 'iphone',  '2016-03-19 12:43:20', '2016-03-21 12:00:00');

​
Delimiter //
Create Trigger update_inventory_trigger 
BEFORE Update on `LCLSA_tech_lab_management_system`.`Inventory`
for each row
begin
  if (NEW.item_rented_by is null and OLD.item_rented_by is not null) then
    set NEW.last_notified = null;
    update History as H set H.return_date = current_timestamp where (H.item_id = new.item_id) AND (H.return_date is null);
  end if;
  
  if (NEW.item_rented_by is not null and OLD.item_rented_by is null) then
    set NEW.last_notified = NEW.return_date;
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