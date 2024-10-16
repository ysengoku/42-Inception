FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	vsftpd \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

EXPOSE 20 21

# Allow users with a shell of /usr/sbin/nologin access to FTP
RUN echo "/usr/sbin/nologin" >> /etc/shells

CMD ["vsftpd", "/etc/vsftpd.conf"]