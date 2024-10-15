FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	php7.4-redis \
	redis-server \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf \
	&& echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf