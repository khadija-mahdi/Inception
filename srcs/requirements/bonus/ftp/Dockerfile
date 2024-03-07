FROM debian:bullseye

RUN apt-get update 

RUN apt-get -y update; \
        apt-get -y upgrade; \
        apt-get install vsftpd -y;

# Copy vsftpd configuration file
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Copy script to create FTP user
COPY ./tools/script.sh /usr/local/bin/script.sh

# Make the script executable
RUN chmod +x /usr/local/bin/script.sh

# Create directory for FTP access
RUN mkdir -p /var/www/html

# Expose FTP port
EXPOSE 20 21

CMD ["sh", "./tools/script.sh"]

ENTRYPOINT ["vsftpd", "/etc/vsftpd.conf"]