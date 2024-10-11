FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
	apt-get install -y adminer && \
	rm -rf /var/lib/apt/lists/*