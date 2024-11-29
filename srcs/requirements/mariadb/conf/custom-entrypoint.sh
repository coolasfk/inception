#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "CUSTOM ENTRYPOINT SCRIPT IS RUNNING..."

# Start MariaDB in safe mode
mysqld_safe --datadir="/var/lib/mysql" &
sleep 5

# Ensure MariaDB is running
echo "CHECKING MARIADB STATUS..."
if ! mysqladmin ping -h "localhost" --silent; then
    echo "MARIADB IS NOT RUNNING. EXITING."
    exit 1
fi

# Remove any conflicting users
echo "REMOVING CONFLICTING USERS..."
mysql -u root <<EOF
DROP USER IF EXISTS 'wp_user'@'%';
DROP USER IF EXISTS 'wordpress'@'%';
DROP USER IF EXISTS 'wordpress'@'wordpress.srcs_inception-network';
EOF
echo "CONFLICTING USERS REMOVED."

# Check if the database already exists
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    echo "INITIALIZING DATABASE..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
EOF
    echo "DATABASE 'WORDPRESS' CREATED."
else
    echo "DATABASE ALREADY EXISTS. SKIPPING INITIALIZATION."
fi

# Ensure 'wordpress' users exist
echo "ENSURING 'WORDPRESS' USERS EXIST..."
mysql -u root <<EOF
CREATE USER IF NOT EXISTS 'wordpress'@'wordpress.srcs_inception-network' IDENTIFIED BY 'evapass';
CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'evapass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'wordpress.srcs_inception-network';
FLUSH PRIVILEGES;
EOF
echo "'WORDPRESS' USERS CREATED AND GRANTED PRIVILEGES."

# Shutdown MariaDB to let the default CMD start it properly
echo "SHUTTING DOWN MARIADB TO START IT WITH CMD..."
mysqladmin -u root shutdown

# Execute the CMD instruction
echo "STARTING MARIADB..."
exec "$@"
