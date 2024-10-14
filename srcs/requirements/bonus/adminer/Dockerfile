FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	php7.4 \
	php-mysql \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
	&& wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php \
	&& chown -R www-data:www-data /var/www/html/index.php \
	&& chmod 755 /var/www/html/index.php

WORKDIR /var/www/html
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]