# Inception

## Local development environnment   
### Ubuntu 24.04.1 Desktop (64-bit) on VirtualBox ver6.1
- Base Memory: 4096 MB
- Storage: VDI 20.00 GB

### Install necessary applications on VM
```bash
# Install git
sudo apt-get update & apt-get upgrade -y
sudo apt install git
# Clone this repository
git clone <this repository>

# Execute config script
bash vm_config.sh
```
This configuration file includes: 
- git
- make
- vim
- docker-ce

## Some useful docker commands
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
docker exec -it <container_name> bash
# Execute a shell within a running Docker container named <container_name>
```

## Some Dockerfile instructions

### FROM
Specifies the base image for the Docker image to create. It's the first mandatory instruction of Dockerfile.   
```
FROM debian:bullseye
# This example means we use debian version 11 (bullseye)
```   
### ENV
Set environment variables.

### RUN
Execute build commands.   
```
# Examples
RUN apt -y update
RUN install -y nginx
```

### COPY
Copy files and directories.

### EXPOSE



`ENTRYPOINT`

To see all instructions: [Dockerfile reference](https://docs.docker.com/reference/dockerfile/)   

## References
[Medium INCEPTION-42](https://medium.com/@gamer.samox/inception-42-d9f1fc38b877)

[Inception #42 project — PART I](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)

[Dockerを用いたWordPress環境構築](https://qiita.com/ryhara/items/0581c03e82bd84c54a6f)

[INCEPTION : Docker イメージを仮想化し、新しい個人用仮想マシンを構築メモ](https://zenn.dev/rt3mis10/articles/4116a3b6b16118)

[実践 Docker - ソフトウェアエンジニアの「Docker よくわからない」を終わりにする本](https://zenn.dev/suzuki_hoge/books/2022-03-docker-practice-8ae36c33424b59)
