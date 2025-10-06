-- Настройка репликации для slave
CHANGE MASTER TO
MASTER_HOST='mysql-shard1-master',
MASTER_USER='repl',
MASTER_PASSWORD='replpass',
MASTER_AUTO_POSITION=1;

START SLAVE;

-- Создание пользователя для чтения
CREATE USER 'read_user'@'%' IDENTIFIED BY 'readpass';
GRANT SELECT ON . TO 'read_user'@'%';

FLUSH PRIVILEGES;
