-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ecfs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecfs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecfs` DEFAULT CHARACTER SET utf8 ;
USE `ecfs` ;

-- -----------------------------------------------------
-- Table `ecfs`.`bureau`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`bureau` (
  `id_bureau` SMALLINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bureau_code` CHAR(2) NULL DEFAULT NULL,
  `bureau_name` VARCHAR(40) NULL DEFAULT NULL,
  `edocs_bureau_code` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id_bureau`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`cons_proceeding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`cons_proceeding` (
  `id_cp` INT(12) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_proceeding` INT(12) NULL DEFAULT NULL,
  `consolidated_proceeding_id` INT(12) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cp`),
  INDEX `id_proceeding` (`id_proceeding` ASC),
  INDEX `consolidated_proceeding_id` (`consolidated_proceeding_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 507602585
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`document` (
  `id_document` INT(12) NOT NULL,
  `id_file_type` SMALLINT(6) NULL DEFAULT NULL,
  `description` VARCHAR(80) NULL DEFAULT NULL,
  `page_count_display` VARCHAR(255) NULL DEFAULT NULL,
  `page_count` INT(11) NULL DEFAULT NULL,
  `byte_size` INT(11) NULL DEFAULT NULL,
  `transmission_start_date` VARCHAR(255) NULL DEFAULT NULL,
  `transmission_end_date` VARCHAR(255) NULL DEFAULT NULL,
  `flag_archived` SMALLINT(6) NULL DEFAULT NULL,
  `date_processed` VARCHAR(255) NULL DEFAULT NULL,
  `native_app_byte_size` INT(11) NULL DEFAULT NULL,
  `native_app_id_file_type` SMALLINT(6) NULL DEFAULT NULL,
  `comment` VARCHAR(20) NULL DEFAULT NULL,
  `flag_migrated_from_rips` CHAR(1) NULL DEFAULT NULL,
  `flag_conv_problem` CHAR(1) NULL DEFAULT NULL,
  `ocr_flag` VARCHAR(255) NULL DEFAULT NULL,
  `date_ocr` VARCHAR(255) NULL DEFAULT NULL,
  `date_modified` VARCHAR(255) NULL DEFAULT NULL,
  `date_pdf_modified` VARCHAR(255) NULL DEFAULT NULL,
  `attachment_id` VARCHAR(255) NULL DEFAULT NULL,
  `official_title` VARCHAR(255) NULL DEFAULT NULL,
  `file_description` VARCHAR(255) NULL DEFAULT NULL,
  `edocs_link` VARCHAR(255) NULL DEFAULT NULL,
  `file_name` VARCHAR(255) NULL DEFAULT NULL,
  `col_24` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `id_document` (`id_document` ASC),
  INDEX `id_file_type` (`id_file_type` ASC),
  INDEX `attachment_id` (`attachment_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`document_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`document_log` (
  `id_document` INT(12) NULL DEFAULT NULL,
  `id_submission` INT(12) NULL DEFAULT NULL,
  `id_file_type` SMALLINT(6) NULL DEFAULT NULL,
  `description` VARCHAR(80) NULL DEFAULT NULL,
  `page_count` INT(11) NULL DEFAULT NULL,
  `byte_size` INT(11) NULL DEFAULT NULL,
  `transmission_start_date` VARCHAR(255) NULL DEFAULT NULL,
  `transmission_end_date` VARCHAR(255) NULL DEFAULT NULL,
  `flag_archived` SMALLINT(6) NULL DEFAULT NULL,
  `date_processed` VARCHAR(255) NULL DEFAULT NULL,
  `native_app_byte_size` INT(11) NULL DEFAULT NULL,
  `native_app_id_file_type` SMALLINT(6) NULL DEFAULT NULL,
  `comment` VARCHAR(20) NULL DEFAULT NULL,
  `flag_migrated_from_rips` CHAR(1) NULL DEFAULT NULL,
  `flag_conv_problem` CHAR(1) NULL DEFAULT NULL,
  `ocr_flag` CHAR(1) NULL DEFAULT NULL,
  `user_name` VARCHAR(20) NULL DEFAULT NULL,
  `dtime` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `id_document` (`id_document` ASC),
  INDEX `id_submission` (`id_submission` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`edocs_submission_type_mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`edocs_submission_type_mapping` (
  `id` INT(12) NOT NULL DEFAULT '0',
  `edocs_submission_type` VARCHAR(80) NULL DEFAULT NULL,
  `ecfs_submission_type` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`federal_register`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`federal_register` (
  `id_register` INT(12) NOT NULL DEFAULT '0',
  `id_document` INT(12) NULL DEFAULT NULL,
  `federal_register` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_register`),
  INDEX `id_document` (`id_document` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`file_type_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`file_type_lk` (
  `id_file_type` SMALLINT(6) NOT NULL DEFAULT '0',
  `file_extension` CHAR(4) NULL DEFAULT NULL,
  `file_type_description` CHAR(18) NULL DEFAULT NULL,
  `mime_type` CHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`id_file_type`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`historical_proceeding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`historical_proceeding` (
  `id_proceeding` INT(12) NOT NULL DEFAULT '0',
  `comments` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`id_proceeding`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_bin;


-- -----------------------------------------------------
-- Table `ecfs`.`holiday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`holiday` (
  `holi_id` INT(11) NOT NULL DEFAULT '0',
  `holiday_date` VARCHAR(255) NULL DEFAULT NULL,
  `holiday_description` VARCHAR(80) NULL DEFAULT NULL,
  `holiday_type` CHAR(1) NULL DEFAULT NULL,
  `next_bus_date` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`holi_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`hot_docket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`hot_docket` (
  `id_hotdocket` INT(12) NOT NULL DEFAULT '0',
  `id_proceeding` INT(12) NULL DEFAULT NULL,
  `docket_name` CHAR(10) NULL DEFAULT NULL,
  `date_docket_created` VARCHAR(255) NULL DEFAULT NULL,
  `active_sw` CHAR(1) NULL DEFAULT NULL,
  `docket_description` VARCHAR(120) NULL DEFAULT NULL,
  `docket_description_detailed` VARCHAR(120) NULL DEFAULT NULL,
  PRIMARY KEY (`id_hotdocket`),
  INDEX `id_proceeding` (`id_proceeding` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`id_doc_keepers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`id_doc_keepers` (
  `id` BIGINT(11) NULL DEFAULT NULL,
  INDEX `id` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`ml_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`ml_address` (
  `id` INT(12) NOT NULL DEFAULT '0',
  `phone` CHAR(30) NULL DEFAULT NULL,
  `l_addressee` VARCHAR(80) NULL DEFAULT NULL,
  `l_title` VARCHAR(80) NULL DEFAULT NULL,
  `l_addresse1` VARCHAR(80) NULL DEFAULT NULL,
  `l_addresse2` VARCHAR(80) NULL DEFAULT NULL,
  `l_city` VARCHAR(80) NULL DEFAULT NULL,
  `l_zip` VARCHAR(30) NULL DEFAULT NULL,
  `l_orgname` VARCHAR(80) NULL DEFAULT NULL,
  `l_state` CHAR(2) NULL DEFAULT NULL,
  `mlname` VARCHAR(30) NULL DEFAULT NULL,
  `active_sw` CHAR(1) NULL DEFAULT NULL,
  `service` CHAR(1) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `country_name` CHAR(25) NULL DEFAULT NULL,
  `country_code` CHAR(15) NULL DEFAULT NULL,
  `postal_code` CHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`ocr_convert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`ocr_convert` (
  `id_document` DECIMAL(18,0) NULL DEFAULT NULL,
  `id_submission` DECIMAL(18,0) NULL DEFAULT NULL,
  `id_proceeding` DECIMAL(18,0) NULL DEFAULT NULL,
  `proceeding_name` CHAR(10) NULL DEFAULT NULL,
  `starttime` VARCHAR(255) NULL DEFAULT NULL,
  `endtime` VARCHAR(255) NULL DEFAULT NULL,
  `flag` CHAR(1) NULL DEFAULT NULL,
  `applicant_name` VARCHAR(80) NULL DEFAULT NULL,
  `date_submission` VARCHAR(255) NULL DEFAULT NULL,
  `page_count` INT(11) NULL DEFAULT NULL,
  `date_rcpt` VARCHAR(255) NULL DEFAULT NULL,
  `byte_size_old` DECIMAL(18,0) NULL DEFAULT NULL,
  `bytw_size_new` DECIMAL(18,0) NULL DEFAULT NULL,
  `batch_id` DECIMAL(18,0) NULL DEFAULT NULL,
  INDEX `id_document` (`id_document` ASC),
  INDEX `id_submission` (`id_submission` ASC),
  INDEX `id_proceeding` (`id_proceeding` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`permission_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`permission_lk` (
  `id_permission_level` SMALLINT(6) NOT NULL DEFAULT '0',
  `permission_level` CHAR(5) NULL DEFAULT NULL,
  `permission_level_description` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`id_permission_level`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_batch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_batch` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `sequence` INT(11) NULL DEFAULT NULL,
  `pages` INT(11) NULL DEFAULT NULL,
  `submission_ids` TEXT NULL DEFAULT NULL,
  `id_print_group` DECIMAL(12,0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_event` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `id_print_batch` DECIMAL(12,0) NULL DEFAULT NULL,
  `id_printer` INT(11) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `date_created` VARCHAR(255) NULL DEFAULT NULL,
  `date_finished` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_print_batch` (`id_print_batch` ASC),
  INDEX `id_printer` (`id_printer` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_group` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `date_created` VARCHAR(255) NULL DEFAULT NULL,
  `staff_flag` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_job` (
  `id_print_job` DECIMAL(5,0) NOT NULL DEFAULT '0',
  `id_printer` INT(11) NULL DEFAULT NULL,
  `id_user_queued` INT(11) NULL DEFAULT NULL,
  `id_user_spooled` INT(11) NULL DEFAULT NULL,
  `job_status` SMALLINT(6) NULL DEFAULT NULL,
  `job_type` SMALLINT(6) NULL DEFAULT NULL,
  `date_job_entered` VARCHAR(255) NULL DEFAULT NULL,
  `date_job_printed` VARCHAR(255) NULL DEFAULT NULL,
  `workstation_name` CHAR(20) NULL DEFAULT NULL,
  `request_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_print_job`),
  INDEX `id_printer` (`id_printer` ASC),
  INDEX `id_user_queued` (`id_user_queued` ASC),
  INDEX `id_user_spooled` (`id_user_spooled` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_job_del`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_job_del` (
  `id_print_job1` DECIMAL(5,0) NOT NULL DEFAULT '0',
  `id_printer` INT(11) NULL DEFAULT NULL,
  `id_user_queued` INT(11) NULL DEFAULT NULL,
  `id_user_spooled` INT(11) NULL DEFAULT NULL,
  `job_status` SMALLINT(6) NULL DEFAULT NULL,
  `job_type` SMALLINT(6) NULL DEFAULT NULL,
  `date_job_entered` VARCHAR(255) NULL DEFAULT NULL,
  `date_job_printed` VARCHAR(255) NULL DEFAULT NULL,
  `workstation_name` CHAR(20) NULL DEFAULT NULL,
  `request_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_print_job1`),
  INDEX `id_printer` (`id_printer` ASC),
  INDEX `id_user_queued` (`id_user_queued` ASC),
  INDEX `id_user_spooled` (`id_user_spooled` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_job_parms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_job_parms` (
  `id_print_job_parms` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `id_print_job` DECIMAL(12,0) NULL DEFAULT NULL,
  `id_document` DECIMAL(12,0) NULL DEFAULT NULL,
  `page_start` INT(11) NULL DEFAULT NULL,
  `page_end` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_print_job_parms`),
  INDEX `id_print_job` (`id_print_job` ASC),
  INDEX `id_document` (`id_document` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`print_job_parms_del`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`print_job_parms_del` (
  `id_print_job_parms` DECIMAL(5,0) NOT NULL DEFAULT '0',
  `id_print_job` DECIMAL(5,0) NULL DEFAULT NULL,
  `id_document1` DECIMAL(12,0) NULL DEFAULT NULL,
  `page_start` INT(11) NULL DEFAULT NULL,
  `page_end` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_print_job_parms`),
  INDEX `id_print_job` (`id_print_job` ASC),
  INDEX `id_document1` (`id_document1` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`printer_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`printer_lk` (
  `id_printer` INT(11) NULL DEFAULT NULL,
  `printer_name` CHAR(120) NULL DEFAULT NULL,
  `public_printer_name` CHAR(120) NULL DEFAULT NULL,
  `flag_public_access` CHAR(1) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`proceeding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`proceeding` (
  `id_proceeding` INT(12) NOT NULL DEFAULT '0',
  `proceeding_name` CHAR(10) NULL DEFAULT NULL,
  `proceeding_description` CHAR(10) NULL DEFAULT NULL,
  `consolidated_proceeding_id` DECIMAL(18,0) NULL DEFAULT NULL,
  `date_proceeding_created` VARCHAR(255) NULL DEFAULT NULL,
  `id_bureau` SMALLINT(11) NULL DEFAULT NULL,
  `flag_rulemaking_or_docket` CHAR(1) NULL DEFAULT NULL,
  `flag_historical_data_exists` CHAR(1) NULL DEFAULT NULL,
  `flag_archived` CHAR(1) NULL DEFAULT NULL,
  `file_number` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `id_state` SMALLINT(11) NULL DEFAULT NULL,
  `callsign` CHAR(9) NULL DEFAULT NULL,
  `channel` CHAR(8) NULL DEFAULT NULL,
  `applicant_name` VARCHAR(255) NULL DEFAULT NULL,
  `subject` VARCHAR(255) NULL DEFAULT NULL,
  `appeal` VARCHAR(255) NULL DEFAULT NULL,
  `filed_by` VARCHAR(255) NULL DEFAULT NULL,
  `rule_section` VARCHAR(30) NULL DEFAULT NULL,
  `exparte_late_filed` CHAR(1) NULL DEFAULT NULL,
  `flag_open_close` CHAR(1) NULL DEFAULT NULL,
  `date_designated` VARCHAR(255) NULL DEFAULT NULL,
  `date_initial_decision` VARCHAR(255) NULL DEFAULT NULL,
  `date_oral_argument` VARCHAR(255) NULL DEFAULT NULL,
  `date_nprm` VARCHAR(255) NULL DEFAULT NULL,
  `date_reporting_and_order` VARCHAR(255) NULL DEFAULT NULL,
  `date_effective` VARCHAR(255) NULL DEFAULT NULL,
  `date_commission_decision` VARCHAR(255) NULL DEFAULT NULL,
  `date_public_notice` VARCHAR(255) NULL DEFAULT NULL,
  `date_rule_board_decision` VARCHAR(255) NULL DEFAULT NULL,
  `date_closed` VARCHAR(255) NULL DEFAULT NULL,
  `date_archived` VARCHAR(255) NULL DEFAULT NULL,
  `location` VARCHAR(255) NULL DEFAULT NULL,
  `flag_internet_file` CHAR(1) NULL DEFAULT NULL,
  `recent_filing_count` INT(11) NULL DEFAULT NULL,
  `total_filing_count` INT(11) NULL DEFAULT NULL,
  `flag_small_business_impact` CHAR(1) NULL DEFAULT NULL,
  `bureau_id_num` VARCHAR(25) NULL DEFAULT NULL,
  `face_card_id` DECIMAL(12,0) NULL DEFAULT NULL,
  PRIMARY KEY (`id_proceeding`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`proceeding_to_bureau_mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`proceeding_to_bureau_mapping` (
  `proceeding_bureau_id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `proceeding_id` DECIMAL(12,0) NULL DEFAULT NULL,
  `bureau_id` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`proceeding_bureau_id`),
  INDEX `proceeding_id` (`proceeding_id` ASC),
  INDEX `bureau_id` (`bureau_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`state_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`state_lk` (
  `id_state` SMALLINT(6) NOT NULL DEFAULT '0',
  `state_cd` CHAR(2) NULL DEFAULT NULL,
  `state` CHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`id_state`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`state_ml_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`state_ml_lk` (
  `id_state` SMALLINT(6) NOT NULL DEFAULT '0',
  `state_cd` CHAR(2) NULL DEFAULT NULL,
  `state` CHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`id_state`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`status_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`status_lk` (
  `id_submission_status` TINYINT(4) NOT NULL DEFAULT '0',
  `status` CHAR(18) NULL DEFAULT NULL,
  PRIMARY KEY (`id_submission_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`submission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`submission` (
  `id_trans` DECIMAL(12,0) NULL DEFAULT NULL,
  `id_proceeding` DECIMAL(12,0) NULL DEFAULT NULL,
  `applicant_name` VARCHAR(80) NULL DEFAULT NULL,
  `author_name` VARCHAR(30) NULL DEFAULT NULL,
  `lawfirm_name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_name` VARCHAR(80) NULL DEFAULT NULL,
  `contact_email_id` VARCHAR(80) NULL DEFAULT NULL,
  `address_line_1` VARCHAR(80) NULL DEFAULT NULL,
  `address_line_2` VARCHAR(80) NULL DEFAULT NULL,
  `id_submission_type` SMALLINT(11) NULL DEFAULT NULL,
  `id_submission_status` SMALLINT(11) NULL DEFAULT NULL,
  `viewing_status` CHAR(2) NULL DEFAULT NULL,
  `file_numer` VARCHAR(20) NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `id_state` SMALLINT(11) NULL DEFAULT NULL,
  `zip_code` CHAR(5) NULL DEFAULT NULL,
  `postal_code` CHAR(4) NULL DEFAULT NULL,
  `subject` VARCHAR(255) NULL DEFAULT NULL,
  `delagated_authority_number` VARCHAR(30) NULL DEFAULT NULL,
  `exparte_late_filed` CHAR(1) NULL DEFAULT NULL,
  `date_submission` VARCHAR(255) NULL DEFAULT NULL,
  `date_filed` VARCHAR(255) NULL DEFAULT NULL,
  `date_rcpt` VARCHAR(255) NULL DEFAULT NULL,
  `date_released` VARCHAR(255) NULL DEFAULT NULL,
  `date_accepted` VARCHAR(255) NULL DEFAULT NULL,
  `date_disseminated` VARCHAR(255) NULL DEFAULT NULL,
  `confirmation_number` VARCHAR(40) NULL DEFAULT NULL,
  `date_transmission_completed` VARCHAR(255) NULL DEFAULT NULL,
  `server_name` VARCHAR(80) NULL DEFAULT NULL,
  `path_info` VARCHAR(80) NULL DEFAULT NULL,
  `remote_addr` VARCHAR(20) NULL DEFAULT NULL,
  `remote_host` VARCHAR(20) NULL DEFAULT NULL,
  `remote_ident` VARCHAR(80) NULL DEFAULT NULL,
  `remote_user` VARCHAR(80) NULL DEFAULT NULL,
  `browser` VARCHAR(80) NULL DEFAULT NULL,
  `filed_from` CHAR(1) NULL DEFAULT NULL,
  `id_user` SMALLINT(11) NULL DEFAULT NULL,
  `ruleno` CHAR(8) NULL DEFAULT NULL,
  `id_ruleno` DECIMAL(20,0) NULL DEFAULT NULL,
  `flag_migrated_from_rips` CHAR(11) NULL DEFAULT NULL,
  `date_pn_ex_parte` VARCHAR(255) NULL DEFAULT NULL,
  `intl_address` VARCHAR(250) NULL DEFAULT '',
  `total_page_count` INT(11) NULL DEFAULT NULL,
  `brief_comment_flag` SMALLINT(80) NULL DEFAULT NULL,
  `id_viewing_status` TINYINT(4) NULL DEFAULT NULL,
  `date_modified` VARCHAR(255) NULL DEFAULT NULL,
  `bureau_id_num` VARCHAR(25) NULL DEFAULT NULL,
  `id_edocs` DECIMAL(12,0) NULL DEFAULT NULL,
  `report_number` VARCHAR(20) NULL DEFAULT NULL,
  `fcc_record` VARCHAR(50) NULL DEFAULT NULL,
  `date_comment_period` VARCHAR(255) NULL DEFAULT NULL,
  `date_reply_comment` VARCHAR(255) NULL DEFAULT NULL,
  `small_business_impact` CHAR(1) NULL DEFAULT NULL,
  `reg_flex_analysis` CHAR(1) NULL DEFAULT NULL,
  INDEX `id_trans` (`id_trans` ASC),
  INDEX `id_proceeding` (`id_proceeding` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`submission_clone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`submission_clone` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `id_submission` DECIMAL(12,0) NULL DEFAULT NULL,
  `id_proceeding` DECIMAL(12,0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`submission_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`submission_log` (
  `id_trans` INT(12) NULL DEFAULT NULL,
  `id_submission` INT(12) NULL DEFAULT NULL,
  `id_proceeding` INT(12) NULL DEFAULT NULL,
  `applicant_name` VARCHAR(80) NULL DEFAULT NULL,
  `author_name` VARCHAR(30) NULL DEFAULT NULL,
  `lawfirm_name` VARCHAR(255) NULL DEFAULT NULL,
  `contact_name` VARCHAR(80) NULL DEFAULT NULL,
  `contact_email_id` VARCHAR(80) NULL DEFAULT NULL,
  `address_line_1` VARCHAR(80) NULL DEFAULT NULL,
  `address_line_2` VARCHAR(80) NULL DEFAULT NULL,
  `id_submission_type` SMALLINT(11) NULL DEFAULT NULL,
  `id_submission_status` SMALLINT(11) NULL DEFAULT NULL,
  `viewing_status` CHAR(2) NULL DEFAULT NULL,
  `file_numer` VARCHAR(20) NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `id_state` SMALLINT(11) NULL DEFAULT NULL,
  `zip_code` CHAR(5) NULL DEFAULT NULL,
  `postal_code` CHAR(4) NULL DEFAULT NULL,
  `subject` VARCHAR(255) NULL DEFAULT NULL,
  `delagated_authority_number` VARCHAR(30) NULL DEFAULT NULL,
  `exparte_late_filed` CHAR(1) NULL DEFAULT NULL,
  `date_submission` VARCHAR(255) NULL DEFAULT NULL,
  `date_filed` VARCHAR(255) NULL DEFAULT NULL,
  `date_rcpt` VARCHAR(255) NULL DEFAULT NULL,
  `date_released` VARCHAR(255) NULL DEFAULT NULL,
  `date_accepted` VARCHAR(255) NULL DEFAULT NULL,
  `date_disseminated` VARCHAR(255) NULL DEFAULT NULL,
  `confirmation_number` VARCHAR(40) NULL DEFAULT NULL,
  `date_transmission_completed` VARCHAR(255) NULL DEFAULT NULL,
  `server_name` VARCHAR(80) NULL DEFAULT NULL,
  `path_info` VARCHAR(80) NULL DEFAULT NULL,
  `remote_addr` VARCHAR(20) NULL DEFAULT NULL,
  `remote_host` VARCHAR(20) NULL DEFAULT NULL,
  `remote_ident` VARCHAR(80) NULL DEFAULT NULL,
  `remote_user` VARCHAR(80) NULL DEFAULT NULL,
  `browser` VARCHAR(80) NULL DEFAULT NULL,
  `filed_from` CHAR(1) NULL DEFAULT NULL,
  `id_user` SMALLINT(11) NULL DEFAULT NULL,
  `ruleno` CHAR(8) NULL DEFAULT NULL,
  `id_ruleno` DECIMAL(20,0) NULL DEFAULT NULL,
  `flag_migrated_from_rips` CHAR(11) NULL DEFAULT NULL,
  `date_pn_ex_parte` VARCHAR(255) NULL DEFAULT NULL,
  `loginname` VARCHAR(30) NULL DEFAULT '',
  `dtime` VARCHAR(255) NULL DEFAULT NULL,
  `transtype` VARCHAR(80) NULL DEFAULT NULL,
  INDEX `id_submission` (`id_submission` ASC),
  INDEX `id_proceeding` (`id_proceeding` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`submission_note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`submission_note` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `id_submission` DECIMAL(12,0) NULL DEFAULT NULL,
  `id_user` SMALLINT(6) NULL DEFAULT NULL,
  `created` VARCHAR(255) NULL DEFAULT NULL,
  `text` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_submission` (`id_submission` ASC),
  INDEX `id_user` (`id_user` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`submission_type_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`submission_type_lk` (
  `id_submission_type` SMALLINT(6) NOT NULL DEFAULT '0',
  `submission_type` CHAR(2) NULL DEFAULT NULL,
  `submission_type_short` VARCHAR(12) NULL DEFAULT NULL,
  `submission_type_description` VARCHAR(80) NULL DEFAULT NULL,
  `flag_public` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_submission_type`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`system_params`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`system_params` (
  `id` DECIMAL(12,0) NOT NULL DEFAULT '0',
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `value` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`temp_size2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`temp_size2` (
  `col_0` BIGINT(11) NULL DEFAULT NULL,
  `col_1` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`track_changes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`track_changes` (
  `id` INT(12) NOT NULL DEFAULT '0',
  `record_id` INT(12) NULL DEFAULT NULL,
  `record_type` VARCHAR(10) NULL DEFAULT NULL,
  `user_id` SMALLINT(6) NULL DEFAULT NULL,
  `change_time` VARCHAR(255) NULL DEFAULT NULL,
  `changes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `record_id` (`record_id` ASC),
  INDEX `user_id` (`user_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`users` (
  `id_user` SMALLINT(11) NOT NULL DEFAULT '0',
  `permission_level_id` SMALLINT(6) NULL DEFAULT NULL,
  `user_name` VARCHAR(30) NULL DEFAULT NULL,
  `date_entered` VARCHAR(255) NULL DEFAULT NULL,
  `password` CHAR(12) NULL DEFAULT NULL,
  `initials` CHAR(3) NULL DEFAULT NULL,
  `flag_active` CHAR(1) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `new_user_name` VARCHAR(128) NULL DEFAULT NULL,
  `email_address` VARCHAR(255) NULL DEFAULT NULL,
  `view_confidential_filing` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`users_to_bureau_mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`users_to_bureau_mapping` (
  `user_bureau_id` INT(12) NOT NULL DEFAULT '0',
  `users_id` SMALLINT(6) NULL DEFAULT NULL,
  `bureau_id` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`user_bureau_id`),
  INDEX `users_id` (`users_id` ASC),
  INDEX `bureau_id` (`bureau_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecfs`.`viewing_status_lk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecfs`.`viewing_status_lk` (
  `viewing_status` CHAR(2) NOT NULL DEFAULT '',
  `viewing_status_description` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`viewing_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
