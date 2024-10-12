# Inception

## Local development environnment   
### Ubuntu 24.04.1 Desktop (64-bit) on VirtualBox ver6.1
- Base Memory: 4096 MB
- Storage: VDI 20.00 GB

### Install necessary applications and set up VM
```bash
# Install git
sudo apt-get update & apt-get upgrade -y
sudo apt install git

# Execute config script
bash vm_config.sh
```

## Useful docker commands
```bash
docker ps
# Show active containers status

docker ps -a
# Show all containers status
```

```bash
docker logs <container_name>
# Show the logs of <container_name> (both standard output and error)
```

```bash
docker network ls
# List all networks

docker network inspect <network name>
# Inspect a network status
```

```bash
docker exec -it <container_name> /bin/bash
# Execute a shell within a running Docker container named <container_name>

docker run -it --entrypoint /bin/bash <container_name>
# If the container is not running
```
```bash
docker exec -it <mariadb container_name> mysql -u root -p<password>
# Opens an interactive terminal session to the MariaDB instance allowing to execute SQL commands as the root user with the specified password.
```

## Dockerfile instructions
To see all instructions: [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)   

### FROM
Specifies the base image for the Docker image to create. It's the first mandatory instruction of Dockerfile.   
```bash
FROM debian:bullseye
# This example means we use debian version 11 (bullseye)
```   
### ENV
Set environment variables.

### RUN
Execute build commands.   
```bash
# Examples
RUN apt -y update
RUN install -y nginx
```

### COPY
Copy files and directories.
```bash
COPY <original> <copy to>

# EXample
COPY ./tools/db_init.sh /usr/local/bin/db_init.sh
```

### EXPOSE
Describe which ports the container is listening on.   

### ENTRYPOINT
Specify default executable.   

## SQL commands

Before executing SQL commands, we should open an interactive terminal session to the MariaDB instance with `
docker exec -it <mariadb container_name> mysql -u root -p<password>`

```sql
SHOW DATABASES;
# Displays a list of all databases on the server.

SELECT User, Host FROM mysql.user;
# Show all users

SHOW GRANTS FOR 'your_username'@'%';
# Retrieve the privileges of a specified user for any host, localhost for the local machine
```

```sql
CREATE DATABASE IF NOT EXISTS `your_database_name`;
# Create a new database if it does not already exist

CREATE USER IF NOT EXISTS 'your_username'@'%' IDENTIFIED BY 'your_password';
# Create a new user if it does not already exist, allowing connections from any host ('%') with the specified password

GRANT ALL PRIVILEGES ON *.* TO 'your_username'@'%' WITH GRANT OPTION;
# Grant all privileges on all databases and tables to the new user. This also allows the user to grant privileges to others

FLUSH PRIVILEGES;
# Apply the changes
```

## References
[Medium INCEPTION-42](https://medium.com/@gamer.samox/inception-42-d9f1fc38b877)

[Inception #42 project — PART I](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)   
[Inception #42 project — PART II](https://medium.com/@ssterdev/inception-42-project-part-ii-19a06962cf3b)

[Dockerを用いたWordPress環境構築](https://qiita.com/ryhara/items/0581c03e82bd84c54a6f)

[INCEPTION : Docker イメージを仮想化し、新しい個人用仮想マシンを構築メモ](https://zenn.dev/rt3mis10/articles/4116a3b6b16118)

[実践 Docker - ソフトウェアエンジニアの「Docker よくわからない」を終わりにする本](https://zenn.dev/suzuki_hoge/books/2022-03-docker-practice-8ae36c33424b59)
