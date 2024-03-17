FROM debian:bullseye

# Update and upgrade packages
RUN apt update -y && apt upgrade -y

# Install Redis and PHP with Redis extension
RUN apt install -y redis-server php-redis

RUN apt-get install procps -y

# Set ENTRYPOINT
RUN service redis-server restart

ENTRYPOINT ["redis-server", "--protected-mode", "no", "--bind", "0.0.0.0"]

