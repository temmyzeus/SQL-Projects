CREATE DATABASE IF NOT EXISTS `koel_db`;

CREATE TABLE `users` (
	`id` INT NOT NULL AUT0_INCREMENT,
	`name` VARCHAR NOT NULL,
	`email` VARCHAR NOT NULL,
	`password` VARCHAR NOT NULL,
	`is_admin` BOOL NOT NULL DEFAULT 0,
	`preferences` TEXT,
	`remember_token` VARCHAR NOT NULL,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
	UNIQUE (`id`, `email`)
);

CREATE TABLE `interactions` (
	`id` BIGINT NOT NULL,
	`user_id` INT,
	`song_id` VARCHAR,
	`liked` BOOL,
	`play_count` INT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
);

CREATE TABLE `artists` (
	`id` INT,
	`name` VARCHAR,
	`image` VARCHAR,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
)

CREATE TABLE `playlists` (
	`id` INT,
	`user_id` INT,
	`name` VARCHAR,
	`rules` TEXT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
);

CREATE TABLE `songs` (
	`id` VARCHAR,
	`album_id` INT,
	`artist_id` INT,
	`title` VARCHAR,
	`length` FLOAT,
	`track` INT,
	`disc` INT,
	`lyrics` TEXT,
	`path` PATH,
	`mtime` INT,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
);

CREATE TABLE `playlist_song` (
	`id` INT,
	`playlisy_id` INT,
	`song_id` VARCHAR
)

CREATE TABLE `albums` (
	`id` INT,
	`artist_id` INT,
	`name` VARCHAR,
	`cover` VARCHAR,
	`created_at` DATETIME,
	`updated_at` DATETIME,
	PRIMARY KEY `id`
)

CREATE TABLE `password_resets` (
	`email` VARCHAR,
	`token` VARCHAR,
	`created_at` DATETIME
)

CREATE TABLE `settings` (
	`key` VARCHAR,
	`value` TEXT,
	PRIMARY KEY `key`
)