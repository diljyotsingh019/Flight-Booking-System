SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flight_booking_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flight_booking_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flight_booking_system` DEFAULT CHARACTER SET utf8 ;
USE `flight_booking_system` ;

-- -----------------------------------------------------
-- Table `flight_booking_system`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`airlines` (
  `airline_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `air_conf_numbers` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking_system`.`airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`airports` (
  `airport_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking_system`.`flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`flights` (
  `flight_id` INT NOT NULL,
  `departure_airport_id` SMALLINT NOT NULL,
  `arrival_airport_id` SMALLINT NOT NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_flights_airports_idx` (`departure_airport_id` ASC) VISIBLE,
  INDEX `fk_flights_airports1_idx` (`arrival_airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_flights_airports`
    FOREIGN KEY (`departure_airport_id`)
    REFERENCES `flight_booking_system`.`airports` (`airport_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_flights_airports1`
    FOREIGN KEY (`arrival_airport_id`)
    REFERENCES `flight_booking_system`.`airports` (`airport_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking_system`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone` TINYINT NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking_system`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `amount` SMALLINT NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `payment_details` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payments_customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `flight_booking_system`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking_system`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking_system`.`tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `airline_id` SMALLINT NOT NULL,
  `flight_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `departure_date` DATETIME NOT NULL,
  `arrival_date` DATETIME NOT NULL,
  `ticket_details` VARCHAR(45) NOT NULL,
  INDEX `fk_passengers_flights1_idx` (`flight_id` ASC) VISIBLE,
  INDEX `fk_passengers_customers1_idx` (`customer_id` ASC) VISIBLE,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_tickets_payments1_idx` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_passengers_airlines1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `flight_booking_system`.`airlines` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passengers_flights1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flight_booking_system`.`flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_passengers_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `flight_booking_system`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_payments1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `flight_booking_system`.`payments` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
