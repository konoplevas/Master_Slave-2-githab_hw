-- Конфигурация для шарда пользователей
CREATE DATABASE IF NOT EXISTS shard1_users;
USE shard1_users;

CREATE TABLE users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
password_hash VARCHAR(255) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE user_profiles (
profile_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
first_name VARCHAR(50),
last_name VARCHAR(50),
phone VARCHAR(20),
FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Конфигурация для шарда книг
CREATE DATABASE IF NOT EXISTS shard2_books;
USE shard2_books;

CREATE TABLE books (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
isbn VARCHAR(20) UNIQUE,
genre_id INT NOT NULL,
price DECIMAL(10,2),
published_date DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE authors (
author_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
biography TEXT
) ENGINE=InnoDB;

CREATE TABLE genres (
genre_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL UNIQUE,
description TEXT
) ENGINE=InnoDB;

-- Конфигурация для шарда магазинов
CREATE DATABASE IF NOT EXISTS shard3_shops;
USE shard3_shops;

CREATE TABLE shops (
shop_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
region_id INT NOT NULL,
address TEXT,
phone VARCHAR(20),
email VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE inventory (
inventory_id INT AUTO_INCREMENT PRIMARY KEY,
shop_id INT NOT NULL,
book_id INT NOT NULL,
quantity INT DEFAULT 0,
last_restocked DATE,
FOREIGN KEY (shop_id) REFERENCES shops(shop_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
shop_id INT NOT NULL,
total_amount DECIMAL(10,2),
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled')
) ENGINE=InnoDB;
