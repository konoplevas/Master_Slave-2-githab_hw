-- Настройка горизонтального шардинга для пользователей
-- Шард 1: user_id 1-1000000
-- Шард 2: user_id 1000001-2000000
-- и т.д.

-- Создание таблицы для метаданных шардинга
CREATE DATABASE IF NOT EXISTS shard_metadata;
USE shard_metadata;

CREATE TABLE shard_rules (
rule_id INT AUTO_INCREMENT PRIMARY KEY,
table_name VARCHAR(100) NOT NULL,
shard_key VARCHAR(100) NOT NULL,
shard_type ENUM('RANGE', 'HASH', 'GEO') NOT NULL,
shard_id INT NOT NULL,
min_value VARCHAR(255),
max_value VARCHAR(255),
connection_string VARCHAR(500) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Добавление правил для пользователей
INSERT INTO shard_rules (table_name, shard_key, shard_type, shard_id, min_value, max_value, connection_string) VALUES
('users', 'user_id', 'RANGE', 1, '1', '1000000', 'mysql://app_user:apppass@mysql-shard1-master:3306/shard1_users'),
('users', 'user_id', 'RANGE', 2, '1000001', '2000000', 'mysql://app_user:apppass@mysql-shard2-master:3306/shard2_books');

-- Добавление правил для книг (hash-based по genre_id)
INSERT INTO shard_rules (table_name, shard_key, shard_type, shard_id, min_value, max_value, connection_string) VALUES
('books', 'genre_id', 'HASH', 1, NULL, NULL, 'mysql://app_user:apppass@mysql-shard1-master:3306/shard1_users'),
('books', 'genre_id', 'HASH', 2, NULL, NULL, 'mysql://app_user:apppass@mysql-shard2-master:3306/shard2_books');

-- Добавление правил для магазинов (geographic по region_id)
INSERT INTO shard_rules (table_name, shard_key, shard_type, shard_id, min_value, max_value, connection_string) VALUES
('shops', 'region_id', 'GEO', 1, '1', '50', 'mysql://app_user:apppass@mysql-shard3-master:3306/shard3_shops'),
('shops', 'region_id', 'GEO', 2, '51', '100', 'mysql://app_user:apppass@mysql-shard1-master:3306/shard1_users');
