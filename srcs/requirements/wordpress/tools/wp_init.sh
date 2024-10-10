#!/bin/bash

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sleep 10

if [ ! -e /var/www/wordpress/wp-config.php ]; then
        wp core download --allow-root \
            --path='/var/www/html'

        wp config create --allow-root \
            --dbname="${SQL_DATABASE}" \
            --dbuser="${SQL_USER}" \
            --dbpass="${SQL_PASSWORD}" \
            --dbhost='mariadb:3306' \
            --path='/var/www/html'

        wp core install --allow-root \
            --url="${DOMAIN_NAME}" \
            --title="${SITE_TITLE}" \
            --admin_user="${WP_ADMIN}" \
            --admin_password="${WP_ADMIN_PASSWORD}" \
            --admin_email="${WP_ADMIN_EMAIL}" \
            --skip-email \
            --path
fi

mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

exec /usr/sbin/php-fpm7.4 -F
