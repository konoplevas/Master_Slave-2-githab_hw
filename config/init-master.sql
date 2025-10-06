-- Создание пользователя для репликации
CREATE USER 'repl'@'%' IDENTIFIED BY 'replpass';
GRANT REPLICATION SLAVE ON . TO 'repl'@'%';

-- Создание пользователя для приложения
CREATE USER 'app_user'@'%' IDENTIFIED BY 'apppass';
GRANT ALL PRIVILEGES ON . TO 'app_user'@'%';

FLUSH PRIVILEGES;
