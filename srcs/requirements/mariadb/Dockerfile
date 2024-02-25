FROM debian:bullseye

RUN apt update -y && apt upgrade -y \
    && apt install -y zsh curl git mariadb-server \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

EXPOSE 3306

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]
