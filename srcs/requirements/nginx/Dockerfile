FROM debian:bookworm

# Install nginx
RUN apt update -y && \
	apt upgrade -y && \
	apt install -y nginx && \
	rm -rf /var/lib/apt/lists/*

# To ensure Nginx stays in the foreground
CMD ["nginx", "-g", "daemon off;"]
