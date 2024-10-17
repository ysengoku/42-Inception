FROM debian:bullseye

RUN apt update && apt-get install -y \
	python3 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*
	
RUN	mkdir -p /var/www/resume && \
	chmod -R 755 /var/www/resume && \
	chown -R www-data:www-data /var/www/resume

COPY ./resume /var/www/resume

EXPOSE 8080

WORKDIR /var/www/resume
CMD ["python3", "-m", "http.server", "8080"]