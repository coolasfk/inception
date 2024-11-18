FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY conf /etc/mysql/conf.d

CMD ["mysqld"]