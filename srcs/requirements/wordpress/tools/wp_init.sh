#!/bin/bash

mkdir -p /var/www/html
cd /var/www/html

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

        # Redis configuration
        wp config set WP_REDIS_HOST "${REDIS_HOST}" --allow-root
        wp config set WP_REDIS_PORT 6379 --allow-root
        wp config set WP_CACHE_KEY_SALT "${DOMAIN_NAME}" --allow-root
        wp config set WP_REDIS_CLIENT "${REDIS_CLIENT}" --allow-root
fi

# Install and activate plugins
wp plugin install redis-cache --activate --allow-root
wp plugin update redis-cache --allow-root
wp redis enable --allow-root

# Set ownership and permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
# Set wp-content to writable (for redis cache)
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 775 /var/www/html/wp-content

mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

exec /usr/sbin/php-fpm7.4 -F
