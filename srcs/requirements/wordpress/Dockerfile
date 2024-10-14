FROM debian:bullseye

# Install wordpress & php
RUN apt update -y && apt upgrade -y && \
	apt-get install -y wget \
	php7.4 \
	php-fpm \
	php-mysql \
	mariadb-client \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

# Update PHP configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set wordpress configuration
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh

ENTRYPOINT ["/usr/local/bin/wp_init.sh"]
