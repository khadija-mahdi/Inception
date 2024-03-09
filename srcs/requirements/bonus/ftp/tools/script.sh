#!/bin/sh

# Set up FTP user
useradd -m $FTP_USERNAME
echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd

# Adjust permissions
chown $FTP_USERNAME:$FTP_USERNAME -R /home/$FTP_USERNAME/

# Add user to vsftpd user list
echo "$FTP_USERNAME" >> /etc/vsftpd.userlist 

# Start vsftpd
exec  vsftpd /etc/vsftpd.conf