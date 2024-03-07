#!/bin/bash

# Check if the FTP user already exists
if id "ftpuser" &>/dev/null; then
    echo "User 'ftpuser' already exists."
else
    # Create FTP user with the specified username and password from the .env file
    adduser --disabled-password --gecos "" $FTP_USERNAME && echo "$FTP_USERNAME:$FTP_PASSWORD" | chpasswd
    echo "User '$FTP_USERNAME' created."
fi