FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld


COPY conf /etc/mysql/conf.d

CMD ["mysqld"]