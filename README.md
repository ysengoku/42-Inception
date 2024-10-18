# Inception

## Docker
Docker is a plateforme which alows applications to run in isolated environments called containers. Containers package everything needed for the application, including software, libralies and configuration files, ensuring that application behaves the same across different environments. This helps reduce issues caused by differences between development and production environments. While similar to virtual machine, Dcoker containers are more lightweight and resource-efficient.      

### Dcoker compose
Docker Compose is a tool for defining and running multi-container Docker applications using a YAML file to configure application services. It allows us to orchestrate multiple containers to work together as a single service.   
   
Without Docker Compose, managing multi-container applications involves manually setting up and linking each container, which can be complex and error-prone. With Docker Compose, we can define, run, and connect multiple containers as a single service through a simple YAML file, streamlining deployment and development workflows.   

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
docker volume ls
# List all volumes

docker volume inspect <volume name>
# Inspect a volume status
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

## Docker Network
Docker network allows containers to communicate each other and with the outside. It isolate and secure container communications.   

Containers attached to the same network can communicate with each other using container names as hotsnames. For example, in this project, `wordpress` can access `nginx` using the hostname `nginx`.   

Networks can be defined within docker-compose files:   
```yml
# In docker-compose.yml
networks:
 inception: # network name
  driver: bridge

# Bridge is the default network driver. It creates a private internal network to the host. Containers on this network can communicate each other and the host.
```
[More about network drivers](https://docs.docker.com/engine/network/drivers/)

## Nginx

### OpenSSL
Generate a self-signed SSL certification and private key   
```bash
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=login.42.fr/UID=login"

# openssl req:
# Subcommand for certificate request processing (to generate a new certificate)

# -x509:
# This option specifies that a self-signed certificate is to be generated rather than a certificate signing request (CSR).

# -nodes:
# This option instructs OpenSSL to create the private key without securing it with a passphrase. "nodes" stands for "no DES", which historically meant not to encrypt the private key with DES.

# -out /etc/nginx/ssl/inception.crt:
# This option specifies the output file for the generated certificate. In this case, the certificate is saved to /etc/nginx/ssl/inception.crt.

# -keyout /etc/nginx/ssl/inception.key:
# This option specifies the output file for the generated private key. Here, the private key is saved to /etc/nginx/ssl/inception.key.

# -subj "/C=FR/ST=AURA/L=Lyon/O=42/OU=42/CN=login.42.fr/UID=login":
# This option sets the subject field of the certificate with specific details.。
	#/C=FR: Country
	#/ST=AURA: State
	#/L=Lyon: Locality (City or town name)
	#/O=42: Organization Name
	#/OU=42: Organizational Unit Name
	#/CN=login.42.fr: Common Name. (Typically the domain name for which the certificate is valid)
	#/UID=login: ユーザ識別子 (User ID)
```

Test SSL configuration
```bash
# Try to access with insecure SSL connections (-k option)
curl -k https://login.42.fr

# Check logs
docker exec -it nginx bash
cat /var/log/nginx/error.log
cat /var/log/nginx/access.log
```

## MariaDB
Login to database
```bash
# Access to mariadb container's shell
docker exec -it mariadb bash

# Login to MariaDB
mysql -u root -p<password> # As root
mysql -u <user name> -p<password> # As User
```

## Wordpress
Admin page   
`https://login.42.fr/wp-admin`   

User login   
`https://login.42.fr/wp-login.php`


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

## Structure of the project
```
Root   
├── Makefile   
└── srcs   
    ├── docker-compose.yml   
    ├── .env   
    │   
    └── requirements   
        ├── Nginx   
        │   ├── Dockerfile   
        │   └── conf   
        │       └── nginx.conf   
        ├── MariaDB   
        │   ├── Dockerfile   
        │   └── conf   
        │   │   └── 50-server.cnf   
        │   └── tools   
        │       └── db_init.sh   
        └── WordPress   
            ├── Dockerfile   
            └── conf   
            │   └── www.conf   
            └── tools   
                └── wp_init.sh   
```

## Bonus Part

### Adminer
Adminer is a database management tool designed to be a single PHP file. We can download directly from https://www.adminer.org/

#### Steps to set up Adminer in this project
##### 1. In __Dockerfile__ of adminer:
   - Install `php`, `php-fpm`, `php-mysql` and `wget`
   - Download the Adminer PHP file from https://www.adminer.org/ using wget and save it to `/var/www/html/index.php`
   - Change ownership and permission of `/var/www/html/index.php`
   - Update `/etc/php/7.4/fpm/pool.d/www.conf` (listen = '9000')
   - Expose the port `9000`
   - Execute the command `php-fpm7.4 --nodaemonize`
    
##### 2. In __nginx.conf__ of nginx container:
- Add `location /adminer` in server part

##### 3. In __docker-compose.yml__:
- Add adminer as service
	
#### Access to adminer on browser
Go to `https://login.42.fr/adminer`   
Put login informations.
```
- server: mariadb
- username: sql user
- password: sql user password
- database: wordpress
```

---

### Redis
Redis is an in-memory database used to store and retrieve data quickly. It acts as a cache to speed up applications by keeping frequently accessed data easily accessible.

#### Steps to set up Redis in this project
##### 1. In __Dockerfile__ of redis:
- Install `redis`
- Update configuration in `/etc/redis/redis.conf`
```
   	maxmemory 128mb
	maxmemory-policy allkeys-lru
   	bind 0.0.0.0
   	daemonize no
```
- Expose the port `6379`

##### 2. In __wp_init.sh__ of wordpress container:
- Add following Redis configuration
```
   	WP_REDIS_HOST
   	WP_REDIS_PORT
   	WP_CACHE_KEY_SALT
   	WP_REDIS_CLIENT
```
- Install and enable plugin
- Update ownership and permissions of `/var/www/html/wp-content`

##### 3. In __docker-compose.yml__:
- Add redis as service	

---

### FTP server

To test if it works, use this command:
```bash
filezilla
```
Reference: [vsftpd website](http://vsftpd.beasts.org/vsftpd_conf.html)   

---   

### Static Website
I added one-page resume site based on Bootstrap template that I realized during Piscine Discovery.

### Address
I use a subdomain for this website. To do it, we need to add it to /etc/hosts so that `127.0.0.1` is binded to `subdomain_name.login.42.fr`.   
```bash
sudo echo "127.0.0.1 subdomain_name.login.42.fr" >> /etc/hosts

# In /etc/hosts, we have these 2 lines:
# 127.0.0.1 login.42.fr
# 127.0.0.1 subdomain_name.login.42.fr
```

### Set up a static website
#### 1. Docker-compose
- Add a new volume for the website. It should be shared with Nginx
- Expose the port `8080`

#### 2. Dockerfile
- Create a directory `/var/www/resume` (I named my site "resume") and change its ownership (www-data) and permission. Copy website files there.
- Install Python3
- In `/var/www/resume`, execute `python3 -m http.server 8080`

#### 3. nginx.conf
- In http section, add a new server for the website with a server_name including subdomain `subdomain_name.login.42.fr` defining `location \`.

---

## Fail2ban
`fail2ban checks log files to find failed attempts and then takes action based on the configured rules. It uses regular expressions defined in filter configuration files to identify failed login attempts or other suspicious activities in the logs.

How `fail2ban` works:

1. Log Monitoring: `fail2ban` monitors specified log files for patterns that match failed login attempts or other suspicious activities.
2. Filters: It uses filter configuration files to define the regular expressions that identify these patterns.
3. Actions: When a pattern is matched, `fail2ban` can take actions such as banning the IP address that generated the failed attempt.

### Set up fail2ban

#### Customize configuration: `custom.conf`

This file specifies the jails and their configurations, including which log files to monitor.

Example:
```properties
[sshd]
enabled = true
logpath = /var/log/auth.log
maxretry = 5

[nginx-http-auth]
enabled = true
port    = http,https
filter  = nginx-http-auth
logpath = /var/log/nginx/error.log
maxretry = 5
```

#### Create filter definition: nginx-http-auth.conf

This file defines the filter used by the `nginx-http-auth` jail. The `[Definition]` section contains the regular expressions that `fail2ban` will use to identify failed attempts in the log file.

Example:
```properties
[Definition]

# Patterns that fail2ban should use to identify failed attempts
failregex = ^<HOST> -.* "(GET|POST).*HTTP/.*" 401
            ^<HOST> -.* "(GET|POST).*HTTP/.*" 429
            ^<HOST> -.* "(GET|POST).*HTTP/.*" 400

# Patterns that fail2ban should ignore
ignoreregex = ^<HOST> -.* "(GET|POST).*HTTP/.*" 502
```

#### Dockerfile for `fail2ban`

1. install `fail2ban`
2. Copy configuration files into the appropriate directories within the fail2ban container.
3. Start fail2ban in the foreground

## References
[Medium INCEPTION-42](https://medium.com/@gamer.samox/inception-42-d9f1fc38b877)

[Inception #42 project — PART I](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)   
[Inception #42 project — PART II](https://medium.com/@ssterdev/inception-42-project-part-ii-19a06962cf3b)

[Dockerを用いたWordPress環境構築](https://qiita.com/ryhara/items/0581c03e82bd84c54a6f)

[INCEPTION : Docker イメージを仮想化し、新しい個人用仮想マシンを構築メモ](https://zenn.dev/rt3mis10/articles/4116a3b6b16118)

[実践 Docker - ソフトウェアエンジニアの「Docker よくわからない」を終わりにする本](https://zenn.dev/suzuki_hoge/books/2022-03-docker-practice-8ae36c33424b59)
