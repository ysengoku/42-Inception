FROM debian:bullseye

# Set working directory
WORKDIR /var/www

# Install wordpress & php
RUN apt update -y && apt upgrade -y && \
	apt-get install -y wget \
	php7.4 \
	php-fpm \
	php-mysql \
	mariadb-client \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.6.2.tar.gz && \
	rm wordpress-6.6.2.tar.gz && \
	chmod 755 /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

# Update PHP configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

# Set up WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Update wordpress configuration
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh

ENTRYPOINT ["/usr/local/bin/wp_init.sh"]
