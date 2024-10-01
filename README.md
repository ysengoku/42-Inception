# Inception

## Local development environnment   
Ubuntu 24.04.1 Desktop (64-bit) on VirtualBox ver6.1
- Base Memory: 4096 MB
- Storage: VDI 20.80 GB

Install
- git
- vim
- docker.io `sudo apt-get install docker.io`
- docker-compose `sudo apt-get install docker-compose`

## Docker commands
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

## References
[Medium INCEPTION-42](https://medium.com/@gamer.samox/inception-42-d9f1fc38b877)

[Inception #42 project — PART I](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)

[Dockerを用いたWordPress環境構築](https://qiita.com/ryhara/items/0581c03e82bd84c54a6f)

[INCEPTION : Docker イメージを仮想化し、新しい個人用仮想マシンを構築メモ](https://zenn.dev/rt3mis10/articles/4116a3b6b16118)

[実践 Docker - ソフトウェアエンジニアの「Docker よくわからない」を終わりにする本](https://zenn.dev/suzuki_hoge/books/2022-03-docker-practice-8ae36c33424b59)
