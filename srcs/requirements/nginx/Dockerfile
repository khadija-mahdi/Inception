FROM debian:bullseye

RUN apt update && \
    apt install -y zsh curl nginx git openssl vim && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir -p /etc/nginx/ssl

CMD ["zsh"]

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kmahdi.42.fr/UID=kmahdi"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

# CMD	:	CMD [ "nginx", "-g", "daemon on;" ]