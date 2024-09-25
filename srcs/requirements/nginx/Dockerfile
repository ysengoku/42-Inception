FROM debian:latest

# Install nginx
RUN apt update && \
	apt upgrade -y && \
	apt install -y nginx && \
	rm -rf /var/lib/apt/lists/*

# Use exec form of CMD to ensure Nginx stays in the foreground
CMD ["nginx", "-g", "daemon off;"]
