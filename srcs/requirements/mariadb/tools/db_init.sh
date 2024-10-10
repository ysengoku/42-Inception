#!/bin/bash

# Start the database on background
#mysqld --datadir='/var/lib/mysql'

# Check if the required environment variables are set
if  [ -z "$SQL_ROOT_PASSWORD" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_DATABASE" ]; then
	echo "Missing environment variables";
	exit 1;
fi

# Wait for the database to start
DB_HOST="${DB_HOST:-localhost}"
until mysqladmin ping -h"${DB_HOST}" --silent; do
	echo "Waiting for MariaDB to start...";
	sleep 1;
done

# Set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Create the database and user
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON '${SQL_DATABASE}' .* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Activate the changes
mysql -e "FLUSH PRIVILEGES";

# Shutdown the database and restart it on foreground
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown;
