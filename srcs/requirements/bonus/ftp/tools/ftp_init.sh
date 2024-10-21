#!/bin/bash

service vsftpd start

if [ -n "{FTP_USER}" ] && [ -n "{FTP_PASSWORD}" ]; then

	# Create a user and set a password
	adduser -disabled-password --gecos "" ${FTP_USER}
	echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd &> /dev/null
	echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist &> /dev/null

	# Create a directory for the user
	mkdir -p /home/${FTP_USER}/ftp
	chown nobody:nogroup /home/${FTP_USER}/ftp
	chmod a-w /home/${FTP_USER}/ftp
	mkdir /home/${FTP_USER}/ftp/files
	chown ${FTP_USER}:${FTP_USER} /home/${FTP_USER}/ftp/files
fi

# Create a directory for the anonymous user
mkdir -p /var/ftp/pub
chown ftp:ftp /var/ftp/pub

service vsftpd stop
exec /usr/sbin/vsftpd