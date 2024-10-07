#!/bin/bash

#wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#chmod +x wp-cli.phar
#mv wp-cli.phar /usr/local/bin/wp

if [ ! -e /var/www/wordpress/wp-config.php ]; then
	wp config create --allow-root \
				--dbname=$SQL_DATABASE \
				--dbuser=$SQL_USER \
				--dbpass=$SQL_PASSWORD \
				--dbhost=mariadb:3306 \
				--path='/var/www/wordpress'

wp core install --url=$DOMAIN_NAME \
				--title=$SITE_TITLE \
				--admin_user=$WP_ADMIN \
				--admin_password=$WP_ADMIN_PASSWORD \
				--admin_email=$WP_ADMIN_EMAIL \
				--skip-email

wp user create $WP_USER $WP_ADMIN_EMAIL \
				--role=author \
				--user_pass=$WP_USER_PASSWORD \
				--porcelain

exec /usr/sbin/php-fpm7.4 -F
