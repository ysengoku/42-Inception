FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y 
	adminer \
	php7.4 \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
	&& chmod +x adminer-4.8.1.php \
	&& chown -R www-data:www-data adminer-4.8.1.php \
	&& mv adminer-4.8.1.php /var/www/html/adminer.php