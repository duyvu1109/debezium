CREATE DATABASE IF NOT EXISTS source CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE DATABASE IF NOT EXISTS destination CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;


CREATE TABLE source.members (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
);

CREATE TABLE destination.debezium_source_members (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
);


INSERT INTO source.members(`id`, `created_at`, `updated_at`, `user_id`) VALUES (1, '2023-11-14 02:41:42', '2024-01-16 10:32:34', 1);
INSERT INTO source.members(`id`, `created_at`, `updated_at`, `user_id`) VALUES (2, '2023-11-14 06:49:03', '2024-01-16 10:33:55', 2);
INSERT INTO source.members(`id`, `created_at`, `updated_at`, `user_id`) VALUES (3, '2023-11-14 06:53:46', '2024-01-17 03:06:17', 3);

/*
use for test changing column type
ALTER TABLE source.members MODIFY user_id VARCHAR(255);
INSERT INTO source.members(`id`, `created_at`, `updated_at`, `user_id`) VALUES (4, NOW(), NOW(), 'd');

ALTER TABLE destination.debezium_source_members MODIFY user_id VARCHAR(255);

*/