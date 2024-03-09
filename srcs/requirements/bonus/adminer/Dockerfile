# Dockerfile
FROM debian:bullseye

# Update and upgrade packages
RUN apt-get update -y && apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y wget php php-fpm php-mysql php-cli nginx

# Download Adminer to the correct directory
RUN mkdir -p /var/www/html && wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php

# Copy Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx and PHP-FPM
CMD service php7.4-fpm start && nginx -g "daemon off;"





