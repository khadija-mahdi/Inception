FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y python3 python3-pip

# Set up a directory for your Django project
RUN mkdir -p /var/www/html

# Change working directory to /var/www/html
WORKDIR /var/www/html

# Install Django and other dependencies
RUN pip3 install django

# Create a new Django project
RUN django-admin startproject myproject .

EXPOSE 3000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:3000"]
