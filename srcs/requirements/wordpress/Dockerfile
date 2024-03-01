# Base image
FROM debian:bullseye

# Update and upgrade packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php php-fpm php-mysql mariadb-client wget sendmail

RUN apt-get install -y sendmail


WORKDIR  /var/www/html

# Install WordPress
RUN wget https://wordpress.org/wordpress-6.3.1.tar.gz -P /var/www/html

RUN tar -xzf wordpress-6.3.1.tar.gz
RUN mv ./wordpress/wp-config-sample.php ./wordpress/wp-config.php
RUN mv ./wordpress/* . 
RUN rm -rf wordpress-6.3.1.tar.gz wordpress 
RUN chown -R root:root /var/www/html

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install WordPress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


# Copy script file
COPY ./tools/script.sh /usr/bin/script.sh

# Make script executable
RUN chmod +x /usr/bin/script.sh

# Move wp-config file

# Expose port 9000 for PHP-FPM
EXPOSE 9000

RUN mkdir -p /run/php/

# ENTRYPOINT [ "tail", "-f" ]
# Set entrypoint to script
ENTRYPOINT ["sh", "/usr/bin/script.sh"]

# CMD for PHP-FPM
CMD [ "php-fpm7.4",  "-F"]