FROM debian:bullseye

RUN apt update -y && apt upgrade -y \
	&& apt-get install -y redis \
	&& rm -rf /var/lib/apt/lists/*

# Update redis configuration
# Set the maximum memory use to 128mb
# Set the policy to allkeys-lru (Remove the least recently used keys when the memory limit is reached)
RUN if [ ! -f "/etc/redis/redis.conf.bak" ]; then \
	cp /etc/redis/redis.conf /etc/redis/redis.conf.bak; \
	fi; \
	&& sed -i "s|# maxmemory <bytes>|maxmemory 128mb|g" /etc/redis/redis.conf; \
	&& sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf; \
	&& sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf;

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]