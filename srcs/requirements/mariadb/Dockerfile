# Base Image
FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Create required directories and set permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /docker-entrypoint-initdb.d

# Update bind-address for external connections
RUN sed -i 's/bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Ensure proper ownership for MariaDB data directory
RUN chown -R mysql:mysql /var/lib/mysql

# Copy custom startup script
COPY conf/custom-entrypoint.sh /custom-entrypoint.sh
RUN chmod +x /custom-entrypoint.sh

# Expose MariaDB default port
EXPOSE 3306
EXPOSE 80

# Use custom entrypoint
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["mysqld"]
