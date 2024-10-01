FROM debian:bullseye

# Install MariaDB
RUN apt update -y && apt upgrade -y
RUN	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf