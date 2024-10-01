FROM debian:bullseye

# Install MariaDB
RUN apt update -y && apt upgrade -y
RUN	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Update configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

# Execute initialization script
COPY ./tools/db_init.sh .
RUN chmod +x db_init.sh
CMD ["bash", "db_init.sh"]
