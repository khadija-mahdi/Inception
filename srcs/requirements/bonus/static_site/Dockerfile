# Use Debian Bullseye as base image
FROM debian:bullseye

# Install Python
RUN apt-get update && apt-get install -y python3 python3-pip

RUN mkdir -p /var/www/html

COPY ./static_site /var/www/html

WORKDIR /var/www/html

CMD ["python3", "-m", "http.server"]
