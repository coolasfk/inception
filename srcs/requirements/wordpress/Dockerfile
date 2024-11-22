# Base WordPress image
FROM wordpress:php7.4-fpm

# Enable error logging in PHP and create the error log file
RUN mkdir -p /var/log/php && \
    echo "log_errors = On" > /usr/local/etc/php/conf.d/php-logging.ini && \
    echo "error_log = /var/log/php/php_errors.log" >> /usr/local/etc/php/conf.d/php-logging.ini && \
    touch /var/log/php/php_errors.log && \
    chmod 666 /var/log/php/php_errors.log && \
    chown -R www-data:www-data /var/log/php

# Update permissions for the WordPress directory
RUN chown -R www-data:www-data /var/www/html

# Install additional tools
RUN apt-get update && apt-get install -y \
    less \
    net-tools \
    procps \
    curl \
    default-mysql-client

# Update PHP-FPM configuration to listen on all interfaces
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /usr/local/etc/php-fpm.d/www.conf

# Copy the wp-config.php and init.sh from the conf directory to the container
COPY conf/wp-config.php /tmp/wp-config.php
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

# Expose PHP-FPM port
EXPOSE 9000

# Start with the custom initialization script
CMD ["/init.sh"]
