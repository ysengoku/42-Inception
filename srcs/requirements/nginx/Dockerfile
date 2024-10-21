FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y \
	nginx \
	openssl \
	net-tools \
	&& rm -rf /var/lib/apt/lists/*

# Configure TSL
RUN mkdir -p /etc/nginx/ssl
#RUN apt update -y && apt install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=yusengok.42.fr/UID=yusengok"

# Congigure Nginx
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Set the permission
RUN chmod -R 755 /var/www/html/
# Set the ownership
RUN chown -R www-data:www-data /var/www/html/

# To ensure Nginx stays in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
