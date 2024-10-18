FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	fail2ban \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/custom.conf /etc/fail2ban/jail.d/custom.conf
COPY ./conf/nginx-http-auth.conf /etc/fail2ban/filter.d/nginx-http-auth.conf
COPY ./conf/wp-login.conf /etc/fail2ban/filter.d/wp-login.conf

# Start fail2ban in the foreground(-f)
ENTRYPOINT ["/usr/bin/fail2ban-server", "-f"]
