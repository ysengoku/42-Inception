#!/bin/bash

service vsftps start

adduser $ftp_user -disabled-password

echo "$ftp_user:$ftp_password" | /usr/sbin/chasswd &> /dev/null
echo "$ftp_user" | tee -a /etc/vsftpd.userlist &> /dev/null

mkdir -p /home/$ftp_user/ftp
chown nobody:nogroup /home/$ftp_user/ftp
chmod a-w /home/$ftp_user/ftp

mkdir /home/$ftp_user/ftp/files
chown $ftp_user:$ftp_user /home/$ftp_user/ftp/files

service vsftpd stop
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf