FROM debian:bullseye

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install MariaDB
RUN apt update -y && apt upgrade -y && \
	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Update configuration
#COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

RUN cat > ./tools/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO \`${SQL_USER}\`@'%' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
COPY ./tools/init.sql /etc/mysql/init.sql

RUN mkdir /run/mysqld

#EXPOSE 3306

# Execute initialization script
#COPY ./tools/db_init.sh /usr/local/bin/db_init.sh
#RUN chmod +x /usr/local/bin/db_init.sh
#ENTRYPOINT ["/usr/local/bin/db_init.sh"]
CMD ["mysql_instqll_db"]
CMD ["mysqld"]
