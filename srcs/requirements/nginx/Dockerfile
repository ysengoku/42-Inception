FROM debian:bullseye

# Install nginx
RUN apt update -y && apt upgrade -y
RUN	apt install -y nginx && \
	rm -rf /var/lib/apt/lists/*

# Configure TSL
RUN mkdir -p /etc/nginx/ssl
RUN apt update -y && apt install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=yusengok.42.fr/UID=yusengok"
# openssl req: openssl コマンドの証明書要求サブコマンド
# -x509: X.509 証明書を生成	
# -nodes: 秘密鍵を暗号化せずに生成
# -out /etc/nginx/ssl/inception.crt: 生成した証明書を /etc/nginx/ssl/inception.crt ファイルに出力
# -keyout /etc/nginx/ssl/inception.key: 生成した秘密鍵を /etc/nginx/ssl/inception.key ファイルに出力
# -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login": 証明書主体 (Subject) 情報を設定します。
	#/C=FR: Country
	#/ST=IDF: State
	#/L=Paris: 市町村名 (Locality)
	#/O=42: 組織名 (Organization)
	#/OU=42: 組織単位名 (Organizational Unit) 
	#/CN=login.42.fr: 共通名 (Common Name) 
	#/UID=login: ユーザ識別子 (User ID)

# Congigure Nginx
RUN mkdir -p /var/run/nginx
RUN rm -f /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Set the permissions
RUN chmod -R 755 /var/www/html
# Set the ownership
RUN chown -R www-data:www-data /var/www/html

# To ensure Nginx stays in the foreground
CMD ["nginx", "-g", "daemon off;"]
