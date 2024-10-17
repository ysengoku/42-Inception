#!/bin/bash

service vsftpd start

if [ -n "{FTP_USER}" ] && [ -n "{FTP_PASSWORD}" ]; then

	adduser -disabled-password --gecos "" ${FTP_USER}

	echo "${FTP_USER}:${FTP_PASSWORD}" | /usr/sbin/chpasswd &> /dev/null
	echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist &> /dev/null

	mkdir -p /home/${FTP_USER}/ftp
	chown nobody:nogroup /home/${FTP_USER}/ftp
	chmod a-w /home/${FTP_USER}/ftp

	mkdir /home/${FTP_USER}/ftp/files
	chown ${FTP_USER}:${FTP_USER} /home/${FTP_USER}/ftp/files
fi

mkdir -p /var/ftp/pub
chown ftp:ftp /var/ftp/pub

service vsftpd stop
/usr/sbin/vsftpd