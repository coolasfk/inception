# Base image: Penultimate stable version of Debian
FROM debian:bullseye

# Set environment variables for WordPress installation
ENV WORDPRESS_VERSION=5.8.3
ENV PHP_VERSION=7.4

# Update the system and install dependencies
RUN apt-get update && \
    apt-get install -y \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-gd \
    less \
    net-tools \
    procps \
    curl \
    default-mysql-client \
    wget \
    tar && \
    apt-get clean

# Create the necessary directory for PHP-FPM socket
RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

# Enable error logging in PHP and create the error log file
RUN mkdir -p /var/log/php && \
    echo "log_errors = On" > /etc/php/${PHP_VERSION}/fpm/conf.d/php-logging.ini && \
    echo "error_log = /var/log/php/php_errors.log" >> /etc/php/${PHP_VERSION}/fpm/conf.d/php-logging.ini && \
    touch /var/log/php/php_errors.log && \
    chmod 666 /var/log/php/php_errors.log && \
    chown -R www-data:www-data /var/log/php

# Download and set up WordPress
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm latest.tar.gz

# Set permissions for WordPress directory
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Update PHP-FPM configuration to listen on all interfaces (not just localhost)
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

COPY conf/wp-config.php /tmp/wp-config.php
RUN chmod 644 /tmp/wp-config.php
# Copy custom initialization script
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

# Expose necessary ports
EXPOSE 9000

# Start PHP-FPM with the custom initialization script
CMD ["/init.sh"]
