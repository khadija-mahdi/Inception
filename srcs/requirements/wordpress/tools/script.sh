#!/bin/bash

# Update database configuration in wp-config.php
sed -i "s/\(define( 'DB_NAME', \).*$/\1'$MARIA_DATABASE' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_USER', \).*$/\1'$MARIA_USER' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_PASSWORD', \).*$/\1'$MARIA_PASSWORD' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_HOST', \).*$/\1'mariadb:3306' );/" /var/www/html/wp-config.php;

# Install WordPress and create admin user
wp core install --allow-root \
    --url=$WORDPRESS_URL \
    --title="Inception" \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL;

# Create additional WordPress user
wp user create --allow-root \
    $WORDPRESS_USER1_NAME $WORDPRESS_USER1_EMAIL \
    --user_pass=$WORDPRESS_USER1_PASSWORD --role=author;

# Download and Install WordPress Plugin
wp plugin install --allow-root redis-cache --activate;

# Configure Redis Cache Plugin
wp config set --allow-root WP_REDIS_HOST "redis";
wp config set --allow-root WP_REDIS_PORT "6379";

wp plugin update --all --allow-root ;
wp redis enable --allow-root ;


exec php-fpm7.4 -F
