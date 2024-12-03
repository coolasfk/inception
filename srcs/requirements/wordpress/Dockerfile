# Base image: Penultimate stable version of Debian
FROM debian:bullseye

# Set environment variables for WordPress installation
ENV WORDPRESS_VERSION=6.7.1
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
    RUN sed -i 's/;clear_env = yes/clear_env = no/' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
# Fix: Update PHP-FPM configuration to enable $_ENV and variables_order
RUN echo "variables_order = \"EGPCS\"" > /etc/php/${PHP_VERSION}/fpm/conf.d/variables_order.ini

# Ensure that variables_order includes 'E' so $_ENV is populated for CLI
RUN echo "variables_order = \"EGPCS\"" > /etc/php/${PHP_VERSION}/cli/conf.d/variables_order.ini

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

# Copy WordPress configuration
COPY conf/wp-config.php /tmp/wp-config.php
RUN chmod 644 /tmp/wp-config.php

# Copy custom initialization script
COPY conf/init.sh /init.sh
RUN chmod +x /init.sh

RUN { \
    echo "env[DB_NAME] = \$DB_NAME"; \
    echo "env[DB_USER] = \$DB_USER"; \
    echo "env[DB_PASSWORD] = \$DB_PASSWORD"; \
    echo "env[DB_HOST] = \$DB_HOST"; \
    echo "env[DB_CHARSET] = \$DB_CHARSET"; \
    echo "env[DB_COLLATE] = \$DB_COLLATE"; \
    echo "env[AUTH_KEY] = \$AUTH_KEY"; \
    echo "env[SECURE_AUTH_KEY] = \$SECURE_AUTH_KEY"; \
    echo "env[LOGGED_IN_KEY] = \$LOGGED_IN_KEY"; \
    echo "env[NONCE_KEY] = \$NONCE_KEY"; \
    echo "env[AUTH_SALT] = \$AUTH_SALT"; \
    echo "env[SECURE_AUTH_SALT] = \$SECURE_AUTH_SALT"; \
    echo "env[LOGGED_IN_SALT] = \$LOGGED_IN_SALT"; \
    echo "env[NONCE_SALT] = \$NONCE_SALT"; \
} >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Verify Composer installation
RUN composer --version

# Set working directory for WordPress
WORKDIR /var/www/html

# Install phpdotenv using Composer
RUN composer require vlucas/phpdotenv

# Expose necessary ports
EXPOSE 9000

# Start PHP-FPM with the custom initialization script
CMD ["/init.sh"]
