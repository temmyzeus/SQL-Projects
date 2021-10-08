DROP DATABASE IF EXISTS `koel_db`;
CREATE DATABASE IF NOT EXISTS `koel_db`;
USE `koel_db`;

CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`email` VARCHAR(30) NOT NULL,
	`password` VARCHAR(30) NOT NULL,
	`is_admin` BOOL NOT NULL DEFAULT 0,
	`preferences` TEXT,
	`remember_token` VARCHAR(30) NOT NULL,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP(),
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE (`id`, `email`)
);

ALTER TABLE `users` AUTO_INCREMENT = 30001;

CREATE TABLE `interactions` (
	`id` BIGINT NOT NULL,
	`user_id` INT,
	`song_id` VARCHAR(30),
	`liked` BOOL,
	`play_count` INT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`),
	UNIQUE (`id`)
);

CREATE TABLE `artists` (
	`id` INT,
	`name` VARCHAR(30),
	`image` VARCHAR(50),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

CREATE TABLE `playlists` (
	`id` INT,
	`user_id` INT,
	`name` VARCHAR(30),
	`rules` TEXT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

CREATE TABLE `songs` (
	`id` VARCHAR(30),
	`album_id` INT,
	`artist_id` INT,
	`title` VARCHAR(50),
	`length` FLOAT,
	`track` INT,
	`disc` INT,
	`lyrics` TEXT,
	`path` TEXT,
	`mtime` INT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

CREATE TABLE `playlist_song` (
	`id` INT,
	`playlisy_id` INT,
	`song_id` VARCHAR(50)
);

CREATE TABLE `albums` (
	`id` INT,
	`artist_id` INT,
	`name` VARCHAR(50),
	`cover` VARCHAR(50),
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY (`id`)
);

CREATE TABLE `password_resets` (
	`email` VARCHAR(30),
	`token` VARCHAR(50),
	`created_at` DATETIME
);

CREATE TABLE `settings` (
	`key` VARCHAR(30),
	`value` TEXT,
	PRIMARY KEY (`key`)
);