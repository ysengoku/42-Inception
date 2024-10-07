FROM debian:bullseye

# Install wordpress & php
RUN apt update -y && apt upgrade -y
RUN	apt-get install -y wget php8.3 php-fpm php-mysql maridb-client && \
	rm -rf /var/lib/apt/lists/*
RUN apt update -y
RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www
RUN chown -R root:root /var/www/wordpress

# Update configuration
COPY ./conf/wp-config.php /var/www/wordpress/wp-config.php