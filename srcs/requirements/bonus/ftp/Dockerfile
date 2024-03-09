FROM debian:bullseye

RUN apt update && apt upgrade -y 

RUN apt install -y iputils-ping vim vsftpd 

RUN apt install -y openssl

RUN mkdir -p /etc/ssl

RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kmahdi.42.fr/UID=kmahdi"

RUN mkdir -p /var/run/vsftpd/empty

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/script.sh /home/script.sh

RUN chmod +x /home/script.sh

RUN service vsftpd restart

ENTRYPOINT ["/home/script.sh" ] 
