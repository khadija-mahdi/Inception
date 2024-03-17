#!/bin/bash

# Start MariaDB service
service mariadb start

# Wait for MariaDB to start
sleep 5

# Create database if not exist
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DATABASE}\`;"

# Create user if not exists and grant privileges
mariadb -e "CREATE USER IF NOT EXISTS \`${MARIA_USER}\`@'%' IDENTIFIED BY '${MARIA_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIA_DATABASE}\`.* TO \`${MARIA_USER}\`@'%';"

# Create root user if not exists and set password
mariadb -e "CREATE USER IF NOT EXISTS \`root\`@'%' IDENTIFIED BY '${MARIA_ROOT_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON *.* TO \`root\`@'%' WITH GRANT OPTION;"
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown MariaDB
mysqladmin -u root -p"${MARIA_ROOT_PASSWORD}" shutdown

mysqld_safe