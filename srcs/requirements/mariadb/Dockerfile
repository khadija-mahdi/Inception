FROM debian:bullseye

RUN apt update -y && apt upgrade -y \
    && apt install -y  mariadb-server ;

EXPOSE 3306

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]
