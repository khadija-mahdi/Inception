FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN  apt install -y redis-server && apt install -y  php-redis


ENTRYPOINT [ "redis-server","--protected-mode","no","--bind","0.0.0.0" ]