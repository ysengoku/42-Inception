FROM debian:bullseye

# Install wordpress & php
RUN apt update -y && apt upgrade -y
RUN	apt-get install -y wget php8.3 php-fpm php-mysql maridb-client && \
	rm -rf /var/lib/apt/lists/*
RUN apt update -y
RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www
RUN chown -R root:root /var/www/wordpress

# Update PHP configuration
COPY ./conf/www.conf /etc/php/8.3/fpm/pool.d/www.conf

# Update wordpress configuration
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY ./tools/wp_init.sh /usr/local/bin/wp_init.sh
RUN chmod +x /usr/local/bin/wp_init.sh
ENTRYPOINT ["/usr/local/bin/wp_init.sh"]

RUN /usr/sbin/php-fpm8.3 -F