FROM debian:bullseye

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install MariaDB
RUN apt update -y && apt upgrade -y && \
	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# Update configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

# Execute initialization script
COPY ./tools/db_init.sh /usr/local/bin/db_init.sh
RUN chmod +x /usr/local/bin/db_init.sh
ENTRYPOINT ["/usr/local/bin/db_init.sh"]
CMD ["mysqld_safe"]