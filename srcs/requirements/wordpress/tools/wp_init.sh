#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html
#chmod -R 755 /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sleep 10

if [ ! -e /var/www/html/wp-config.php ]; then
        wp core download --allow-root

        wp core config \
            --dbname="${SQL_DATABASE}" \
            --dbuser="${SQL_USER}" \
            --dbpass="${SQL_PASSWORD}" \
            --dbhost='mariadb:3306' \
            --allow-root

        wp core install \
            --url="${DOMAIN_NAME}" \
            --title="${SITE_TITLE}" \
            --admin_user="${WP_ADMIN}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --allow-root 

        wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
            --role=author \
            --user_pass="${WP_USER_PASSWORD}" \
            --allow-root
fi

mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

exec /usr/sbin/php-fpm7.4 -F
