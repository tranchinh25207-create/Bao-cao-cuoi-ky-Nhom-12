-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema petcare
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petcare
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petcare` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `petcare` ;

-- -----------------------------------------------------
-- Table `petcare`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`members` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `member_code` VARCHAR(20) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `birth_date` DATE NOT NULL,
  `join_date` DATE NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE INDEX `uq_member_code` (`member_code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`traininglevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`traininglevel` (
  `level_id` INT NOT NULL AUTO_INCREMENT,
  `level_name` VARCHAR(100) NOT NULL,
  `badge_color` VARCHAR(50) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`level_id`),
  UNIQUE INDEX `uq_level_name` (`level_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`trainer` (
  `member_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `status` ENUM('paid', 'volunteer') NOT NULL DEFAULT 'volunteer',
  PRIMARY KEY (`member_id`),
  CONSTRAINT `fk_trainer_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `petcare`.`members` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`trainingclass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`trainingclass` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `level_id` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  `day_of_week` ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
  `start_time` TIME NOT NULL,
  `training_area` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`class_id`),
  INDEX `fk_class_level` (`level_id` ASC) VISIBLE,
  INDEX `fk_class_trainer` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_level`
    FOREIGN KEY (`level_id`)
    REFERENCES `petcare`.`traininglevel` (`level_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_class_trainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `petcare`.`trainer` (`member_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`trainingsession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`trainingsession` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `class_id` INT NOT NULL,
  `session_date` DATE NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_session_class` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_session_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `petcare`.`trainingclass` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`attendance` (
  `member_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  `attendance_status` ENUM('Present', 'Absent') NULL DEFAULT 'Present',
  `check_in_time` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`, `session_id`),
  INDEX `fk_attendance_session` (`session_id` ASC) VISIBLE,
  CONSTRAINT `fk_attendance_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `petcare`.`members` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_session`
    FOREIGN KEY (`session_id`)
    REFERENCES `petcare`.`trainingsession` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`memberlevel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`memberlevel` (
  `member_id` INT NOT NULL,
  `level_id` INT NOT NULL,
  `achieved_date` DATE NOT NULL,
  PRIMARY KEY (`member_id`, `level_id`),
  INDEX `fk_memberlevel_level` (`level_id` ASC) VISIBLE,
  CONSTRAINT `fk_memberlevel_level`
    FOREIGN KEY (`level_id`)
    REFERENCES `petcare`.`traininglevel` (`level_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_memberlevel_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `petcare`.`members` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`sessiontrainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`sessiontrainer` (
  `session_id` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  `role` ENUM('head', 'assistant') NOT NULL DEFAULT 'assistant',
  PRIMARY KEY (`session_id`, `trainer_id`),
  INDEX `fk_sessiontrainer_trainer` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_sessiontrainer_session`
    FOREIGN KEY (`session_id`)
    REFERENCES `petcare`.`trainingsession` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sessiontrainer_trainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `petcare`.`trainer` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `petcare`.`trainingrequirement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petcare`.`trainingrequirement` (
  `requirement_id` INT NOT NULL AUTO_INCREMENT,
  `level_id` INT NOT NULL,
  `requirement_name` VARCHAR(150) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`requirement_id`),
  INDEX `fk_requirement_level` (`level_id` ASC) VISIBLE,
  CONSTRAINT `fk_requirement_level`
    FOREIGN KEY (`level_id`)
    REFERENCES `petcare`.`traininglevel` (`level_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
