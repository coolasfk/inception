#!/bin/bash

# Start MySQL service
mysqld_safe &

# Wait for MariaDB to start
sleep 5

# Create the database, user, and assign privileges
mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -e "CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Shutdown MySQL server (so it can be restarted properly by CMD)
mysqladmin -u root shutdown

# Exec the actual MySQL server
exec "$@"
