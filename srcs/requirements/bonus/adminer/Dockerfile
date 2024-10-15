FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	php7.4 \
	php-fpm \
	php-mysql \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php \
	&& chown -R www-data:www-data /run/php

RUN mkdir -p /var/www/html \
	&& wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php \
	&& chown -R www-data:www-data /var/www/html/index.php \
	&& chmod 755 /var/www/html/index.php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["php-fpm7.4", "--nodaemonize"]
