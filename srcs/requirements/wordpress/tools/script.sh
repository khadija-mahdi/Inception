#!/bin/bash

sleep 10

sed -i "s/\(define( 'DB_NAME', \).*$/\1'$MARIA_DATABASE' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_USER', \).*$/\1'$MARIA_USER' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_PASSWORD', \).*$/\1'$MARIA_PASSWORD' );/" /var/www/html/wp-config.php;
sed -i "s/\(define( 'DB_HOST', \).*$/\1'mariadb:3306' );/" /var/www/html/wp-config.php;

wp core install --allow-root \
    --url=https://kmahdi.42.fr \
    --title="Inception" \
    --admin_user=$WORDPRESS_ADMIN_USER \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email="kmahdi@student.1337.ma";

wp user create --allow-root \
    $WORDPRESS_USER1_NAME "user@gmail.com" \
    --user_pass=$WORDPRESS_USER1_PASSWORD --role=author;

exec "$@"
