-- MySQL Script generated by MySQL Workbench
-- Thu May  4 10:56:06 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema externatic
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `externatic` ;

-- -----------------------------------------------------
-- Schema externatic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `externatic` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `externatic` ;

-- -----------------------------------------------------
-- Table `externatic`.`candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`candidate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalAdress` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `jobSeeker` TINYINT NOT NULL,
  `picture` VARCHAR(45) NULL DEFAULT NULL,
  `resume` VARCHAR(45) NULL DEFAULT NULL,
  `contactPreference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `regionId` INT NOT NULL,
  PRIMARY KEY (`id`, `regionId`),
  INDEX `fk_city_region1_idx` (`regionId` ASC) VISIBLE,
  CONSTRAINT `fk_city_region1`
    FOREIGN KEY (`regionId`)
    REFERENCES `externatic`.`region` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`contrat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`contrat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`job_title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`job_title` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`candidate_filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`candidate_filter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `job_title_id` INT NOT NULL,
  `contrat_id` INT NOT NULL,
  PRIMARY KEY (`id`, `candidate_id`, `city_id`, `job_title_id`, `contrat_id`),
  INDEX `fk_candidate_filter_candidate1_idx` (`candidate_id` ASC) VISIBLE,
  INDEX `fk_candidate_filter_city1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_candidate_filter_job_title1_idx` (`job_title_id` ASC) VISIBLE,
  INDEX `fk_candidate_filter_contrat1_idx` (`contrat_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidate_filter_candidate1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `externatic`.`candidate` (`id`),
  CONSTRAINT `fk_candidate_filter_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `externatic`.`city` (`id`),
  CONSTRAINT `fk_candidate_filter_contrat1`
    FOREIGN KEY (`contrat_id`)
    REFERENCES `externatic`.`contrat` (`id`),
  CONSTRAINT `fk_candidate_filter_job_title1`
    FOREIGN KEY (`job_title_id`)
    REFERENCES `externatic`.`job_title` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`compagny`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`compagny` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `siretNumber` VARCHAR(60) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `Valide` TINYINT(1) NULL DEFAULT '0',
  `Logo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`consultant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`consultant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalCode` VARCHAR(45) NOT NULL,
  `picture` VARCHAR(45) NULL DEFAULT NULL,
  `superAdmin` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`meeting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `startTime` DATETIME NOT NULL,
  `endTime` DATETIME NOT NULL,
  `participant1` INT NOT NULL,
  `participant1REF` VARCHAR(45) NOT NULL,
  `participant2` INT NOT NULL,
  `participant2REF` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `accepted` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `person1` INT NULL DEFAULT NULL,
  `person1REF` VARCHAR(45) NOT NULL,
  `person2` INT NOT NULL,
  `person2REF` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `hour` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`recruiter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`recruiter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postalCode` VARCHAR(45) NOT NULL,
  `valide` TINYINT NOT NULL DEFAULT '0',
  `picture` VARCHAR(45) NULL DEFAULT NULL,
  `compagny_id` INT NOT NULL,
  PRIMARY KEY (`id`, `compagny_id`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE,
  INDEX `fk_recruiter_compagny1_idx` (`compagny_id` ASC) VISIBLE,
  CONSTRAINT `fk_recruiter_compagny1`
    FOREIGN KEY (`compagny_id`)
    REFERENCES `externatic`.`compagny` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`remote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`remote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `externatic`.`offer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`offer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `salary` VARCHAR(45) NOT NULL,
  `valide` TINYINT NOT NULL DEFAULT '0',
  `teamPicture` VARCHAR(45) NOT NULL,
  `jobOfferPresentation` VARCHAR(1000) NOT NULL,
  `desiredProfile` VARCHAR(1000) NOT NULL,
  `recruitmentProcess` VARCHAR(1000) NOT NULL,
  `numberOfEmployees` VARCHAR(45) NULL DEFAULT NULL,
  `jobTitleDetails` VARCHAR(45) NULL DEFAULT NULL,
  `cityId` INT NOT NULL,
  `consultantId` INT NOT NULL,
  `recruiterId` INT NOT NULL,
  `contratId` INT NOT NULL,
  `jobTitleId` INT NOT NULL,
  `remoteId` INT NOT NULL,
  PRIMARY KEY (`id`, `cityId`, `consultantId`, `recruiterId`, `contratId`, `jobTitleId`, `remoteId`),
  INDEX `fk_offer_city1_idx` (`cityId` ASC) VISIBLE,
  INDEX `fk_offer_consultant1_idx` (`consultantId` ASC) VISIBLE,
  INDEX `fk_offer_recruiter1_idx` (`recruiterId` ASC) VISIBLE,
  INDEX `fk_offer_contrat1_idx` (`contratId` ASC) VISIBLE,
  INDEX `fk_offer_job_title1_idx` (`jobTitleId` ASC) VISIBLE,
  INDEX `fk_offer_remote1_idx` (`remoteId` ASC) VISIBLE,
  CONSTRAINT `fk_offer_city1`
    FOREIGN KEY (`cityId`)
    REFERENCES `externatic`.`city` (`id`),
  CONSTRAINT `fk_offer_consultant1`
    FOREIGN KEY (`consultantId`)
    REFERENCES `externatic`.`consultant` (`id`),
  CONSTRAINT `fk_offer_contrat1`
    FOREIGN KEY (`contratId`)
    REFERENCES `externatic`.`contrat` (`id`),
  CONSTRAINT `fk_offer_job_title1`
    FOREIGN KEY (`jobTitleId`)
    REFERENCES `externatic`.`job_title` (`id`),
  CONSTRAINT `fk_offer_recruiter1`
    FOREIGN KEY (`recruiterId`)
    REFERENCES `externatic`.`recruiter` (`id`),
  CONSTRAINT `fk_offer_remote1`
    FOREIGN KEY (`remoteId`)
    REFERENCES `externatic`.`remote` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`meeting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `startTime` DATETIME NOT NULL,
  `endTime` DATETIME NOT NULL,
  `participant1` INT NOT NULL,
  `participant1REF` VARCHAR(45) NOT NULL,
  `participant2` INT NOT NULL,
  `participant2REF` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `accepted` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `externatic`.`offer_candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `externatic`.`offer_candidate` (
  `offerId` INT NOT NULL,
  `candidateId` INT NOT NULL,
  PRIMARY KEY (`offerId`, `candidateId`),
  INDEX `fk_offer_has_candidate_candidate1_idx` (`candidateId` ASC) VISIBLE,
  INDEX `fk_offer_has_candidate_offer1_idx` (`offerId` ASC) VISIBLE,
  CONSTRAINT `fk_offer_has_candidate_candidate1`
    FOREIGN KEY (`candidateId`)
    REFERENCES `externatic`.`candidate` (`id`),
  CONSTRAINT `fk_offer_has_candidate_offer1`
    FOREIGN KEY (`offerId`)
    REFERENCES `externatic`.`offer` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO
  compagny (siretNumber, name, mail, phone, password, Valide, logo)
 VALUES (
    '123424452',
    'Ronaldo',
    'Ronaldo@siuuuuuu.com',
    '070707070707',
    'siuuuuu',
    '0',
    'cest un logo promis'
  ),
(
    '12342',
    'Ronldo',
    'Ronao@siuuuuuu.com',
    '07077070707',
    'siuuuu',
    '0',
    'ces un loo promis'
  ),
  (
    '124452',
    'Ronao',
    'Ronal@siuuuuuu.com',
    '0707070707',
    'siuuuu',
    '0',
    'cest ulogo promis'
  );
  
  INSERT INTO
  region(name)VALUES("Île-de-France"), ("Rhône-Alpes");
  
  INSERT INTO
  city(name, regionId)VALUES("Paris", 1),("Versailles", 1), ("Lyon", 2);
  
INSERT INTO consultant (name, firstname, mail, phone, birthday, password, street, city, postalCode, picture, superAdmin)
VALUES ('Dupont', 'Jean', 'jdupont@example.com', '01.23.45.67.89', '1990-01-01', 'monmotdepasse', '123 rue de la Paix', 'Paris', '75001', 'default.jpg', 0);

INSERT INTO recruiter (name, firstname, mail, phone, birthday, password, street, city, postalCode, valide, compagny_id)
VALUES ('Doe', 'John', 'johndoe@example.com', '0123456789', '1980-01-01', 'mypassword', '5th Avenue', 'New York', '10001', 1, 2);

INSERT INTO contrat (type) VALUES ('CDI'), ('CDD'), ('Stage'), ('Alternance');

INSERT INTO job_title (name) VALUES ('Assistant Manager'), ('Développeur Web'), ('Développeur App'), ('Développeur Jeux Videos'), ('Game Developper');

INSERT INTO remote (type) VALUES ('Présentiel'), ('Présentiel/Télétravail'), ('Télétravail');


-- Benjamin(19/04)
 ALTER TABLE compagny MODIFY Valide TINYINT(1) DEFAULT 0 NULL;

-- Benjamin (19/04)
 ALTER TABLE compagny MODIFY Logo VARCHAR(45) DEFAULT NULL NULL;

 ALTER TABLE  candidate
MODIFY COLUMN resume VARCHAR(150) NULL DEFAULT NULL,
MODIFY COLUMN picture VARCHAR(150) NULL DEFAULT NULL;

-- Benjamin (10/05)
ALTER TABLE candidate ADD COLUMN gender VARCHAR(45) NOT NULL;

-- Benjamin(18/05)
ALTER TABLE recruiter ADD COLUMN gender VARCHAR(45) NOT NULL;

-- Benjamin (24/05)
ALTER TABLE candidate CHANGE COLUMN postalAdress postalCode varchar(45) NOT NULL;

ALTER TABLE `externatic`.`city` 
ADD COLUMN `postalCode` VARCHAR(45) NULL AFTER `regionId`; 

INSERT INTO offer (salary, remoteId, teamPicture, jobOfferPresentation, desiredProfile, recruitmentProcess, numberOfEmployees, jobTitleDetails, cityId, consultantId, recruiterId, contratId, jobTitleId)
 VALUES ("20000", 1, "futur foto", "jobOfferPresentation", "desiredProfile", "Recruitment Process", "23", "Ingénieur réseaux / H/F – Industrie", 1,1,1,2,1),
 ("30000", 2, "teamPic.jpg", "Job Offer Presentation", "Desired Profile", "Recruitment Process", "50", "Software Engineer", 2, 1, 1, 3, 2),
 ("40000", 1, "teamPicture.png", "Job Offer Presentation", "Desired Profile", "Recruitment Process", "100", "Senior Data Analyst", 3, 1, 1, 1, 3),
 ("25000", 3, "team.jpg", "Job Offer Presentation", "Desired Profile", "Recruitment Process", "30", "Marketing Coordinator", 1, 1, 1, 2, 4),
 ("50000", 2, "teamPic.jpeg", "Job Offer Presentation", "Desired Profile", "Recruitment Process", "70", "Senior Project Manager", 3, 1, 1, 1, 5);
