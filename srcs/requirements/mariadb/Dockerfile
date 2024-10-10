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

ARG SQL_USER
ARG SQL_DATABASE
ARG SQL_PASSWORD
ARG SQL_ROOT_PASSWORD

RUN echo "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" > /etc/mysql/init.sql && \
    echo "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" >> /etc/mysql/init.sql && \
    echo "GRANT ALL PRIVILEGES ON *.* TO \`${SQL_USER}\`@'%' WITH GRANT OPTION;" >> /etc/mysql/init.sql && \
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" >> /etc/mysql/init.sql && \
    echo "FLUSH PRIVILEGES;" >> /etc/mysql/init.sql
#COPY ./tools/init.sql /etc/mysql/init.sql

RUN mkdir /run/mysqld

#EXPOSE 3306

# Execute initialization script
#COPY ./tools/db_init.sh /usr/local/bin/db_init.sh
#RUN chmod +x /usr/local/bin/db_init.sh
#ENTRYPOINT ["/usr/local/bin/db_init.sh"]
CMD ["mysql_instqll_db"]
CMD ["mysqld"]
