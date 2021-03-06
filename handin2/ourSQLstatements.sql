SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
CREATE SCHEMA IF NOT EXISTS `bidd` DEFAULT CHARACTER SET latin1 ;
CREATE SCHEMA IF NOT EXISTS `BIDD` ;
USE `mydb` ;
USE `bidd` ;
USE `BIDD` ;

-- -----------------------------------------------------
-- Table `BIDD`.`genres`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`genres` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`persons`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`persons` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(256) NOT NULL ,
  `birthDate` DATE NULL DEFAULT NULL ,
  `deathDate` DATE NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`posTypes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`posTypes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL DEFAULT NULL ,
  `posTypes_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`roles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`roles` (
  `id` INT(11) NOT NULL ,
  `name` VARCHAR(256) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`prodTypes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`prodTypes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(256) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`productions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`productions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(256) NULL DEFAULT NULL ,
  `typeId` INT(11) NULL DEFAULT NULL ,
  `childOf` INT(11) NULL DEFAULT NULL ,
  `rating` DOUBLE NULL DEFAULT NULL COMMENT '	\\n' ,
  `votes` INT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_productions_prodTypes1_idx` (`typeId` ASC) ,
  CONSTRAINT `fk_productions_prodTypes1`
    FOREIGN KEY (`typeId` )
    REFERENCES `BIDD`.`prodTypes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`positions`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`positions` (
  `startDate` DATE NULL DEFAULT NULL ,
  `endDate` DATE NULL DEFAULT NULL ,
  `persId` INT(11) NOT NULL DEFAULT '0' ,
  `prodId` INT(11) NOT NULL DEFAULT '0' ,
  `posTypId` INT(11) NOT NULL DEFAULT '0' ,
  `Id` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`Id`) ,
  INDEX `fk_positions_productions1_idx` (`prodId` ASC) ,
  INDEX `fk_positions_persons1_idx` (`persId` ASC) ,
  INDEX `fk_positions_posTypes1_idx` (`posTypId` ASC) ,
  CONSTRAINT `fk_positions_productions1`
    FOREIGN KEY (`prodId` )
    REFERENCES `BIDD`.`productions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_positions_persons1`
    FOREIGN KEY (`persId` )
    REFERENCES `BIDD`.`persons` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_positions_posTypes1`
    FOREIGN KEY (`posTypId` )
    REFERENCES `BIDD`.`posTypes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`positionRoles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`positionRoles` (
  `posId` INT(11) NOT NULL DEFAULT '0' ,
  `rolId` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`posId`, `rolId`) ,
  INDEX `fk_positionRoles_roles1_idx` (`rolId` ASC) ,
  INDEX `fk_positionRoles_positions1_idx` (`posId` ASC) ,
  CONSTRAINT `fk_positionRoles_roles1`
    FOREIGN KEY (`rolId` )
    REFERENCES `BIDD`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_positionRoles_positions1`
    FOREIGN KEY (`posId` )
    REFERENCES `BIDD`.`positions` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`productionHasGenres`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`productionHasGenres` (
  `production_id` INT(11) NOT NULL DEFAULT '0' ,
  `genres_id` INT(11) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`production_id`, `genres_id`) ,
  INDEX `fk_productionHasGenres_productions1_idx` (`production_id` ASC) ,
  INDEX `fk_productionHasGenres_genres1_idx` (`genres_id` ASC) ,
  CONSTRAINT `fk_productionHasGenres_productions1`
    FOREIGN KEY (`production_id` )
    REFERENCES `BIDD`.`productions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productionHasGenres_genres1`
    FOREIGN KEY (`genres_id` )
    REFERENCES `BIDD`.`genres` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`releases`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`releases` (
  `prodId` INT(11) NOT NULL ,
  `country` VARCHAR(256) NULL DEFAULT NULL ,
  `releaseDate` DATE NULL DEFAULT NULL ,
  INDEX `fk_releases_productions1_idx` (`prodId` ASC) ,
  CONSTRAINT `fk_releases_productions1`
    FOREIGN KEY (`prodId` )
    REFERENCES `BIDD`.`productions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BIDD`.`language`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`language` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIDD`.`hasLanguage`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`hasLanguage` (
  `prodId` INT(11) NULL ,
  `languageId` INT(11) NULL ,
  INDEX `fk_hasLanguage_productions1_idx` (`prodId` ASC) ,
  INDEX `fk_hasLanguage_language1_idx` (`languageId` ASC) ,
  CONSTRAINT `fk_hasLanguage_productions1`
    FOREIGN KEY (`prodId` )
    REFERENCES `BIDD`.`productions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hasLanguage_language1`
    FOREIGN KEY (`languageId` )
    REFERENCES `BIDD`.`language` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BIDD`.`studentVotes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `BIDD`.`studentVotes` (
  `name` VARCHAR(45) NOT NULL ,
  `prodId` INT(7) NOT NULL ,
  `rating` DOUBLE NULL ,
  PRIMARY KEY (`name`, `prodId`) ,
  INDEX `fk_studentVotes_productions1_idx` (`prodId` ASC) ,
  CONSTRAINT `fk_studentVotes_productions1`
    FOREIGN KEY (`prodId` )
    REFERENCES `BIDD`.`productions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
