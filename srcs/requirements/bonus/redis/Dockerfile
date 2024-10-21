FROM debian:bullseye

RUN apt update -y && apt upgrade -y \
	&& apt-get install -y redis \
	&& rm -rf /var/lib/apt/lists/*

# Update redis configuration
RUN if [ ! -f "/etc/redis/redis.conf.bak" ]; then \
cp /etc/redis/redis.conf /etc/redis/redis.conf.bak; \
fi; \
# Set the maximum memory use to 128mb
sed -i "s|# maxmemory <bytes>|maxmemory 128mb|g" /etc/redis/redis.conf; \
# Set the policy to allkeys-lru (Remove the least recently used keys when the memory limit is reached)
sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf; \
# Make redis listen on all interfaces
sed -i "s|bind 127.0.0.1|bind 0.0.0.0|g" /etc/redis/redis.conf; \
# Disable daemonize (run in the foreground)
sed -i "s|^daemonize yes|daemonize no|g" /etc/redis/redis.conf;

EXPOSE 6379

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]